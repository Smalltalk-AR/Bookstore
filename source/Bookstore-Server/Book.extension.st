Extension { #name : #Book }

{ #category : #'*Bookstore-Server' }
Book class >> authorFrom: aNeoJSon [
	^ BookAuthor fromJson: aNeoJSon
]

{ #category : #'*Bookstore-Server' }
Book class >> fromJson: aNeoJSON [
	^ self
		titled: (aNeoJSON at: #title)
		by: (self authorFrom: (aNeoJSON at: #author))
		editedBy: (aNeoJSON at: #editorial)
		on: (aNeoJSON at: #releaseYear)
		index: (aNeoJSON at: #index)
]

{ #category : #'*Bookstore-Server' }
Book class >> neoJsonMapping: mapper [
	mapper
		for: self
		do:
			[ :mapping | mapping mapInstVars: #(title author editorial releaseYear index) ]
]
