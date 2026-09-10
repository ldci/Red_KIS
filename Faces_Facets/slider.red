#!/usr/local/bin/red-view
Red [needs: view]
;--Status: OK
view [
	title "Slider"
	slider 180x25 data 0% [
		p/data: face/data
		t/text: to-string round/to face/data 0.1
	]
	t: text 50 "0%"
	return
	p: progress 180
]