Class {
	#name : 'ECECForager',
	#superclass : 'CMAgent',
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'energy',
		'counter'
	],
	#classInstVars : [
		'catabolicRate',
		'fertilityThreshold',
		'harvestRate',
		'initialEnergy'
	],
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'accessing' }
ECECForager class >> catabolicRate [

	^ catabolicRate
]

{ #category : 'accessing' }
ECECForager class >> catabolicRate: aNumber [

	catabolicRate := aNumber
]

{ #category : 'accessing' }
ECECForager class >> fertilityThreshold [

	^ fertilityThreshold
]

{ #category : 'accessing' }
ECECForager class >> fertilityThreshold: aNumber [

	fertilityThreshold := aNumber
]

{ #category : 'accessing' }
ECECForager class >> harvestRate [

	^ harvestRate
]

{ #category : 'accessing' }
ECECForager class >> harvestRate: aNumber [

	harvestRate := aNumber
]

{ #category : 'accessing' }
ECECForager class >> initialEnergy [

	^ initialEnergy
]

{ #category : 'accessing' }
ECECForager class >> initialEnergy: aNumber [

	initialEnergy := aNumber
]

{ #category : 'initialization' }
ECECForager class >> initializeParameters [

	super initializeParameters.
	fertilityThreshold := 100.
	catabolicRate := 2.
	initialEnergy := 50.
	harvestRate := nil.
]

{ #category : 'biology' }
ECECForager >> consumeEnergy [

	self energy: self energy - self class catabolicRate
]

{ #category : 'as yet unclassified' }
ECECForager >> cowPovClass [

	self subclassResponsibility
]

{ #category : 'biology' }
ECECForager >> eat [
	"The forager eats a quatity of biomass of its current location. The quantity depends on the harvestRate: a proportion of biomass (50% or 99% according to forager type)"
	
	| quantity |
	patch ifNil: [ ^ nil ].
	
	quantity := self patch biomass * self class harvestRate.
	
	self energy: self energy + quantity.
	self patch biomass: self patch biomass - quantity
]

{ #category : 'accessing' }
ECECForager >> energy [

	^ energy
]

{ #category : 'accessing' }
ECECForager >> energy: anObject [

	energy := anObject
]

{ #category : 'initialization' }
ECECForager >> initialize [

	super initialize.
	energy := self class initialEnergy.
	counter := 1
]

{ #category : 'printing' }
ECECForager >> interestingDetails [
	"Answer a Collection>of interesting receiver's attributes, from a modeler point of view, to display in a popup for example "

	^ super interestingDetails , { 
		'Energy: ' -> (self energy asString)
		}
]

{ #category : 'biology' }
ECECForager >> move [
	"The Forager examines its current location and around. From thw patches that are not occupied, it chooses the one containing the most biomass. If the chosen patch has enough biomass to meet the catabolic rate, the Forager moves there. If not, it moves instead to a randomly chosen adjacent free place (not occupied by another Forager)"	

	| candidatePatches maxBiomass targetPatch |
	patch ifNil: [ ^ self ].
	
	candidatePatches := self patch neighbourhoodAndSelf select: [ :each |
		each biomass > self class catabolicRate and: [ each hasNoOccupants ] ].
	
	candidatePatches ifEmpty: [
		self randomWalkConstrainedBy: [ :c | c hasNoOccupants ].
		^ self ].
	
	maxBiomass := (candidatePatches collect: [ :each | each biomass ]) max.
	targetPatch := candidatePatches detect: [ :each | each biomass = maxBiomass ].
	
	self moveTo: targetPatch.
]

{ #category : 'pov' }
ECECForager >> pov [

	<pov>
	^ CMPointOfView size: self sizeOfPOV
]

{ #category : 'pov' }
ECECForager >> povImage [

	<pov>
	| frames image |
	
	image := self patch biomass > 0
		ifTrue: [
			frames := self cowPovClass walking.
			frames at: ((counter - 1) \\ frames size) + 1 ]
		ifFalse: [ 
			| boat cow |
			boat := CMBoat swimming first.
			boat := boat flipBy: #horizontal centerAt: boat center.
			boat := (Form extent: boat extent max asPoint depth: boat depth) + boat.
			boat := boat movedDownBy: 5.

			cow := self cowPovClass lying first movedUpBy: 5.
			boat + cow ].
	
	^ CMPointOfView
		image: image
		size: 32
]

{ #category : 'biology' }
ECECForager >> reproduce [
	"The forager reproduces asexually, creating an offspring with the same heritable traits as itself (e.g., feeding strategy). At the same time the parent's energy is reduced by the offspring's initial energy (50).  Newborn offspring occupies the nearest free place to its parent. "
	
	| newForager freePatch |
	patch ifNil: [ ^ self ].
	
	freePatch := self nearestEmptyLocationWithinRadius: 1.
	freePatch ifNil: [ ^ self ].
	
	newForager := self cormasModel newEntity: self class.
	self energy: self energy - newForager energy.
	
	newForager moveTo: freePatch
]

{ #category : 'povSize' }
ECECForager >> sizeOfPOV [

	^ 2 + (self energy / self class fertilityThreshold * 10)
]

{ #category : 'stepping' }
ECECForager >> step [

	counter := counter + 1.

	self
		consumeEnergy;
		move;
		eat.
		
	self energy >= self class fertilityThreshold
		ifTrue: [ self reproduce ].
		
	self energy <= 0
		ifTrue: [ self die ]
]
