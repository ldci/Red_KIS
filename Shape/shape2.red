#!/usr/local/bin/red-view
Red [needs: view]

myshape: [ 
	move 10x40
	qcurve 30x10 50x40
	curv 70x10 90x40 110x10 130x40 150x10 170x40 
	move 10x40
]
view compose/deep/only [
	title "My shape"
	base 200x80 draw [pen yellow shape (myshape)]
]