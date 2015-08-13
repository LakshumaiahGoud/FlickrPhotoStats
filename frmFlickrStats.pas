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

unit frmFlickrStats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdIOHandler, IdIOHandlerStream, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, XMLDoc, xmldom, XMLIntf, msxmldom, Vcl.ComCtrls,
  flickr.repository,
  ExtCtrls, TeEngine, TeeProcs, Chart, Series, VclTee.TeeGDIPlus,
  System.UITypes, flickr.globals,
  Vcl.ImgList, Vcl.Buttons, System.Win.TaskbarCore, Vcl.Taskbar, System.Actions,
  Vcl.ActnList, IdHashMessageDigest, idHash, IdGlobal, Vcl.OleCtrls, SHDocVw,
  flickr.profiles, flickr.profile, flickr.filtered.list, Vcl.Menus,
  frmFlickrContextList, flickr.tendency, diagnostics, flickr.charts, flickr.organic,
  flickr.organic.stats, flickr.lib.options.email, flickr.rejected, flickr.lib.utils,
  frmAuthentication, frmSetup, frmChart, flickr.pools.list, flickr.list.comparer;

type
  TViewType = (TotalViews, TotalLikes, TotalComments, TotalViewsHistogram, TotalLikesHistogram);

  TfrmFlickr = class(TForm)
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    XMLDocument1: TXMLDocument;
    Panel1: TPanel;
    btnSave: TButton;
    ImageList1: TImageList;
    Taskbar1: TTaskbar;
    ActionList1: TActionList;
    Authenticate: TButton;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    PopupMenu1: TPopupMenu;
    MarkGroups1: TMenuItem;
    N1: TMenuItem;
    ShowListGroups1: TMenuItem;
    ShowListAlbums1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    StartMarking1: TMenuItem;
    EndMarking1: TMenuItem;
    N4: TMenuItem;
    CheckAll1: TMenuItem;
    UncheckAll1: TMenuItem;
    btnLoad: TButton;
    Label19: TLabel;
    Label20: TLabel;
    PageControl1: TPageControl;
    Dashboard: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    listPhotos: TListView;
    Panel5: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    photoId: TEdit;
    btnAdd: TButton;
    batchUpdate: TButton;
    btnExcel: TButton;
    chkAddItem: TCheckBox;
    CheckBox2: TCheckBox;
    chkUpdate: TCheckBox;
    chkUpdateCollections: TCheckBox;
    edtfilter: TEdit;
    btnAddFilter: TButton;
    btnResetFilter: TButton;
    ComboBox2: TComboBox;
    Splitter1: TSplitter;
    PageControl2: TPageControl;
    Statistics: TTabSheet;
    Panel4: TPanel;
    TabSheet6: TTabSheet;
    Memo1: TMemo;
    Panel12: TPanel;
    btnLoadHall: TButton;
    TabSheet7: TTabSheet;
    listAlbums: TMemo;
    Panel13: TPanel;
    Button9: TButton;
    Button10: TButton;
    TabSheet3: TTabSheet;
    Panel6: TPanel;
    Label4: TLabel;
    lblfetching: TLabel;
    btnGetList: TButton;
    edtUserId: TEdit;
    progressfetching: TProgressBar;
    listPhotosUser: TListView;
    TabSheet5: TTabSheet;
    Panel8: TPanel;
    Label5: TLabel;
    Label11: TLabel;
    btnGetGroups: TButton;
    progressfetchinggroups: TProgressBar;
    Button2: TButton;
    btnAddPhotos: TButton;
    edtFilterGroup: TEdit;
    btnFilterOK: TButton;
    btnFilterCancel: TButton;
    Profiles: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox1: TComboBox;
    btnLoadProfile: TButton;
    edtProfile: TEdit;
    btnSaveProfile: TButton;
    chkReplaceProfile: TCheckBox;
    chkDisplayOnly: TCheckBox;
    CheckBox1: TCheckBox;
    PageControl3: TPageControl;
    tabList: TTabSheet;
    listGroups: TListView;
    tabStatus: TTabSheet;
    Panel9: TPanel;
    Label10: TLabel;
    pstatus: TProgressBar;
    Panel10: TPanel;
    mStatus: TMemo;
    TabSheet8: TTabSheet;
    mLogs: TMemo;
    TabSheet9: TTabSheet;
    Label9: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtMax: TEdit;
    apikey: TEdit;
    secret: TEdit;
    Button1: TButton;
    showMarks: TCheckBox;
    chkPending: TCheckBox;
    edtMaxLog: TEdit;
    chkRealTime: TCheckBox;
    Button11: TButton;
    listValuesViewsAlbums: TMemo;
    listValuesViewsAlbumsID: TMemo;
    btnLoadOptions: TButton;
    listValuesLikesAlbums: TMemo;
    listValuesLikesAlbumsID: TMemo;
    TabSheet10: TTabSheet;
    Chart2: TChart;
    Series4: TBarSeries;
    Panel14: TPanel;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Panel15: TPanel;
    Panel16: TPanel;
    Splitter8: TSplitter;
    dailyViews: TChart;
    LineSeries2: TBarSeries;
    dailyLikes: TChart;
    BarSeries1: TBarSeries;
    Panel17: TPanel;
    Splitter9: TSplitter;
    ChartViews: TChart;
    ChartComments: TChart;
    LineSeries1: TLineSeries;
    ChartLikes: TChart;
    LineSeries7: TLineSeries;
    Panel18: TPanel;
    Panel19: TPanel;
    ChartHallLikes: TChart;
    PieSeries1: TPieSeries;
    chartAlbum: TChart;
    Series5: TPieSeries;
    chartHallViews: TChart;
    PieSeries2: TPieSeries;
    Splitter3: TSplitter;
    Memo2: TMemo;
    ShowonFlickr1: TMenuItem;
    Splitter4: TSplitter;
    Panel20: TPanel;
    mostviewschart: TChart;
    BarSeries3: TBarSeries;
    mostlikeschart: TChart;
    BarSeries4: TBarSeries;
    organicViews: TChart;
    organicLikes: TChart;
    LineSeries5: TLineSeries;
    groupspread: TChart;
    LineSeries6: TLineSeries;
    executionTime: TChart;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtEmail: TEdit;
    Label31: TLabel;
    ComboBox3: TComboBox;
    LineSeries3: TLineSeries;
    Series7: THorizBarSeries;
    TeeGDIPlus1: TTeeGDIPlus;
    LineSeries4: TLineSeries;
    btnAbout: TButton;
    Splitter5: TSplitter;
    Splitter10: TSplitter;
    Splitter11: TSplitter;
    Splitter12: TSplitter;
    dailyComments: TChart;
    BarSeries5: TBarSeries;
    Splitter13: TSplitter;
    Splitter14: TSplitter;
    Splitter15: TSplitter;
    Splitter16: TSplitter;
    Splitter17: TSplitter;
    Splitter18: TSplitter;
    Label32: TLabel;
    Label33: TLabel;
    chkRejected: TCheckBox;
    chkResponses: TCheckBox;
    btnRemovePhoto: TButton;
    Splitter19: TSplitter;
    organicComments: TChart;
    LineSeries8: TLineSeries;
    Splitter20: TSplitter;
    chartfollowing: TChart;
    BarSeries6: TBarSeries;
    chksorting: TCheckBox;
    N5: TMenuItem;
    Delete1: TMenuItem;
    Panel21: TPanel;
    WebBrowser2: TWebBrowser;
    btnShowReport: TButton;
    Panel11: TPanel;
    chartItemComments: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    chartItemCommentsH: TChart;
    BarSeries2: TBarSeries;
    Splitter2: TSplitter;
    Splitter21: TSplitter;
    Panel22: TPanel;
    Splitter22: TSplitter;
    chartItemViews: TChart;
    LineSeries9: TLineSeries;
    LineSeries10: TLineSeries;
    LineSeries11: TLineSeries;
    ChartItemViewsH: TChart;
    BarSeries7: TBarSeries;
    Splitter23: TSplitter;
    Panel23: TPanel;
    Splitter24: TSplitter;
    chartItemLikes: TChart;
    LineSeries12: TLineSeries;
    LineSeries13: TLineSeries;
    LineSeries14: TLineSeries;
    chartitemLikesH: TChart;
    BarSeries8: TBarSeries;
    ProgressBar1: TProgressBar;
    Process: TLabel;
    CheckBox3: TCheckBox;
    btnAddItems: TButton;
    Label34: TLabel;
    PopupMenu2: TPopupMenu;
    ShowonFlickr2: TMenuItem;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    N6: TMenuItem;
    BanUnbanforgroupAddition1: TMenuItem;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    ClearSelection1: TMenuItem;
    procedure batchUpdateClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure listPhotosItemChecked(Sender: TObject; Item: TListItem);
    procedure FormDestroy(Sender: TObject);
    function isInSeries(id: string): Boolean;
    procedure listPhotosCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnGetListClick(Sender: TObject);
    procedure apikeyChange(Sender: TObject);
    procedure btnAddItemsClick(Sender: TObject);
    procedure btnGetGroupsClick(Sender: TObject);
    procedure AuthenticateClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAddPhotosClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure btnSaveProfileClick(Sender: TObject);
    procedure btnLoadProfileClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure listGroupsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnFilterOKClick(Sender: TObject);
    procedure btnFilterCancelClick(Sender: TObject);
    procedure MarkGroups1Click(Sender: TObject);
    procedure ShowListGroups1Click(Sender: TObject);
    procedure ShowListAlbums1Click(Sender: TObject);
    procedure StartMarking1Click(Sender: TObject);
    procedure EndMarking1Click(Sender: TObject);
    procedure CheckAll1Click(Sender: TObject);
    procedure UncheckAll1Click(Sender: TObject);
    procedure showMarksClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure chartAlbumClickSeries(Sender: TCustomChart; Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button11Click(Sender: TObject);
    procedure btnLoadOptionsClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure btnLoadHallClick(Sender: TObject);
    procedure ShowonFlickr1Click(Sender: TObject);
    procedure listGroupsItemChecked(Sender: TObject; Item: TListItem);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnResetFilterClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnRemovePhotoClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure btnShowReportClick(Sender: TObject);
    procedure Label12DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure listPhotosUserItemChecked(Sender: TObject; Item: TListItem);
    procedure ChartViewsDblClick(Sender: TObject);
    procedure ShowonFlickr2Click(Sender: TObject);
    procedure BanUnbanforgroupAddition1Click(Sender: TObject);
    procedure ClearSelection1Click(Sender: TObject);
  private
    procedure LoadForms(repository: IFlickrRepository);
    function ExistPhotoInList(id: string; var Item: TListItem): Boolean;
    procedure RequestInformation_REST_Flickr(id: string);
    procedure UpdateCounts;
    procedure UpdateTotals(onlyLabels : boolean);
    procedure UpdateChart(totalViews, totalLikes, totalComments, totalPhotos, totalSpreadGroups: Integer);
    procedure UpdateGlobals();
    procedure UpdateAnalytics();
    procedure LoadHallOfFame(repository: IFlickrRepository);
    function SaveToExcel(AView: TListView; ASheetName, AFileName: string): Boolean;
    function getTotalAlbumsCounts: Integer;
    procedure UpdateSingleStats(id: string);
    function SaveToExcelGroups(AView: TListView; ASheetName, AFileName: string): Boolean;
    function ExportGraphToExcel(viewsource : TViewType; ASheetName, AFileName: string): Boolean;
    procedure LoadProfiles;
    procedure UpdateDailyViewsChart;
    procedure UpdateDailyLikesChart;
    procedure UpdateDailyCommentsChart;
    procedure UpdateMostViewedChart;
    procedure UpdateMostLikedChart;
    procedure UpdateLabels;
    procedure AlbumLog(s: string);
    procedure UpdateOrganics;
    procedure UpdateLabel;
    procedure UpdateLabelGroups;
    procedure UpdateLabelPhotos;
  public
    repository: IFlickrRepository;
    globalsRepository: IFlickrGlobals;
    organic : IFlickrOrganic;
    CheckedSeries: TStringList;
    userToken: string;
    userTokenSecret: string;
    flickrProfiles: IProfiles;
    FilteredGroupList: IFilteredList;
    NavigationUrl : String;
    ListDisplay : TfrmFlickrContext;
    startMark : integer;
    endMark : integer;
    flickrChart : IFlickrChart;
    filterEnabled : boolean;
    optionsEMail : IOptionsEmail;
    rejected: IRejected;
    RepositoryLoaded : boolean;
    procedure Log(s: string);
  end;

var
  frmFlickr: TfrmFlickr;

implementation

uses
  flickr.photos, flickr.stats, flickr.rest, flickr.top.stats, ComObj,
  flickr.oauth, StrUtils, flickr.access.token, flickr.lib.parallel, ActiveX,
  System.SyncObjs, generics.collections, flickr.base,
  flickr.pools, flickr.albums, System.inifiles, flickr.time, ShellApi,
  flickr.lib.response, flickr.lib.logging, frmSplash, flickr.lib.email.html;

{$R *.dfm}

procedure TfrmFlickr.apikeyChange(Sender: TObject);
begin
  btnSave.Enabled := true;
end;

procedure TfrmFlickr.AuthenticateClick(Sender: TObject);
var
  OAuthUrl: string;
  response: string;
  oauth_callback_confirmed: string;
  oauth_token: string;
  oauth_token_secret: string;
  authenticationScreen: TfrmAuthenticate;
begin
  // apikey.text 0edf6f13dc6309c822b59ae8bb783df6
  // secret.text b9e217d1c0333300
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  if secret.text = '' then
  begin
    showmessage('Secret key can''t be empty');
    exit;
  end;
  //btnGetToken.enabled := false;
  Log('authentication started');
  // oauthr authentication
  Log('Generating request token query for ' + apikey.text + ' ' + secret.text);
  OAuthUrl := TOAuth.New(apikey.text, secret.text).GenerateRequestTokenQuery();
  // Example successful response
  // oauth_callback_confirmed=true&
  // oauth_token=72157650113637896-43aba062d96def83&
  // oauth_token_secret=153e53c592649722
  Log('Calling OAuth URL ' + OAuthUrl);
  response := IdHTTP1.Get(OAuthUrl);
  Log('OAuth URL response ' + response);

  // Parsing response
  Log('Parsing response');
  // oauth_callback_confirmed=true&oauth_token=72157650113637896-43aba062d96def83&oauth_token_secret=153e53c592649722
  response := response.Replace('oauth_callback_confirmed', '');
  response := response.Replace('oauth_token', '');
  response := response.Replace('_secret', '');
  // =true&=72157650113637896-43aba062d96def83&=153e53c592649722
  oauth_callback_confirmed := AnsiLeftStr(response, AnsiPos('&', response));
  // =true&
  response := AnsiRightStr(response, length(response) - length(oauth_callback_confirmed));
  // =72157650113637896-43aba062d96def83&=153e53c592649722
  oauth_token := AnsiLeftStr(response, AnsiPos('&', response));
  // =72157650113637896-43aba062d96def83&
  response := AnsiRightStr(response, length(response) - length(oauth_token));
  // =153e53c592649722
  oauth_token_secret := response;

  // Clean the parameters
  oauth_callback_confirmed := oauth_callback_confirmed.Replace('=', '').Replace('&', '');
  oauth_token := oauth_token.Replace('=', '').Replace('&', '');
  oauth_token_secret := oauth_token_secret.Replace('=', '').Replace('&', '');
  Log('oauth_callback_confirmed= ' + oauth_callback_confirmed);
  Log('oauth_token= ' + oauth_token);
  Log('oauth_token_secret= ' + oauth_token_secret);

  userTokenSecret := oauth_token_secret;

  authenticationScreen := TfrmAuthenticate.Create(Application);
  try
    authenticationScreen.NavigationUrl := NavigationUrl;
    authenticationScreen.WebBrowser1.Navigate('https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write');
    authenticationScreen.ShowModal;
  finally
    authenticationScreen.Free;
  end;


  Log('Navigating to ' + 'https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write');
  NavigationUrl := 'https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write';
  //WebBrowser1.Navigate('https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write');
  //showmessage('Authorise the application in the browser and once you get the example page, press Get token button');
  //btnGetToken.enabled := true;
end;

procedure TfrmFlickr.BanUnbanforgroupAddition1Click(Sender: TObject);
var
  id : string;
  photo : IPhoto;
begin
  if listPhotos.ItemIndex <> -1 then
  begin
    id := listPhotos.Items[listPhotos.ItemIndex].Caption;
    photo := repository.GetPhoto(id);
    photo.banned := not photo.banned;
    listPhotos.Items[listPhotos.ItemIndex].SubItems[10] := photo.banned.ToString();
  end;
end;

procedure TfrmFlickr.Log(s: string);
var
  max : string;
begin
  max := edtMaxLog.text;
  if mLogs.Lines.Count > max.ToInteger then
    mLogs.Lines.Clear;
  mLogs.Lines.Add(DateTimeToStr(Now) + ' ' + s);
end;

procedure TfrmFlickr.AlbumLog(s: string);
var
  max : string;
begin
  max := edtMaxLog.text;
  if memo2.Lines.Count > max.ToInteger then
    memo2.Lines.Clear;
  memo2.Lines.Add(DateTimeToStr(Now) + ' ' + s);
end;

procedure TfrmFlickr.MarkGroups1Click(Sender: TObject);
var
  id : string;
  photo : IPhoto;
  i: Integer;
  j: Integer;
begin
  //Mark the groups
  if listgroups.Items.Count > 0 then
  begin
    if listPhotos.ItemIndex <> -1 then
    begin
    btnFilterCancelClick(sender);
    id := listPhotos.Items[listPhotos.ItemIndex].Caption;
    photo := repository.GetPhoto(id);
    for i := 0 to photo.Groups.Count-1 do
    begin
      for j := 0 to listgroups.Items.count-1 do
      begin
        if photo.Groups[i].Id = listgroups.Items[j].caption then
        begin
          listgroups.Items[j].Checked := true;
        end;
      end;
    end;
    end;
  end;
end;

procedure TfrmFlickr.batchUpdateClick(Sender: TObject);
var
  i: Integer;
  st : TStopWatch;
  min, max : integer;
begin
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  batchUpdate.Enabled := false;
  btnLoad.Enabled := false;
  btnGetList.Enabled := false;
  ProgressBar1.Visible := true;
  photoId.Enabled := false;
  btnAdd.Enabled := false;
  Process.Visible := true;
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := listPhotos.Items.Count;
  listPhotos.OnItemChecked := nil;
  listPhotos.OnCustomDrawSubItem := nil;
  ProgressBar1.Min := 0;
  ProgressBar1.Max := listPhotos.Items.Count;
  if (startmark <> -1) and (endmark <> -1) then
  begin
    min := startmark;
    max := endmark;
  end
  else
  begin
    min := 0;
    max := listPhotos.Items.Count - 1;
  end;
  for i := min to max do
  begin
    Process.Caption := 'Processing image: ' + listPhotos.Items[i].Caption + ' ' + i.ToString + ' out of ' + listPhotos.Items.Count.ToString;
    ProgressBar1.position := i;
    Taskbar1.ProgressValue := i;
    Application.ProcessMessages;
    if chkUpdate.checked then
    begin
      if listPhotos.items[i].checked then
      begin
        st := TStopWatch.Create;
        st.Start;
        RequestInformation_REST_Flickr(listPhotos.Items[i].Caption);
        st.Stop;
        log('Getting history for ' + listPhotos.Items[i].Caption + ': ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));
      end;
    end
    else
    begin
      st := TStopWatch.Create;
      st.Start;
      RequestInformation_REST_Flickr(listPhotos.Items[i].Caption);
      st.Stop;
      log('Getting history for ' + listPhotos.Items[i].Caption + ': ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));
    end;
  end;

  ProgressBar1.Visible := false;
  Process.Visible := false;
  if not filterEnabled then
  begin
    UpdateTotals(false);
    LoadHallOfFame(repository);
  end;
  listPhotos.OnItemChecked := listPhotosItemChecked;
  listPhotos.OnCustomDrawSubItem := listPhotosCustomDrawSubItem;
  btnSave.Enabled := true;
  photoId.Enabled := true;
  btnLoad.Enabled := true;
  btnAdd.Enabled := true;
  Taskbar1.ProgressValue := 0;
  btnGetList.Enabled := true;
  batchUpdate.Enabled := true;
end;

procedure TfrmFlickr.UpdateTotals(onlyLabels : boolean);
var
  i: Integer;
  Item: TListItem;
  totalViews, totalViewsacc: Integer;
  totalLikes, totalLikesacc: Integer;
  totalComments, totalCommentsacc: Integer;
  stat: IStat;
begin
  totalViewsacc := 0;
  totalLikesacc := 0;
  totalCommentsacc := 0;
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    Item := listPhotos.Items[i];
    totalViews := StrToInt(Item.SubItems.Strings[1]);
    totalViewsacc := totalViewsacc + totalViews;

    totalLikes := StrToInt(Item.SubItems.Strings[2]);;
    totalLikesacc := totalLikesacc + totalLikes;

    totalComments := StrToInt(Item.SubItems.Strings[3]);;
    totalCommentsacc := totalCommentsacc + totalComments;
  end;

  totalViewsacc := totalViewsacc + getTotalAlbumsCounts();

  stat := TStat.Create(Date, totalViewsacc, totalLikesacc, totalCommentsacc);
  globalsRepository.AddGlobals(stat);

  if not onlyLabels then
  begin
    UpdateChart(totalViewsacc, totalLikesacc, totalCommentsacc, repository.photos.Count, repository.getTotalSpreadGroups());
    UpdateGlobals();
    UpdateAnalytics();
  end;
  UpdateLabels();
end;

procedure TfrmFlickr.UpdateLabels();
var
  views : integer;
begin
  Label12.Visible := true;
  Label13.Visible := true;
  Label14.Visible := true;
  Label15.Visible := true;
  Label16.Visible := true;
  Label17.Visible := true;
  Label18.Visible := true;
  Label19.Visible := true;
  Label20.Visible := true;
  Label28.Visible := true;
  Label29.Visible := true;

  if globalsRepository.globals.Count > 3 then
    views := globalsRepository.globals[globalsRepository.globals.Count-2].views-globalsRepository.globals[globalsRepository.globals.Count-3].views
  else
    views := 0;
  Label16.Caption :=  Format('%n',[views.ToDouble]).Replace('.00','');
  if globalsRepository.globals.Count > 2 then
    views := globalsRepository.globals[globalsRepository.globals.Count-1].views-globalsRepository.globals[globalsRepository.globals.Count-2].views
  else
    views := 0;
  Label17.Caption :=  Format('%n',[views.ToDouble]).Replace('.00','');
  views := globalsRepository.globals[globalsRepository.globals.Count-1].views;
  Label18.Caption :=  Format('%n',[views.ToDouble]).Replace('.00','');
  Label29.Caption := DateToStr(globalsRepository.globals[globalsRepository.globals.Count-1].date);
end;

procedure TfrmFlickr.EndMarking1Click(Sender: TObject);
var
  i: Integer;
begin
  if (listPhotos.ItemIndex <> -1) and (startMark <> -1) then
  begin
    endMark :=  listPhotos.ItemIndex;
    for i := 0 to listPhotos.Items.Count - 1 do
    begin
      if (i >= startMark) and (i <= endMark) then
        listPhotos.Items[i].Checked := not listPhotos.Items[i].Checked;
    end;
    //startMark := -1;
    //endMark := -1;
  end;
  UpdateLabel();
end;

function TfrmFlickr.ExistPhotoInList(id: string; var Item: TListItem): Boolean;
var
  i: Integer;
  found: Boolean;
begin
  i := 0;
  found := false;
  while (not found) and (i < listPhotos.Items.Count) do
  begin
    found := listPhotos.Items[i].Caption = id;
    inc(i);
  end;
  if found then
    Item := listPhotos.Items[i - 1];
  Result := found;
end;

procedure TfrmFlickr.RequestInformation_REST_Flickr(id: string);
var
  Item, itemExisting: TListItem;
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4, iXMLRootNode5: IXMLNode;
  views, title, likes, comments, taken: string;
  stat: IStat;
  photo, existing: IPhoto;
  IdHTTP: TIdHTTP;
  IdIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  xmlDocument: IXMLDocument;
  timedout: Boolean;
  Albums: TList<IAlbum>;
  Groups: TPoolList;
  tags : string;
  photoGroups : IPhoto;
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
          response := IdHTTP.Get(TFlickrRest.New().getInfo(apikey.text, id));
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
      tags := '';
      while iXMLRootNode4 <> nil do
      begin
        if iXMLRootNode4.NodeName = 'title' then
          title := iXMLRootNode4.NodeValue;
        if iXMLRootNode4.NodeName = 'dates' then
          taken := iXMLRootNode4.attributes['taken'];
        if iXMLRootNode4.NodeName = 'comments' then
          comments := iXMLRootNode4.NodeValue;
        if iXMLRootNode4.NodeName = 'tags' then
        begin
          iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
          while iXMLRootNode5 <> nil do
          begin
            if (iXMLRootNode5.NodeName = 'tag') and (iXMLRootNode5.NodeValue <> 'jordicorbilla') and (iXMLRootNode5.NodeValue <> 'jordicorbillaphotography') then
              tags := tags + iXMLRootNode5.NodeValue + ',';
            iXMLRootNode5 := iXMLRootNode5.NextSibling;
          end;
        end;
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
          response := IdHTTP.Get(TFlickrRest.New().getFavorites(apikey.text, id));
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

    photo := TPhoto.Create(id, title, taken, tags);
    stat := TStat.Create(Date, StrToInt(views), StrToInt(likes), StrToInt(comments));
    Albums := TList<IAlbum>.create;
    //Groups := TList<IPool>.create;
    photoGroups := repository.GetPhoto(id);
    if photoGroups <> nil then
      Groups := photoGroups.Groups
    else
      Groups := TPoolList.create;

    if chkUpdateCollections.checked then
    begin
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
            response := IdHTTP.Get(TFlickrRest.New().getAllContexts(apikey.text, id));
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
            Groups.AddItem(TPool.create(iXMLRootNode3.attributes['id'], iXMLRootNode3.attributes['title'], Date));
          iXMLRootNode3 := iXMLRootNode3.NextSibling;
        end;
      finally
        IdIOHandler.Free;
        IdHTTP.Free;
        xmlDocument := nil;
      end;
    end;

    if repository.ExistPhoto(photo, existing) then
    begin
      photo := existing;
      photo.Title := title; //replace the title as it changes
      photo.Taken := taken;
      photo.tags := tags;
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

    if not ExistPhotoInList(id, itemExisting) then
    begin
      Item := frmFlickr.listPhotos.Items.Add;
      Item.Caption := frmFlickr.photoId.text;
      Item.SubItems.Add(title);
      Item.SubItems.Add(views);
      Item.SubItems.Add(likes);
      Item.SubItems.Add(comments);
      Item.SubItems.Add(DateToStr(Date));
      if views = '0' then
        views := '1';
      Item.SubItems.Add(taken);
      Item.SubItems.Add(photo.Albums.Count.ToString());
      Item.SubItems.Add(photo.Groups.Count.ToString());
      Item.SubItems.Add(tags);
      Item.SubItems.Add(FormatFloat('0.##%', (likes.ToInteger / views.ToInteger) * 100.0));
      Item.SubItems.Add(photo.banned.ToString());
    end
    else
    begin
      itemExisting.Caption := id;
      itemExisting.SubItems.Clear;
      itemExisting.SubItems.Add(title);
      itemExisting.SubItems.Add(views);
      itemExisting.SubItems.Add(likes);
      itemExisting.SubItems.Add(comments);
      itemExisting.SubItems.Add(DateToStr(Date));
      if views = '0' then
        views := '1';
      itemExisting.SubItems.Add(taken);
      itemExisting.SubItems.Add(photo.Albums.Count.ToString());
      itemExisting.SubItems.Add(photo.Groups.Count.ToString());
      itemExisting.SubItems.Add(tags);
      itemExisting.SubItems.Add(FormatFloat('0.##%', (likes.ToInteger / views.ToInteger) * 100.0));
      itemExisting.SubItems.Add(photo.banned.ToString());
    end;
    if chkRealTime.Checked then
      UpdateTotals(true);
  finally
    CoUninitialize;
  end;
end;

procedure TfrmFlickr.btnAboutClick(Sender: TObject);
var
  SplashScreen: TfrmFlickrSplash;
begin
  SplashScreen := TfrmFlickrSplash.Create(Application);
  try
    SplashScreen.label2.Visible := false;
    SplashScreen.label4.Visible := true;
    SplashScreen.btnClose.Visible := true;
    SplashScreen.ShowModal;
  finally
    SplashScreen.Free;
  end;
end;

procedure TfrmFlickr.btnAddClick(Sender: TObject);
begin
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  listPhotos.OnItemChecked := nil;
  listPhotos.OnCustomDrawSubItem := nil;
  RequestInformation_REST_Flickr(photoId.text);
  photoId.text := '';
  UpdateTotals(false);
  btnSave.Enabled := true;
  listPhotos.OnItemChecked := listPhotosItemChecked;
  listPhotos.OnCustomDrawSubItem := listPhotosCustomDrawSubItem;
  UpdateLabel;
end;

procedure TfrmFlickr.btnLoadClick(Sender: TObject);
var
  st : TStopWatch;
  comparer : TCompareType;
begin
  if Assigned(repository) then
  begin
    repository := nil;
    if chksorting.Checked then
    begin
      comparer := tCompareViews;
      if radioButton1.checked then
        comparer := tCompareId;
      if radioButton2.checked then
        comparer := tCompareViews;
      if radioButton3.checked then
        comparer := tCompareLikes;
      if radioButton4.checked then
        comparer := tCompareComments;
      if radioButton5.checked then
        comparer := tCompareTaken;
      if radioButton6.checked then
        comparer := tCompareAlbums;
      if radioButton7.checked then
        comparer := tCompareGroups;
      repository := TFlickrRepository.Create(chksorting.Checked, comparer)
    end
    else
      repository := TFlickrRepository.Create();
  end;
  st := TStopWatch.Create;
  st.Start;
  repository.sorted := chksorting.Checked;
  repository.load('flickrRepository.xml');
  st.Stop;
  log('Loading repository flickrRepository: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));

  if Assigned(globalsRepository) then
  begin
    globalsRepository := nil;
    globalsRepository := TFlickrGlobals.Create();
  end;
  st := TStopWatch.Create;
  st.Start;
  globalsRepository.load('flickrRepositoryGlobal.xml');
  st.Stop;
  log('Loading repository flickrRepositoryGlobal: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));

  if Assigned(organic) then
  begin
    organic := nil;
    organic := TFlickrOrganic.Create();
  end;
  st := TStopWatch.Create;
  st.Start;
  organic.load('flickrOrganic.xml');
  st.Stop;
  log('Loading repository flickrOrganic: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));

  st := TStopWatch.Create;
  st.Start;
  LoadForms(repository);
  st.Stop;
  log('Loading Forms for repository: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));

  st := TStopWatch.Create;
  st.Start;
  LoadHallOfFame(repository);
  st.Stop;
  log('Loading Hall of fame: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));

  st := TStopWatch.Create;
  st.Start;
  LoadProfiles();
  st.Stop;
  log('Loading Profiles: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));

  Button9Click(sender);
  btnLoadOptionsClick(Sender);
  RepositoryLoaded := true;
end;

procedure TfrmFlickr.btnLoadHallClick(Sender: TObject);
begin
  LoadHallOfFame(repository);
end;

procedure TfrmFlickr.LoadProfiles();
var
  i : integer;
begin
  ComboBox1.Clear;
  if Assigned(flickrProfiles) then
  begin
    flickrProfiles := nil;
    flickrProfiles := TProfiles.Create();
  end;
  flickrProfiles.load('flickrProfiles.xml');
  for i := 0 to flickrProfiles.list.Count - 1 do
  begin
    ComboBox1.AddItem(flickrProfiles.list[i].Name + ' (' + flickrProfiles.list[i].GroupId.Count.ToString + ')', nil);
  end;
end;

procedure TfrmFlickr.LoadHallOfFame(repository: IFlickrRepository);
var
  topStats: TTopStats;
  maxValues: string;
  SeriesV, SeriesL : TPieSeries;
begin
  topStats := TTopStats.Create(repository);
  Memo1.Lines.Clear;
  Memo1.Lines.Add('************************************');
  Memo1.Lines.Add('************ HALL OF FAME **********');
  Memo1.Lines.Add('************************************');

  if chartHallViews.SeriesList.Count > 0 then
    chartHallViews.RemoveAllSeries;
  if chartHallLikes.SeriesList.Count > 0 then
    chartHallLikes.RemoveAllSeries;

  SeriesV := flickrChart.GetNewPieSeries(chartHallViews, true);
  SeriesL := flickrChart.GetNewPieSeries(chartHallLikes, true);

  maxValues := edtMax.text;
  Memo1.Lines.Add(topStats.GetTopXNumberOfViews(maxValues.ToInteger(), SeriesV));
  Memo1.Lines.Add(topStats.GetTopXNumberOfLikes(maxValues.ToInteger(), SeriesL));
  Memo1.Lines.Add(topStats.GetTopXNumberOfComments(maxValues.ToInteger()));

  chartHallViews.AddSeries(SeriesV);
  chartHallLikes.AddSeries(SeriesL);
  topStats.Free;
end;

procedure TfrmFlickr.LoadForms(repository: IFlickrRepository);
begin
  apikey.text := repository.apikey;
  secret.text := repository.secret;
  edtUserId.text := repository.UserId;
  authenticate.Enabled := true;
  listPhotos.Clear;
  UpdateCounts();
  UpdateLabel;
end;

procedure TfrmFlickr.UpdateCounts();
var
  i: Integer;
  Item: TListItem;
  totalViews, totalViewsacc: Integer;
  totalLikes, totalLikesacc: Integer;
  totalComments, totalCommentsacc: Integer;
begin
  totalViewsacc := 0;
  totalLikesacc := 0;
  totalCommentsacc := 0;

  listPhotos.OnCustomDrawSubItem := nil;
  listPhotos.OnItemChecked := nil;

  for i := 0 to repository.photos.Count - 1 do
  begin
    Item := listPhotos.Items.Add;
    Item.Caption := repository.photos[i].id;
    Item.SubItems.Add(repository.photos[i].title);
    totalViews := repository.photos[i].getTotalViews;
    totalViewsacc := totalViewsacc + totalViews;
    Item.SubItems.Add(IntToStr(totalViews));
    totalLikes := repository.photos[i].getTotalLikes;
    totalLikesacc := totalLikesacc + totalLikes;
    Item.SubItems.Add(IntToStr(totalLikes));
    totalComments := repository.photos[i].getTotalComments;
    totalCommentsacc := totalCommentsacc + totalComments;
    Item.SubItems.Add(IntToStr(totalComments));
    Item.SubItems.Add(DateToStr(repository.photos[i].LastUpdate));
    Item.SubItems.Add(repository.photos[i].taken); //taken
    Item.SubItems.Add(repository.photos[i].Albums.Count.ToString()); //albums
    Item.SubItems.Add(repository.photos[i].Groups.Count.ToString()); //groups
    if totalViews = 0 then
      totalViews := 1;
    Item.SubItems.Add(repository.photos[i].tags);
    Item.SubItems.Add(FormatFloat('0.##%', (totalLikes / totalViews) * 100.0));
    Item.SubItems.Add(repository.photos[i].banned.ToString());
  end;

  listPhotos.OnCustomDrawSubItem := listPhotosCustomDrawSubItem;
  listPhotos.OnItemChecked := listPhotosItemChecked;

  UpdateChart(totalViewsacc, totalLikesacc, totalCommentsacc, repository.photos.Count, repository.getTotalSpreadGroups());
  UpdateGlobals();
  UpdateLabels();
  UpdateOrganics();
  UpdateAnalytics();
end;

procedure TfrmFlickr.UpdateOrganics();
var
  SeriesPositive, SeriesNegative, SeriesLost  : TBarSeries;
  i: Integer;
  Series : TAreaSeries;
  SeriesTendency: TLineSeries;
  chartTendency : ITendency;
  viewsTendency : integer;
begin
  if organicViews.SeriesList.Count > 0 then
    organicViews.RemoveAllSeries;

  SeriesPositive := flickrChart.GetNewBarSeries(organicViews);
  OrganicViews.AddSeries(SeriesPositive);
  SeriesPositive.MultiBar := mbStacked;
  SeriesPositive.BarWidthPercent := 25;

  SeriesNegative := flickrChart.GetNewBarSeries(organicViews);
  OrganicViews.AddSeries(SeriesNegative);
  SeriesNegative.MultiBar := mbStacked;
  SeriesNegative.BarWidthPercent := 25;

  chartTendency := TTendency.Create;

  for i := 0 to organic.Globals.Count-1 do
  begin
    chartTendency.AddXY(i, Round((organic.Globals[i].positiveViews * 100)/ (organic.Globals[i].positiveViews + organic.Globals[i].negativeViews)));
    SeriesPositive.AddXY(organic.Globals[i].date, (organic.Globals[i].positiveViews * 100)/ (organic.Globals[i].positiveViews + organic.Globals[i].negativeViews), '', clgreen);
    SeriesNegative.AddXY(organic.Globals[i].date, (organic.Globals[i].negativeViews * 100)/ (organic.Globals[i].positiveViews + organic.Globals[i].negativeViews), '', clred);
  end;
  chartTendency.Calculate;
  SeriesTendency := flickrChart.GetNewLineSeries(organicViews);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(organic.Globals[0].date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(organic.Globals.Count-1);
  SeriesTendency.AddXY(organic.Globals[organic.Globals.Count-1].date, viewsTendency, '', color);

  organicViews.AddSeries(SeriesTendency);

  if organicLikes.SeriesList.Count > 0 then
    organicLikes.RemoveAllSeries;

  SeriesPositive := flickrChart.GetNewBarSeries(organicLikes);
  //SeriesNegative := flickrChart.GetNewBarSeries(organicLikes);
  SeriesLost := flickrChart.GetNewBarSeries(organicLikes);
  organicLikes.AddSeries(SeriesPositive);
  //organicLikes.AddSeries(SeriesNegative);
  organicLikes.AddSeries(SeriesLost);
  SeriesPositive.MultiBar := mbStacked;
  SeriesPositive.BarWidthPercent := 25;
//  SeriesNegative.MultiBar := mbStacked;
//  SeriesNegative.BarWidthPercent := 25;
  SeriesLost.MultiBar := mbStacked;
  SeriesLost.BarWidthPercent := 25;

  chartTendency := TTendency.Create;

  for i := 0 to organic.Globals.Count-1 do
  begin
    chartTendency.AddXY(i, Round((organic.Globals[i].positiveLikes * 100)/ (organic.Globals[i].positiveLikes + organic.Globals[i].negativeLikes + organic.Globals[i].lostLikes)));
    SeriesPositive.AddXY(organic.Globals[i].date, (organic.Globals[i].positiveLikes * 100)/ (organic.Globals[i].positiveLikes + organic.Globals[i].negativeLikes + organic.Globals[i].lostLikes), '', clgreen);
    //SeriesNegative.AddXY(organic.Globals[i].date, (organic.Globals[i].negativeLikes * 100)/ (organic.Globals[i].positiveLikes + organic.Globals[i].negativeLikes + organic.Globals[i].lostLikes), '', clred);
    SeriesLost.AddXY(organic.Globals[i].date, (organic.Globals[i]. lostLikes * 100)/ (organic.Globals[i].positiveLikes + organic.Globals[i].negativeLikes + organic.Globals[i].lostLikes), '', clyellow);
  end;

  chartTendency.Calculate;
  SeriesTendency := flickrChart.GetNewLineSeries(organicLikes);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(organic.Globals[0].date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(organic.Globals.Count-1);
  SeriesTendency.AddXY(organic.Globals[organic.Globals.Count-1].date, viewsTendency, '', color);

  organicLikes.AddSeries(SeriesTendency);

  if organicComments.SeriesList.Count > 0 then
    organicComments.RemoveAllSeries;

  SeriesPositive := flickrChart.GetNewBarSeries(organicComments);
  //SeriesNegative := flickrChart.GetNewBarSeries(organicComments);
  SeriesLost := flickrChart.GetNewBarSeries(organicComments);
  organicComments.AddSeries(SeriesPositive);
  //organicComments.AddSeries(SeriesNegative);
  organicComments.AddSeries(SeriesLost);
  SeriesPositive.MultiBar := mbStacked;
  SeriesPositive.BarWidthPercent := 25;
//  SeriesNegative.MultiBar := mbStacked;
//  SeriesNegative.BarWidthPercent := 25;
  SeriesLost.MultiBar := mbStacked;
  SeriesLost.BarWidthPercent := 25;

  chartTendency := TTendency.Create;

  for i := 0 to organic.Globals.Count-1 do
  begin
    chartTendency.AddXY(i, Round((organic.Globals[i].positiveComments * 100)/ (organic.Globals[i].positiveComments + organic.Globals[i].negativeComments + organic.Globals[i].lostComments)));
    SeriesPositive.AddXY(organic.Globals[i].date, (organic.Globals[i].positiveComments * 100)/ (organic.Globals[i].positiveComments + organic.Globals[i].negativeComments + organic.Globals[i].lostComments), '', clgreen);
    //SeriesNegative.AddXY(organic.Globals[i].date, (organic.Globals[i].negativeComments * 100)/ (organic.Globals[i].positiveComments + organic.Globals[i].negativeComments + organic.Globals[i].lostComments), '', clred);
    SeriesLost.AddXY(organic.Globals[i].date, (organic.Globals[i]. lostComments * 100)/ (organic.Globals[i].positiveComments + organic.Globals[i].positiveComments + organic.Globals[i].lostComments), '', clyellow);
  end;

  chartTendency.Calculate;
  SeriesTendency := flickrChart.GetNewLineSeries(organicComments);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(organic.Globals[0].date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(organic.Globals.Count-1);
  SeriesTendency.AddXY(organic.Globals[organic.Globals.Count-1].date, viewsTendency, '', color);

  organicComments.AddSeries(SeriesTendency);

  if executionTime.SeriesList.Count > 0 then
    executionTime.RemoveAllSeries;

  Series := flickrChart.GetNewAreaSeries(executionTime);
  color := RGB(Random(255), Random(255), Random(255));

  chartTendency := TTendency.Create;

  for i := 0 to organic.Globals.Count-1 do
  begin
    chartTendency.AddXY(i, Round(TTime.GetAdjustedTimeValue(organic.Globals[i].executionTime)));
    Series.AddXY(organic.Globals[i].date, TTime.GetAdjustedTimeValue(organic.Globals[i].executionTime), '', color);
  end;
  executionTime.AddSeries(Series);

  chartTendency.Calculate;

  SeriesTendency := flickrChart.GetNewLineSeries(executionTime);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(organic.Globals[0].date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(organic.Globals.Count-1);
  SeriesTendency.AddXY(organic.Globals[organic.Globals.Count-1].date, viewsTendency, '', color);

  executionTime.AddSeries(SeriesTendency);

  //Group spread
  if groupspread.SeriesList.Count > 0 then
    groupspread.RemoveAllSeries;

  SeriesPositive := flickrChart.GetNewBarSeries(groupspread);

  chartTendency := TTendency.Create;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 0 to organic.Globals.Count-1 do
  begin
    chartTendency.AddXY(i, organic.Globals[i].TotalGroups);
    SeriesPositive.AddXY(organic.Globals[i].date, organic.Globals[i].TotalGroups, '', color);
  end;

  chartTendency.Calculate;
  SeriesTendency := flickrChart.GetNewLineSeries(groupspread);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(organic.Globals[0].date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(organic.Globals.Count-1);
  SeriesTendency.AddXY(organic.Globals[organic.Globals.Count-1].date, viewsTendency, '', color);

  groupspread.AddSeries(SeriesTendency);


  //Following
  if chartFollowing.SeriesList.Count > 0 then
    chartFollowing.RemoveAllSeries;

  SeriesPositive := flickrChart.GetNewBarSeries(chartFollowing);

  chartTendency := TTendency.Create;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 0 to organic.Globals.Count-1 do
  begin
    chartTendency.AddXY(i, organic.Globals[i].Following);
    SeriesPositive.AddXY(organic.Globals[i].date, organic.Globals[i].Following, '', color);
  end;

  chartTendency.Calculate;
  SeriesTendency := flickrChart.GetNewLineSeries(chartFollowing);
  color := clYellow;

  label32.Visible := true;
  label33.Caption := Format('%n',[organic.Globals[organic.Globals.Count-1].Following.ToDouble]).Replace('.00','');
  label33.Visible := true;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(organic.Globals[0].date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(organic.Globals.Count-1);
  SeriesTendency.AddXY(organic.Globals[organic.Globals.Count-1].date, viewsTendency, '', color);

  chartFollowing.AddSeries(SeriesTendency);
end;

procedure TfrmFlickr.UpdateGlobals;
var
  Series, SeriesTendency: TLineSeries;
  color: TColor;
  i: Integer;
  chartTendency : ITendency;
  viewsTendency : integer;
begin
  if ChartViews.SeriesList.Count > 0 then
    ChartViews.RemoveAllSeries;

  chartTendency := TTendency.Create;

  Series := flickrChart.GetNewLineSeries(ChartViews);
  color := RGB(Random(255), Random(255), Random(255));

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    chartTendency.AddXY(i, globalsRepository.Globals[i].views);
    Series.AddXY(globalsRepository.globals[i].Date, globalsRepository.globals[i].views, '', color);
  end;
  ChartViews.AddSeries(Series);
  chartTendency.Calculate;

  SeriesTendency := flickrChart.GetNewLineSeries(ChartViews);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(globalsRepository.globals[0].Date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(globalsRepository.globals.Count - 1);
  SeriesTendency.AddXY(globalsRepository.globals[globalsRepository.globals.Count - 1].Date, viewsTendency, '', color);
//  for i := 0 to globalsRepository.globals.Count - 1 do
//  begin
//    viewsTendency := chartTendency.tendencyResult(i);
//    SeriesTendency.AddXY(globalsRepository.globals[i].Date, viewsTendency, '', color);
//  end;
  ChartViews.AddSeries(SeriesTendency);

  if ChartLikes.SeriesList.Count > 0 then
    ChartLikes.RemoveAllSeries;

  Series := flickrChart.GetNewLineSeries(ChartLikes);
  color := RGB(Random(255), Random(255), Random(255));
  chartTendency := TTendency.Create;
  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    chartTendency.AddXY(i, globalsRepository.globals[i].likes);
    Series.AddXY(globalsRepository.globals[i].Date, globalsRepository.globals[i].likes, '', color);
  end;
  ChartLikes.AddSeries(Series);

  chartTendency.Calculate;

  SeriesTendency := flickrChart.GetNewLineSeries(ChartLikes, false);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(globalsRepository.globals[0].Date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(globalsRepository.globals.Count - 1);
  SeriesTendency.AddXY(globalsRepository.globals[globalsRepository.globals.Count - 1].Date, viewsTendency, '', color);

  if ChartComments.SeriesList.Count > 0 then
    ChartComments.RemoveAllSeries;

  Series := flickrChart.GetNewLineSeries(ChartComments);
  color := RGB(Random(255), Random(255), Random(255));
  chartTendency := TTendency.Create;
  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    chartTendency.AddXY(i, globalsRepository.globals[i].numComments);
    Series.AddXY(globalsRepository.globals[i].Date, globalsRepository.globals[i].numComments, '', color);
  end;
  ChartComments.AddSeries(Series);

  chartTendency.Calculate;

  SeriesTendency := flickrChart.GetNewLineSeries(ChartComments, false);
  color := clYellow;

  //Adding only first and last item
  viewsTendency := chartTendency.tendencyResult(0);
  SeriesTendency.AddXY(globalsRepository.globals[0].Date, viewsTendency, '', color);
  viewsTendency := chartTendency.tendencyResult(globalsRepository.globals.Count - 1);
  SeriesTendency.AddXY(globalsRepository.globals[globalsRepository.globals.Count - 1].Date, viewsTendency, '', color);
end;

procedure TfrmFlickr.UncheckAll1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    listPhotos.Items[i].Checked := false;
  end;
end;

procedure TfrmFlickr.UpdateDailyViewsChart();
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  theDate: TDateTime;
  views, viewsTotal, average: Integer;
  averageSeries, tendencySeries: TLineSeries;
  viewsTendency : ITendency;
begin
  if dailyViews.SeriesList.Count > 0 then
    dailyViews.RemoveAllSeries;

  Series := flickrChart.GetNewBarSeries(dailyViews);
  color := RGB(Random(255), Random(255), Random(255));

  viewsTendency := TTendency.Create;

  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    views := globalsRepository.globals[i].views - globalsRepository.globals[i - 1].views;
    viewsTendency.AddXY(i, views);
    Series.AddXY(theDate, views, '', color);
  end;

  dailyViews.AddSeries(Series);

  viewsTendency.Calculate;

  // Add average views
  averageSeries := flickrChart.GetNewLineSeries(dailyViews);
  color := clRed;

  viewsTotal := 0;
  for i := 1 to globalsRepository.globals.Count - 1 do
    viewsTotal := viewsTotal + (globalsRepository.globals[i].views - globalsRepository.globals[i - 1].views);

  average := round(viewsTotal / globalsRepository.globals.Count);

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    averageSeries.AddXY(theDate, average, '', color);
  end;

  dailyViews.AddSeries(averageSeries);

  //Add tendency line
  if globalsRepository.globals.Count > 1 then
  begin
    tendencySeries := flickrChart.GetNewLineSeries(dailyViews);
    color := clYellow;

    //Adding only first and last item
    theDate := globalsRepository.globals[0].Date;
    views := viewsTendency.tendencyResult(0);
    tendencySeries.AddXY(theDate, views, '', color);
    theDate := globalsRepository.globals[globalsRepository.globals.Count - 1].Date;
    views := viewsTendency.tendencyResult(globalsRepository.globals.Count - 1);
    tendencySeries.AddXY(theDate, views, '', color);

    dailyViews.AddSeries(tendencySeries);

    views := viewsTendency.tendencyResult(globalsRepository.globals.Count);
    Label20.Caption :=  Format('%n',[views.ToDouble]).Replace('.00','');
  end;
end;

procedure TfrmFlickr.UpdateDailyCommentsChart;
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  theDate: TDateTime;
  views, viewsTotal, average: Integer;
  averageLikes, tendencySeries: TLineSeries;
  viewsTendency : ITendency;
begin
  if dailyComments.SeriesList.Count > 0 then
    dailyComments.RemoveAllSeries;

  Series := flickrChart.GetNewBarSeries(dailyComments);
  color := RGB(Random(255), Random(255), Random(255));
  viewsTendency := TTendency.Create;
  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    views := globalsRepository.globals[i].numComments - globalsRepository.globals[i - 1].numComments;
    viewsTendency.AddXY(i, views);
    Series.AddXY(theDate, views, '', color);
  end;

  dailyComments.AddSeries(Series);
  viewsTendency.Calculate;
  // Add average views
  averageLikes := flickrChart.GetNewLineSeries(dailyComments);
  color := clRed;

  viewsTotal := 0;
  for i := 1 to globalsRepository.globals.Count - 1 do
    viewsTotal := viewsTotal + (globalsRepository.globals[i].numComments - globalsRepository.globals[i - 1].numComments);

  average := round(viewsTotal / globalsRepository.globals.Count);

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    averageLikes.AddXY(theDate, average, '', color);
  end;

  dailyComments.AddSeries(averageLikes);

  //Add tendency line
  tendencySeries := flickrChart.GetNewLineSeries(dailyComments);
  color := clYellow;

  if globalsRepository.globals.Count > 1 then
  begin
    //Adding only first and last item
    theDate := globalsRepository.globals[0].Date;
    views := viewsTendency.tendencyResult(0);
    tendencySeries.AddXY(theDate, views, '', color);
    theDate := globalsRepository.globals[globalsRepository.globals.Count - 1].Date;
    views := viewsTendency.tendencyResult(globalsRepository.globals.Count - 1);
    tendencySeries.AddXY(theDate, views, '', color);

    dailyComments.AddSeries(tendencySeries);
  end;
end;

procedure TfrmFlickr.UpdateDailyLikesChart();
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  theDate: TDateTime;
  views, viewsTotal, average: Integer;
  averageLikes, tendencySeries: TLineSeries;
  viewsTendency : ITendency;
begin
  if dailyLikes.SeriesList.Count > 0 then
    dailyLikes.RemoveAllSeries;

  Series := flickrChart.GetNewBarSeries(dailyLikes);
  color := RGB(Random(255), Random(255), Random(255));
  viewsTendency := TTendency.Create;
  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    views := globalsRepository.globals[i].likes - globalsRepository.globals[i - 1].likes;
    viewsTendency.AddXY(i, views);
    Series.AddXY(theDate, views, '', color);
  end;

  dailyLikes.AddSeries(Series);
  viewsTendency.Calculate;
  // Add average views
  averageLikes := flickrChart.GetNewLineSeries(dailyLikes);
  color := clRed;

  viewsTotal := 0;
  for i := 1 to globalsRepository.globals.Count - 1 do
    viewsTotal := viewsTotal + (globalsRepository.globals[i].likes - globalsRepository.globals[i - 1].likes);

  average := round(viewsTotal / globalsRepository.globals.Count);

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    averageLikes.AddXY(theDate, average, '', color);
  end;

  dailyLikes.AddSeries(averageLikes);

  //Add tendency line
  if globalsRepository.globals.Count > 1 then
  begin
    tendencySeries := flickrChart.GetNewLineSeries(dailyLikes);
    color := clYellow;

    //Adding only first and last item
    theDate := globalsRepository.globals[0].Date;
    views := viewsTendency.tendencyResult(0);
    tendencySeries.AddXY(theDate, views, '', color);
    theDate := globalsRepository.globals[globalsRepository.globals.Count - 1].Date;
    views := viewsTendency.tendencyResult(globalsRepository.globals.Count - 1);
    tendencySeries.AddXY(theDate, views, '', color);

    dailyLikes.AddSeries(tendencySeries);
  end;
end;

procedure TfrmFlickr.UpdateAnalytics;
begin
  UpdateDailyViewsChart();
  UpdateDailyLikesChart();
  UpdateDailyCommentsChart();
  UpdateMostViewedChart();
  UpdateMostLikedChart();
end;

procedure TfrmFlickr.UpdateMostLikedChart();
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  PhotosSorted: TList<IPhoto>;
  topStats : TTopStats;
  maxValue : string;
begin
  if mostlikeschart.SeriesList.Count > 0 then
    mostlikeschart.RemoveAllSeries;

  Series := flickrChart.GetNewBarSeries(mostlikeschart);
  color := RGB(Random(255), Random(255), Random(255));

  topStats := TTopStats.Create(repository);
  PhotosSorted := nil;
  try
    PhotosSorted := topStats.GetTopXNumberofMostLiked();
    maxValue := edtMax.Text;
    for i := 0 to maxValue.ToInteger -1 do
    begin
      if i < PhotosSorted.count then
      begin
        Series.AddBar(PhotosSorted[i].getHighestLikes(), PhotosSorted[i].Id, color);
      end;
    end;
  finally
    topStats.Free;
    PhotosSorted.Free;
  end;
end;

procedure TfrmFlickr.UpdateMostViewedChart();
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  PhotosSorted: TList<IPhoto>;
  topStats : TTopStats;
  maxValues : string;
begin
  if mostviewschart.SeriesList.Count > 0 then
    mostviewschart.RemoveAllSeries;

  Series := flickrChart.GetNewBarSeries(mostviewschart);
  color := RGB(Random(255), Random(255), Random(255));

  topStats := TTopStats.Create(repository);
  PhotosSorted := nil;
  try
    PhotosSorted := topStats.GetTopXNumberofMostViewed();
    maxValues := edtMax.text;
    for i := 0 to maxValues.ToInteger() - 1 do
    begin
      if i < PhotosSorted.count then
      begin
        Series.AddBar(PhotosSorted[i].getHighestViews(), PhotosSorted[i].Id, color);
      end;
    end;
  finally
    topStats.Free;
    PhotosSorted.Free;
  end;
end;

procedure TfrmFlickr.UpdateSingleStats(id: string);
var
  SeriesViews, SeriesLikes, SeriesComments: TBarSeries;
  color: TColor;
  i: Integer;
  theDate: TDateTime;
  views: Integer;
  photo: IPhoto;
begin
  SeriesViews := flickrChart.GetNewBarSeries(chartItemViewsH);
  SeriesLikes := flickrChart.GetNewBarSeries(chartItemLikesH);
  SeriesComments := flickrChart.GetNewBarSeries(chartItemCommentsH);
  SeriesViews.Title := id;
  SeriesLikes.Title := id;
  SeriesComments.Title := id;
  color := RGB(Random(255), Random(255), Random(255));

  photo := repository.GetPhoto(id);

  for i := 1 to photo.stats.Count - 1 do
  begin
    theDate := photo.stats[i].Date;
    views := photo.stats[i].views - photo.stats[i - 1].views;
    SeriesViews.AddXY(theDate, views, '', color);

    views := photo.stats[i].likes - photo.stats[i - 1].likes;
    SeriesLikes.AddXY(theDate, views, '', color);

    views := photo.stats[i].numComments - photo.stats[i - 1].numComments;
    SeriesComments.AddXY(theDate, views, '', color);
  end;

  chartItemViewsH.AddSeries(SeriesViews);
  chartItemLikesH.AddSeries(SeriesLikes);
  chartItemCommentsH.AddSeries(SeriesComments);
end;

procedure TfrmFlickr.UpdateChart(totalViews, totalLikes, totalComments, totalPhotos, totalSpreadGroups: Integer);
var
  Series: TBarSeries;
  color: TColor;
begin
  if Chart2.SeriesList.Count > 0 then
    Chart2.RemoveAllSeries;

  Series := flickrChart.GetNewBarSeries(Chart2, true);
  color := RGB(Random(255), Random(255), Random(255));
  Series.AddBar(totalViews, 'Views', color);
  color := RGB(Random(255), Random(255), Random(255));
  Series.AddBar(totalLikes, 'Likes', color);
  color := RGB(Random(255), Random(255), Random(255));
  Series.AddBar(totalComments, 'Comments', color);
  color := RGB(Random(255), Random(255), Random(255));
  Series.AddBar(totalPhotos, 'Photos', color);
  color := RGB(Random(255), Random(255), Random(255));
  Series.AddBar(totalSpreadGroups, 'Group spread', color);
  Chart2.AddSeries(Series);
end;

procedure TfrmFlickr.btnSaveClick(Sender: TObject);
var
  st : TSTopwatch;
  option : Integer;
begin
  option := MessageDlg('Do you want to save the changes?',mtInformation, mbOKCancel, 0);
  if option = mrOK then
  begin
    st := TStopWatch.Create;
    st.Start;
    repository.save(apikey.text, secret.text, edtUserId.text, 'flickrRepository.xml');
    st.Stop;
    log('Saving repository flickrRepository: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));
    st := TStopWatch.Create;
    st.Start;
    globalsRepository.save('flickrRepositoryGlobal.xml');
    st.Stop;
    log('Saving repository flickrRepositoryGlobal: ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));
    btnSave.Enabled := false;
    btnLoad.Enabled := true;
  end;
end;

procedure TfrmFlickr.Button10Click(Sender: TObject);
var
  I: Integer;
  j : Integer;
  photo : IPhoto;
  urlAdd : string;
  timedOut : boolean;
  response : string;
  value : string;
begin
  if (apikey.text = '') or (userToken = '') then
  begin
    showmessage('You are not authorized!');
    exit;
  end;
  //Organise pictures.
  //Get the picture from the left and with current value of views and likes and move them to the album.
  for I := 0 to repository.photos.Count-1 do
  begin
    for j := 0 to listValuesViewsAlbums.Lines.Count-1 do
    begin
      photo := repository.photos[i];
      value := listValuesViewsAlbums.Lines[j].Replace('.','');
      if (photo.getTotalViews() >= value.ToInteger) then
      begin
        //Add the photo to the album
        if not photo.inAlbum(listValuesViewsAlbumsID.Lines[j]) then
        begin
          urlAdd := TFlickrRest.New().getPhotoSetsAdd(apikey.text, userToken, secret.text, userTokenSecret, photo.Id, listValuesViewsAlbumsID.Lines[j]);
          timedout := false;
          while (not timedout) do
          begin
            try
              response := IdHTTP1.Get(urlAdd);
              response := TResponse.filter(response);
              AlbumLog(response + ' ' + photo.Title + ' -> ' + value);
              timedout := true;
            except
              on e: exception do
              begin
                sleep(2000);
                timedout := false;
              end;
            end;
          end;
        end;
      end;
    end;

    for j := 0 to listValuesLikesAlbums.Lines.Count-1 do
    begin
      photo := repository.photos[i];
      value := listValuesLikesAlbums.Lines[j].Replace('.','');
      if (photo.getTotalLikes() >= value.ToInteger) then
      begin
        //Add the photo to the album
        if not photo.inAlbum(listValuesLikesAlbumsID.Lines[j]) then
        begin
          urlAdd := TFlickrRest.New().getPhotoSetsAdd(apikey.text, userToken, secret.text, userTokenSecret, photo.Id, listValuesLikesAlbumsID.Lines[j]);
          timedout := false;
          while (not timedout) do
          begin
            try
              response := IdHTTP1.Get(urlAdd);
              response := TResponse.filter(response);
              response := response.Replace('"', '');
              AlbumLog(response + ' ' + photo.Title + ' -> ' + value);
              timedout := true;
            except
              on e: exception do
              begin
                sleep(2000);
                timedout := false;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmFlickr.Button11Click(Sender: TObject);
var
  iniFile : TInifile;
  i: Integer;
begin
  inifile := TInifile.Create(ExtractFilePath(ParamStr(0)) + 'FlickrAnalytics.ini');
  try
    inifile.WriteString('System', 'MaxItemsListGlobals', edtMax.Text);
    inifile.WriteBool('System', 'ShowMarksInGraphs', showMarks.Checked);
    inifile.WriteBool('System', 'ConsiderPendingQueueItems', chkPending.Checked);
    inifile.WriteBool('System', 'UpdateCountsRealTime', chkRealTime.Checked);
    inifile.WriteString('System', 'MaxNumberOfLinesLog', edtMaxLog.Text);
    inifile.WriteString('System', 'eMailAddress', edtEmail.Text);

    inifile.WriteInteger('AlbumViews', 'MaxItems', listValuesViewsAlbums.Lines.count);

    for i := 0 to listValuesViewsAlbums.Lines.Count-1 do
    begin
      inifile.WriteString('AlbumViews', 'Value' + i.ToString(), listValuesViewsAlbums.Lines[i]);
      inifile.WriteString('AlbumViews', 'ValueID' + i.ToString(), listValuesViewsAlbumsID.Lines[i]);
    end;

    inifile.WriteInteger('AlbumLikes', 'MaxItems', listValuesLikesAlbums.Lines.count);

    for i := 0 to listValuesLikesAlbums.Lines.Count-1 do
    begin
      inifile.WriteString('AlbumLikes', 'Value' + i.ToString(), listValuesLikesAlbums.Lines[i]);
      inifile.WriteString('AlbumLikes', 'ValueID' + i.ToString(), listValuesLikesAlbumsID.Lines[i]);
    end;
  finally
    inifile.Free;
  end;

  optionsEmail.flickrApiKey := apikey.Text;
  optionsEmail.secret := secret.Text;
  optionsEmail.userToken := userToken;
  optionsEmail.userTokenSecret := userTokenSecret;
  optionsEmail.flickrUserId := edtUserId.Text;
  optionsEMail.save;
end;

procedure TfrmFlickr.btnLoadOptionsClick(Sender: TObject);
var
  inifile : Tinifile;
  maxAlbumViews : integer;
  maxAlbumLikes : integer;
  i : integer;
  value : string;
begin
  inifile := TInifile.Create(ExtractFilePath(ParamStr(0)) + 'FlickrAnalytics.ini');
  try
    edtMax.Text := inifile.ReadString('System', 'MaxItemsListGlobals', '80');
    showMarks.Checked := inifile.ReadBool('System', 'ShowMarksInGraphs', false);
    chkPending.Checked := inifile.ReadBool('System', 'ConsiderPendingQueueItems', true);
    chkRealTime.Checked := inifile.ReadBool('System', 'UpdateCountsRealTime', false);
    edtMaxLog.Text := inifile.ReadString('System', 'MaxNumberOfLinesLog', '10000');
    edtEmail.Text := inifile.ReadString('System', 'eMailAddress', '');

    maxAlbumViews := inifile.ReadInteger('AlbumViews', 'MaxItems', 0);

    listValuesViewsAlbums.Lines.Clear;
    listValuesViewsAlbumsID.Lines.Clear;
    for i := 0 to maxAlbumViews - 1 do
    begin
      value := inifile.ReadString('AlbumViews', 'Value' + i.ToString(), '');
      listValuesViewsAlbums.Lines.Add(value);
      value := inifile.ReadString('AlbumViews', 'ValueID' + i.ToString(), '');
      listValuesViewsAlbumsID.Lines.Add(value);
    end;

    maxAlbumLikes := inifile.ReadInteger('AlbumLikes', 'MaxItems', 0);

    listValuesLikesAlbums.Lines.Clear;
    listValuesLikesAlbumsID.Lines.Clear;
    for i := 0 to maxAlbumLikes - 1 do
    begin
      value := inifile.ReadString('AlbumLikes', 'Value' + i.ToString(), '');
      listValuesLikesAlbums.Lines.Add(value);
      value := inifile.ReadString('AlbumLikes', 'ValueID' + i.ToString(), '');
      listValuesLikesAlbumsID.Lines.Add(value);
    end;
  finally
    inifile.Free;
  end;

  optionsEMail := TOptionsEmail.New().load();
  apikey.Text := optionsEmail.flickrApiKey;
  secret.Text := optionsEMail.secret;
  edtUserId.Text := optionsEmail.flickrUserId;
end;

procedure TfrmFlickr.Button1Click(Sender: TObject);
var
  urlGroups: string;
  response: string;
begin
  urlGroups := TFlickrRest.New().getTestLogin(apikey.text, userToken, secret.text, userTokenSecret);
  response := IdHTTP1.Get(urlGroups);
  showmessage(response);
end;

procedure TfrmFlickr.Button2Click(Sender: TObject);
begin
  if SaveToExcelGroups(listGroups, 'Flickr Analytics', ExtractFilePath(ParamStr(0)) + 'FlickrAnalyticsGroups.xls') then
    showmessage('Data saved successfully!');
end;

procedure TfrmFlickr.btnAddFilterClick(Sender: TObject);
var
  i: Integer;
  add : boolean;
  value : string;
  Item : TListItem;
begin
  listPhotos.Items.Clear;
  filterEnabled := true;
  btnSave.Enabled := false;
  btnLoad.Enabled := false;
  startMark := -1;
  endMark := -1;
  value := edtFilter.text;
  for i := 0 to repository.photos.count-1 do
  begin
    add := false;
    case Combobox2.ItemIndex of
          0: //ID
          begin
            case combobox3.ItemIndex of
              0: add := repository.photos[i].Id = value;
              1: add := repository.photos[i].Id.ToExtended < value.ToExtended;
              2: add := repository.photos[i].Id.ToExtended > value.ToExtended;
              3: add := repository.photos[i].Id.ToExtended <= value.ToExtended;
              4: add := repository.photos[i].Id.ToExtended >= value.ToExtended;
              5: add := repository.photos[i].Id <> value;
              6: add := repository.photos[i].Id.ToLower.Contains(value.ToLower);
            end;
          end;
          1: //Title
          begin
            case combobox3.ItemIndex of
              0,1,2,3,4: add := repository.photos[i].title = value;
              5: add := repository.photos[i].title <> edtfilter.Text;
              6: add := repository.photos[i].title.ToLower.Contains(value.ToLower);
            end;
          end;
          2: //Views
          begin
            case combobox3.ItemIndex of
              0: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views.tostring = value;
              1: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views < value.Tointeger;
              2: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views > value.Tointeger;
              3: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views <= value.Tointeger;
              4: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views >= value.Tointeger;
              5: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views <> value.ToInteger;
              6: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].views.tostring.ToLower.Contains(value.ToLower);
            end;
          end;
          3: //Likes
          begin
            case combobox3.ItemIndex of
              0: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes.tostring = value;
              1: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes < value.Tointeger;
              2: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes > value.Tointeger;
              3: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes <= value.Tointeger;
              4: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes >= value.Tointeger;
              5: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes <> value.ToInteger;
              6: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].likes.tostring.ToLower.Contains(value.ToLower);
            end;
          end;
          4: //Comments
          begin
            case combobox3.ItemIndex of
              0: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments.tostring = value;
              1: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments < value.Tointeger;
              2: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments > value.Tointeger;
              3: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments <= value.Tointeger;
              4: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments >= value.Tointeger;
              5: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments <> value.ToInteger;
              6: add := repository.photos[i].stats[repository.photos[i].stats.Count-1].numComments.tostring.ToLower.Contains(value.ToLower);
            end;
          end;
          5: //Last Update
          begin
            case combobox3.ItemIndex of
              0,1,2,3,4,5,6: add := FormatDateTime('dd/mm/yyyy', repository.photos[i].LastUpdate).ToLower.Contains(value.ToLower);
            end;
          end;
          6: //Taken
          begin
            case combobox3.ItemIndex of
              0,1,2,3,4,5,6: add := repository.photos[i].Taken.ToLower.Contains(value.ToLower);
            end;
          end;
          7: //Albums
          begin
            case combobox3.ItemIndex of
              0: add := repository.photos[i].Albums.count.ToString = value;
              1: add := repository.photos[i].Albums.count < value.ToInteger;
              2: add := repository.photos[i].Albums.count > value.ToInteger;
              3: add := repository.photos[i].Albums.count <= value.ToInteger;
              4: add := repository.photos[i].Albums.count >= value.ToInteger;
              5: add := repository.photos[i].Albums.count <> value.ToInteger;
              6: add := repository.photos[i].Albums.count.ToString.ToLower.Contains(value.ToLower);
            end;
          end;
          8: //Groups
          begin
            case combobox3.ItemIndex of
              0: add := repository.photos[i].Groups.count.ToString = value;
              1: add := repository.photos[i].Groups.count < value.ToInteger;
              2: add := repository.photos[i].Groups.count > value.ToInteger;
              3: add := repository.photos[i].Groups.count <= value.ToInteger;
              4: add := repository.photos[i].Groups.count >= value.ToInteger;
              5: add := repository.photos[i].Groups.count <> value.ToInteger;
              6: add := repository.photos[i].Groups.count.ToString.ToLower.Contains(value.ToLower);
            end;
          end;
          9: //Tags
          begin
            case combobox3.ItemIndex of
              0,1,2,3,4,5,6: add := repository.photos[i].tags.ToLower.Contains(value.ToLower);
            end;
          end;
          10: //Affection
          begin

          end;
      end;
      if add then
      begin
        Item := frmFlickr.listPhotos.Items.Add;
        Item.Caption := repository.photos[i].Id;
        Item.SubItems.Add(repository.photos[i].Title);
        Item.SubItems.Add(repository.photos[i].stats[repository.photos[i].stats.Count-1].views.toString);
        Item.SubItems.Add(repository.photos[i].stats[repository.photos[i].stats.Count-1].likes.toString);
        Item.SubItems.Add(repository.photos[i].stats[repository.photos[i].stats.Count-1].numcomments.toString);
        Item.SubItems.Add((DateToStr(repository.photos[i].stats[repository.photos[i].stats.Count-1].date)));
        Item.SubItems.Add(repository.photos[i].Taken);
        Item.SubItems.Add(repository.photos[i].Albums.Count.ToString());
        Item.SubItems.Add(repository.photos[i].Groups.Count.ToString());
        Item.SubItems.Add(repository.photos[i].Tags);
        Item.SubItems.Add(FormatFloat('0.##%', (repository.photos[i].stats[repository.photos[i].stats.Count-1].likes / repository.photos[i].stats[repository.photos[i].stats.Count-1].views) * 100.0));
        Item.SubItems.Add(repository.photos[i].banned.ToString());
      end;
      Label31.Caption := 'Number of items: ' + InttoStr(listphotos.Items.Count) + ' (0) selected';
  end;
end;

procedure TfrmFlickr.btnResetFilterClick(Sender: TObject);
begin
  //Restore everything as it was.
  startMark := -1;
  endMark := -1;
  listPhotos.OnItemChecked := nil;
  listPhotos.OnCustomDrawSubItem := nil;
  filterEnabled := false;
  btnSave.Enabled := true;
  btnLoad.Enabled := true;
  listPhotos.Visible := false;
  LoadForms(repository);
  listPhotos.OnItemChecked := listPhotosItemChecked;
  listPhotos.OnCustomDrawSubItem := listPhotosCustomDrawSubItem;
  listPhotos.Visible := true;
  chartItemViews.SeriesList.Clear;
  chartItemLikes.SeriesList.Clear;
  chartItemComments.SeriesList.Clear;
  chartItemViewsH.SeriesList.Clear;
  chartItemLikesH.SeriesList.Clear;
  chartItemCommentsH.SeriesList.Clear;
end;

procedure TfrmFlickr.btnFilterCancelClick(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
begin
  pagecontrol3.TabIndex := 0;
  listGroups.Visible := false;
  listGroups.OnItemChecked := nil;
  listgroups.OnCustomDrawItem := nil;

  listGroups.Items.Clear;

  for i := 0 to FilteredGroupList.list.Count - 1 do
  begin
    Item := listGroups.Items.Add;
    Item.Caption := FilteredGroupList.list[i].id;
    Item.SubItems.Add(FilteredGroupList.list[i].title);
    Item.SubItems.Add(FilteredGroupList.list[i].Photos.ToString());
    Item.SubItems.Add(FilteredGroupList.list[i].Members.ToString());
  end;

  listGroups.OnItemChecked := listGroupsItemChecked;
  listgroups.OnCustomDrawItem := listGroupsCustomDrawItem;

  listGroups.Visible := true;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count) + ' (0) selected';
end;

procedure TfrmFlickr.btnFilterOKClick(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
  description: string;
begin
  pagecontrol3.TabIndex := 0;
  listGroups.Visible := false;
  listGroups.Items.Clear;

  description := edtFilterGroup.text;
  for i := 0 to FilteredGroupList.list.Count - 1 do
  begin
    if FilteredGroupList.list[i].title.ToUpper.Contains(description.ToUpper) then
    begin
      Item := listGroups.Items.Add;
      Item.Caption := FilteredGroupList.list[i].id;
      Item.SubItems.Add(FilteredGroupList.list[i].title);
      Item.SubItems.Add(FilteredGroupList.list[i].Photos.ToString());
      Item.SubItems.Add(FilteredGroupList.list[i].Members.ToString());
    end;
  end;
  listGroups.Visible := true;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count) + ' (0) selected';
end;

procedure TfrmFlickr.btnAddPhotosClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  k: Integer;
  photoId: string;
  groupId: string;
  urlAdd, response: string;
  photos: TList<string>;
  groups: TList<string>;
  timedout: Boolean;
  total : integer;
  max : string;
  success : integer;
  photoToCheck : IPhoto;
begin
  if (apikey.text = '') or (userToken = '') then
  begin
    showmessage('You are not authorized!');
    exit;
  end;
  photos := TList<string>.Create;
  groups := TList<string>.Create;

  try
    PageControl3.ActivePage := tabStatus;
    for i := 0 to listPhotos.Items.Count - 1 do
    begin
      if listPhotos.Items[i].Checked then
        photos.Add(listPhotos.Items[i].Caption);
    end;
    for i := 0 to listGroups.Items.Count - 1 do
    begin
      if listGroups.Items[i].Checked then
        groups.Add(listGroups.Items[i].Caption);
    end;

    if not chkRejected.Checked then
      rejected := TRejected.Create;
    // add photos to the groups
    pstatus.Max := (photos.Count * groups.Count);
    pstatus.Min := 0;
    Taskbar1.ProgressState := TTaskBarProgressState.Normal;
    Taskbar1.ProgressMaxValue := pstatus.Max;
    k := 0;

    mStatus.Lines.Add('Adding ' + photos.Count.ToString + ' photos into  ' + groups.Count.ToString + ' groups each.');
    total := photos.Count * groups.Count;
    mStatus.Lines.Add('Total number of transactions: ' + total.ToString());
    success := 0;
    for i := 0 to photos.Count - 1 do
    begin
      for j := 0 to groups.Count - 1 do
      begin
        photoId := photos[i];
        groupId := groups[j];
        timedout := false;
        if not rejected.Exists(groupId) and not (repository.isPhotoInGroup(photoId, groupId, photoToCheck)) then
        begin
          if not (photoToCheck.banned) then
          begin
            urlAdd := TFlickrRest.New().getPoolsAdd(apikey.text, userToken, secret.text, userTokenSecret, photoId, groupId);
            while (not timedout) do
            begin
              try
                response := IdHTTP1.Get(urlAdd);
                if response.Contains('Photo limit reached') or response.Contains('Maximum') then
                begin
                  mStatus.Lines.Add('Adding group : ' + groupId + ' to the rejected list');
                  rejected.Add(groupId);
                end;
                if not chkPending.Checked then
                begin
                  if response.Contains('Pending Queue') then
                  begin
                    mStatus.Lines.Add('Adding group : ' + groupId + ' to the rejected list');
                    rejected.Add(groupId);
                  end;
                end;
                timedout := true;
              except
                on e: exception do
                begin
                  sleep(2000);
                  timedout := false;
                end;
              end;
            end;
          end;
        end;
        inc(k);
        pstatus.position := k;
        Taskbar1.ProgressValue := k;
        response := TResponse.filter(response);
        if chkResponses.Checked then
        begin
          if response.Contains('ok') then
          begin
            mStatus.Lines.Add('PhotoId: ' + photoId + ' GroupId: ' + groupId + ' response: ' + response);
            inc(success);
          end;
        end
        else
        begin
          mStatus.Lines.Add('PhotoId: ' + photoId + ' GroupId: ' + groupId + ' response: ' + response);
          if response.Contains('ok') then
          begin
            inc(success);
          end;
        end;

        max := edtMaxLog.text;
        if mStatus.Lines.Count > max.ToInteger then
          mStatus.Lines.Clear;
        Application.ProcessMessages;
        sleep(10);
      end;
    end;
  finally
    mStatus.Lines.Add('Total number of groups added: ' + success.ToString() + ' out of ' + total.ToString());
    photos.Free;
    groups.Free;
  end;
end;

procedure TfrmFlickr.btnLoadProfileClick(Sender: TObject);
var
  profileName: string;
  profile: IProfile;
  i: Integer;
  j: Integer;
  Item: TListItem;
begin
  try
    pagecontrol3.TabIndex := 0;
    profileName := ComboBox1.Items[ComboBox1.ItemIndex];
    profileName := profileName.Remove(profileName.IndexOf('('), (profileName.IndexOf(')') - profileName.IndexOf('('))+1);
    profileName := profileName.Remove(profileName.Length-1, 1);
    // Now look for this profileName in the Main Object.
    profile := flickrProfiles.getProfile(profileName);
    listGroups.OnItemChecked := nil;
    listgroups.OnCustomDrawItem := nil;
    if chkDisplayOnly.Checked then
    begin
      listGroups.Visible := false;
      listGroups.Items.Clear;
      edtProfile.text := profileName;
      for i := 0 to FilteredGroupList.list.Count - 1 do
      begin
        for j := 0 to profile.groupId.Count - 1 do
        begin
          if FilteredGroupList.list[i].id = (profile.groupId[j]) then
          begin
            Item := listGroups.Items.Add;
            Item.Caption := FilteredGroupList.list[i].id;
            Item.SubItems.Add(FilteredGroupList.list[i].title);
            Item.SubItems.Add(FilteredGroupList.list[i].Photos.ToString());
            Item.SubItems.Add(FilteredGroupList.list[i].Members.ToString());
            Item.checked := true;
          end;
        end;
      end;
      listGroups.Visible := true;
    end
    else
    begin
      if profile <> nil then
      begin
        listGroups.Visible := false;
        edtProfile.text := profileName;
        for i := 0 to profile.groupId.Count - 1 do
          for j := 0 to listGroups.Items.Count - 1 do
          begin
            if profile.groupId[i] = listGroups.Items[j].Caption then
            begin
              listGroups.Items[j].Checked := true;
            end;
          end;
        listGroups.Visible := true;
      end;
    end;
  finally
    listGroups.OnItemChecked := listGroupsItemChecked;
    listgroups.OnCustomDrawItem := listGroupsCustomDrawItem;
    UpdateLabelGroups();
  end;
end;

procedure TfrmFlickr.btnRemovePhotoClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  k: Integer;
  photoId: string;
  groupId: string;
  urlAdd, response: string;
  photos: TList<string>;
  groups: TList<string>;
  timedout: Boolean;
  total : integer;
  max : string;
  success : integer;
  resultPhoto : IPhoto;
begin
  if (apikey.text = '') or (userToken = '') then
  begin
    showmessage('You are not authorized!');
    exit;
  end;
  photos := TList<string>.Create;
  groups := TList<string>.Create;

  try
    PageControl3.ActivePage := tabStatus;
    for i := 0 to listPhotos.Items.Count - 1 do
    begin
      if listPhotos.Items[i].Checked then
        photos.Add(listPhotos.Items[i].Caption);
    end;
    for i := 0 to listGroups.Items.Count - 1 do
    begin
      if listGroups.Items[i].Checked then
        groups.Add(listGroups.Items[i].Caption);
    end;

    // add photos to the groups
    pstatus.Max := (photos.Count * groups.Count);
    pstatus.Min := 0;
    Taskbar1.ProgressState := TTaskBarProgressState.Normal;
    Taskbar1.ProgressMaxValue := pstatus.Max;
    k := 0;

    mStatus.Lines.Add('Removing ' + photos.Count.ToString + ' photos from  ' + groups.Count.ToString + ' groups each.');
    total := photos.Count * groups.Count;
    mStatus.Lines.Add('Total number of transactions: ' + total.ToString());
    success := 0;
    for i := 0 to photos.Count - 1 do
    begin
      for j := 0 to groups.Count - 1 do
      begin
        photoId := photos[i];
        groupId := groups[j];
        timedout := false;
        if (repository.isPhotoInGroup(photoId, groupId, resultPhoto)) then
        begin
          urlAdd := TFlickrRest.New().getPoolsRemove(apikey.text, userToken, secret.text, userTokenSecret, photoId, groupId);
          while (not timedout) do
          begin
            try
              response := IdHTTP1.Get(urlAdd);
              timedout := true;
            except
              on e: exception do
              begin
                sleep(2000);
                timedout := false;
              end;
            end;
          end;
        end;
        inc(k);
        pstatus.position := k;
        Taskbar1.ProgressValue := k;
        response := TResponse.filter(response);
        if chkResponses.Checked then
        begin
          if response.Contains('ok') then
          begin
            mStatus.Lines.Add('PhotoId: ' + photoId + ' GroupId: ' + groupId + ' response: ' + response);
            inc(success);
          end;
        end
        else
        begin
          mStatus.Lines.Add('PhotoId: ' + photoId + ' GroupId: ' + groupId + ' response: ' + response);
          if response.Contains('ok') then
          begin
            inc(success);
          end;
        end;

        max := edtMaxLog.text;
        if mStatus.Lines.Count > max.ToInteger then
          mStatus.Lines.Clear;
        Application.ProcessMessages;
        sleep(10);
      end;
    end;
  finally
    mStatus.Lines.Add('Total number of groups removed: ' + success.ToString() + ' out of ' + total.ToString());
    photos.Free;
    groups.Free;
  end;
end;

procedure TfrmFlickr.btnSaveProfileClick(Sender: TObject);
var
  profile: IProfile;
  i: Integer;
begin
  if edtProfile.text = '' then
  begin
    showmessage('profile name can''t be empty');
    exit;
  end;

  // Give me the profile
  profile := flickrProfiles.getProfile(edtProfile.text);

  if profile = nil then
  begin
    // New Profile
    profile := TProfile.Create;
    profile.Name := edtProfile.text;
    for i := 0 to listGroups.Items.Count - 1 do
    begin
      if listGroups.Items[i].Checked then
      begin
        profile.AddId(listGroups.Items[i].Caption);
      end;
    end;
    flickrProfiles.Add(profile);
  end
  else
  begin
    if chkReplaceProfile.Checked then
    begin
      flickrProfiles.list.Remove(profile);
      profile := nil;

      // New Profile
      profile := TProfile.Create;
      profile.Name := edtProfile.text;
      for i := 0 to listGroups.Items.Count - 1 do
      begin
        if listGroups.Items[i].Checked then
        begin
          profile.AddId(listGroups.Items[i].Caption);
        end;
      end;
      flickrProfiles.Add(profile);
    end
    else
    begin
      for i := 0 to listGroups.Items.Count - 1 do
      begin
        if listGroups.Items[i].Checked then
        begin
          profile.AddId(listGroups.Items[i].Caption);
        end;
      end;
    end;
  end;
  flickrProfiles.save('flickrProfiles.xml');
  LoadProfiles();
end;

procedure TfrmFlickr.btnShowReportClick(Sender: TObject);
var
  description : TStrings;
begin
  //Show the html generated report.
  if RepositoryLoaded then
  begin
    description := THtmlComposer.getMessage(repository, globalsRepository, organic);
    try
      description.SaveToFile('flickrHtmlreport.htm');
      WebBrowser2.Navigate('file:///' + ExtractFilePath(ParamStr(0)) + 'flickrHtmlreport.htm');
    finally
      description.Free;
    end;
  end;
end;

procedure TfrmFlickr.Button8Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to listGroups.Items.Count - 1 do
  begin
    listGroups.Items[i].Checked := false;
  end;
end;

procedure TfrmFlickr.Button9Click(Sender: TObject);
begin
  getTotalAlbumsCounts();
end;

procedure TfrmFlickr.chartAlbumClickSeries(Sender: TCustomChart; Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ValueIndex >= 0 then
    ShowMessage(Series.ValueMarkText[ValueIndex]);
end;

procedure TfrmFlickr.ChartViewsDblClick(Sender: TObject);
begin
  frmChartViewer := TfrmChartViewer.Create(nil);
  frmChartViewer.CloneChart(TChart(Sender));
  frmChartViewer.Show;
end;

procedure TfrmFlickr.CheckAll1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    listPhotos.Items[i].Checked := true;
  end;
end;

procedure TfrmFlickr.CheckBox1Click(Sender: TObject);
var
  i: Integer;
begin
  listgroups.OnItemChecked := nil;
  for i := 0 to listGroups.Items.Count - 1 do
  begin
    listGroups.Items[i].Checked := CheckBox1.Checked;
  end;
  listgroups.OnItemChecked := listGroupsItemChecked;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count) + '(' + InttoStr(listgroups.Items.Count) + ') selected';
end;

procedure TfrmFlickr.CheckBox2Click(Sender: TObject);
var
  i: Integer;
begin
  if chkAddItem.Checked then
    listPhotos.OnItemChecked := nil;
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    listPhotos.Items[i].Checked := CheckBox2.Checked;
  end;
  if chkAddItem.Checked then
    listPhotos.OnItemChecked := listPhotosItemChecked;
  if CheckBox2.Checked then
    Label31.Caption := 'Number of items: ' + InttoStr(listphotos.Items.Count) + ' (' + InttoStr(listphotos.Items.Count) + ') selected'
  else
  begin
    Label31.Caption := 'Number of items: ' + InttoStr(listphotos.Items.Count) + ' (0) selected';
    chartItemViews.SeriesList.Clear;
    chartItemLikes.SeriesList.Clear;
    chartItemComments.SeriesList.Clear;
    chartItemViewsH.SeriesList.Clear;
    chartItemLikesH.SeriesList.Clear;
    chartItemCommentsH.SeriesList.Clear;
  end;
end;

procedure TfrmFlickr.CheckBox3Click(Sender: TObject);
var
  i: Integer;
begin
  listPhotosUser.OnItemChecked := nil;
  for i := 0 to listPhotosUser.Items.Count - 1 do
  begin
    listPhotosUser.Items[i].Checked := CheckBox3.Checked;
  end;
  listgroups.OnItemChecked := listPhotosUserItemChecked;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count) + '(' + InttoStr(listgroups.Items.Count) + ') selected';
end;

procedure TfrmFlickr.ClearSelection1Click(Sender: TObject);
var
  i: Integer;
begin
  if (startMark <> -1) and (endMark <> -1) then
  begin
    endMark :=  listPhotos.ItemIndex;
    for i := startMark to endMark do
    begin
        listPhotos.Items[i].Checked := not listPhotos.Items[i].Checked;
    end;
    startMark := -1;
    endMark := -1;
  end;
  UpdateLabel();
end;

procedure TfrmFlickr.showMarksClick(Sender: TObject);
begin
  flickrChart.VisibleMarks(chartitemViews, showMarks.Checked);
  flickrChart.VisibleMarks(chartitemLikes, showMarks.Checked);
  flickrChart.VisibleMarks(chartitemComments, showMarks.Checked);
  flickrChart.VisibleMarks(chartitemViewsH, showMarks.Checked);
  flickrChart.VisibleMarks(chartitemLikesH, showMarks.Checked);
  flickrChart.VisibleMarks(chartitemCommentsH, showMarks.Checked);
  flickrChart.VisibleMarks(Chart2, showMarks.Checked);
  flickrChart.VisibleMarks(ChartViews, showMarks.Checked);
  flickrChart.VisibleMarks(ChartLikes, showMarks.Checked);
  flickrChart.VisibleMarks(ChartComments, showMarks.Checked);
  flickrChart.VisibleMarks(dailyViews, showMarks.Checked);
  flickrChart.VisibleMarks(dailyLikes, showMarks.Checked);
end;

procedure TfrmFlickr.ComboBox1Change(Sender: TObject);
begin
  btnLoadProfile.Enabled := true;
  edtProfile.Enabled := true;
  btnSaveProfile.Enabled := true;
end;

procedure TfrmFlickr.Delete1Click(Sender: TObject);
var
  id : string;
  buttonSelected : integer;
begin
  if listPhotos.ItemIndex <> -1 then
  begin
    id := listPhotos.Items[listPhotos.ItemIndex].Caption;
    buttonSelected := MessageDlg('Are you sure you want to remove '+id+' from the list?',mtCustom,
                              [mbYes,mbCancel], 0);
    if buttonSelected = mrYes then
    begin
      listPhotos.Items[listPhotos.ItemIndex].Delete;
      repository.DeletePhoto(id);
      UpdateLabel();
    end;
  end;
end;

// returns MD5 has for a file
// function TfrmFlickr.MD5(apikey: string; secret: string): string;
// var
// idmd5: TIdHashMessageDigest5;
// begin
// idmd5 := TIdHashMessageDigest5.Create;
// try
// Result := idmd5.HashStringAsHex(secret + 'api_key' + apikey + 'permswrite',
// IndyTextEncoding_OSDefault());
// finally
// idmd5.Free;
// end;
// end;

procedure TfrmFlickr.btnGetGroupsClick(Sender: TObject);
var
  Item: TListItem;
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4: IXMLNode;
  pages, title, id, ismember, total, totalitems: string;
  numPages: Integer;
  urlGroups: string;
  i: Integer;
  timedout: Boolean;
  st : TStopWatch;
  photos : string;
  members : string;
  comparer : TCompareType;
begin
  if (apikey.text = '') or (userToken = '') then
  begin
    showmessage('You are not authorized!');
    exit;
  end;
  if (edtUserId.text = '') or (userTokenSecret = '') then
  begin
    showmessage('User ID key can''t be empty');
    exit;
  end;
  if Assigned(FilteredGroupList) then
  begin
    FilteredGroupList := nil;
    comparer := tCompareMembers;
    if RadioButton8.Checked then
      comparer := tCompareMembers;
    if RadioButton9.Checked then
      comparer := tComparePoolSize;
    FilteredGroupList := TFilteredList.Create(comparer);
  end;
  pagecontrol3.TabIndex := 0;
  btnLoad.Enabled := false;
  btnAdd.Enabled := false;
  btnAddItems.Enabled := false;
  batchUpdate.Enabled := false;
  listGroups.Visible := false;
  progressfetchinggroups.Visible := true;
  Application.ProcessMessages;
  urlGroups := TFlickrRest.New().getGroups(apikey.text, '1', '500', userToken, secret.text, userTokenSecret);
  timedout := false;
  while (not timedout) do
  begin
    try
      response := IdHTTP1.Get(urlGroups);
      timedout := true;
    except
      on e: exception do
      begin
        sleep(2000);
        TLogger.LogFile('reading groups first iteration: ' + e.Message);
        application.ProcessMessages;
        timedout := false;
      end;
    end;
  end;
  XMLDocument1.LoadFromXML(response);
  iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
  iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
  iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <groups>
  pages := iXMLRootNode3.attributes['page'];
  total := iXMLRootNode3.attributes['pages'];
  totalitems := iXMLRootNode3.attributes['total'];
  iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <group>
  listGroups.Clear;
  // numTotal := total.ToInteger();
  progressfetchinggroups.Max := totalitems.ToInteger();
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := totalitems.ToInteger();
  progressfetchinggroups.position := 0;
  while iXMLRootNode4 <> nil do
  begin
    if iXMLRootNode4.NodeName = 'group' then
    begin
      id := iXMLRootNode4.attributes['id'];
      ismember := iXMLRootNode4.attributes['member'];
      title := iXMLRootNode4.attributes['name'];
      photos := iXMLRootNode4.attributes['photos'];
      members := iXMLRootNode4.attributes['member_count'];
      if ismember = '1' then
        FilteredGroupList.Add(TBase.New(id, title, StrToInt(photos), StrToInt(members)));
    end;
    progressfetchinggroups.position := progressfetchinggroups.position + 1;
    Taskbar1.ProgressValue := progressfetchinggroups.position;
    Application.ProcessMessages;
    iXMLRootNode4 := iXMLRootNode4.NextSibling;
  end;

  // Load the remaining pages
  numPages := total.ToInteger;
  for i := 2 to numPages do
  begin
    sleep(100);
    urlGroups := TFlickrRest.New().getGroups(apikey.text, i.ToString, '500', userToken, secret.text, userTokenSecret);
    timedout := false;
    while (not timedout) do
    begin
      try
        response := IdHTTP1.Get(urlGroups);
        timedout := true;
      except
        on e: exception do
        begin
          sleep(2000);
          TLogger.LogFile('reading groups second iteration: ' + e.Message);
          application.ProcessMessages;
          timedout := false;
        end;
      end;
    end;
    XMLDocument1.LoadFromXML(response);
    iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
    iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
    iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <groups>
    pages := iXMLRootNode3.attributes['page'];
    iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <group>
    while iXMLRootNode4 <> nil do
    begin
      if iXMLRootNode4.NodeName = 'group' then
      begin
        id := iXMLRootNode4.attributes['id'];
        ismember := iXMLRootNode4.attributes['member'];
        title := iXMLRootNode4.attributes['name'];
        photos := iXMLRootNode4.attributes['photos'];
        members := iXMLRootNode4.attributes['member_count'];
        if ismember = '1' then
          FilteredGroupList.Add(TBase.New(id, title, StrToInt(photos), StrToInt(members)));
      end;
      progressfetchinggroups.position := progressfetchinggroups.position + 1;
      Taskbar1.ProgressValue := progressfetchinggroups.position;
      Application.ProcessMessages;
      iXMLRootNode4 := iXMLRootNode4.NextSibling;
    end;
  end;
  // Add items to the listview
  st := TStopWatch.Create;
  FilteredGroupList.sort;
  st.Start;
  listGroups.OnItemChecked := nil;
  listgroups.OnCustomDrawItem := nil;
  for i := 0 to FilteredGroupList.list.Count - 1 do
  begin
    Item := listGroups.Items.Add;
    Item.Caption := FilteredGroupList.list[i].id;
    Item.SubItems.Add(FilteredGroupList.list[i].title);
    Item.SubItems.Add(FilteredGroupList.list[i].Photos.ToString());
    Item.SubItems.Add(FilteredGroupList.list[i].Members.ToString());
  end;
  listGroups.OnItemChecked := listGroupsItemChecked;
  listgroups.OnCustomDrawItem := listGroupsCustomDrawItem;
  st.Stop;
  log('populating group list ' + TTime.GetAdjustedTime(st.ElapsedMilliseconds));
  btnLoad.Enabled := true;
  btnAdd.Enabled := true;
  batchUpdate.Enabled := true;
  btnAddPhotos.Enabled := true;
  btnRemovePhoto.Enabled := true;
  btnAddItems.Enabled := true;
  progressfetchinggroups.Visible := false;
  Taskbar1.ProgressValue := 0;
  listGroups.Visible := true;
  UpdateLabelGroups();
end;

function TfrmFlickr.getTotalAlbumsCounts(): Integer;
var
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4, iXMLRootNode5: IXMLNode;
  pages, total: string;
  numPages, numTotal: Integer;
  i: Integer;
  totalViews: Integer;
  photosetId: string;
  title: string;
  countViews: Integer;
  numPhotos: Integer;
  Series : TPieSeries;
  color : TColor;
begin
  if chartAlbum.SeriesList.Count > 0 then
    chartAlbum.RemoveAllSeries;

  Series := flickrChart.GetNewPieSeries(chartAlbum, true);


  listPhotosUser.Visible := false;
  lblfetching.Visible := true;
  progressfetching.Visible := true;
  listAlbums.Clear;
  Application.ProcessMessages;
  response := IdHTTP1.Get(TFlickrRest.New().getPhotoSets(apikey.text, edtUserId.text, '1', '500'));
  XMLDocument1.LoadFromXML(response);
  iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
  iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
  iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photosets>
  pages := iXMLRootNode3.attributes['pages'];
  total := iXMLRootNode3.attributes['total'];
  iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photoset>
  numTotal := total.ToInteger();
  progressfetching.Max := numTotal;
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := numTotal;
  progressfetching.position := 0;
  totalViews := 0;
  while iXMLRootNode4 <> nil do
  begin
    if iXMLRootNode4.NodeName = 'photoset' then
    begin
      photosetId := iXMLRootNode4.attributes['id'];
      numPhotos := iXMLRootNode4.attributes['photos'];
      countViews := iXMLRootNode4.attributes['count_views'];
      iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
      title := iXMLRootNode5.text;
      totalViews := totalViews + countViews;
    end;
    progressfetching.position := progressfetching.position + 1;
    listAlbums.Lines.Add('Id: ' + photosetId + ' title: ' + title + ' Photos: ' + numPhotos.ToString() + ' Views: ' + countViews.ToString());
    color := RGB(Random(255), Random(255), Random(255));
    Series.Add(countViews.ToDouble, 'Id: ' + photosetId + ' title: ' + title + ' Photos: ' + numPhotos.ToString() + ' Views: ' + countViews.ToString(), color);
    Taskbar1.ProgressValue := progressfetching.position;
    Application.ProcessMessages;
    iXMLRootNode4 := iXMLRootNode4.NextSibling;
  end;

  // Load the remaining pages
  numPages := pages.ToInteger;
  for i := 2 to numPages do
  begin
    response := IdHTTP1.Get(TFlickrRest.New().getPhotoSets(apikey.text, edtUserId.text, i.ToString, '500'));
    XMLDocument1.LoadFromXML(response);
    iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
    iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
    iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photosets>
    pages := iXMLRootNode3.attributes['pages'];
    iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photoset>
    while iXMLRootNode4 <> nil do
    begin
      if iXMLRootNode4.NodeName = 'photoset' then
      begin
        photosetId := iXMLRootNode4.attributes['id'];
        numPhotos := iXMLRootNode4.attributes['photos'];
        countViews := iXMLRootNode4.attributes['count_views'];
        iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
        title := iXMLRootNode5.text;
        totalViews := totalViews + countViews;
      end;
      progressfetching.position := progressfetching.position + 1;
      listAlbums.Lines.Add('Id: ' + photosetId + ' title: ' + title + ' Photos: ' + numPhotos.ToString() + ' Views: ' + countViews.ToString());
      color := RGB(Random(255), Random(255), Random(255));
      Series.Add(countViews.ToDouble, 'Id: ' + photosetId + slinebreak + ' title: ' + title + slinebreak + ' Photos: ' + numPhotos.ToString() + slinebreak + ' Views: ' + countViews.ToString(), color);
      Taskbar1.ProgressValue := progressfetching.position;
      Application.ProcessMessages;
      iXMLRootNode4 := iXMLRootNode4.NextSibling;
    end;
  end;

  chartAlbum.AddSeries(Series);

  lblfetching.Visible := false;
  progressfetching.Visible := false;
  Taskbar1.ProgressValue := 0;
  listPhotosUser.Visible := true;
  Result := totalViews;
end;

procedure TfrmFlickr.btnGetListClick(Sender: TObject);
var
  Item: TListItem;
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4: IXMLNode;
  pages, title, id, ispublic, total: string;
  numPages, numTotal: Integer;
  i: Integer;
  IdHTTP: TIdHTTP;
  IdIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  xmlDocument: IXMLDocument;
  timedout: Boolean;
begin
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  if edtUserId.text = '' then
  begin
    showmessage('UserId can''t be empty');
    exit;
  end;
  btnLoad.Enabled := false;
  btnAdd.Enabled := false;
  btnAddItems.Enabled := false;
  batchUpdate.Enabled := false;
  listPhotosUser.Visible := false;
  lblfetching.Visible := true;
  progressfetching.Visible := true;
  Application.ProcessMessages;

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
        response := IdHTTP.Get(TFlickrRest.New().getPhotos(apikey.text, edtUserId.text, '1', '500'));
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
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photos>
      pages := iXMLRootNode3.attributes['pages'];
      total := iXMLRootNode3.attributes['total'];
      iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photo>
      listPhotosUser.Clear;
      numTotal := total.ToInteger();
      progressfetching.Max := numTotal;
      Taskbar1.ProgressState := TTaskBarProgressState.Normal;
      Taskbar1.ProgressMaxValue := numTotal;
      progressfetching.position := 0;
      while iXMLRootNode4 <> nil do
      begin
        if iXMLRootNode4.NodeName = 'photo' then
        begin
          id := iXMLRootNode4.attributes['id'];
          ispublic := iXMLRootNode4.attributes['ispublic'];
          title := iXMLRootNode4.attributes['title'];
          if ispublic = '1' then
          begin
            Item := listPhotosUser.Items.Add;
            Item.Caption := id;
            Item.SubItems.Add(title);
          end;
        end;
        progressfetching.position := progressfetching.position + 1;
        Taskbar1.ProgressValue := progressfetching.position;
        Application.ProcessMessages;
        iXMLRootNode4 := iXMLRootNode4.NextSibling;
      end;
  finally
    IdIOHandler.Free;
    IdHTTP.Free;
    xmlDocument := nil;
  end;

  // Load the remaining pages
  numPages := pages.ToInteger;
  for i := 2 to numPages do
  begin
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
          response := IdHTTP.Get(TFlickrRest.New().getPhotos(apikey.text, edtUserId.text, i.ToString, '500'));
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
        iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photos>
        pages := iXMLRootNode3.attributes['pages'];
        iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photo>
        while iXMLRootNode4 <> nil do
        begin
          if iXMLRootNode4.NodeName = 'photo' then
          begin
            id := iXMLRootNode4.attributes['id'];
            ispublic := iXMLRootNode4.attributes['ispublic'];
            title := iXMLRootNode4.attributes['title'];
            if ispublic = '1' then
            begin
              Item := listPhotosUser.Items.Add;
              Item.Caption := id;
              Item.SubItems.Add(title);
            end;
          end;
          progressfetching.position := progressfetching.position + 1;
          Taskbar1.ProgressValue := progressfetching.position;
          Application.ProcessMessages;
          iXMLRootNode4 := iXMLRootNode4.NextSibling;
        end;
    finally
      IdIOHandler.Free;
      IdHTTP.Free;
      xmlDocument := nil;
    end;
  end;
  btnLoad.Enabled := true;
  btnAdd.Enabled := true;
  batchUpdate.Enabled := true;
  btnAddItems.Enabled := true;
  lblfetching.Visible := false;
  progressfetching.Visible := false;
  Taskbar1.ProgressValue := 0;
  listPhotosUser.Visible := true;
end;

procedure TfrmFlickr.btnAddItemsClick(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
begin
  btnAddItems.Enabled := false;
  ProgressBar1.Visible := true;
  photoId.Enabled := false;
  btnAdd.Enabled := false;
  batchUpdate.Enabled := false;
  Process.Visible := true;
  ProgressBar1.Min := 0;
  ProgressBar1.Max := listPhotos.Items.Count;
  for i := 0 to listPhotosUser.Items.Count - 1 do
  begin
    if listPhotosUser.Items[i].Checked then
    begin
      Process.Caption := 'Processing image: ' + listPhotosUser.Items[i].Caption + ' ' + i.ToString + ' out of ' + listPhotosUser.Items.Count.ToString;
      ProgressBar1.position := i;
      Application.ProcessMessages;

      if not ExistPhotoInList(listPhotosUser.Items[i].Caption, Item) then
      begin
        photoId.text := listPhotosUser.Items[i].Caption;
        btnAddClick(Sender);
      end;
    end;
  end;
  photoId.text := '';
  ProgressBar1.Visible := false;
  Process.Visible := false;
  UpdateTotals(false);
  LoadHallOfFame(repository);
  btnSave.Enabled := true;
  batchUpdate.Enabled := true;
  photoId.Enabled := true;
  btnAdd.Enabled := true;
  btnAddItems.Enabled := true;
end;

function TfrmFlickr.SaveToExcel(AView: TListView; ASheetName, AFileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row: Integer;
  ExcelOLE, Sheet: OLEVariant;
  i: Integer;
begin
  // Create Excel-OLE Object
  Result := false;
  ExcelOLE := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    ExcelOLE.Visible := false;

    ExcelOLE.Workbooks.Add(xlWBATWorksheet);
    Sheet := ExcelOLE.Workbooks[1].WorkSheets[1];
    Sheet.Name := ASheetName;

    Sheet.Cells[1, 1] := 'Id';
    Sheet.Cells[1, 2] := 'Title';
    Sheet.Cells[1, 3] := 'Views';
    Sheet.Cells[1, 4] := 'Likes';
    Sheet.Cells[1, 5] := 'Comments';
    Sheet.Cells[1, 6] := 'Last Update';
    Sheet.Cells[1, 7] := 'Taken';
    Sheet.Cells[1, 8] := 'Albums';
    Sheet.Cells[1, 9] := 'Groups';
    Sheet.Cells[1, 10] := 'Tags';
    Sheet.Cells[1, 11] := 'Affection';

    Row := 2;
    for i := 0 to AView.Items.Count - 1 do
    begin
      Sheet.Cells[Row, 1] := AView.Items.Item[i].Caption;
      Sheet.Cells[Row, 2] := AView.Items.Item[i].SubItems[0];
      Sheet.Cells[Row, 3] := AView.Items.Item[i].SubItems[1];
      Sheet.Cells[Row, 4] := AView.Items.Item[i].SubItems[2];
      Sheet.Cells[Row, 5] := AView.Items.Item[i].SubItems[3];
      Sheet.Cells[Row, 6] := AView.Items.Item[i].SubItems[4];
      Sheet.Cells[Row, 7] := AView.Items.Item[i].SubItems[5];
      Sheet.Cells[Row, 8] := AView.Items.Item[i].SubItems[6];
      Sheet.Cells[Row, 9] := AView.Items.Item[i].SubItems[7];
      Sheet.Cells[Row, 10] := AView.Items.Item[i].SubItems[8];
      Sheet.Cells[Row, 11] := AView.Items.Item[i].SubItems[9];
      inc(Row);
    end;

    try
      ExcelOLE.Workbooks[1].SaveAs(AFileName);
      Result := true;
    except

    end;
  finally
    if not VarIsEmpty(ExcelOLE) then
    begin
      ExcelOLE.DisplayAlerts := false;
      ExcelOLE.Quit;
      ExcelOLE := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

function TfrmFlickr.ExportGraphToExcel(viewsource : TViewType; ASheetName, AFileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row: Integer;
  ExcelOLE, Sheet: OLEVariant;
  i: Integer;
begin
  // Create Excel-OLE Object
  Result := false;
  ExcelOLE := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    ExcelOLE.Visible := false;

    ExcelOLE.Workbooks.Add(xlWBATWorksheet);
    Sheet := ExcelOLE.Workbooks[1].WorkSheets[1];
    Sheet.Name := ASheetName;

    Sheet.Cells[1, 1] := 'Date';


    case viewsource of
      TotalViews:
      begin
        Sheet.Cells[1, 2] := 'Views';
        Row := 2;
        for i := 0 to globalsRepository.globals.Count - 1 do
        begin
          Sheet.Cells[Row, 1] := '''' + FormatDateTime('dd/mm/yyyy', globalsRepository.globals[i].Date);
          Sheet.Cells[Row, 2] := globalsRepository.globals[i].views.ToString;
          inc(Row);
        end;
        Row := 2;
      end;
      TotalLikes:
      begin
        Sheet.Cells[1, 2] := 'Likes';
        Row := 2;
      end;
      TotalComments:
      begin
        Sheet.Cells[1, 2] := 'Comments';
        Row := 2;
      end;
      TotalViewsHistogram:
      begin
        Sheet.Cells[1, 2] := 'Views';
        Row := 2;
        for i := 1 to globalsRepository.globals.Count - 1 do
        begin
          Sheet.Cells[Row, 1] := '''' + FormatDateTime('dd/mm/yyyy', globalsRepository.globals[i].Date);
          Sheet.Cells[Row, 2] := InttoStr(globalsRepository.globals[i].views - globalsRepository.globals[i - 1].views);
          inc(Row);
        end;
      end;
      TotalLikesHistogram:
      begin
        Sheet.Cells[1, 2] := 'Likes';
        Row := 2;
      end;
    end;

    try
      ExcelOLE.Workbooks[1].SaveAs(AFileName);
      Result := true;
    except

    end;
  finally
    if not VarIsEmpty(ExcelOLE) then
    begin
      ExcelOLE.DisplayAlerts := false;
      ExcelOLE.Quit;
      ExcelOLE := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

function TfrmFlickr.SaveToExcelGroups(AView: TListView; ASheetName, AFileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row: Integer;
  ExcelOLE, Sheet: OLEVariant;
  i: Integer;
begin
  // Create Excel-OLE Object
  Result := false;
  ExcelOLE := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    ExcelOLE.Visible := false;

    ExcelOLE.Workbooks.Add(xlWBATWorksheet);
    Sheet := ExcelOLE.Workbooks[1].WorkSheets[1];
    Sheet.Name := ASheetName;

    Sheet.Cells[1, 1] := 'Id';
    Sheet.Cells[1, 2] := 'Title';

    Row := 2;
    for i := 0 to AView.Items.Count - 1 do
    begin
      Sheet.Cells[Row, 1] := AView.Items.Item[i].Caption;
      Sheet.Cells[Row, 2] := AView.Items.Item[i].SubItems[0];
      inc(Row);
    end;

    try
      ExcelOLE.Workbooks[1].SaveAs(AFileName);
      Result := true;
    except

    end;
  finally
    if not VarIsEmpty(ExcelOLE) then
    begin
      ExcelOLE.DisplayAlerts := false;
      ExcelOLE.Quit;
      ExcelOLE := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

procedure TfrmFlickr.ShowListAlbums1Click(Sender: TObject);
var
  id : string;
  photo : IPhoto;
  i : integer;
begin
  ListDisplay := TfrmFlickrContext.Create(self);
  if listPhotos.ItemIndex <> -1 then
  begin
    id := listPhotos.Items[listPhotos.ItemIndex].Caption;
    photo := repository.GetPhoto(id);
    for i := 0 to photo.Albums.Count-1 do
    begin
      ListDisplay.AddItem(photo.Albums[i].id, photo.Albums[i].title);
    end;
  end;
  ListDisplay.Show;
end;

procedure TfrmFlickr.ShowListGroups1Click(Sender: TObject);
var
  id : string;
  photo : IPhoto;
  i : integer;
begin
  ListDisplay := TfrmFlickrContext.Create(self);
  if listPhotos.ItemIndex <> -1 then
  begin
    id := listPhotos.Items[listPhotos.ItemIndex].Caption;
    photo := repository.GetPhoto(id);
    for i := 0 to photo.Groups.Count-1 do
    begin
      ListDisplay.AddItem(photo.groups[i].id, photo.groups[i].title, DateToStr(photo.groups[i].Added));
    end;
  end;
  ListDisplay.Show;
end;

procedure TfrmFlickr.ShowonFlickr1Click(Sender: TObject);
var
  id : string;
begin
  //Show item in the URL view
  //https://www.flickr.com/photos/jordicorbillaphotography/
  if listPhotos.ItemIndex <> -1 then
  begin
    id := listPhotos.Items[listPhotos.ItemIndex].Caption;
    ShellExecute(self.WindowHandle,'open','chrome.exe', PChar('https://www.flickr.com/photos/jordicorbillaphotography/' + id + '/in/photostream/lightbox/'), nil, SW_SHOW);
  end;
end;

procedure TfrmFlickr.ShowonFlickr2Click(Sender: TObject);
var
  id : string;
begin
  //Show item in the URL view
  //https://www.flickr.com/photos/jordicorbillaphotography/
  if listGroups.ItemIndex <> -1 then
  begin
    id := listGroups.Items[listGroups.ItemIndex].Caption;
    ShellExecute(self.WindowHandle,'open','chrome.exe', PChar('https://www.flickr.com/groups/' + id), nil, SW_SHOW);
  end;
end;

procedure TfrmFlickr.StartMarking1Click(Sender: TObject);
begin
  if listPhotos.ItemIndex <> -1 then
  begin
    startMark :=  listPhotos.ItemIndex;
    endMark := -1;
  end;
end;

procedure TfrmFlickr.btnExcelClick(Sender: TObject);
begin
  if SaveToExcel(listPhotos, 'Flickr Analytics', ExtractFilePath(ParamStr(0)) + 'FlickrAnalytics.xls') then
    showmessage('Data saved successfully!');
  ExportGraphToExcel(TotalViews, 'Total Views History',ExtractFilePath(ParamStr(0)) + 'FlickrAnalyticsTotalViews.xls');
  ExportGraphToExcel(TotalViewsHistogram, 'Total Views History',ExtractFilePath(ParamStr(0)) + 'FlickrAnalyticsTotalViewsHistogram.xls');
end;

procedure TfrmFlickr.FormCreate(Sender: TObject);
var
  comparer : TCompareType;
begin
  if chksorting.Checked then
  begin
    comparer := tCompareViews;
    if radioButton1.checked then
      comparer := tCompareId;
    if radioButton2.checked then
      comparer := tCompareViews;
    if radioButton3.checked then
      comparer := tCompareLikes;
    if radioButton4.checked then
      comparer := tCompareComments;
    if radioButton5.checked then
      comparer := tCompareTaken;
    if radioButton6.checked then
      comparer := tCompareAlbums;
    if radioButton7.checked then
      comparer := tCompareGroups;
    repository := TFlickrRepository.Create(chksorting.Checked, comparer);
  end
  else
    repository := TFlickrRepository.Create();
  organic := TFlickrOrganic.Create();
  rejected := TRejected.Create;
  flickrProfiles := TProfiles.Create();

  comparer := tCompareMembers;
  if RadioButton8.Checked then
    comparer := tCompareMembers;
  if RadioButton9.Checked then
    comparer := tComparePoolSize;
  FilteredGroupList := TFilteredList.Create(comparer);

  globalsRepository := TFlickrGlobals.Create();
  CheckedSeries := TStringList.Create;
  Process.Visible := false;
  PageControl1.ActivePage := Dashboard;
  PageControl2.ActivePage := statistics;
  startMark := -1;
  endMark := -1;
  flickrChart := TFlickrChart.create;
  frmFlickr.Caption := 'Flickr Photo Analytics ' + TUtils.GetVersion;
  RepositoryLoaded := false;
  if not fileExists(ExtractFilePath(ParamStr(0)) + 'flickrRepository.xml') then
    btnLoad.Enabled := false;
end;

procedure TfrmFlickr.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CheckedSeries);
  repository := nil;
  organic := nil;
  flickrProfiles := nil;
  FilteredGroupList := nil;
  globalsRepository := nil;
  flickrChart := nil;
  rejected := nil;
end;

procedure TfrmFlickr.FormShow(Sender: TObject);
var
  setup: TfrmSetupApp;
begin
  btnLoadOptionsClick(sender);
  if (Apikey.Text = '') or (secret.Text = '') or (edtUserId.Text = '') then
  begin
    setup := TfrmSetupApp.Create(Application);
    try
      if Apikey.Text <> '' then
        setup.apikey.Text := Apikey.Text;
      if secret.Text <> '' then
        setup.secret.Text := secret.Text;
      if edtUserId.Text <> '' then
        setup.edtUserId.Text := edtUserId.Text;
      setup.ShowModal;
    finally
      setup.Free;
    end;
  end;
end;

function TfrmFlickr.isInSeries(id: string): Boolean;
var
  i: Integer;
  found: Boolean;
begin
  i := 0;
  found := false;
  while (not found) and (i < CheckedSeries.Count) do
  begin
    found := CheckedSeries[i] = id;
    inc(i);
  end;
  Result := found;
end;

procedure TfrmFlickr.Label12DblClick(Sender: TObject);
var
  Bitmap: TBitMap;
  prefix : string;
begin
  Bitmap := Self.GetFormImage;
  try
    prefix := DateTimeToStr(Date).Replace('\','').Replace('/','').Replace(' ','').Replace(':','');
    Bitmap.SaveToFile( prefix + 'Image.bmp' );
  finally
    Bitmap.Free;
  end;
end;

procedure TfrmFlickr.Label2DblClick(Sender: TObject);
begin
  batchUpdate.Enabled := true;
end;

procedure TfrmFlickr.listGroupsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  color, Color2: TColor;
begin
  color := Sender.Canvas.Font.color;
  Color2 := Sender.Canvas.Brush.color;
  if Item.Checked then
  begin
    Sender.Canvas.Font.color := clBlue;
    Sender.Canvas.Brush.color := Color2;
  end
  else
  begin
    Sender.Canvas.Font.color := color;
    Sender.Canvas.Brush.color := Color2;
  end;
end;

procedure TfrmFlickr.listGroupsItemChecked(Sender: TObject; Item: TListItem);
begin
  UpdateLabelGroups();
end;

procedure TfrmFlickr.listPhotosCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  color, Color2: TColor;
begin
  color := Sender.Canvas.Font.color;
  Color2 := Sender.Canvas.Brush.color;
  if SubItem = 1 then
  begin
    if ((Item.SubItems.Strings[1].ToInteger >= 1000) and (Item.SubItems.Strings[1].ToInteger < 3000)) then
    begin
      Sender.Canvas.Font.color := clBlue;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 3000) and (Item.SubItems.Strings[1].ToInteger < 5000)) then
    begin
      Sender.Canvas.Font.color := clGreen;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 5000) and (Item.SubItems.Strings[1].ToInteger < 8000)) then
    begin
      Sender.Canvas.Font.color := clOlive;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 8000) and (Item.SubItems.Strings[1].ToInteger < 10000)) then
    begin
      Sender.Canvas.Font.color := clFuchsia;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 10000)) then
    begin
      Sender.Canvas.Font.color := clRed;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[10].ToBoolean)) then
    begin
      Sender.Canvas.Font.color := clNavy;
      Sender.Canvas.Brush.color := Color2;
    end;
  end
  else
  begin
    Sender.Canvas.Font.color := color;
    Sender.Canvas.Brush.color := Color2;
  end;
end;

procedure TfrmFlickr.listPhotosItemChecked(Sender: TObject; Item: TListItem);
var
  id, title, views, likes, comments, LastUpdate: string;
  photo: IPhoto;
  stat: IStat;
  i: Integer;
  Series, SeriesViews, SeriesLikes, SeriesComments: TLineSeries;
  barSeries: TBarSeries;
  colour: TColor;
  viewsTendency, likesTendency, commentsTendency : Itendency;
  SeriesTendencyViews, SeriesTendencyLikes, SeriesTendencyComments : TLineSeries;
  theDate : TDateTime;
  vTendency : integer;
begin
  if (Item.Checked) and (not chkAddItem.Checked) then
  begin
    id := Item.Caption;
    title := Item.SubItems.Strings[0];
    views := Item.SubItems.Strings[1];
    likes := Item.SubItems.Strings[2];
    comments := Item.SubItems.Strings[3];
    LastUpdate := Item.SubItems.Strings[4];

    photo := repository.GetPhoto(id);
    if photo <> nil then
    begin
      SeriesViews := flickrChart.GetNewLineSeries(chartItemViews);
      SeriesLikes := flickrChart.GetNewLineSeries(chartItemLikes);
      SeriesComments := flickrChart.GetNewLineSeries(chartItemComments);
      SeriesViews.title := id;
      SeriesLikes.title := id;
      SeriesComments.title := id;
      CheckedSeries.Add(id);
      viewsTendency := TTendency.Create;
      likesTendency := TTendency.Create;
      commentsTendency := TTendency.Create;
      colour := RGB(Random(255), Random(255), Random(255));
      for i := 0 to photo.stats.Count - 1 do
      begin
        stat := photo.stats[i];
        viewsTendency.AddXY(i, stat.views);
        SeriesViews.AddXY(stat.Date, stat.views, '', colour);

        likesTendency.AddXY(i, stat.likes);
        SeriesLikes.AddXY(stat.Date, stat.likes, '', colour);

        commentsTendency.AddXY(i, stat.numComments);
        SeriesComments.AddXY(stat.Date, stat.numComments, '', colour);
      end;
      chartItemViews.AddSeries(SeriesViews);
      chartItemLikes.AddSeries(SeriesLikes);
      chartItemComments.AddSeries(SeriesComments);
      viewsTendency.Calculate;
      likesTendency.Calculate;
      commentsTendency.Calculate;

      SeriesTendencyViews := flickrChart.GetNewLineSeries(chartItemViews);
      SeriesTendencyViews.title := id + 'tendency';
      color := clYellow;

      //Adding only first and last item
      theDate := photo.stats[0].Date;
      vTendency := viewsTendency.tendencyResult(0);
      SeriesTendencyViews.AddXY(theDate, vTendency, '', color);
      theDate := photo.stats[photo.stats.Count - 1].Date;
      vTendency := viewsTendency.tendencyResult(photo.stats.Count - 1);
      SeriesTendencyViews.AddXY(theDate, vTendency, '', color);

      chartItemViews.AddSeries(SeriesTendencyViews);

      SeriesTendencyLikes := flickrChart.GetNewLineSeries(chartItemLikes);
      SeriesTendencyLikes.title := id + 'tendency';
      color := clYellow;

      //Adding only first and last item
      theDate := photo.stats[0].Date;
      vTendency := likesTendency.tendencyResult(0);
      SeriesTendencyLikes.AddXY(theDate, vTendency, '', color);
      theDate := photo.stats[photo.stats.Count - 1].Date;
      vTendency := likesTendency.tendencyResult(photo.stats.Count - 1);
      SeriesTendencyLikes.AddXY(theDate, vTendency, '', color);

      chartItemLikes.AddSeries(SeriesTendencyLikes);

      SeriesTendencyComments := flickrChart.GetNewLineSeries(chartItemComments);
      SeriesTendencyComments.title := id + 'tendency';
      color := clYellow;

      //Adding only first and last item
      theDate := photo.stats[0].Date;
      vTendency := commentsTendency.tendencyResult(0);
      SeriesTendencyComments.AddXY(theDate, vTendency, '', color);
      theDate := photo.stats[photo.stats.Count - 1].Date;
      vTendency := commentsTendency.tendencyResult(photo.stats.Count - 1);
      SeriesTendencyComments.AddXY(theDate, vTendency, '', color);

      chartItemComments.AddSeries(SeriesTendencyComments);

      UpdateSingleStats(id);
    end;
  end
  else
  begin
    id := Item.Caption;
    if isInSeries(id) then
    begin
      Series := nil;
      for i := 0 to chartItemViews.SeriesList.Count - 1 do
      begin
        if chartItemViews.SeriesList[i].title = id then
        begin
          Series := TLineSeries(chartItemViews.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        chartItemViews.RemoveSeries(Series);

      Series := nil;
      for i := 0 to chartItemLikes.SeriesList.Count - 1 do
      begin
        if chartItemLikes.SeriesList[i].title = id then
        begin
          Series := TLineSeries(chartItemLikes.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        chartItemLikes.RemoveSeries(Series);

      Series := nil;
      for i := 0 to chartItemComments.SeriesList.Count - 1 do
      begin
        if chartItemComments.SeriesList[i].title = id then
        begin
          Series := TLineSeries(chartItemComments.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        chartItemComments.RemoveSeries(Series);

      Series := nil;
      for i := 0 to chartItemViews.SeriesList.Count - 1 do
      begin
        if chartItemViews.SeriesList[i].title = id + 'tendency' then
        begin
          Series := TLineSeries(chartItemViews.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        chartItemViews.RemoveSeries(Series);

      Series := nil;
      for i := 0 to chartItemLikes.SeriesList.Count - 1 do
      begin
        if chartItemLikes.SeriesList[i].title = id + 'tendency' then
        begin
          Series := TLineSeries(chartItemLikes.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        chartItemLikes.RemoveSeries(Series);

      Series := nil;
      for i := 0 to chartItemComments.SeriesList.Count - 1 do
      begin
        if chartItemComments.SeriesList[i].title = id + 'tendency' then
        begin
          Series := TLineSeries(chartItemComments.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        chartItemComments.RemoveSeries(Series);

      barSeries := nil;
      for i := 0 to chartItemViewsH.SeriesList.Count - 1 do
      begin
        if chartItemViewsH.SeriesList[i].title = id then
        begin
          barSeries := TBarSeries(chartItemViewsH.SeriesList[i]);
          Break;
        end;
      end;
      if barSeries <> nil then
        chartItemViewsH.RemoveSeries(barSeries);

      barSeries := nil;
      for i := 0 to chartItemLikesH.SeriesList.Count - 1 do
      begin
        if chartItemLikesH.SeriesList[i].title = id then
        begin
          barSeries := TBarSeries(chartItemLikesH.SeriesList[i]);
          Break;
        end;
      end;
      if barSeries <> nil then
        chartItemLikesH.RemoveSeries(barSeries);

      barSeries := nil;
      for i := 0 to chartItemCommentsH.SeriesList.Count - 1 do
      begin
        if chartItemCommentsH.SeriesList[i].title = id then
        begin
          barSeries := TBarSeries(chartItemCommentsH.SeriesList[i]);
          Break;
        end;
      end;
      if barSeries <> nil then
        chartItemCommentsH.RemoveSeries(barSeries);
    end;
  end;

  UpdateLabel();
end;

procedure TfrmFlickr.listPhotosUserItemChecked(Sender: TObject; Item: TListItem);
begin
  UpdateLabelPhotos();
end;

procedure TfrmFlickr.UpdateLabel();
var
  i : integer;
  count : integer;
begin
  count := 0;
  for i := 0 to listphotos.Items.Count-1 do
  begin
    if listphotos.Items[i].Checked then
      inc(count);
  end;
  chkUpdate.Checked := (count > 0);

  Label31.Caption := 'Number of items: ' + InttoStr(listphotos.Items.Count) + ' (' + count.ToString + ') selected';
end;

procedure TfrmFlickr.UpdateLabelGroups();
var
  i: Integer;
  count : integer;
begin
  count := 0;
  for i := 0 to listgroups.Items.Count-1 do
  begin
    if listgroups.Items[i].Checked then
      inc(count);
  end;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count) + '(' + count.ToString + ') selected';
end;

procedure TfrmFlickr.UpdateLabelPhotos();
var
  i: Integer;
  count : integer;
begin
  count := 0;
  for i := 0 to listPhotosUser.Items.Count-1 do
  begin
    if listPhotosUser.Items[i].Checked then
      inc(count);
  end;
  Label34.Caption := 'Number of items: ' + InttoStr(listPhotosUser.Items.Count) + '(' + count.ToString + ') selected';
end;

end.
