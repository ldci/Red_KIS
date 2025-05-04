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
	i: 0										;--all codes
	codesA: #[]									;--a map object ANSI->Braille
	codesB: #[]									;--a map object Braille->ANSI
	while [i <= 255] [
		idx: i + 10240							;--for Braille code value
		key: form to-char i						;--ANSI code
		value: form to-char idx					;--Braille code
		extend/case codesA reduce [key value]	;--update map
		extend/case codesB reduce [value key]	;--update map
		i: i + 1
	]
]

processString: func [
"Processes ANSI string or Braille string"
	string [string!]
	/ansi /braille
][	
	str: copy ""
	;--for ansi use select/case, characters are case-sensitive
	if ansi [foreach c string [append str select/case codesA form c]] 
	if braille [foreach c string [append str select codesB form c]]
	str
] 

;--we can use say with macOS 
sayString: does [
	prog: rejoin ["say -v " "Daniel" " " a1/text]
	call/shell/wait prog
]

mainWin: layout [
	title "Braille [256/8 dots Codes]"
	b1: button "Generate" [
		if cb/data [sayString] 
		a2/text: processString/ansi a1/text
		a3/text: processString/braille a2/text
	]
	cb: check "Sound" false
	b2: button "Clear" [clear a1/text clear a2/text clear a3/text]
	pad 75x0
	b3: button "Quit" [quit]
	return
	a1: area 400x75 wrap
	return
	a2: area 400x200 wrap font-size 24 font-color blue
	return
	a3: area 400x75 wrap
	do [a1/text: tstr generateCodes]
]
view mainWin