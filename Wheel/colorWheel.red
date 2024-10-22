#!/usr/local/bin/red-view
Red [ 
	Needs: view
] 


hsb2Rgb: function [
	hue		[float!]	;--hue [0..1]
	sat 	[float!]	;--saturation [0..1]
	bri		[float!] 	;--brightness [0..1]
	return: [tuple!]
][
	color: make tuple! reduce [255 255 255]
	u: to-integer bri * 255 + 0.5
	if sat = 0.0 [color/1: color/2: color/3: u]
	hf: (hue - round/floor hue) * 6 ;--6 quadrants
	h: to-integer hf
	f: hf - round/floor hf
	p: to-integer (bri * (1 - sat) * 255 + 0.5)
	q: to-integer (bri * (1 - (sat * f)) * 255 + 0.5)
	t: to-integer (bri * (1 - (sat * (1 - f))) * 255 + 0.5)
	switch h [
		0 [color/1: u color/2: t color/3: p]
		1 [color/1: q color/2: u color/3: p]
		2 [color/1: p color/2: u color/3: t]
		3 [color/1: p color/2: q color/3: u]
		4 [color/1: t color/2: p color/3: u]
		5 [color/1: u color/2: p color/3: q]
	]
	color
]


colorWheel: function [
	radius	[integer!]
	return: [image!]
][
	tau: pi * 2.0
	imsize: as-pair radius * 2 radius * 2
	imsize: imsize + 40
	im: make image! imsize
	cy: to-integer imsize/y / 2
	cx: to-integer imsize/x / 2
	y: 0 
	while [y < imsize/y] [
		x: 0
		dy: to-float (y - cy)
		while [x < imsize/x][
			dx: to-float (x - cx)
			distance: sqrt ((dx * dx) + (dy * dy))
			if distance <= radius [
				theta: atan2 dy dx
				hue: theta + pi / tau
				idx: to-integer (y * imsize/x) + x + 1 ;--Red and Rebol are one-based
				im/:idx: hsb2Rgb hue 1.0 1.0
			]
			x: x + 1
		]
		y: y + 1
	]
	im
]

acolor: black

drawCross: 	compose [line-width 1 
			pen (acolor) line 0x10 6x10 
			pen off pen (acolor) line 14x10 20x10
			pen (acolor) line 10x0 10x6 
			pen off pen (acolor) line 10x14 10x20
			line-width 2 box 0x0 20x20]


img: colorWheel 100

win: layout [
	title "Color Wheel"
	pad 195x0 button "Quit" [Quit]
	return
	canvas: base 256x256 img
	return
	f1: field 256
	at canvas/offset + 5x5 p2: base 0.0.0.254 22x22 loose draw drawCross
	on-drag [
		posct: p2/offset - canvas/offset + 11 
		if all [posct/x >= 0 posct/y >= 0 posct/x <= 234 posct/y <= 234][
			clear f1/text
			color: pick img to pair! posct ;--red 0.6.5 point2D --> pair
			acolor: white - color
			drawCross/4: drawCross/11: drawCross/16: drawCross/23: acolor
			f1/text: rejoin ["Coordinates:" form posct " Color:" color]
		]
	]
]

view win



