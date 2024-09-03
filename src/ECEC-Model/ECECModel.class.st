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

{ #category : 'menu' }
ECECModel class >> aboutThisModel [

	^ '# ECEC Model

This is a simple implementation of a **very powerful** agent-based model. For more information, visit [our website](https://cormas.org).

## Agents

There are two types of agents:

1. Restrained foragers
2. Unrestrained foragers
'
]

{ #category : 'accessing' }
ECECModel class >> initialNumberOfRestrainedForagers [

	^ 10
]

{ #category : 'accessing' }
ECECModel class >> initialNumberOfUnrestrainedForagers [

	^ 10
]

{ #category : 'tests - printing' }
ECECModel class >> prefix [

	^ 'ECEC'
]

{ #category : 'init' }
ECECModel >> homogeneousEnvironment [
	<init>
	self
		createGridNumberOfRows: 27
		numberOfColumns: 27
		neighbourhood: 8
		closed: false.
		
	self theVegetationUnits do: [ :each | each initializeWithRandomBiomass ].
	
	self initializeAgents.
	
	ECECVegetationUnit activePovSelector: #povBiomass.
	ECECForager activePovSelector: #pov
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
	<init>
	| x y |
	self homogeneousEnvironment.
	
	self theCells do: [ :cell |
		x := cell coordinates x.
		y := cell coordinates y.
		
		(x % 6 <= 2 and: [ y % 6 <= 2 ]) ifFalse: [ cell biomass: 0 ] ].
]

{ #category : 'probes' }
ECECModel >> numberOfRestrainedForagers [

	<probeNamed: 'Number of restrained foragers' color: '0000FF'>
	^ self theRestrainedForagers size
]

{ #category : 'probes' }
ECECModel >> numberOfUnrestrainedForagers [

	<probeNamed: 'Number of unrestrained foragers' color: 'FF0000'>
	^ self theUnrestrainedForagers size
]

{ #category : 'init' }
ECECModel >> remoteIslandEnvironment [
	<init>
	| x y |
	self homogeneousEnvironment.
	
	self theCells do: [ :cell |
		x := cell coordinates x.
		y := cell coordinates y.
		
		(x % 12 <= 3 and: [ y % 12 <= 3 ]) ifFalse: [ cell biomass: 0 ] ].
]

{ #category : 'init' }
ECECModel >> smallEnvironment [
	<init>
	self
		createGridNumberOfRows: 4
		numberOfColumns: 4
		neighbourhood: 8
		closed: false.
		
	self theVegetationUnits do: [ :each | each initializeWithRandomBiomass ].
	
	self
		createN: 1
		randomlyLocatedAloneEntities: ECECRestrainedForager.
		
	self
		createN: 1
		randomlyLocatedAloneEntities: ECECUnrestrainedForager.
	
	ECECVegetationUnit activePovSelector: #povBiomass.
	ECECForager activePovSelector: #pov
]

{ #category : 'control' }
ECECModel >> step: anObject [
	<control>
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

	<probeNamed: 'Total amount of biomass' color: '00b44c'>
	^ self theVegetationUnits sum: [ :each | each biomass ]
]
