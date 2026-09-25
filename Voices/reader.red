#!/usr/local/bin/red-view
Red[
	Author: "ldci"
	needs: 	view
]
;--for macOS Mojave (32-bit)
;--please adapt to your configuration
home: select list-env "HOME"
appDir: to-file rejoin [home "/Programmation/Red/Tests_FJ/voices/"]
appDir: "/Users/fjouen/Programmation/Red_ARM/code/Red_KIS_64-bit/voices/"
change-dir to-file appDir


voices: 	[]	;--for voices
voices2: 	[]	;--for voice description 
codes: 		[]	;--code for the voices
sentences:	[]	;--sentence examples
flag: 1
filename:  	%voices.txt ;--from macOS "say -v '?'"
isFile?: false
;--all macOS voices
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
    f2/text: voices2/1
]

;--1. Entourer le texte avec des simples quotes (le plus simple)
generate1: does [
    if isFile? [
        prog: rejoin ["say --voice=" voices/:flag " '" txt "'"]
		ret: call/wait prog
        f3/text: rejoin ["Call return: " form ret]
    ]
]

;--2. Entourer avec des guillemets et échapper les guillemets internes (plus robuste)
generate2: does [
    if isFile? [
		safe-txt: replace/all copy txt {"} {\"}
		prog: rejoin ["say --voice=" voices/:flag space {"} safe-txt {"}]
		ret: call/wait prog
        f3/text: rejoin ["Call return: " form ret]
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
			f2/text: codes/(face/selected)
			f1/text: voices2/(face/selected)
			;generate
		]
	f1: field 180
	f2: field center
	
	button "Talk"	[generate1] 
	button "Quit" 50	[quit]
	return
	a: area 665x400
	return
	f3: field 665
	do [unless exists? filename [getVoices] loadVoices]
]

view mainWin

