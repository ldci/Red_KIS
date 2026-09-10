#!/usr/local/bin/red-view
Red [needs: view]

;--Status: OK
view [
	title "Text-list"
	tl: text-list 150x100 data["Carl Sassenrath" "David Oliva (Oldes)" "Nenad Rakocevic"]
 	[t/text: face/data/(face/selected)] ;--or pick face/data face/selected
	return
	t: field 150
]

