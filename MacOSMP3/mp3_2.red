#! /usr/local/bin/red-view
Red [
	Title:   "macOS Sound Player"
	Author:  "ldci"
	File: 	 %mp3_2.red
	Needs:	 'View
]

;--including a progress bar and % to follow the duration.
fileName: none
fileInfo: none
vol: 1
isFile?: false
playing?: false
;--Red/Sensei func
shell-quote: func [s [string!]][
    s: copy s
    replace/all s "'" "'\''"
    rejoin ["'" s "'"]
]

loadFile: does [
	isFile?: false
	clear info/text
	fileInfo: copy ""
	duration: 0.0
	durationText: copy ""
	tmp: request-file
	unless none? tmp [
		fileName: to string! to-file tmp
		isFile?: true
		ret: call/output rejoin ["afinfo " shell-quote fileName] fileInfo
		if ret = 0
			[parse fileInfo [
				thru "estimated duration:"
				copy durationText to " sec"
			]	
			info/text: fileInfo
			duration: to float! trim durationText
			mduration: duration / 60 ;--in minutes
			fduration/text: rejoin [form round/to mduration 0.01 " min"]
			status/text: rejoin [" Reading file by afinfo: ==> OK"]
		]
		if ret <> 0 [status/text: "==> Error in afinfo reading file"]
	]
]

playFile: does [
    if isFile? [
        elapsed: 0.0
        playing?: true
        p/data: 0%
		call rejoin ["afplay " shell-quote fileName]
    ]
]
setVolume: does [
	vol: to-integer sl/data * 10 
	fvol/text: to-string vol
	call rejoin ["osascript -e 'set volume " form vol "'"]
]

stopFile: does [
    playing?: false
    p/data: 0%
    if isFile? [call "killall afplay"]
]

view win: layout [
	title "macOS ARM-64 music reader"
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
	text "Reading File" middle
	status: field 405
	return 
	text "Duration"  80 middle
	fduration: field center
	p: progress 210 0%
	;--100 ms for timer
	timer: base 1x1 rate 0:00:00.1 on-time [
    	if all [playing? duration > 0.0] [
        	elapsed: elapsed + 0.1
        	p/data: to percent! min 1.0 (elapsed / duration) 	;--from 0.0 to 1.0
        	;ff/text: form to percent! round/to p/data 0.1		;--in percent better view
        	ff/text: rejoin [form round/to (elapsed / 60) 0.1 " min"]	
        	if elapsed >= duration [playing?: false]
    	]
	]
	ff: field 78 center
	do [sl/data: 10% fvol/text: to-string vol timer/visible?: false]
]
