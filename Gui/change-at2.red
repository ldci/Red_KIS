#!/usr/local/bin/red-view
Red [ 
] 
;-- now change at is supported for images by Red :)

size1: 200x100
size2: 50x50
pos: 75x25

a: make image! reduce [size1 red]
b: make image! reduce [size2 green]
change at a pos b
;--recreate original image
a: make image! reduce [size1 red]
plot: compose [image (a) image (b) (pos)]
view [
	title "Test"
	canvas1: image size1 a return 
	canvas2: image size1 draw plot
]
