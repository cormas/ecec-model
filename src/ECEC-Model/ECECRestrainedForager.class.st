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

{ #category : 'pov' }
ECECRestrainedForager >> pov [

	<pov>
	^ Color blue
]

{ #category : 'pov' }
ECECRestrainedForager >> povEnergy [

	<pov>
	^ self
		  povAttribute: #energy
		  min: 0
		  max: 180
		  color: Color blue
]
