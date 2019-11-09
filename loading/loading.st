 
| localRepository | 

localRepository := '/media/sf_Repos'.

Metacello new
  baseline: 'GlorpDriverMySQL';
  repository: 'github://apiorno/GlorpDriverMySQL:master/source';
  load.

Gofer it
    smalltalkhubUser: 'zeroflag' project: 'Teapot';
    configuration;
    loadStable.

Metacello new
    baseline: 'Bookstore';
    filetreeDirectory: ('<1s>/<2s>' expandMacrosWith: localRepository with: 'Bookstore-Backend/source/');
    lock;
    load: 'Development'.