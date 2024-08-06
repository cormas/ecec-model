Class {
	#name : 'ECECUnrestrainedForager',
	#superclass : 'ECECForager',
	#category : 'ECEC-Model',
	#package : 'ECEC-Model'
}

{ #category : 'class initialization' }
ECECUnrestrainedForager class >> initializeParameters [

	super initializeParameters.
	harvestRate := 0.99.
]

{ #category : 'pov' }
ECECUnrestrainedForager >> pov [

	<pov>
	^ Color red
]

{ #category : 'pov' }
ECECUnrestrainedForager >> povEnergy [

	<pov>
	^ self
		  povAttribute: #energy
		  min: 0
		  max: 180
		  color: Color red
]
