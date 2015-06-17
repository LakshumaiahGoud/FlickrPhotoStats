// Copyright (c) 2015, Jordi Corbilla
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
// - Neither the name of this library nor the names of its contributors may be
// used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

unit flickr.repository.rest;

interface

uses
  Windows, flickr.repository;

type
  IRepositoryRest = interface

  end;

  TRepositoryRest = class(TInterfacedObject, IRepositoryRest)
    class procedure UpdatePhoto(repository: IFlickrRepository; apikey, id: string; verbosity : boolean);
    class function getTotalAlbumsCounts(apikey, userId : string; verbosity : boolean): Integer; static;
  end;

var
  CritSect : TRTLCriticalSection;

implementation

uses
  WinApi.ActiveX, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdIOHandler, IdIOHandlerStream, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, XMLDoc, xmldom, XMLIntf, msxmldom, Vcl.ComCtrls, flickr.photos,
  System.SyncObjs, generics.collections, flickr.stats, flickr.Pools, flickr.Albums, IdGlobal,
  flickr.rest, System.SysUtils;

{ TRepositoryRest }

class procedure TRepositoryRest.UpdatePhoto(repository: IFlickrRepository; apikey, id: string; verbosity : boolean);
var
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4: IXMLNode;
  views, title, likes, comments, taken: string;
  stat: IStat;
  photo, existing: IPhoto;
  IdHTTP: TIdHTTP;
  IdIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  xmlDocument: IXMLDocument;
  timedout: Boolean;
  Albums: TList<IAlbum>;
  Groups: TList<IPool>;
begin
  CoInitialize(nil);
  try
    IdIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdIOHandler.ReadTimeout := IdTimeoutInfinite;
    IdIOHandler.ConnectTimeout := IdTimeoutInfinite;
    xmlDocument := TXMLDocument.Create(nil);
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.IOHandler := IdIOHandler;
      timedout := false;
      while (not timedout) do
      begin
        try
          response := IdHTTP.Get(TFlickrRest.New().getInfo(apikey, id));
          timedout := true;
        except
          on e: exception do
          begin
            sleep(2000);
            timedout := false;
          end;
        end;

      end;

      xmlDocument.LoadFromXML(response);
      iXMLRootNode := xmlDocument.ChildNodes.first; // <xml>
      iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photo>
      views := iXMLRootNode3.attributes['views'];
      iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <owner>
      while iXMLRootNode4 <> nil do
      begin
        if iXMLRootNode4.NodeName = 'title' then
          title := iXMLRootNode4.NodeValue;
        if iXMLRootNode4.NodeName = 'dates' then
          taken := iXMLRootNode4.attributes['taken'];
        if iXMLRootNode4.NodeName = 'comments' then
          comments := iXMLRootNode4.NodeValue;
        iXMLRootNode4 := iXMLRootNode4.NextSibling;
      end;
    finally
      IdIOHandler.Free;
      IdHTTP.Free;
      xmlDocument := nil;
    end;

    IdIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdIOHandler.ReadTimeout := IdTimeoutInfinite;
    IdIOHandler.ConnectTimeout := IdTimeoutInfinite;
    xmlDocument := TXMLDocument.Create(nil);
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.IOHandler := IdIOHandler;
      timedout := false;
      while (not timedout) do
      begin
        try
          response := IdHTTP.Get(TFlickrRest.New().getFavorites(apikey, id));
          timedout := true;
        except
          on e: exception do
          begin
            sleep(2000);
            timedout := false;
          end;
        end;
      end;

      xmlDocument.LoadFromXML(response);
      iXMLRootNode := xmlDocument.ChildNodes.first; // <xml>
      iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photo>
      likes := iXMLRootNode3.attributes['total'];
    finally
      IdIOHandler.Free;
      IdHTTP.Free;
      xmlDocument := nil;
    end;

    photo := TPhoto.Create(id, title, taken);
    stat := TStat.Create(Date, StrToInt(views), StrToInt(likes), StrToInt(comments));
    Albums := TList<IAlbum>.create;
    Groups := TList<IPool>.create;

    IdIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdIOHandler.ReadTimeout := IdTimeoutInfinite;
    IdIOHandler.ConnectTimeout := IdTimeoutInfinite;
    xmlDocument := TXMLDocument.Create(nil);
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.IOHandler := IdIOHandler;
      timedout := false;
      while (not timedout) do
      begin
        try
          response := IdHTTP.Get(TFlickrRest.New().getAllContexts(apikey, id));
          timedout := true;
        except
          on e: exception do
          begin
            sleep(2000);
            timedout := false;
          end;
        end;
      end;

      xmlDocument.LoadFromXML(response);
      iXMLRootNode := xmlDocument.ChildNodes.first; // <xml>
      iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <set or pool>
      while iXMLRootNode3 <> nil do
      begin
        if iXMLRootNode3.NodeName = 'set' then
          Albums.add(TAlbum.create(iXMLRootNode3.attributes['id'], iXMLRootNode3.attributes['title']));
        if iXMLRootNode3.NodeName = 'pool' then
          Groups.add(TPool.create(iXMLRootNode3.attributes['id'], iXMLRootNode3.attributes['title']));
        iXMLRootNode3 := iXMLRootNode3.NextSibling;
      end;
    finally
      IdIOHandler.Free;
      IdHTTP.Free;
      xmlDocument := nil;
    end;

    EnterCriticalSection(CritSect);
    if verbosity then
      WriteLn('Updating : ' + title + ' views:' + views);
    if repository.ExistPhoto(photo, existing) then
    begin
      photo := existing;
      photo.Title := title; //replace the title as it changes
      photo.Taken := taken;
      photo.AddStats(stat);
      photo.AddCollections(Albums, groups);
      photo.LastUpdate := Date;
    end
    else
    begin
      photo.AddStats(stat);
      photo.LastUpdate := Date;
      photo.AddCollections(Albums, groups);
      repository.AddPhoto(photo);
    end;
    LeaveCriticalSection(CritSect);

    //Save the repository
  finally
    CoUninitialize;
  end;
