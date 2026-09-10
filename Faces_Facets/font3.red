#!/usr/local/bin/red-view
Red [
	needs view
]
;--Status: OK
darkMode: yes
either darkMode [fcolor: white] [fcolor: black]
view [
	title "Hello"
	below
	h1 "Hello" font-color fcolor
	h2 "Hello" font-color fcolor
	h3 "Hello" font-color fcolor
	h4 "Hello" font-color fcolor
	h5 "Hello" font-color fcolor
]
