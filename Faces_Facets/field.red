#!/usr/local/bin/red-view
Red [needs: view]
;--Status: OK 
;--on-key-dow event can also be used

view [
	title "Field"
	text "Enter a value"
	f: field "123" [r/text: to-string face/data] 	;--works now 
	;on-key-down [r/text: to-string face/data] 		;--works as alternative
	return 
	r: text 180 black center
]