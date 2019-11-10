Extension { #name : #Book }

{ #category : #'*Bookstore-Server' }
Book class >> authorFrom: aNeoJSon [
	^ BookAuthor fromJson: aNeoJSon
]

{ #category : #'*Bookstore-Server' }
Book class >> fromJson: aNeoJSon [
	^ self
		titled: (aNeoJSon at: #title)
		by: (self authorFrom: (aNeoJSon at: #author))
		editedBy: (aNeoJSon at: #editorial)
		on: (aNeoJSon at: #releaseYear)
]

{ #category : #'*Bookstore-Server' }
Book class >> neoJsonMapping: mapper [
	mapper
		for: self
		do:
			[ :mapping | mapping mapInstVars: #(title author editorial releaseYear) ]
]
