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

{ #category : 'pov' }
ECECRestrainedForager >> pov [

	<pov>
	^ super pov
		color: Color blue;
		yourself
]

{ #category : 'pov' }
ECECRestrainedForager >> povEnergy [

	<pov>
	^ super pov 
		color: (CMColor
		  colorValue: energy
		  min: 0
		  max: 180
		  color: Color blue);
		yourself 
]
