#!/usr/local/bin/red-view
Red [needs: view]
;--Status: Not OK for aligment
view [
	title "Fonts"
	button "hello"
	button "bold" bold
	button "underline" underline
	button "strike" strike
	return
	button "top" 70x70 top
	button "middle" 70x70 middle ;vertical
	button "bottom" 70x70 bottom
	return
	button "left" 70x70 left
	button "center" 70x70 center ;horizontal
	button "right" 70x70 right
	return
	button "top left" 70x70 top left
	button "top center" 70x70 top center
	button "top right" 70x70 top right
]
