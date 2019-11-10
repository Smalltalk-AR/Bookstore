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

{ #category : #initialization }
Bookstore >> addAuthor: author [
	authors add: author
]

{ #category : #initialization }
Bookstore >> addAuthorBasedOn: aJSONString [
	| author |
	author := BookAuthor
		fromJson: (NeoJSONObject fromString: aJSONString).
	self addAuthor: author.
	^ TeaResponse ok
		body: author;
		headers: {('Access-Control-Allow-Origin' -> '*')}
]

{ #category : #initialization }
Bookstore >> addBook: book [
	books add: book
]

{ #category : #initialization }
Bookstore >> addBookBasedOn: aJSONString [
	| book |
	book := Book fromJson: (NeoJSONObject fromString: aJSONString).
	self addBook: book.
	^ TeaResponse ok
		body: book;
		headers: {('Access-Control-Allow-Origin' -> '*')}
]

{ #category : #initialization }
Bookstore >> authors [
	^ authors
]

{ #category : #initialization }
Bookstore >> books [
	^ books
]

{ #category : #initialization }
Bookstore >> configureEndpointsFor: aServer [
	aServer
		GET: '/authors' -> [ :request | self getAllAuthors ];
		POST: '/authors' -> [ :request | self addAuthorBasedOn: request contents ];
		DELETE: '/authors' -> [ :request | self deleteAuthorBasedOn: request contents ].
	aServer
		GET: '/books' -> [ :request | self getAllBooks ];
		POST: '/books' -> [ :request | self addBookBasedOn: request contents ];
		DELETE: '/books' -> [ :request | self deleteBookBasedOn: request contents ]
]

{ #category : #initialization }
Bookstore >> deleteAuthorBasedOn: aJSONString [
	| authorToDelete |
	authorToDelete := BookAuthor
		fromJson: (NeoJSONObject fromString: aJSONString).
	authors
		detect: [ :author | author = authorToDelete ]
		ifFound: [ :author | authors remove: author ]
		ifNone: [ "do nothing" ].
	^ TeaResponse ok
		body: authorToDelete;
		headers: {('Access-Control-Allow-Origin' -> '*')}
]

{ #category : #initialization }
Bookstore >> deleteBookBasedOn: aJSONString [
	| bookToDelete |
	bookToDelete := Book
		fromJson: (NeoJSONObject fromString: aJSONString).
	books
		detect: [ :book | book = bookToDelete ]
		ifFound: [ :book | books remove: book ]
		ifNone: [ "do nothing" ].
	^ TeaResponse ok
		body: bookToDelete;
		headers: {('Access-Control-Allow-Origin' -> '*')}
]

{ #category : #initialization }
Bookstore >> getAllAuthors [
	^ TeaResponse ok
		body: authors;
		headers: {('Access-Control-Allow-Origin' -> '*')}
]

{ #category : #initialization }
Bookstore >> getAllBooks [
	^ TeaResponse ok
		body: books;
		headers: {('Access-Control-Allow-Origin' -> '*')}
]

{ #category : #initialization }
Bookstore >> initialize [
	server := Teapot
		configure:
			{(#port -> 9090).
			(#defaultOutput -> #json).
			(#debugMode -> true)}.
	self configureEndpointsFor: server.
	authors := Set new.
	books := Set new
]

{ #category : #initialization }
Bookstore >> start [
	server start
]

{ #category : #initialization }
Bookstore >> stop [
	server stop
]
