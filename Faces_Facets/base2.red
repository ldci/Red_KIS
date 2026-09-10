#!/usr/local/bin/red-view
Red [
	needs: view
]
;--Status: not OK
;--b/text is not displayed

view [
	title "Hello Red"
	b: base "HELLO!" 256x256 %pluto.jpg ;--[dump-face b]
]