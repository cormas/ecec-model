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

{ #category : 'aspects' }
ECECVegetationUnit >> aspectBiomass: look [
	<aspect>
	look colorShadeOf: Color green forValue: biomass from: 0 to: self class k
]

{ #category : 'aspects' }
ECECVegetationUnit >> aspectBiomassForager: look [

	<aspect>
	self biomass < ECECForager catabolicRate
		ifTrue: [ look color: Color white ]
		ifFalse: [ self aspectBiomass: look ]
]

{ #category : 'aspects' }
ECECVegetationUnit >> aspectDefault: look [

	<aspect>
	self aspectBiomass: look
]

{ #category : 'aspects' }
ECECVegetationUnit >> aspectForagersVision: look [

	<aspect>
	((self hasOccupantsOfClass: ECECForager) or: [
			 self neighbourhood anySatisfy: [ :each |
				 each hasOccupantsOfClass: ECECForager ] ])
		ifTrue: [ self aspectBiomassForager: look ]
		ifFalse: [ look color: Color black ]
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

{ #category : 'printing' }
ECECVegetationUnit >> interestingDetails [
	"Answer a <Collection> of interesting receiver's attributes, from a modeler point of view, to display in a popup for example"

	^ super interestingDetails , { 
		'Biomass' -> ((biomass truncateTo: 0.005) asString)
		}
]

{ #category : 'stepping' }
ECECVegetationUnit >> step [
	
	self growBiomass
]
