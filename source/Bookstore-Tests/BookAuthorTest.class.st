Class {
	#name : #BookAuthorTest,
	#superclass : #TestCase,
	#category : #'Bookstore-Tests'
}

{ #category : #tests }
BookAuthorTest >> testAccessing [

	| author |

	author := BookAuthor named: 'Gabriel' lastName: 'García Márquez' bornIn: 'Colombia'.

	self
		assert: author firstName equals: 'Gabriel';
		assert: author lastName equals: 'García Márquez';
		assert: author country equals: 'Colombia'
]

{ #category : #tests }
BookAuthorTest >> testEquals [

	| author sameAuthor |

	author := BookAuthor 
		named: 'Gabriel' 
		lastName: 'García Márquez' 
		bornIn: 'Colombia'.
	sameAuthor := BookAuthor 
		named: 'Gabriel' 
		lastName: 'García Márquez' 
		bornIn: 'Colombia'.

	self assert: author equals: sameAuthor
]

{ #category : #tests }
BookAuthorTest >> testFailedCreation [

	self
		should: [ BookAuthor named: '' lastName: 'García Márquez' bornIn: 'Colombia' ]
			raise: InstanceCreationFailed
			withMessageText: 'Nil property in Person';
		should: [ BookAuthor named: 'Gabriel' lastName: '' bornIn: 'Colombia' ]
			raise: Error
			withMessageText: 'Nil property in Person'
]
