#! /usr/local/bin/red-view
Red [
	Title:   "macOS MP3 Player"
	Author:  "ldci"
	File: 	 %mp3_2.red
	Needs:	 'View
]

;--including a progress bar to follow the duration.
fileName: ""
fileInfo: ""
prog: "" 
vol: 1
isFile?: false
duration: 0.0     ; durée du morceau, en secondes
durationText: copy ""
elapsed: 0.0
playing?: false

loadFile: does [
	isFile?: false
	clear info/text
	fileInfo: copy ""
	duration: 0.0
	durationText: copy ""
	tmp: request-file
	unless none? tmp [
		fileName: to string! to-file tmp
		;win/text: fileName
		isFile?: true
		prog: rejoin ["afinfo '" fileName "'"]
		call/output prog fileInfo
		parse fileInfo [
			thru "estimated duration:"
			copy durationText to " sec"
		]
		info/text: fileInfo
		duration: to float! trim durationText
		fduration/text: rejoin [form round/to duration 0.01 " sec"]
	]
]

playFile: does [
    if isFile? [
        elapsed: 0.0
        playing?: true
        p/data: 0%
        prog: copy "afplay '"
        append prog reduce [fileName "'"]
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


stopFile: does [
    playing?: false
    p/data: 0%
    if isFile? [call "killall afplay"]
]

view win: layout [
	title "macOS mp3 reader"
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
	return 
	fduration: field center
	p: progress 300 0%
	timer: base 1x1 rate 10 on-time [
    	if all [playing? duration > 0.0] [
        	elapsed: elapsed + 0.1
        	p/data: to percent! min 1.0 (elapsed / duration)
        	ff/text: form round/to p/data 0.1
        	if elapsed >= duration [playing?: false]
    	]
	]
	ff: field 80 center
	do [sl/data: 10% fvol/text: to-string vol]
]
