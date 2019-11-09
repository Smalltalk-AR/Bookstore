Class {
	#name : #Book,
	#superclass : #Object,
	#instVars : [
		'title',
		'author',
		'editorial',
		'relaseYear'
	],
	#category : #'Bookstore-Model'
}

{ #category : #'instance creation' }
Book class >> titled: aTitle by: aBookAuthor editedBy: anEditorial on: aEditionYear [

	AssertionChecker
		refuse: [ aTitle isEmpty ]
			because: 'Title must be a non-empty string'
			raising: InstanceCreationFailed;
		refuse: [ anEditorial isEmpty ]
			because: 'Editorial must be a non-empty string'
			raising: InstanceCreationFailed.

	^ self new
		intializeTitled: aTitle
		by: aBookAuthor
		editedBy: anEditorial
		on: aEditionYear
]

{ #category : #accessing }
Book >> author [

	^ author
]

{ #category : #publicationYear }
Book >> editionYear [
	
	^ relaseYear 
]

{ #category : #accessing }
Book >> editorial [

	^ editorial
]

{ #category : #'instance creation' }
Book >> intializeTitled: aTitle by: anAuthor editedBy: anEditorial on: aYear [

	title := aTitle.
	author := anAuthor.
	editorial := anEditorial.
	relaseYear := aYear
]

{ #category : #accessing }
Book >> title [

	^ title
]
