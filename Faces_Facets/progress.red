#!/usr/local/bin/red-view
Red [needs: view]
;--based on Ivo Balbaert's example
view [
	title "Progress"
	across
	p1: progress 100x20 10% 	;-- horizontal progress bar
	p2: progress 20x100 15% 	;-- vertical progress bar
	
	;-- bar following input:
	below
	text "Give the percentage (like 30%) and ENTER"
	field "30%" [p3/data: face/data]
	p3: progress
	;-- slider showing status in text
	t: text "25%"
	slider 100x24 data 25% [t/text: to-string round face/data]
	return
	;-- slider displayed in a progress bar:
	slider 100x24 data 10% [p4/data: face/data]
	p4: progress 100x20 10%
]