#!/usr/local/bin/red-view
Red [
	Title: "makeUnicode"
	Author: "ldci"
	Version: 2.0
	Notes: {This code allows to generate emojis or unicode characters}
	Needs: view
]

makeUnicodeSymbols: function [
"Generates unicode symbols from charcodes"
	s 		[string!]	;--string can be empty 
	b 		[block!]	;--block of hexadecimal or integer values
	return: [string!]	;--result
][
	repeat i length? b [append s to-char b/:i]
]


;*************************** view test ******************************
random/seed now/time/precise
s1: makeUnicodeSymbols "Change Color " 	[23FAh FE0Fh]
s2: makeUnicodeSymbols "Quit " 			[274Eh]

view win: layout [
	title "View Test"
	canvas: base 320x240 red font-size 80 return
	button 150x48 font-size 13 s1	[canvas/color: random white]
	pad 52x0
	button 100x48 font-size 13 s2	[quit]
	do [canvas/text: makeUnicodeSymbols "Hi" [128125] canvas/color: random white]
]




