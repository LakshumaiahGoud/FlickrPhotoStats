FlickrPhotoStats
================

Flickr Photo stats provides you with the ability to request information from your Flickr stream using the Web REST API. This tool does not need a PRO account to run against. It will keep track of your stats locally overtime.

Download the latest version here:

[![Downloads](https://img.shields.io/badge/downloads-1.2k-blue.svg)](https://github.com/JordiCorbilla/FlickrPhotoStats/releases/tag/4.8.0.2) [![Downloads](https://img.shields.io/badge/lines-47k-green.svg)](https://github.com/JordiCorbilla/FlickrPhotoStats/releases/tag/4.8.0.2) [![Stable Release](https://img.shields.io/badge/version-4.8.0.2rc-blue.svg)](https://github.com/JordiCorbilla/FlickrPhotoStats/releases/tag/4.8.0.2) [![License](https://img.shields.io/badge/license-GPL-blue.svg)](https://github.com/JordiCorbilla/FlickrPhotoStats/releases/tag/4.8.0.2) [![Delphi version](https://img.shields.io/badge/delphi-10.1BerlinUpdate2-red.svg)](https://github.com/JordiCorbilla/FlickrPhotoStats/releases/tag/4.8.0.2)

**Additional libraries required:**
The application requires SSL authentication and for that it uses the libraries provided by OpenSSL.
Remember to download the following libraries and place them in the application root:

- [OpenSSL v1.02 32bits](http://indy.fulgan.com/SSL/openssl-1.0.2d-i386-win32.zip).
- [OpenSSL v1.02 64bits](http://indy.fulgan.com/SSL/openssl-1.0.2d-x64_86-win64.zip).

**License:** GNU General Public License.

The app only needs a valid *API Key* that can be requested in the App Garden where my application is already [published](https://www.flickr.com/services/apps/72157639602915254/):

[The App Garden - API request](https://www.flickr.com/services/apps/create/apply/?).

Once obtained, you can load your list or start a new one using the Api Key.

Additional info can be found in the following [**post**](http://thundaxsoftware.blogspot.co.uk/p/flickr-photo-analytics-v4.html) in my blog.

**Example of the app**:

**New Dashboard v4.8.0.2 (Windows 10 support) **:

![](https://github.com/JordiCorbilla/FlickrPhotoStats/raw/master/dashboard.png)
![](https://github.com/JordiCorbilla/FlickrPhotoStats/raw/master/dashboard2.png)

**Dashboard (previous versions)**:

![](http://3.bp.blogspot.com/-fFx_AXjkKjk/VhkkWW1GF-I/AAAAAAAAFIE/aosoNiSmji0/s640/10102015Image.png)

**Processing**:

![](http://3.bp.blogspot.com/-h1K2_xTgOdo/VhklfDRPHCI/AAAAAAAAFIM/M3OHcdncoYo/s640/10102015Image.png)

**Authentication**:

![](http://2.bp.blogspot.com/-buVw7akFPG4/VdzYG7JkCcI/AAAAAAAAE_w/qolCi6kzKDY/s640/auth2.png)

It will keep a list of all the photos you add to keep track of them automatically.
The following information will be saved:
- Number of views.
- Number of Likes.
- Number of Comments.
- Last time it was updated.
- Affection (number of likes over number of views).

Each value is saved and stored over time so the tool can display the trend of a particular photo.

Code convention:
- > 1000 < 3000 views: blue.
- > 3000 < 5000 views: green.
- > 5000 < 8000 views: Olive.
- > 8000 < 10000 views: Fuchsia. 
- > 10000 views: red.
 
Use **Batch Update** to easily update all the values and keep a good track record of your flickr stream.

Version 4.8.0.2 (RC stable):
- [FlickrPhotoStats(x64) v4.8.0.2](https://github.com/JordiCorbilla/FlickrPhotoStats/releases/tag/4.8.0.2).
 
Version 4.8.0.1 (RC stable):
- [FlickrPhotoStats(x64) v4.8.0.1](https://app.box.com/s/fm0qqguhzbpt31fj97uori8ydgtcjkly).

### Older versions:

Version 4.6 (RC):
- [FlickrPhotoStats(x64) v4.6.0.1](https://app.box.com/s/fm0qqguhzbpt31fj97uori8ydgtcjkly).

Version 4.7 (RC):
- [FlickrPhotoStats(x64) v4.7.0.1](https://app.box.com/s/9v3z1s1fu1wouipmlcfhfklda59qgzmb).

Older versions can be found here: [Archive](https://github.com/JordiCorbilla/FlickrPhotoStats/tree/v4.6.0.1).

### Usage of the Flickr API

You can create an instance of ParseServer, and mount it on a new or existing Express website:

```Delphi
   //TFlickrRest exposes the methods of the Flickr API.
   //THTTPRest exposes a REST approach with XML format
   THttpRest.Post(TFlickrRest.New(optionsAgent).getInfo(id), procedure (iXMLRootNode : IXMLNode)
    begin
      views := iXMLRootNode.attributes['views'];
    end);
```

## Changelog
### Features for version 3.1:
- Get the total list of photos using flickr.people.getPhotos for automatic population of the application.

### Features for version 4.1:
- OAuth authentication.
- Get list of groups and create your own profiles for automatic population.
- Totals for Albums.

### Features for version 4.3:
- Dashboard.
- Trend lines.
- Album population.

### Features for version 4.4:
- Dashboard upgrade.
- Area series.
- Performance improvements.
- BatchUpdate to send emails out to users.
- emails support HTML.
- splash screen.
- Photo filtering.

### Features for version 4.5:
- Dashboard upgrade.
- Double click on graphs to expand.
- Performance improvements.
- BatchUpdate to send emails out to users.
- emails support HTML.
- splash screen.
- Photo filtering.
- Memory leaks.
- Web dashboard using ASP.NET MVC.

### Features for version 4.6:
- Dashboard upgrade.
- Trend upgrade.

### Features for version 4.7:
- Dashboard upgrade.
- Data Backup in zip format.
- Trend upgrade.

### Features for version 4.8.0.1:
- Consolidation of bug fixes from 4.7 version.
- Performance improvements.
- Parse.com integration.

### Features for version 4.8.0.2:
- Reduction of memory and time footprint:
   Memory Footprint    before    after    % reduction 
     Load             768 Mb     25 Mb    97 %
     Save             768 Mb     25 Mb    97 %

   Time Footprint      before    after    % reduction 
     Load             135551 ms  178 ms  100 %
     Save             115745 ms  135 ms  100 %
- Multi-threaded approach to increase performance. Reduction of 99% of the time.

Source code is available here.

The application can now use **OAuth** authentication using REST. The application itself can validate the user tokens and provide all the flow within the application. I will write a post about this in my blog.

Developed with Delphi 10.1 Berlin and C# and using [OpenSSL](https://www.openssl.org/) libraries.

## Roadmap
### Version 4.4:
- Additional photo filtering.
- Speed improvements.

### Version 4.5:
- Authentication improvements.
- Pool improvements.
 
### Version 4.6:
- Automatic backup.
- Saving the history independently.

### Version 4.7:
- Stable and highly functional release.
- Pool and album handling.

### Version 4.8:
- Memory and CPU performance.

### Version 5:
- Saving the repository in a SQL DB (MySQL, SQL Server).
- For version 5 I will start my hosted version where I will be able to take users on-board and just email the results back.

Platform Support
----------------

It works under Windows 7, Windows 8, Windows 10 and Windows 2012.

Minimum Requirements
----------------

This application is memory intensive and it will require loads of memory overtime. A year worth of history is about 500Mb in memory. Minumum recommended memory is 4Gb with a cpu with 4 cores (64 bits). Google can detect the constant sending/receiving of requests as a robot. Recommended screen resolution: 1920x1200. Minimum (1600x1200)

**Licence**
-------

    Flickr Photo Analytics Copyright (C) 2015 Jordi Corbilla

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU 
    General Public License as published by the Free Software Foundation, either version 3 of the License,
    or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
    the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.
    
    You should have received a copy of the GNU General Public License along with this program. 
    If not, see http://www.gnu.org/licenses/.

## Sponsors
No sponsors yet! Will you be the first?

[![PayPayl donate button](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=L5FCF6LX5C9AW "Donate once-off to this project using Paypal")
