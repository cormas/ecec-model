Class {
	#name : 'ECECVegetationUnit',
	#superclass : 'CMCell',
	#traits : 'TCMMath',
	#classTraits : 'TCMMath classTrait',
	#instVars : [
		'biomass',
		'counter'
	],
	#classInstVars : [
		'k',
		'r'
	],
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'class initialization' }
ECECVegetationUnit class >> initializeParameters [

	super initializeParameters.
	k := 10.
	r := 0.2.
]

{ #category : 'parameters' }
ECECVegetationUnit class >> k [
	<parameterGetter>
	^ k
]

{ #category : 'parameters' }
ECECVegetationUnit class >> k: aNumber [
	<parameterSetter>
	k := aNumber
]

{ #category : 'parameters' }
ECECVegetationUnit class >> r [
	<parameterGetter>
	^ r
]

{ #category : 'parameters' }
ECECVegetationUnit class >> r: aNumber [
	<parameterSetter>
	r := aNumber
]

{ #category : 'converting' }
ECECVegetationUnit >> asString [
	" Private - See superimplementor's comment "

 	^ String streamContents: [ : stream | 
 		  stream
 			  << super asString;
 				crtab; tab;
 			 	<< 'biomass: ';
 				<< (biomass truncateTo: 0.005) asString ]
]

{ #category : 'accessing' }
ECECVegetationUnit >> biomass [

	^ biomass
]

{ #category : 'accessing' }
ECECVegetationUnit >> biomass: anObject [

	biomass := anObject
]

{ #category : 'growth' }
ECECVegetationUnit >> growBiomass [
	<action>
	self biomass: (self logisticGrowth: self biomass r: self class r k: self class k)
]

{ #category : 'as yet unclassified' }
ECECVegetationUnit >> hello [
^ 'world'
]

{ #category : 'initialization' }
ECECVegetationUnit >> initialize [ 

	super initialize.
	biomass := 0.
	counter := 0.
]

{ #category : 'initialization' }
ECECVegetationUnit >> initializeWithRandomBiomass [

	self biomass: self random
]

{ #category : 'printing' }
ECECVegetationUnit >> interestingDetails [
	"Answer a <Collection> of interesting receiver's attributes, from a modeler point of view, to display in a popup for example"

	^ super interestingDetails , { 
		'Biomass' -> ((biomass truncateTo: 0.005) asString)
		}
]

{ #category : 'pov' }
ECECVegetationUnit >> povBiomass [

	<pov>
	^ CMPointOfView color: (self
		colorAttribute: #biomass
		min: 0
		max: self class k
		color: Color green)
]

{ #category : 'pov' }
ECECVegetationUnit >> povBiomassForager [
	
	<pov>
	^ self biomass < ECECForager catabolicRate
		ifTrue: [ CMPointOfView color: Color white ]
		ifFalse: [ self povBiomass ]
]

{ #category : 'pov' }
ECECVegetationUnit >> povForagersVision [

	<pov>
	(self hasOccupantsOfClass: ECECForager)
		ifTrue: [ ^ self povBiomassForager ].
	
	(self neighbourhood anySatisfy: [ :each | each hasOccupantsOfClass: ECECForager ])
		ifTrue: [ ^ self povBiomassForager ].
	
	^ CMPointOfView color: Color black
]

{ #category : 'pov' }
ECECVegetationUnit >> povImage [

	<pov>
	| frames image minBiomass maxBiomass stages stageIndex rand grass |
	
	minBiomass := 0.
	maxBiomass := self class k.
	
	image := biomass > 0
		ifTrue: [ 
			rand := Random seed: id.
			stages := { CMFarmingPlants corn . CMFarmingPlants carrot } atRandom: rand.
			stageIndex := maxBiomass min: 
				(((stages size * (biomass - minBiomass)) / (maxBiomass - minBiomass)) floor + 1).
			
			grass := CMGrass grassFor: self condition: [ :cell | cell biomass > 0 ].
			grass := grass scaledToSize: 28@28.
			
			grass + (stages at: stageIndex) ]
		ifFalse: [
			frames := CMWater flowing.
			frames at: ((id + counter - 1) \\ frames size) + 1 ].
		
	^ CMPointOfView image: image
]

{ #category : 'stepping' }
ECECVegetationUnit >> step [
	
	counter := counter + 1.
	self growBiomass
]
