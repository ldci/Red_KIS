#!/usr/local/bin/red-view
Red[
	Needs: 'View
]
;#!/usr/local/bin/red-view
;'with pad 
names: ["Carl Sassenrath" "David Oliva (Oldes)" "Nenad Rakocevic" "Chris Lattner"]
languages: ["Rebol 2" "Rebol 3 ""Red" "Swift"]
win: layout compose [
	title "Picker"
	backdrop red
	below
	text "Languages" 300x25 center font-size 14
	pad 100x0 drop-list 100x25 data languages select 1 
	on-change[name/text: names/(face/selected)]
	pad -100x0 name: H2 (names/1) 300 center
	pad 120x4
	button "Quit" [Quit]
]
view win

;--use -t Darwin-ARM64 or -t macOS-ARM64