#!/usr/local/bin/red-view
Red [needs: view]

;--Status: OK
view [
	title "Drop-down"
    t: text "-->"
    drop-down "Choose one" data ["First" "Second" "Third"] 
    [t/text: pick face/data face/selected ];--does work
    ;on-change [t/text: pick face/data face/selected];--alternative solution
]       

