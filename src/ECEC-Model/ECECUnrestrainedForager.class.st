Class {
	#name : 'ECECUnrestrainedForager',
	#superclass : 'ECECForager',
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'accessing' }
ECECUnrestrainedForager class >> harvestRate [
	<parameterFloatDefault: 0.99>
	^ harvestRate
]

{ #category : 'aspects' }
ECECUnrestrainedForager >> aspectDefault: look [

	<aspect>
	super aspectDefault: look.
	look color: Color red
]

{ #category : 'aspects' }
ECECUnrestrainedForager >> aspectEnergy: look [

	<aspect>
	super aspectDefault: look.
	look
		colorShadeOf: Color red
		forValue: energy
		from: 0
		to: 180
]
