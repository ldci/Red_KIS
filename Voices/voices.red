#!/usr/local/bin/red-view
Red[
	Author: "ldci"
	needs: 	view
]
;--for macOS 64-bit
;--new version 
voices: 	[]	;--for voices
voices2: 	[]	;--for voice description 
codes: 		[]	;--code for the voices
sentences:	[]	;--sentence examples
flag: 1
filename:  	%voices.txt ;--from macOS "say -v '?'"

getVoices: does [call/shell/output "say -v '?'" filename]

loadVoices: does [
    vfile: read/lines filename
    foreach v vfile [
        tmp: split v "#" 
        append sentences tmp/2
        trim/lines tmp/1
        parts: split tmp/1 space
        append voices first parts        ;--prénom pour say
        append codes last parts          ;--code langue
        voice-name: copy/part tmp/1 (length? tmp/1) - (length? last parts) - 1
        trim voice-name
        append voices2 voice-name        ;--prénom + label
    ]
    a/text: sentences/1
    f/text: codes/1
    f2/text: voices2/1
]

generate: does [
	;prog: rejoin ["say -v " voices/:flag " " a/text]
	;call/shell/wait prog
    call/shell/wait rejoin ["say -v " voices/:flag " " mold a/text]
]

mainWin: layout [
	title "Voices for macOS"
	dp1: drop-down 100 data voices
		select 1
		on-change [
			flag: face/selected
			f/text: codes/(face/selected)
			f2/text: voices2/(face/selected)
			a/text: sentences/(face/selected)
		]
	f2: field 200
	f: field 60 center
	return
		
	a: area 315x25
	button "Talk" 55	[call/shell/wait rejoin ["say -v " voices/:flag " " mold a/text]] 
	return 
	pad 325x0
	button  "Quit" 55	[quit]
	do [unless exists? filename [getVoices] loadVoices]
]

view mainWin

