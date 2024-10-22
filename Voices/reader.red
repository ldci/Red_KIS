#!/usr/local/bin/red-view
Red[
	Author: "ldci"
	needs: 	view
]
;--for macOS Mojave (32-bit)
;--please adapt to your configuration
home: select list-env "HOME"
appDir: to-file rejoin [home "/Programmation/Red/Tests_FJ/voices/"]
change-dir to-file appDir


voices: 	[]
languages: 	[]
sentences:	[]
flag: 		1
filename:	%voices.txt
isFile?: 	no

;--all macOS voices
getVoices: does [call/shell/output "say -v '?'" filename]


loadVoices:  does [
	vfile: read/lines filename
	foreach v vfile [
		tmp: split v "#" 
		append sentences tmp/2
		trim/lines tmp/1
		append voices first split tmp/1 space
		append languages second split tmp/1 space
	]
	f/text: languages/1
]

generate: does [
	if isFile? [
		prog: rejoin ["say --voice=" #"^"" voices/:flag #"^"" " " #"^"" txt #"^""]
		call/shell/wait prog
	]
]

loadFile: does [
	tmp: request-file
	unless none? tmp [
		txt: lowercase read tmp	;--lowercase forall text
		trim/lines txt			;--suppress all line breaks and extra spaces
		a/text: read tmp		;--orginal text
		isFile?: yes			;--we have a text file
	]
]


mainWin: layout [
	title "Voice Reader"
	button "Load"   [loadFile]
	text 50 "Voice"
	dp1: drop-down data voices
		select 1
		on-change [
			flag: face/selected
			f/text: languages/(face/selected)
			;generate
		]
	f: field center
	button "Talk"	[generate] 
	button "Quit"	[quit]
	return
	a: area 500x400
	do [unless exists? filename [getVoices] loadVoices]
]

view mainWin

