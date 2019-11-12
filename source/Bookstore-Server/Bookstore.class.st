Class {
	#name : #Bookstore,
	#superclass : #Object,
	#instVars : [
		'server',
		'authors',
		'books'
	],
	#category : #'Bookstore-Server'
}

{ #category : #API }
Bookstore >> addAuthor: author [

	authors add: author
]

{ #category : #API }
Bookstore >> addAuthorBasedOn: aJSONString [

	| author |

	author := BookAuthor fromJson: ( NeoJSONObject fromString: aJSONString ).
	self addAuthor: author.
	
	^ TeaResponse ok body: author
]

{ #category : #API }
Bookstore >> addBook: book [

	books add: book
]

{ #category : #API }
Bookstore >> addBookBasedOn: aJSONString [

	| book |

	book := Book fromJson: ( NeoJSONObject fromString: aJSONString ).
	self addBook: book.
	
	^ TeaResponse ok body: book
]

{ #category : #API }
Bookstore >> authors [

	^ authors
]

{ #category : #API }
Bookstore >> books [

	^ books
]

{ #category : #initialization }
Bookstore >> configureEndpointsFor: aServer [

	aServer
		GET: '/authors' -> [ :request | self getAllAuthors ];
		POST: '/authors' -> [ :request | self addAuthorBasedOn: request contents ];
		DELETE: '/authors' -> [ :request | self deleteAuthorBasedOn: request contents ];
		OPTIONS: '/authors' -> self preflightResponse.

	aServer
		GET: '/books' -> [ :request | self getAllBooks ];
		POST: '/books' -> [ :request | self addBookBasedOn: request contents ];
		DELETE: '/books' -> [ :request | self deleteBookBasedOn: request contents ];
		OPTIONS: '/books' -> self preflightResponse.

	aServer
		after: '/*' -> [ :request :response | response headers at: 'Access-Control-Allow-Origin' put: '*' ]
]

{ #category : #API }
Bookstore >> deleteAuthorBasedOn: aJSONString [

	| authorToDelete |

	authorToDelete := BookAuthor fromJson: ( NeoJSONObject fromString: aJSONString ).
	authors
		detect: [ :author | author = authorToDelete ]
		ifFound: [ :author | authors remove: author ]
		ifNone: [ "do nothing" ].
		
	^ TeaResponse ok body: authorToDelete
]

{ #category : #API }
Bookstore >> deleteBookBasedOn: aJSONString [

	| bookToDelete |

	bookToDelete := Book fromJson: ( NeoJSONObject fromString: aJSONString ).
	books
		detect: [ :book | book = bookToDelete ]
		ifFound: [ :book | books remove: book ]
		ifNone: [ "do nothing" ].
		
	^ TeaResponse ok
		body: bookToDelete.
]

{ #category : #API }
Bookstore >> getAllAuthors [

	^ TeaResponse ok
		body: authors
]

{ #category : #API }
Bookstore >> getAllBooks [

	^ TeaResponse ok body: books
]

{ #category : #initialization }
Bookstore >> initialize [

	server := Teapot
		configure:
			{( #port -> 1710 ).
			( #defaultOutput -> #json ).
			( #debugMode -> true )}.
	self configureEndpointsFor: server.
	authors := Set new.
	books := Set new
]

{ #category : #CORS }
Bookstore >> preflightResponse [

	^ [ :request | 
	| response |

	response := ZnResponse noContent.
	response headers at: 'Access-Control-Allow-Methods' put: 'POST DELETE'.
	response headers at: 'Access-Control-Allow-Headers' put: 'Content-Type'.
	response
	]
]

{ #category : #controling }
Bookstore >> start [

	server start
]

{ #category : #controling }
Bookstore >> stop [

	server stop
]
