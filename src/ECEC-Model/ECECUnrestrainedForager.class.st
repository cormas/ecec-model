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

{ #category : 'pov' }
ECECUnrestrainedForager >> pov [

	<pov>
	^ super pov
		color: Color red;
		yourself
]

{ #category : 'pov' }
ECECUnrestrainedForager >> povEnergy [

	<pov>
	^ super pov
		color: (self
		  colorAttribute: #energy
		  min: 0
		  max: 180
		  color: Color red);
		yourself
]
