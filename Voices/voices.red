#!/usr/local/bin/red-view
Red[
	Author: "ldci"
	needs: 	view
]
;--for macOS 32-bit (Mojave) 
;--new version 
voices: 	[]
languages: 	[]
sentences:	[]
flag: 1
filename:  	%voices.txt

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
	a/text: sentences/1
	f/text: languages/1
]

generate: does [
	prog: rejoin ["say -v " voices/:flag " " a/text]
	call/shell/wait prog
]

mainWin: layout [
	title "Voices"
	dp1: drop-down data voices
		select 1
		on-change [
			flag: face/selected
			f/text: languages/(face/selected)
			a/text: sentences/(face/selected)
			;generate
		]
	f: field center
	button "Talk"	[generate] 
	pad 100x0 
	button  "Quit"	[quit]
	return
	a: area 450x50
	do [unless exists? filename [getVoices] loadVoices]
]

view mainWin

