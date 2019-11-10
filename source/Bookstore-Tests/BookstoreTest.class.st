Class {
	#name : #BookstoreTest,
	#superclass : #TestCase,
	#instVars : [
		'bookstore'
	],
	#category : #'Bookstore-Tests'
}

{ #category : #running }
BookstoreTest >> setUp [
	bookstore := Bookstore new
]

{ #category : #running }
BookstoreTest >> tearDown [
	bookstore stop
]

{ #category : #running }
BookstoreTest >> testAccessingFromNewBookstore [
	| store |
	store := Bookstore new.
	self
		assert: store authors isEmpty;
		assert: store books isEmpty;
		assert: store getAllAuthors body isEmpty;
		assert: store getAllBooks body isEmpty
]

{ #category : #running }
BookstoreTest >> testAddAuthorFromJSONToBookstore [
	| json |
	json := '{"firstName":"Example", "lastName":"Name", "nationality":"Malasya"}'.
	self assert: bookstore authors isEmpty.
	bookstore addAuthorBasedOn: json.
	self
		withTheOnlyOneIn: bookstore authors
		do: [ :author | 
			('{"firstName":"<1s>", "lastName":"<2s>", "nationality":"<3s>"}'
				expandMacrosWith: author firstName
				with: author lastName
				with: author country) = json ].
	^ json
]

{ #category : #running }
BookstoreTest >> testAddAuthorToBookstore [
	| author |
	author := BookAuthor
		named: 'Example'
		lastName: 'Name'
		bornIn: 'Malasia'.
	self assert: bookstore authors isEmpty.
	bookstore addAuthor: author.
	self
		withTheOnlyOneIn: bookstore authors
		do: [ :auth | auth = author ]
]

{ #category : #running }
BookstoreTest >> testAddBookFromJSONToBookstore [
	| json authorJSON |
	authorJSON := self testAddAuthorFromJSONToBookstore.
	json := '{"title":"El Placer de Cocinar a Millhouse", "author":<1s>, "editorial":"Editorial Pepito", "releaseYear":2001, "index":1}'
		expandMacrosWith: authorJSON.
	self assert: bookstore books isEmpty.
	bookstore addBookBasedOn: json.
	self
		withTheOnlyOneIn: bookstore books
		do: [ :book | 
			('{"title":"<1s>", "author":<2s>, "editorial":"<3s>", "year":<4n>, "index":<5n>}'
				expandMacrosWithArguments:
					{book title.
					authorJSON.
					book editorial.
					book editionYear.
					book index}) = json ].
	^ json
]

{ #category : #running }
BookstoreTest >> testAddBookToBookstore [
	| book |
	self testAddAuthorToBookstore.
	book := Book
		titled: 'Como cocinar a Millhouse'
		by: bookstore authors asArray first
		editedBy: 'Editorial Pepito'
		on: 2001
		index: 1.
	self assert: bookstore books isEmpty.
	bookstore addBook: book.
	self withTheOnlyOneIn: bookstore books do: [ :bk | bk = book ]
]

{ #category : #running }
BookstoreTest >> testDeleteAuthorFromJSON [
	| json |
	json := self testAddAuthorFromJSONToBookstore.
	bookstore deleteAuthorBasedOn: json.
	self assert: bookstore authors isEmpty
]

{ #category : #running }
BookstoreTest >> testDeleteBooksFromJSON [
	| json |
	json := self testAddBookFromJSONToBookstore.
	bookstore deleteBookBasedOn: json.
	self assert: bookstore books isEmpty
]
