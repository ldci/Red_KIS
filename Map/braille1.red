#!/usr/local/bin/red-view
Red [
	Title: "braille1"
	Author: "ldci"
	Version: 1.0
	Notes: {Plays map}
]
;-- French Braille's cell is a 2x3 matrix with 6 points
comment [1 4 2 5 3 6]

active:   to-char 1F534h
inactive: to-char 26ABh
str: "Hello Red World! ~ 1 2"

bCodes: make map! [
	#"a" [1 0 0 0 0 0]
	#"b" [1 0 1 0 0 0]
	#"c" [1 1 0 0 0 0]
	#"d" [1 1 0 1 0 0]
	#"e" [1 0 0 1 0 0]
	#"f" [1 1 1 0 0 0]
	#"g" [1 1 1 1 0 0]
	#"h" [1 0 1 1 0 0]
	#"i" [0 1 1 0 0 0]
	#"j" [1 0 1 1 0 0]
	#"k" [1 0 0 0 1 0]
	#"l" [1 0 1 0 1 0]
	#"m" [1 1 0 0 1 0]
	#"n" [1 1 0 1 1 0]
	#"o" [1 0 0 1 1 0]
	#"p" [1 1 1 0 1 0]
	#"q" [1 1 1 1 1 0]
	#"r" [1 0 1 1 1 0]
	#"s" [0 1 1 0 1 0]
	#"t" [0 1 1 1 1 0]
	#"u" [1 0 0 0 1 1]
	#"v" [1 0 1 0 1 1]
	#"w" [0 1 1 1 0 1]
	#"x" [1 1 0 0 1 1]
	#"y" [1 1 0 1 1 1]
	#"z" [1 0 0 1 1 1]
	#"ç" [1 1 1 0 1 1]
	#"é" [1 1 1 1 1 1]
	#"à" [1 0 1 1 1 1]
	#"è" [0 1 1 0 1 1]
	#"ù" [0 1 1 1 1 1]
	#"â" [1 0 0 0 0 1]
	#"ê" [1 0 1 0 0 1]
	#"î" [1 1 0 0 0 1]
	#"ô" [1 1 0 1 0 1]
	#"û" [1 0 0 1 0 1]
	#"ë" [1 1 1 0 0 1]
	#"ï" [1 1 1 1 0 1]
	#"ü" [1 0 1 1 0 1]
	#"œ" [0 1 1 0 0 1]
	#"'" [0 0 0 0 0 1]
	#"," [0 0 0 0 1 0]
	#";" [0 0 1 0 1 0]
	#":" [0 0 1 1 0 0]
	#"." [0 0 1 0 0 1]
	#"!" [0 0 1 1 1 0]
	#"?" [0 0 1 0 0 1]
	#"-" [0 0 0 0 1 1]
	#"+" [0 1 0 0 1 1]
	#"(" [0 0 1 1 0 0]
	#")" [0 0 0 1 1 1]
	#"^"" [0 0 1 1 1 1]
	#"/" [0 1 0 0 1 0]
	#"@" [0 1 0 1 1 0]
	#"*" [0 0 0 1 1 0]
	#"1" [1 0 0 0 0 1]
	#"2" [1 0 1 0 0 1]
	#"3" [1 1 0 0 0 1]
	#"4" [1 1 0 1 0 1]
	#"5" [1 0 0 1 0 1]
	#"6" [1 1 1 0 0 1]
	#"7" [1 1 1 1 0 1]
	#"8" [1 0 1 1 0 1]
	#"9" [0 1 1 0 0 1]
	#"0" [0 1 0 1 1 1]
	#" " [0 0 0 0 0 0]	;--for space 
	#"µ" [0 0 0 0 0 1]	;--uppercase prefix alt m
	#"¬" [0 1 0 0 0 1]	;--italic prefix alt l
	#"~" [0 1 0 1 1 1]	;--numerical prefix alt n
]

generateCell: func [code [char! string!]
][
	bc: select bCodes code
	either bc/1 = 1 [prin active] [prin inactive]	;--point 1
	either bc/2 = 1 [print active] [print inactive]	;--point 4
	either bc/3 = 1 [prin active] [prin inactive]	;--point 2
	either bc/4 = 1 [print active] [print inactive]	;--point 5
	either bc/5 = 1 [prin active] [prin inactive]	;--point 3
	either bc/6 = 1 [print active] [print inactive]	;--point 6
]

processString: func [astring [string!]
][
	print s: lowercase astring
	foreach c s [print c generateCell c]
]

processString str

