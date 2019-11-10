Class {
	#name : #Book,
	#superclass : #Object,
	#instVars : [
		'title',
		'author',
		'editorial',
		'releaseYear',
		'index'
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
Book >> = anObject [
	^ anObject class = self class
		and: [ author = anObject author
				and: [ releaseYear = anObject editionYear
						and: [ index = anObject index and: [ title = anObject title ] ] ] ]
]

{ #category : #accessing }
Book >> author [

	^ author
]

{ #category : #publicationYear }
Book >> editionYear [
	
	^ releaseYear 
]

{ #category : #accessing }
Book >> editorial [

	^ editorial
]

{ #category : #accessing }
Book >> hash [
	^ author hash
		bitXor: (releaseYear hash bitXor: (index hash bitXor: title hash))
]

{ #category : #'instance creation' }
Book >> index [
	^ index
]

{ #category : #'instance creation' }
Book >> intializeTitled: aTitle by: anAuthor editedBy: anEditorial on: aYear index: anIndex [
	title := aTitle.
	author := anAuthor.
	editorial := anEditorial.
	releaseYear := aYear.
	index := anIndex
]

{ #category : #accessing }
Book >> title [

	^ title
]
