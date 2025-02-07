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

{ #category : 'initialization' }
ECECForagerTest >> setUp [

	super setUp.
	restrainedForager := ECECRestrainedForager new.
	unrestrainedForager := ECECUnrestrainedForager new.
]

{ #category : 'tests' }
ECECForagerTest >> testPov [

	self assert: restrainedForager pov color isColor.
	self assert: unrestrainedForager pov color isColor.
	self deny: restrainedForager pov equals: unrestrainedForager pov.
]
