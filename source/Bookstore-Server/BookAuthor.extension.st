Extension { #name : #BookAuthor }

{ #category : #'*Bookstore-Server' }
BookAuthor class >> fromJson: aNeoJSon [
	^ self
		named: (aNeoJSon at: #firstName)
		lastName: (aNeoJSon at: #lastName)
		bornIn: (aNeoJSon at: #nationality)
]

{ #category : #'*Bookstore-Server' }
BookAuthor class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | mapping mapInstVars: #(firstName lastName nationality) ]
]
