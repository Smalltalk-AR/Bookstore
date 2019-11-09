Iceberg remoteTypeSelector: #httpsUrl.

Metacello new
	baseline: 'Bookstore';
	repository: 'github://Smalltalk-AR/Bookstore-Backend:master/source';
	load: 'Deployment'.

SmalltalkImage current
	closeSourceFiles;
	openSourceFiles;
	snapshot: true andQuit: true. 
