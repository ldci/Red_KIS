#!/usr/local/bin/red-view
Red [ 
] 
;-- now change at is supported for images by Red :)

change-at: function [
	img1	[image!]	;--first image
	pos		[pair!]		;--offseting position
	img2 	[image!]	;--second image
][
	nRows: 	img2/size/x 
	nLines: img2/size/y
	if any [pos/x = 0 pos/y = 0] [pos: 1x1]		;--Red is 1-based 
	;--image 2 must be contained in image 1: we ignore extra pixels
	if (pos/x + img2/size/x) > img1/size/x [nRows:  img1/size/x - pos/x + 1]
	if (pos/y + img2/size/y) > img1/size/y [nLines: img1/size/y - pos/y + 1]
	
	line: 1
	offset: (pos/y - 1 * img1/size/x) + pos/x
	until [
		row: 1
		while [row <= nRows][
			img1/:offset: img2/:row
			row: row + 1
			offset: offset + 1
		]
		offset: pos/y - 1 + line 
		offset: offset * img1/size/x + pos/x
		line: line + 1
		any [line = (nLines + 1) offset > (img1/size/x * img1/size/y)]
	]
]

size1: 200x100
size2: 50x50
pos: 75x25

a: make image! reduce [size1 red]
b: make image! reduce [size2 green]
change-at a pos b
;--recreate original image
a: make image! reduce [size1 red]
plot: compose [image (a) image (b) (pos)]
view [
	title "Test"
	canvas1: image size1 a return 
	canvas2: image size1 draw plot
]
