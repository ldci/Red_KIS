#!/usr/local/bin/red-view
Red [
	Title:   "Draw tests: rcvDegree2xy "
	Author:  "ldci"
	Needs:	 View
]

radius: 150
center: 200x200
freq: 64
buffer: copy []

;--from RedCV lib
rcvDegree2xy: function [
"Returns XY coordinates from angle and distance between 2 points"
	radius [number!]	; distance
	angle  [number!]	; angle in degree
][
	as-pair radius * cosine angle radius * sine angle 
]

generate: does [
	if angle > 359 [angle: 0]
	f/text: rejoin [form angle]
	_cos: round/to cosine angle 0.0001
	_sin: round/to sin to-float angle 0.0001
	_tan: round/to tangent angle 0.0001
	xy: center + rcvDegree2xy radius + 6 angle	;--xy distance as pair		
	cxy: as-point2D  xy/x - _cos center/y		;--cosine distance
	sxy: as-point2D cxy/x xy/y					;--sine distance

	;--tangent 90 degrees is undefined (#1.NaN)
	;unless  [issue? _tan] []
	;-- thanks to gurzgri
	t1:  xy + rcvdegree2xy radius + 10 angle + 90
	t2:  xy + rcvdegree2xy radius - 300 angle + 90
	
	f1/text: form _cos
	f2/text: form _sin
	f3/text: form _tan
	
	buffer: compose [line-width 2 pen red  
			fill-pen white circle (center) 156
			pen red fill-pen blue circle (center) 3
	] 

	repend buffer [
		'fill-pen ivory 
		'line center xy 'circle xy 6 
		'pen blue 
		;'line center cxy sxy
		'triangle center cxy sxy
		'pen black
		'line t1 t2
	]
	canvas/draw: buffer
	angle: angle + 1 ;% 360
]
view win: layout [
	title "Cosine Sine Animation"
	text "Frequency" 
	fr: field 50 [if error? try [freq: to-integer face/text] [freq: 32]]
	button "Start" [canvas/rate: freq]
	
	button "Stop"  [canvas/rate: none] 
	pad 25x0
	button "Quit"  [Quit]
	return
	text 40 "Angle" f: field 30
	text 30 "Cos" f1: field 50
	text 30 "Sin" f2: field 50
	text 30 "Tan" f3: field 50
	return 
	canvas: base 400x400 ivory 
	on-time [generate]
	do [angle: 0 generate canvas/rate: none fr/text: form freq]
]

