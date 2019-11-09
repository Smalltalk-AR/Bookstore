Class {
	#name : #BookTest,
	#superclass : #TestCase,
	#category : #'Bookstore-Tests'
}

{ #category : #accessing }
BookTest >> gabrielGarciaMarquez [
	
	^ BookAuthor named: 'Gabriel' lastName: 'García Marquez' bornIn: 'Colombia'
]

{ #category : #tests }
BookTest >> testAccessing [

	| book |

	book := Book
		titled: 'Cien años de soledad'
		by: self gabrielGarciaMarquez
		editedBy: 'Penguin Random House'
		on: 2001.
		
	self
		assert: book title equals: 'Cien años de soledad';
		assert: book author equals: self gabrielGarciaMarquez;
		assert: book editorial equals: 'Penguin Random House';
		assert: book editionYear equals: 2001
]

{ #category : #tests }
BookTest >> testFailedCreation [

	self
		should: [ Book
				titled: ''
				by: self gabrielGarciaMarquez
				editedBy: 'editorial'
				on: 2001
			]
		raise: InstanceCreationFailed
		withMessageText: 'You must provide a title'
]