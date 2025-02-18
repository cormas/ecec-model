Class {
	#name : 'ECECForagerTest',
	#superclass : 'TestCase',
	#instVars : [
		'restrainedForager',
		'unrestrainedForager'
	],
	#category : 'ECEC-Model-Tests',
	#package : 'ECEC-Model-Tests'
}

{ #category : 'running' }
ECECForagerTest >> setUp [

	super setUp.
	restrainedForager := ECECRestrainedForager new.
	unrestrainedForager := ECECUnrestrainedForager new.
	
]

{ #category : 'running' }
ECECForagerTest >> tearDown [ 

	ECECUnrestrainedForager initializeParameters.
	ECECRestrainedForager initializeParameters.
	super tearDown.
]

{ #category : 'tests' }
ECECForagerTest >> testCatabolicRate [

	ECECForager catabolicRate: 13.

	self assert: ECECForager catabolicRate equals: 13
]

{ #category : 'tests' }
ECECForagerTest >> testConsumeEnergy [
	
	| newEnergy |
	restrainedForager energy: 13.	
	restrainedForager consumeEnergy.
	newEnergy := restrainedForager energy.
		
	self assert: newEnergy < 13.
]

{ #category : 'tests' }
ECECForagerTest >> testEnergy [

	restrainedForager energy: 13.	
		
	self assert: restrainedForager energy equals: 13.
]

{ #category : 'tests' }
ECECForagerTest >> testFertilityThreshold [

	ECECForager fertilityThreshold: 13.	
		
	self assert: ECECForager fertilityThreshold equals: 13.
]

{ #category : 'tests' }
ECECForagerTest >> testHarvestRate [

	ECECUnrestrainedForager harvestRate: 13.	
		
	self assert: ECECUnrestrainedForager harvestRate equals: 13.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialCatabolicRate [

	self assert: ECECForager catabolicRate equals: 2.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialEnergy [	
		
	self assert: ECECForager initialEnergy equals: 50.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialEnergySet [

	ECECForager initialEnergy: 13.	
		
	self assert: ECECForager initialEnergy equals: 13.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialFertilityThreshold [

	self assert: ECECRestrainedForager fertilityThreshold equals: 100.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialHarvestRateRestrained [
		
	self assert: ECECRestrainedForager harvestRate equals: 0.5.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialHarvestRateUnrestrained [
		
	self assert: ECECUnrestrainedForager harvestRate equals: 0.99.
]

{ #category : 'tests' }
ECECForagerTest >> testPov [
		
	self assert: restrainedForager pov color isColor.
	self assert: unrestrainedForager pov color isColor.
	self deny: restrainedForager pov equals: unrestrainedForager pov.
]

{ #category : 'tests' }
ECECForagerTest >> testPovCowClassRestrained [

	self assert: restrainedForager cowPovClass equals: CMPurpleCow.
]

{ #category : 'tests' }
ECECForagerTest >> testPovCowClassUnrestrained [

	self assert: unrestrainedForager cowPovClass equals: CMBrownCow.
]

{ #category : 'tests' }
ECECForagerTest >> testPovEnergyClass [

	| pov |
	pov := restrainedForager povEnergy. 
	self assert: pov class equals: CMPointOfView. 
]
