Class {
	#name : #BookAuthor,
	#superclass : #Object,
	#instVars : [
		'firstName',
		'lastName',
		'nationality'
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

	^ ( anObject isKindOf: self class )
		and: [ firstName = anObject firstName
				and: [ lastName = anObject lastName and: [ nationality = anObject country ] ]
			]
]

{ #category : #country }
BookAuthor >> country [

	^ nationality 
]

{ #category : #accessing }
BookAuthor >> firstName [

	^ firstName
]

{ #category : #comparing }
BookAuthor >> hash [

	^ firstName hash bitXor: ( lastName hash bitXor: nationality )
]

{ #category : #initialization }
BookAuthor >> initializeNamed: aFistName lastName: aLastName bornIn: aCountry [

	firstName := aFistName.
	lastName := aLastName.
	nationality := aCountry
]

{ #category : #accessing }
BookAuthor >> lastName [

	^ lastName
]
