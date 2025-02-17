"
I represent a collection of tests for cluster layout.
"
Class {
	#name : #GraphClusterLayoutTest,
	#superclass : #GAbstractTreeLayoutTest,
	#category : #'GraphLayout-Tests'
}

{ #category : #accessing }
GraphClusterLayoutTest >> actualClass [
	^ GraphClusterLayout 
]

{ #category : #tests }
GraphClusterLayoutTest >> testComputePosition [
	"Testing the computation of position of a given node.For easier testing, we transfer the set of vertices 	to LinkedList, so we can have ordered collection. Have in mind that position stors center of 	vertex.
	For v5, expected result 45 .
	For v4, expected result 25 .
	For v3, expected result 15 .
	For v2, expected result 25
	For v1, expected result 5."

	| gr v1 v2 v3 v4 v5 layout used root |
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	v5 := gr addVertexWithValue: 5.
	gr
		addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := LinkedList new.
	used
		add: v1;
		add: v2;
		add: v3;
		add: v4;
		add: v5.
	layout := GraphClusterLayout new.
	root := layout rootNodesFor: gr vertices.
	root do: [ :e | layout initializeNode: e ].
	root do: [ :e | layout computePosition: e ].
	self assert: ((layout xOf: v5) roundDownTo: 0.01) equals: 45.
	self assert: ((layout xOf: v4) roundDownTo: 0.01) equals: 25.
	self assert: ((layout xOf: v3) roundDownTo: 0.01) equals: 15.
	self assert: ((layout xOf: v2) roundDownTo: 0.01) equals: 25.
	self assert: ((layout xOf: v1) roundDownTo: 0.01) equals: 5.
]

{ #category : #tests }
GraphClusterLayoutTest >> testDoExecute [
	"A test that checks execution of cluster layout. For easier testing, we transfer the set of vertices 	to LinkedList, so we can have ordered collection. Have in mind that position stors center of 	vertex.
	For v5, expected result -26.92@91.65.
	For v4, expected result -39.92@ -32.29.
	For v3, expected result 8.61@-22.29 .
	For v2, expected result -62.370000000000005@ -52.19.
	For v1, expected result 84.69@ -34.33 ."

	| gr v1 v2 v3 v4 v5 layout used |
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	v5 := gr addVertexWithValue: 5.
	gr
		addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := LinkedList new.
	used
		add: v1;
		add: v2;
		add: v3;
		add: v4;
		add: v5.
	layout := GraphClusterLayout new.
	layout on: used.
	self assert: (v5 position roundDownTo: 0.01) equals: -26.92@91.65.
	self assert: (v4 position roundDownTo: 0.01) equals: -39.92@ -32.29.
	self assert: (v3 position roundDownTo: 0.01) equals: 8.61@ -22.29 .
	self assert: (v2 position roundDownTo: 0.01) equals: -62.370000000000005@ -52.19.
	self assert: (v1 position roundDownTo: 0.01) equals: 84.69@ -34.33 .
]

{ #category : #tests }
GraphClusterLayoutTest >> testInitialize [
	| layout |
	layout := GraphClusterLayout new.
	self assert: (layout verticalGap = 30 and: layout horizontalGap = 20)
]

{ #category : #tests }
GraphClusterLayoutTest >> testInitializeNode [
	| gr v1 v2 v3 v4 v5 layout |
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	v5 := gr addVertexWithValue: 5.
	gr
		addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	layout := GraphClusterLayout new.
	layout initializeNode: v3.
	self assert: (layout layerOf: v3) notNil
]
