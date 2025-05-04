#!/usr/local/bin/red-view
Red [
	Title: "braille3"
	Author: "ldci"
	File: %braille3.red
	Needs: view
]
;-- Electronic Braille's cell is a 2x4 matrix with 8 points
comment [1 4 2 5 3 6 7 8]

;tstr: "Hello Fantastic Red World!"
tstr: {Red Language (http://www.red-lang.org/p/about.html) is a rather new language developed by Nénad Rakocevic and strongly inspired by REBOL (http://www.rebol.com).} 

;--generate ANSI and Braille codes
generateCodes: does [
	i: 32
	blk: []
	while [i <= 255] [
		idx: i + 10240;--for Braille code first value
		key: rejoin [to-char i]
		value: rejoin [to-char idx]
		append append blk key value
		i: i + 1
	]
	codes: make map! blk			;--OK a map from block
]

getCode: func [code [string!]
"Returns Braille code"
][
	select codes code
]
processString: func [astring [string!]
"Process ANSI string and returns Braille string"
][	
	str: copy ""
	foreach c astring [append append str getCode form c " "]
	str
]

mainWin: layout [
	title "Braille [256/8 points Codes]"
	b1: button "Generate" [a2/text: processString a1/text]
	b2: button "Clear" [clear a2/text]
	pad 170x0
	b3: button "Quit" [quit]
	return
	a1: area 400x50 wrap
	return
	a2: area 400x150 wrap font-size 24 font-color black
	do [a1/text: tstr generateCodes]
]
view mainWin