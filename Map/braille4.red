#!/usr/local/bin/red-view
Red [
	Title: "braille4"
	Author: "ldci"
	File: %braille4.red
	Needs: view
]
;-- Electronic Braille's cell is a 2x4 matrix with 8 dots
comment [dots order 1 4 2 5 3 6 7 8]

;tstr: "Hello Fantastic Red World!"
tstr: {Red language is smart for basic image processing. However, since Red is still young and under development, most of useful functions are not yet implemented. This is why RedCV exists.} 

;--generate ANSI and Braille codes
;--for i 10241 10495 1 [print [i to char! i]]
;--append is not supported by map! so we use extend
generateCodes: does [
	i: 32
	codes: #[]
	while [i <= 255] [
		idx: i + 10240				;--for Braille code value
		key: form to-char i			;--ANSI code
		value: form to-char idx		;--Braille code
		extend codes reduce [key value]
		i: i + 1
	]
]

processString: func [string [string!]
"Process ANSI string and returns Braille string"
][	
	str: copy ""
	foreach c string [append str select codes form c]
	str
]

;--we can use say with macOS 
sayString: does [
	prog: rejoin ["say -v " "Daniel" " " a1/text]
	call/shell/wait prog
]

mainWin: layout [
	title "Braille [256/8 dots Codes]"
	b1: button "Generate" [if cb/data [sayString] a2/text: processString a1/text]
	cb: check "Sound" false
	b2: button "Clear" [clear a1/text clear a2/text]
	pad 75x0
	b3: button "Quit" [quit]
	return
	a1: area 400x75 wrap
	return
	a2: area 400x200 wrap font-size 24 font-color blue
	do [a1/text: tstr generateCodes]
]
view mainWin