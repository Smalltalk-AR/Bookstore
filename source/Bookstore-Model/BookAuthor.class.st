Class {
	#name : #BookAuthor,
	#superclass : #Object,
	#instVars : [
		'firstName',
		'lastName',
		'country'
	],
	#category : #'Bookstore-Model-Bookstore-Model'
}

{ #category : #'instance creation' }
BookAuthor class >> named: aFirstName lastName: aLastName bornIn: aCountry [

	AssertionChecker
		refuse: [ aFirstName isEmpty ]
			because: 'First name must be a non-empty string'
			raising: InstanceCreationFailed;
		refuse: [ aLastName isEmpty ]
			because: 'Last name must be a non-empty string'
			raising: InstanceCreationFailed.

	^ self new initializeNamed: aFirstName lastName: aLastName bornIn: aCountry
]

{ #category : #comparing }
BookAuthor >> = anObject [
	^ anObject class = self class
		and: [ firstName = anObject firstName
				and: [ lastName = anObject lastName and: [ country = anObject country ] ]
			]
]

{ #category : #accessing }
BookAuthor >> country [

	^ country 
]

{ #category : #accessing }
BookAuthor >> firstName [

	^ firstName
]

{ #category : #comparing }
BookAuthor >> hash [

	^ firstName hash bitXor: ( lastName hash bitXor: country hash)

]

{ #category : #initialization }
BookAuthor >> initializeNamed: aFistName lastName: aLastName bornIn: aCountry [

	firstName := aFistName.
	lastName := aLastName.
	country := aCountry
]

{ #category : #accessing }
BookAuthor >> lastName [

	^ lastName
]
