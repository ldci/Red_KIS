#!/usr/local/bin/red-view
Red [
	needs view
]
;--Status: Not OK
;--f/text not updated
view [
	title "Radio"
	r1: radio "on"  [f/text: face/text]
	r2: radio "off" [f/text: face/text]
	return
	f: field 170 "????"  
]
