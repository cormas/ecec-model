Class {
	#name : #ECECVegetationUnit,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'biomass'
	],
	#category : #'ECEC-Model'
}

{ #category : #accessing }
ECECVegetationUnit class >> entityName [

	^ 'VegetationUnit'
]

{ #category : #accessing }
ECECVegetationUnit class >> k [

	^ 10 
]

{ #category : #accessing }
ECECVegetationUnit class >> r [

	^ 0.2 
]

{ #category : #converting }
ECECVegetationUnit >> asString [
	" Private - See superimplementor's comment "

 	^ String streamContents: [ : stream | 
 		  stream
 			  << super asString;
 				crtab; tab;
 			 	<< 'biomass: ';
 				<< (biomass truncateTo: 0.005) asString ]
]

{ #category : #accessing }
ECECVegetationUnit >> biomass [

	^ biomass
]

{ #category : #accessing }
ECECVegetationUnit >> biomass: anObject [

	biomass := anObject
]

{ #category : #initialization }
ECECVegetationUnit >> initialize [ 

	super initialize.
	biomass := 0.
]

{ #category : #initialization }
ECECVegetationUnit >> initializeWithRandomBiomass [

	self biomass: Cormas random
]

{ #category : #printing }
ECECVegetationUnit >> interestingDetails [
	"Answer a <Collection> of interesting receiver's attributes, from a modeler point of view, to display in a popup for example"

	^ super interestingDetails , { 
		'Biomass' -> ((biomass truncateTo: 0.005) asString)
		}
]

{ #category : #growth }
ECECVegetationUnit >> logisticGrowth [

	self biomass: (Cormas logisticGrowth: self biomass r: self class r K: self class k)
]

{ #category : #pov }
ECECVegetationUnit >> povBiomass [

	^ self
		povAttribute: #biomass
		min: 0
		max: self class k
		color: Color green
]

{ #category : #pov }
ECECVegetationUnit >> povBiomassForager [
	
	^ self biomass < ECECForager catabolicRate
		ifTrue: [ Color white ]
		ifFalse: [ self povBiomass ]
]

{ #category : #pov }
ECECVegetationUnit >> povForagersVision [

	(self hasOccupantsOfClass: ECECForager)
		ifTrue: [ ^ self povBiomassForager ].
	
	(self neighbourhood anySatisfy: [ :each | each hasOccupantsOfClass: ECECForager ])
		ifTrue: [ ^ self povBiomassForager ].
	
	^ Color black
]

{ #category : #stepping }
ECECVegetationUnit >> step [
	
	self logisticGrowth
]
