Class {
	#name : 'ECECVegetationUnit',
	#superclass : 'CMCell',
	#traits : 'TCMMath',
	#classTraits : 'TCMMath classTrait',
	#instVars : [
		'biomass'
	],
	#classInstVars : [
		'k',
		'r'
	],
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'parameters' }
ECECVegetationUnit class >> k [
	<parameterIntegerDefault: 10>
	^ k
]

{ #category : 'parameters' }
ECECVegetationUnit class >> k: aNumber [
	<parameterSetter>
	k := aNumber
]

{ #category : 'parameters' }
ECECVegetationUnit class >> r [
	<parameterFloatDefault: 0.2>
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

{ #category : 'initialization' }
ECECVegetationUnit >> initialize [ 

	super initialize.
	biomass := 0
]

{ #category : 'initialization' }
ECECVegetationUnit >> initializeWithRandomBiomass [

	self biomass: self random
]

{ #category : 'pov' }
ECECVegetationUnit >> povBiomass [

	<pov>
	^ CMPointOfView color: (CMColor
		colorValue: biomass
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

{ #category : 'stepping' }
ECECVegetationUnit >> step [
	
	self growBiomass
]
