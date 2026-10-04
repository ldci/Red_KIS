#! /usr/local/bin/red-view
Red [
	Title:   "macOS MP3 Player"
	Author:  "ldci"
	File: 	 %mp3.red
	Needs:	 'View
]

fileName: ""
fileInfo: ""
prog: "" 
vol: 1
isFile?: false

loadFile: does [
	isFile?: false
	clear info/text
	fileInfo: copy ""
	tmp: request-file
	if not none? tmp [
		fileName: to string! to-file tmp
		win/text: fileName
		isFile?: true
		prog: copy "afinfo '" 
		append prog reduce [FileName "'" ]
		call/output prog fileInfo
		info/text: fileInfo
	]
]

playFile: does [
	if isFile? [
		prog: copy "afplay '" 
		append prog reduce [FileName "'"] 
		call prog
	]
]

setVolume: does [
	vol: to-integer sl/data * 10 
	fvol/text: to-string vol
	volProg: copy "osascript -e 'set volume "
	append volProg reduce [to-string vol "'"]
	call volProg
]


stopFile: does [if isFile? [prog: "killall afplay" call prog]]

view win: layout [
	title "macOS mp3"
	origin 10x10 space 10x10
	button "Load" [loadFile]
	button "Play" [playFile]
	button "Stop" [stopFile]
	text 60 "Volume" middle
	sl: slider 100x25 [setVolume]
	fvol: field 25			
	button "Quit" [stopFile Quit]
	return
	info: area 500x250
	do [sl/data: 10% fvol/text: to-string vol]
]

if empty? system/view/screens/1/pane [stopFile Quit]
