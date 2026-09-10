#!/usr/local/bin/red-view
Red [
]
;--replace mandrill image with your image 

view [
	title "Drag and resize with loose facets"
	size 512x512
	f: field 400 center
	button "Quit" [quit]
	at 10x40 
	b: base 128x128 %mandrill.jpg loose on-drag [
		c/offset: b/offset + b/size 
		f/text: rejoin ["Offset " b/offset " Size " to point2D! b/size]
	] 
	at (b/offset + b/size) 
	c: base 6x6 red loose on-drag [
		b/size: (c/offset - b/offset) 
		f/text: rejoin ["Offset" b/offset " Size " to point2D! b/size]
	]
	do [f/text: rejoin ["Offset" to point2D! b/offset " Size " to point2D! b/size]]
]