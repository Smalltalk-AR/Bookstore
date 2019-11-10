Class {
	#name : #Book,
	#superclass : #Object,
	#instVars : [
		'title',
		'author',
		'editorial',
		'index',
		'editionYear'
	],
	#category : #'Bookstore-Model'
}

{ #category : #'instance creation' }
Book class >> titled: aTitle by: aBookAuthor editedBy: anEditorial on: aEditionYear index: anIndex [

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
		index: anIndex
]

{ #category : #accessing }
Book >> author [

	^ author
]

{ #category : #accessing }
Book >> editionYear [
	
	^ editionYear 
]

{ #category : #accessing }
Book >> editorial [

	^ editorial
]

{ #category : #accessing }
Book >> index [
	
	^ index 
]

{ #category : #initialization }
Book >> intializeTitled: aTitle by: anAuthor editedBy: anEditorial on: aYear index: anIndex [

	title := aTitle.
	author := anAuthor.
	editorial := anEditorial.
	editionYear := aYear.
	index := anIndex
]

{ #category : #accessing }
Book >> title [

	^ title
]
