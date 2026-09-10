#!/usr/local/bin/red-view
Red [
	needs view
]
;--Status: OK
view [
	title "Check"
	c: check 100 "No" [either c/data [c/text: "Yes"][c/text: "No"]]
]