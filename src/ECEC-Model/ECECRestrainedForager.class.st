Class {
	#name : 'ECECRestrainedForager',
	#superclass : 'ECECForager',
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'class initialization' }
ECECRestrainedForager class >> initializeParameters [

	super initializeParameters.
	harvestRate := 0.5.
]

{ #category : 'as yet unclassified' }
ECECRestrainedForager >> cowPovClass [

	^ CMPurpleCow
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
		color: (self
		  colorAttribute: #energy
		  min: 0
		  max: 180
		  color: Color blue);
		yourself 
]
