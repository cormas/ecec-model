Class {
	#name : 'ECECRestrainedForager',
	#superclass : 'ECECForager',
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'accessing' }
ECECRestrainedForager class >> harvestRate [
	<parameterFloatDefault: 0.5>
	^ harvestRate
]

{ #category : 'aspects' }
ECECRestrainedForager >> aspectDefault: look [

	<aspect>
	super aspectDefault: look.
	look color: Color blue
]

{ #category : 'aspects' }
ECECRestrainedForager >> aspectEnergy: look [

	<aspect>
	super aspectDefault: look.
	look
		colorShadeOf: Color blue
		forValue: energy
		from: 0
		to: 180
]
