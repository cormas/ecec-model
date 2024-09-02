Class {
	#name : 'BaselineOfECECModel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfECECModel',
	#package : 'BaselineOfECECModel'
}

{ #category : 'baselines' }
BaselineOfECECModel >> baseline: spec [

	<baseline>
	spec for: #common do: [

		"Packages"
		spec
			package: 'ECEC-Model';
			package: 'ECEC-Model-Tests' with: [ spec requires: #( 'ECEC-Model' ) ] ]
]
