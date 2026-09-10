#!/usr/local/bin/red-view
Red [ 
] 
;--without change at (just mixing two images)
size1: 200x100
size2: 50x50
pos:   75x25

a: make image! reduce [size1 red]
b: make image! reduce [size2 green]
plot: compose [image (a) image (b) (pos)]

view [
	title "Test"
	button "Quit" [quit]
	return
	canvas1: image size1 a return 
	canvas2: image size1 draw plot
]