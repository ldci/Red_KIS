#!/usr/local/bin/red-view
Red [
]
;--replace mandrill image with your image 
view [
	title "Drag and resize with loose facet"
	size 512x512
	button "Quit" [quit]
	at 10x40 
	b: base 128x128 %mandrill.jpg loose on-drag [c/offset: b/offset + b/size] 
	at (b/offset + b/size) 
	c: base 6x6 red loose on-drag [b/size: (c/offset - b/offset)]
]