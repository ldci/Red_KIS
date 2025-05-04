#!/usr/local/bin/red-view
Red [
	Title: "braille4"
	Author: "ldci"
	File: %braille5.red
	Needs: view
]
;-- Electronic Braille's cell is a 2x4 matrix with 8 dots
comment [dots order 1 4 2 5 3 6 7 8]

tstr: "Hello Fantastic Red World!"
;tstr: {Red language is smart for basic image processing. However, since Red is still young and under development, most of useful functions are not yet implemented. This is why RedCV exists.} 

;--Oldes's solution without maps

encode-braille: function [
    "Process ANSI string and returns Braille string"
    text [string!]
][  
    out: copy ""
    foreach char text [
        if char <= 255 [char: char + 10240]
        append out char
    ]
    out
]
decode-braille: function [
    "Process string while decoding Braille's characters"
    text [string!]
][
    out: copy ""
    foreach char text [
        if all [char >= 10240 char <= 10495] [char: char - 10240]
        append out char
    ]
    out
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
		a2/text: encode-braille a1/text
		a3/text: decode-braille a2/text
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
	do [a1/text: tstr]
]
view mainWin