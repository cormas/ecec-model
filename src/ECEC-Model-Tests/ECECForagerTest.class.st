Class {
	#name : 'ECECForagerTest',
	#superclass : 'TestCase',
	#instVars : [
		'restrainedForager',
		'unrestrainedForager',
		'model'
	],
	#category : 'ECEC-Model-Tests',
	#package : 'ECEC-Model-Tests'
}

{ #category : 'running' }
ECECForagerTest >> setUp [

	super setUp.
	model := ECECModel new.
	
	model 
		createGridNumberOfRows: 3
		numberOfColumns: 3
		neighbourhood: 8
		closed: true.
		
	restrainedForager := model newEntity: ECECRestrainedForager.
	unrestrainedForager := model newEntity: ECECUnrestrainedForager.
	

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
	
	restrainedForager energy: 13.	
	restrainedForager consumeEnergy.
		
	self assert: restrainedForager energy < 13.
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
ECECForagerTest >> testMove [

	|centralCell|
	
	centralCell := model pickCellAt: 2@2.
	restrainedForager moveTo: centralCell.
	restrainedForager move.
	
	self deny: restrainedForager patch equals: centralCell .
	
]

{ #category : 'tests' }
ECECForagerTest >> testMoveWhenNoFreeSpace [

	|centralCell|
	
	centralCell := model pickCellAt: 2@2.
	restrainedForager moveTo: centralCell.
	restrainedForager patch neighbourhood do: [ :cell | 
		(model newEntity: ECECRestrainedForager) moveTo: cell].
	restrainedForager move.
	
	self assert: restrainedForager patch equals: centralCell.
	
]

{ #category : 'tests - reproduction' }
ECECForagerTest >> testNoReproductionWithLowEnergy [

	restrainedForager moveTo: (model pickCellAt: 2@2).
	restrainedForager energy: 13.
	restrainedForager step.
	
	self assert: restrainedForager neighbouringSimilarAgents isEmpty.
	
]

{ #category : 'tests' }
ECECForagerTest >> testPov [
		
	self assert: restrainedForager pov color isColor.
	self assert: unrestrainedForager pov color isColor.
	self deny: restrainedForager pov equals: unrestrainedForager pov.
]

{ #category : 'tests' }
ECECForagerTest >> testPovEnergyClass [

	| pov |
	pov := restrainedForager povEnergy. 
	self assert: pov class equals: CMPointOfView. 
]

{ #category : 'tests - reproduction' }
ECECForagerTest >> testReproduceWhenNoFreeSpace [

	| centralCell initialNumberOfAgents |
	
	centralCell := model pickCellAt: 2@2.
	restrainedForager moveTo: centralCell.
	restrainedForager patch neighbourhood do: [ :cell | 
		(model newEntity: ECECRestrainedForager  ) moveTo: cell].
	
	initialNumberOfAgents := model agents size. 
	restrainedForager energy: 113.
	restrainedForager reproduce.
	
	self
		assert: model agents size
		equals: initialNumberOfAgents - 1.
	
]

{ #category : 'tests - reproduction' }
ECECForagerTest >> testReproductionWithHighEnergy [

	restrainedForager moveTo: (model pickCellAt: 2@2).
	restrainedForager energy: 113.
	restrainedForager step.
	
	self assert: restrainedForager neighbouringSimilarAgents isNotEmpty.
	
]

{ #category : 'tests' }
ECECForagerTest >> testStepWhenEnergyIsLessThenZero [

	| firstCell initialNumberOfAgents |
	
	firstCell := model pickCellAt: 1@1.
	restrainedForager moveTo: firstCell.
	initialNumberOfAgents := model agents size.
	restrainedForager energy: -13.
	restrainedForager step.
	
	self assert: model agents size equals: initialNumberOfAgents - 1.
	
]
