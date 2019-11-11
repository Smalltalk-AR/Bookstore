Class {
	#name : #BookstoreInstaller,
	#superclass : #Object,
	#instVars : [
		'session',
		'bookstore'
	],
	#category : #'Bookstore-Server'
}

{ #category : #persistence }
BookstoreInstaller >> authorClassModelDefinition [

	^ ClassModelDefinition
		for: BookAuthor
		attributesDefinedBy:
			{(BasicAttributeDefinition named: #firstName).
			(BasicAttributeDefinition named: #lastName).
			(BasicAttributeDefinition named: #country)}
]

{ #category : #persistence }
BookstoreInstaller >> authorDescriptorDefinition [

	^ ConcreteDescriptorDefinition
		for: BookAuthor
		onTableNamed: 'AUTHORS'
		mappingsDefinedBy:
			{(DirectMappingDefinition
				fromAttributeNamed: #firstName
				toFieldNamed: 'first_name'
				onTableNamed: 'AUTHORS').
			(DirectMappingDefinition
				fromAttributeNamed: #lastName
				toFieldNamed: 'last_name'
				onTableNamed: 'AUTHORS').
			(DirectMappingDefinition
				fromAttributeNamed: #country
				toFieldNamed: 'country'
				onTableNamed: 'AUTHORS')}
]

{ #category : #actions }
BookstoreInstaller >> authorsRepository [

	| authorsRepository |

	authorsRepository := RDBMSRepository
		storingObjectsOfType: BookAuthor
		checkingConflictsAccordingTo: DoNotCheckForConflictsStrategy new
		workingWith: [ :action | action value: session ].

	^ authorsRepository
		configureMappingsIn: [ :rdbmsRepository | 
			rdbmsRepository
				beAwareOfTableDefinedBy: self authorsTableDefinition;
				beAwareOfClassModelDefinedBy: self authorClassModelDefinition;
				beAwareOfDescriptorDefinedBy: self authorDescriptorDefinition ]
]

{ #category : #persistence }
BookstoreInstaller >> authorsTableDefinition [

	^ RealTableDefinition
		named: 'AUTHORS'
		fieldsDefinedBy:
			{(CharacterFieldDefinition
				toBePrimaryKeyNamed: 'first_name'
				sized: 100).
			(CharacterFieldDefinition
				toBePrimaryKeyNamed: 'last_name'
				sized: 100).
			(CharacterFieldDefinition named: 'country' sized: 100)}
]

{ #category : #initialization }
BookstoreInstaller >> defaultLogin [

	^ Login new
		database: PostgreSQLPlatform new;
		username: 'postgres';
		password: 'secret';
		host: 'localhost';
		port: 5432;
		databaseName: 'bookstore';
		yourself
]

{ #category : #initialization }
BookstoreInstaller >> initialize [

	session := GlorpSession new
		accessor: self postgresDatabaseAccessor;
		system: ConfigurableDescriptorSystem new;
		yourself.
		
	bookstore := Bookstore storingAuthorsIn: self authorsRepository.

]

{ #category : #actions }
BookstoreInstaller >> install [

	session
		login;
		recreateTables;
		logout
]

{ #category : #initialization }
BookstoreInstaller >> postgresDatabaseAccessor [

	DatabaseAccessor classForThisPlatform DefaultDriver: P3DatabaseDriver.
	^ DatabaseAccessor forLogin: self defaultLogin
]

{ #category : #actions }
BookstoreInstaller >> start [ 

	session login. 
	bookstore start.
]

{ #category : #actions }
BookstoreInstaller >> stop [ 

	session logout. 
	bookstore stop.
]
