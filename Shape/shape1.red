#!/usr/local/bin/red-view
Red [needs: view]
myshape: [
	move 10x10 ; puts pen at 10x10
	'hline 30 ;horizontal line to coordinate X =30
	'vline 30 ;vertical line to coordinate Y = 30
	'hline 30 ;horizontal line 30 pixels long (longer than hline above)
	'vline 30 ;vertical line 30 pixels long
	'hline -50 ; just to show the use of RELATIVE negative lenghts
	; shape dialect will close the shape now
]
view compose/deep/only [
	title "My shape"
	bb: base draw [shape (myshape)]
	button "Save" [img: to-image bb save %test.png img]
]