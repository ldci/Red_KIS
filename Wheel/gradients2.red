#!/usr/local/bin/red-view
Red [
	needs: view
]

win: layout [
	title "Gradients Red"
	text 200 "Linear"
	text 200 "Radial"
	text 125 "Diamond"
	button "Quit" [Quit]
	return
	
	base 200x200 draw [
		pen off 
		fill-pen linear 0x0 0 200 white red yellow green blue gray box 0x0 200x200] 
	
	base 200x200 draw [
		pen off 
		fill-pen radial 100x100 0 100 white red yellow green blue gray circle 100x100 90] 
	;--a problem for diamond (macOS and Windows)
	base 200x200 draw [
		pen off 
		fill-pen diamond 100x100 0 100 0 white red yellow green blue gray
		box 0x0 200x200
	]
]

view win
