// Copyright (c) 2014, Jordi Corbilla
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

unit flickr.rest;

interface

type
  IFlickrRest = interface
    function getFavorites(api_key: string; photo_id: string): string;
    function getInfo(api_key: string; photo_id: string): string;
    function getPhotos(api_key: string; user_id: string; page: string; per_page: string): string;
    function getPhotoSets(api_key: string; user_id: string; page: string; per_page: string): string;
    function getGroups(api_key: string; page: string; per_page: string; auth_token : string; api_sig : string): string;
  end;

  TFlickrRest = class(TInterfacedObject, IFlickrRest)
  private
  public
    function getFavorites(api_key: string; photo_id: string): string;
    function getInfo(api_key: string; photo_id: string): string;
    function getPhotos(api_key: string; user_id: string; page: string; per_page: string): string;
    function getPhotoSets(api_key: string; user_id: string; page: string; per_page: string): string;
    function getGroups(api_key: string; page: string; per_page: string; auth_token : string; api_sig : string): string;
    class function New(): IFlickrRest;
  end;

implementation

{ TFlickrRest }

function TFlickrRest.getFavorites(api_key, photo_id: string): string;
begin
  Result := 'https://api.flickr.com/services/rest/?method=flickr.photos.getFavorites&api_key=' + api_key + '&photo_id=' + photo_id;
end;

function TFlickrRest.getGroups(api_key, page, per_page: string; auth_token : string; api_sig : string): string;
begin
  Result := 'https://api.flickr.com/services/rest/?method=flickr.groups.pools.getGroups&api_key=' + api_key + '&page=' + page + '&per_page=' + per_page + '&format=rest&auth_token=' +auth_token + '&api_sig=' + api_sig;
end;

function TFlickrRest.getInfo(api_key, photo_id: string): string;
begin
  Result := 'https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=' + api_key + '&photo_id=' + photo_id;
end;

function TFlickrRest.getPhotos(api_key, user_id, page, per_page: string): string;
begin
  Result := 'https://api.flickr.com/services/rest/?method=flickr.people.getPhotos&api_key=' + api_key + '&user_id=' + user_id + '&page=' + page + '&per_page=' + per_page;
end;

function TFlickrRest.getPhotoSets(api_key, user_id, page, per_page: string): string;
begin
  Result := 'https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=' + api_key + '&user_id=' + user_id + '&page=' + page + '&per_page=' + per_page;
end;

class function TFlickrRest.New: IFlickrRest;
begin
  Result := Create;
end;

end.
