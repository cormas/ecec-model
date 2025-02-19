Class {
	#name : 'ECECVegetationUnitTest',
	#superclass : 'TestCase',
	#instVars : [
		'vegetationUnit'
	],
	#category : 'ECEC-Model-Tests',
	#package : 'ECEC-Model-Tests'
}

{ #category : 'running' }
ECECVegetationUnitTest >> setUp [
	super setUp.

	vegetationUnit := ECECVegetationUnit new.
	vegetationUnit randomNumberGenerator: (Random seed: 13).
]

{ #category : 'running' }
ECECVegetationUnitTest >> tearDown [ 

	ECECVegetationUnit initializeParameters.
	super tearDown. 
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testAsString [
	
	| expectedString |
	vegetationUnit id: 13.
	expectedString := 'an ECECVegetationUnit -id: 13 -n: 0 -o: 0
	id: 13
	coordinates: nil
		biomass: 0.0'.
	
	self assert: vegetationUnit asString equals: expectedString.
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testBiomass [

	vegetationUnit biomass: 13.
	
	self assert: vegetationUnit biomass equals: 13.
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testGrowBiomass [
	| oldBiomass newBiomass |
	
	vegetationUnit biomass: 1.
	
	oldBiomass := vegetationUnit biomass.
	vegetationUnit growBiomass.
	newBiomass := vegetationUnit biomass.
	
	self assert: newBiomass > oldBiomass
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testInitialBiomassIsZero [

	
	self assert: vegetationUnit biomass equals: 0.
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testInitializeParameters [
	
	self assert: ECECVegetationUnit k equals: 10.
	self assert: ECECVegetationUnit r equals: 0.2.
	
	
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testInitializeWithRandomBiomass [

	vegetationUnit initializeWithRandomBiomass.

	self assert: vegetationUnit biomass closeTo: 0.11401195.

	
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testK [

	ECECVegetationUnit k: 13.	
		
	self assert: ECECVegetationUnit k equals: 13.

	
	
]

{ #category : 'tests' }
ECECVegetationUnitTest >> testR [

	ECECVegetationUnit r: 13.	
		
	self assert: ECECVegetationUnit r equals: 13.

	
	
]
