#! /usr/local/bin/red-view
Red [
	Title: "Text List"
	Author: "LDCI"
	Version: 1.0
	Notes: {This code allows to use unicode characters in Red text-list object}
	Needs: view
] 

;--initialize  base text objects
init: [
	s: to-char 2587h ;== #"▇"
	r/text: copy rejoin [s " Red"]
	g/text: copy rejoin [s " Green"]
	b/text: copy rejoin [s " Blue"]
]

;--update the color viewer according to selected object
update: func [face [object!]] [
	;f/font/color: 0.0.0 + f/color
	f/font/color: f/color
	f/color: face/font/color  
	f/text: form face/font/color
]

view win: layout [
	title "Color Selection: text-list"
	space 5x5	
	r: button snow 80x24 left middle font-color red   	[update r]
	g: button snow 80x24 left middle font-color green 	[update g]
	b: button snow 80x24 left middle font-color blue	[update b] 	 
	pad 50x0 button  45 "Quit"[quit]
	return
	
	t: text-list 100x120  font-size 11 font-color white data []
	on-create [
		append face/data rejoin [to-char 2764h to-char FE0Fh " Red"]
		append face/data rejoin [to-char 1F49Ah " Green"]
		append face/data rejoin [to-char 1F499h " Blue"]
		append face/data rejoin [to-char 1F49Ch " Magenta"]
		append face/data rejoin [to-char 1F9E1h " Orange" ]
		append face/data rejoin [to-char 1F49Bh " Yellow"]
		append face/data rejoin [to-char 1F5A4h " Black"]
		face/extra: [red green blue magenta orange yellow black]
	]
	on-change [ 
		face/font/color: do face/extra/(face/selected)
		update face				;--update color viewer
		face/font/color: white	;--restore default font color 
	]
	select 1
	f: base 260x120 white black font-size 16 
	do [reduce init  f/color: red f/text: "255.0.0"]
]