end;


class function TRepositoryRest.getTotalAlbumsCounts(apikey, userId : string; verbosity: boolean): Integer;
var
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4, iXMLRootNode5: IXMLNode;
  pages, total: string;
  numPages: Integer;
  i: Integer;
  totalViews: Integer;
  photosetId: string;
  title: string;
  countViews: Integer;
  IdHTTP: TIdHTTP;
  IdIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  xmlDocument: IXMLDocument;
  timedout : boolean;
begin
CoInitialize(nil);
  try
    IdIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdIOHandler.ReadTimeout := IdTimeoutInfinite;
    IdIOHandler.ConnectTimeout := IdTimeoutInfinite;
    xmlDocument := TXMLDocument.Create(nil);
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.IOHandler := IdIOHandler;
      timedout := false;
      while (not timedout) do
      begin
        try
          response := IdHTTP.Get(TFlickrRest.New().getPhotoSets(apikey, userId, '1', '500'));
          timedout := true;
        except
          on e: exception do
          begin
            sleep(2000);
            timedout := false;
          end;
        end;
      end;
      xmlDocument.LoadFromXML(response);
      iXMLRootNode := xmlDocument.ChildNodes.first; // <xml>
      iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photosets>
      pages := iXMLRootNode3.attributes['pages'];
      total := iXMLRootNode3.attributes['total'];
      iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photoset>
      totalViews := 0;
      while iXMLRootNode4 <> nil do
      begin
        if iXMLRootNode4.NodeName = 'photoset' then
        begin
          photosetId := iXMLRootNode4.attributes['id'];
          countViews := iXMLRootNode4.attributes['count_views'];
          iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
          title := iXMLRootNode5.text;
          totalViews := totalViews + countViews;
        end;
        if verbosity then
          WriteLn('Updating : ' + photosetId + ' views: ' + countViews.ToString());
        iXMLRootNode4 := iXMLRootNode4.NextSibling;
      end;
    finally
        IdIOHandler.Free;
        IdHTTP.Free;
        xmlDocument := nil;
    end;

    try
      numPages := pages.ToInteger;
      for i := 2 to numPages do
      begin
        timedout := false;
        while (not timedout) do
        begin
          try
            response := IdHTTP.Get(TFlickrRest.New().getPhotoSets(apikey, userid, i.ToString, '500'));
            timedout := true;
          except
            on e: exception do
            begin
              sleep(2000);
              timedout := false;
            end;
          end;
        end;
        XMLDocument.LoadFromXML(response);
        iXMLRootNode := XMLDocument.ChildNodes.first; // <xml>
        iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
        iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photosets>
        pages := iXMLRootNode3.attributes['pages'];
        iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photoset>
        while iXMLRootNode4 <> nil do
        begin
          if iXMLRootNode4.NodeName = 'photoset' then
          begin
            photosetId := iXMLRootNode4.attributes['id'];
            countViews := iXMLRootNode4.attributes['count_views'];
            iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
            title := iXMLRootNode5.text;
            totalViews := totalViews + countViews;
          end;
          if verbosity then
            WriteLn('Updating : ' + photosetId + ' views: ' + countViews.ToString());
          iXMLRootNode4 := iXMLRootNode4.NextSibling;
        end;
      end;
    finally
        IdIOHandler.Free;
        IdHTTP.Free;
        xmlDocument := nil;
    end;

  finally
    CoUninitialize;
  end;
  Result := totalViews;
end;

initialization
  InitializeCriticalSection(CritSect);

finalization
  DeleteCriticalSection(CritSect);

end.