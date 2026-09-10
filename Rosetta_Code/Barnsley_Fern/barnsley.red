#!/usr/local/bin/red-view
Red [ 
	Needs: view
	Author: "LDCI"
] 

;--https://rosettacode.org/wiki/Barnsley_fern
;--see also https://rosettacode.org/wiki/Barnsley_fern#Red

random/seed now/time/precise
n: 100000
barnsleyFern: function [n [integer!] size [pair!]
][
	img: make image! reduce [size black]
	p: 0x0 x: y: 0.0
	color: random white
	repeat i n [
		xt: yt: 0.0
		r: random 100
		case [
			r <= 1 [xt: 0.0 yt: 0.16 * y]
			r <= 8 [xt: (0.20 * x) - (0.26 * y)  yt: (0.23 * x) + (0.22 * y) + 1.60]
			r <= 15[xt: (-0.15 * x) + (0.28 * y) yt: (0.26 * x) + (0.24 * y) + 0.44]
			r > 15 [xt: (0.85 * x) + (0.04 * y)  yt: (-0.04 * x) + (0.85 * y) + 1.60]
		]
		x: xt y: yt
    	p/x: to-integer round (img/size/x / 2 + (60 * x))					
    	p/y: to-integer img/size/y - round (60 * y)				
		img/:p: color
	]
	img
] 

win: layout [
	title "Barnsley Fern"
	button "Generate" [
		t: dt [b/image: barnsleyFern n 640x640] 
		f2/text: rejoin [form round/to t/3 0.01 " sec"]]
	f1: field [if error? try [n: to-integer face/text] [n: 100000]]
	button "Quit" [quit]
	return
	b: base 640x640
	return
	f2: field 640
	do [f1/text: form n]
]
view win 
