Class {
	#name : #BaselineOfBookstore,
	#superclass : #BaselineOf,
	#category : #BaselineOfBookstore
}

{ #category : #baselines }
BaselineOfBookstore >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
					setUpDependencies: spec;
					setUpGroups: spec.
				spec group: 'default' with: #('Development') ]
]

{ #category : #baselines }
BaselineOfBookstore >> setUpDependencies: spec [

	spec
		baseline: 'Buoy'
			with: [ spec
				repository: 'github://ba-st/Buoy:v5/source';
				loads: #('Deployment') ];
		project: 'BuoyTestExtensions'
			copyFrom: 'Buoy'
			with: [ spec loads: 'Dependent-SUnit-Extensions' ]
]

{ #category : #baselines }
BaselineOfBookstore >> setUpGroups: spec [

	spec
		package: 'Bookstore-Model' with: [ spec requires: #('Buoy') ];
		package: 'Bookstore-Tests'
			with: [ spec requires: #('Bookstore-Model' 'BuoyTestExtensions') ].
	spec
		group: 'Deployment' with: #('Bookstore-Model');
		group: 'Development' with: #('Bookstore-Tests')
]
