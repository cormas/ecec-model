Class {
	#name : 'ECECModel',
	#superclass : 'CMAbstractModel',
	#instVars : [
		'theRestrainedForagers',
		'theUnrestrainedForagers',
		'theVegetationUnits'
	],
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : '- probes' }
ECECModel class >> colorOfProbe_numberOfRestrainedForagers [
  ^ (Color r: 0.05278592375366569 g: 0.0 b: 1.0 alpha: 1.0)
]

{ #category : '- probes' }
ECECModel class >> colorOfProbe_numberOfUnrestrainedForagers [
  ^ (Color r: 1.0 g: 0.0 b: 0.0019550342130987292 alpha: 1.0)
]

{ #category : '- probes' }
ECECModel class >> colorOfProbe_totalAmountOfBiomass [
  ^ (Color r: 0.21700879765395895 g: 1.0 b: 0.0 alpha: 1.0)
]

{ #category : 'simulation settings' }
ECECModel class >> defaultInit [

	^ #homogeneousEnvironment
]

{ #category : 'accessing' }
ECECModel class >> initialNumberOfRestrainedForagers [

	^ 10
]

{ #category : 'accessing' }
ECECModel class >> initialNumberOfUnrestrainedForagers [

	^ 10
]

{ #category : 'init' }
ECECModel >> homogeneousEnvironment [

	self
		createGridNumberOfRows: 27
		numberOfColumns: 27
		neighbourhood: 8
		closed: false.
		
	self theVegetationUnits do: [ :each | each initializeWithRandomBiomass ].
	
	self
		initializeAgents;
		displayPov: #povBiomass of: ECECVegetationUnit;
		displayPov: #defaultPOV of: ECECForager
]

{ #category : 'initialization' }
ECECModel >> initialize [

	super initialize.
	
	theRestrainedForagers := OrderedCollection new.
	theUnrestrainedForagers := OrderedCollection new.
	theVegetationUnits := OrderedCollection new.
]

{ #category : 'init entities' }
ECECModel >> initializeAgents [

	self
		createN: self class initialNumberOfRestrainedForagers
		randomlyLocatedAloneEntities: ECECRestrainedForager.
		
	self
		createN: self class initialNumberOfUnrestrainedForagers
		randomlyLocatedAloneEntities: ECECUnrestrainedForager.
]

{ #category : 'init' }
ECECModel >> islandEnvironment [

	| x y |
	self homogeneousEnvironment.
	
	self theCells do: [ :cell |
		x := cell coordinates x.
		y := cell coordinates y.
		
		(x % 6 <= 2 and: [ y % 6 <= 2 ]) ifFalse: [ cell biomass: 0 ] ].
]

{ #category : 'probes' }
ECECModel >> numberOfRestrainedForagers [

	<probeNamed: 'Number of restrained foragers'>
	^ self theRestrainedForagers size
]

{ #category : 'probes' }
ECECModel >> numberOfUnrestrainedForagers [

	<probeNamed: 'Number of unrestrained foragers'>
	^ self theUnrestrainedForagers size
]

{ #category : 'init' }
ECECModel >> remoteIslandEnvironment [

	| x y |
	self homogeneousEnvironment.
	
	self theCells do: [ :cell |
		x := cell coordinates x.
		y := cell coordinates y.
		
		(x % 12 <= 3 and: [ y % 12 <= 3 ]) ifFalse: [ cell biomass: 0 ] ].
]

{ #category : 'init' }
ECECModel >> smallEnvironment [

	self
		createGridLines: 4
		columns: 4
		neighbourhood: 8
		closed: false.
		
	self theVegetationUnits do: [ :each | each initializeWithRandomBiomass ].
	
	self
		createN: 1
		randomlyLocatedAloneEntities: ECECRestrainedForager.
		
	self
		createN: 1
		randomlyLocatedAloneEntities: ECECUnrestrainedForager.
	
	self
		displayPov: #povBiomass of: ECECVegetationUnit;
		displayPov: #defaultPOV of: ECECForager
]

{ #category : 'control' }
ECECModel >> step: anObject [

	self
		stepEntities: self theVegetationUnits;
		askRandom: ECECForager toDo: #step
]

{ #category : 'accessing' }
ECECModel >> theRestrainedForagers [
	<getterFor: #ECECRestrainedForager>

	^ theRestrainedForagers
]

{ #category : 'accessing' }
ECECModel >> theRestrainedForagers: anObject [

	theRestrainedForagers := anObject
]

{ #category : 'accessing' }
ECECModel >> theUnrestrainedForagers [
	<getterFor: #ECECUnrestrainedForager>

	^ theUnrestrainedForagers
]

{ #category : 'accessing' }
ECECModel >> theUnrestrainedForagers: anObject [

	theUnrestrainedForagers := anObject
]

{ #category : 'accessing' }
ECECModel >> theVegetationUnits [
	<getterFor: #ECECVegetationUnit>

	^ theVegetationUnits
]

{ #category : 'accessing' }
ECECModel >> theVegetationUnits: anObject [

	theVegetationUnits := anObject
]

{ #category : 'probes' }
ECECModel >> totalAmountOfBiomass [

	<probeNamed: 'Total amount of biomass'>
	^ self theVegetationUnits sum: [ :each | each biomass ]
]
