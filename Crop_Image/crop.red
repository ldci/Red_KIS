#!/usr/local/bin/red-view
Red [
	Title:   "Crop Image"
	Author:  @ldci
	File: 	 %crop.red
	Needs:	 View
]

margins: 5x5				;--for main window spacing
roiW: 128					;--default ROI width size
roiH: 128					;--default ROI height size
acolor: black				;--default color for loose
irSize: 320x240			 	;--default image size
clipOffset: 0x0
clipSize: irSize / 4 ;80x60; 128x128
isFile?: false

loadImage:  does [
	isFile?: false
	canvas2/image: none
	tmpFile: request-file/filter ["Image Files" "*.png;*.jpg;*.jpeg;*.bmp"]
	unless none? tmpFile [
		canvas1/image: load tmpFile
		isFile?: true
	]
]

updateClip: does [
	;f1/text: form round/to rect/offset 0.01 ;--point2D!
	f1/text: form round rect/offset ;--point2D!
	f2/text: form round rect/size ;--point2D!
	roiW: to-integer rect/size/x
	roiH: to-integer rect/size/Y
	x: rect/offset/x - canvas1/offset/x
	y: rect/offset/y - canvas1/offset/y
	clipOffset: as-pair x y 
	clipSize: as-pair roiW roiH
	canvas2/size: rect/size
]

cropImage: func [] [
	if isFile? [ 
		updateClip
		;crop: copy/part skip canvas1/image clipOffset clipSize
		canvas2/image: copy/part at canvas1/image clipOffset clipSize
	]
]

mainWin: layout [
	size 670x300
	title "Crop Image"
	origin margins space margins
	button "Load Image"	[loadImage]
	text "ROI Offset" middle f1: field center
	text "ROI Size"   middle f2: field center
	drop-down 70 data ["Black" "Red" "Green" "Blue" "Yellow" "White"]
		select 1
		on-change [
			aColor: reduce to-word pick face/data any [face/selected 1]
			r: aColor/1	g: aColor/2 b: aColor/3 a: 128
			tColor: to-tuple reduce [r g b a] 
			rect/color: c/color: tColor
		]
	button "Crop" [cropImage]
	button "Quit" [quit]
	return
	canvas1: base irSize
	canvas2: base irSize;128x128
	at canvas1/offset  
	rect: base clipSize 0.0.0.200 loose  on-drag [
		if within? rect/offset canvas1/offset canvas1/size [updateClip]
		c/offset: rect/offset + rect/size 
	]
	at rect/offset + rect/size
	c: base 10x10 acolor loose on-drag [
		rect/size: c/offset - rect/offset 
		updateClip
	]
	do [f1/text: form clipOffset f2/text: form clipSize]
]
view mainWin