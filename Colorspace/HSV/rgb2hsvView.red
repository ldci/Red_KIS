#!/usr/local/bin/red-view
Red [
	Author:  "ldci"
	Need: View
	File: %rgb2hsv.red
]
do %rgbhsv.red

toHSV: function [] [
	visu2/color: white
	r: to integer! fR/text
	g: to integer! fG/text
	b: to integer! fB/text
	blk: rgbToHsv r g b
	fH/text: form h: round/to blk/1 0.01
	fS/text: form s: round/to blk/2 0.01
	fV/text: form v: round/to blk/3 0.01
	rr: to integer! ((h / 360) * 255)
	gg: to integer! (s * 255)
	bb: to integer! (v * 255)
	color: as-color absolute rr gg bb
	visu1/color: color
	bt2/enabled?: true
]

toRGB: function [] [
	h: to float! fH/text
	s: to float! fS/text
	v: to float! fV/text
	blk: hsvToRgb h s v
	r: blk/1 
	g: blk/2
	b: blk/3	
	color: as-color r g b
	visu2/color: color
]

margins: 5x5
mainWin: layout [
	title "Conversion RGB <> HSV"
	origin margins space margins
	text "R" 33 bold fR: field 50 	[r: to integer! fR/text]
	text "G" 30 bold fG: field 50 	[g: to integer! fG/text]	
	text "B" 30 bold fB: field 50	[b: to integer! fB/text]
	bt1: button "RGB -> HSV" 95 [toHSV]
	return
	text "H" 33 bold fH: field 50	
	text "S" 30 bold fS: field 50	
	text "V" 30 bold fV: field 50	
	bt2: button "HSV -> RGB" 95 [toRGB]
	return 
	text "HSV" 35 bold visu1: base 325x25 white
	return 
	text "RGB" 35 bold visu2: base 325x25 white
	return
	pad 305x0 button "Quit" [Quit]
	do [fR/text: form r: 200 fG/text: form g: 128 fB/text: form b: 16
		bt2/enabled?: false
		fH/enabled?: fS/enabled?: fV/enabled?: false
		h: s: v: 0.0
	]
]
view mainWin






