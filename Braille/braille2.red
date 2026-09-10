#!/usr/local/bin/red-view
Red [
	Title: "braille2"
	Author: "ldci"
	File: 	%braille2.Red
	Needs: view
]
;-- Electronic Braille's cell is a 2x4 matrix with 8 points
comment [1 4 2 5 3 6 7 8]

;tstr: "Hello Fantastic Red World!"
tstr: {A key problem of software development today is software bloat, where huge toolchains and development environments are needed in software coding and deployment. Ivo Balbaert.} 


;--This version uses 2 blocks for ANSI and Braille codes
generateCodes: does [
	i: 32
	blkC: copy []		;--ANSI Codes
	blkB: copy []		;--Braille Codes
	while [i <= 255] [
		idx: i + 10240
		append blkC to-char i
		append blkB to-char idx
		i: i + 1
	]
]

generateCell: func [code [string! char!]
][
	idx: index? find blkC to-char code
	blkB/:idx
]
processString: does [
	set-focus a1
	clear a2/text
	str: copy ""
	foreach c a1/text [append  append str generateCell c " "]
	a2/text: str
]

mainWin: layout [
	title "Braille [256 Codes]"
	b1: button "Generate" [processString tstr]
	pad 250x0
	b2: button "Quit" [quit]
	return
	a1: area 400x50 wrap
	return
	a2: area 400x150 wrap font-size 24 font-color black
	do [a1/text: tstr generateCodes]
]
view mainWin