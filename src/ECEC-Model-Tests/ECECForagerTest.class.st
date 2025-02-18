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

	ECECForager initializeParameters.
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

	ECECForager harvestRate: 13.	
		
	self assert: ECECForager harvestRate equals: 13.
]

{ #category : 'tests' }
ECECForagerTest >> testInitialEnergy [

	ECECForager initialEnergy: 13.	
		
	self assert: ECECForager initialEnergy equals: 13.
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
