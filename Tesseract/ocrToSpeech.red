#! /usr/local/bin/red-view
Red [
	Title:   "OCR"
	Author:  "Francois Jouen"
	File: 	 %tesseract.red
	Needs:	 View
	icon:	%red.ico
]

;--only for image files. Non support for pdf files
;--only macOS for say
appDir: to-red-file "/Users/fjouen/Programmation/Red_ARM/Code/Red_KIS_64-bit/Tesseract"
output: %tempo/result-ocr
change-dir appDir
dSize: 512
gsize: as-pair dSize dSize
img: make image! reduce [gSize black]
lang: "eng"
ocrMode: 3
tmpf: none
tBuffer: copy []
isFile?: false
isProcessed?: false

#include %languages/tessdata.red

voices: 	[]
voices2: 	[]	;--for voice description 
codes: 	[]
sentences:	[]
flag: 18
filename:  	%tempo/voices.txt


; 2. TTS : dit le texte avec la voix correspondante
;safe-txt: replace/all copy txt {"} {\"}
;cmd-tts: rejoin ["say --voice=Thomas " {"} safe-txt {"}]
;call/wait cmd-tts

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
    
    f0/text: codes/1
    f1/text: voices2/1
]


;--1. Entourer le texte avec des simples quotes (le plus simple)
generate1: does [
    if isFile? [
        prog: rejoin ["say --voice=" voices/:flag " '" result/text "'"]
		ret: call/wait prog
        f3/text: form ret
    ]
]

;--2. Entourer avec des guillemets et échapper les guillemets internes (plus robuste)
generate2: does [
	safe-txt: replace/all copy result/text {"} {\"}
	prog: rejoin ["say --voice=" voices/:flag space {"} safe-txt {"}]
	ret: call/wait prog
    f3/text: form ret
]


loadImage: does [
	tmpf: request-file
	isFile?: false
	isProcessed?: false
	if not none? tmpf [
		clear result/text
		img: load tmpf
		canvas/image: img
		tFile: form tmpf
		isFile?: true	
	]
]

ocr: [
"Original Tesseract only"
"Neural nets LSTM only"
"Tesseract + LSTM"
"Default, based on what is available"
]

; 1. OCR : capture le texte directement en mémoire
;cmd-ocr: rejoin ["tesseract " img-path " stdout -l fra"]
;call/output/wait cmd-ocr txt: copy ""
;cmd: reduce ["tesseract " tmpf  stdout " -l " lang]


processFile: does [
	if isFile? [
		if exists? output [delete output]
		clear result/text 
		
		;tessearact rajoute l'extension.txt à l'output
		output: %tempo/result-ocr
		; Construction de la commande de base
		cmd: reduce ["tesseract " tmpf output "-l " lang]
		; Ajout de --oem seulement si nécessaire (modes 1 et 3)
		if find [1 3] ocrMode [append cmd reduce ["--oem" ocrMode]]
		
		; Formatage final en une seule chaîne
		prog: form reduce cmd

		call/wait prog
		
	    f3/text: form ret: call/wait prog
		;--maintenant pour Red 
		output: %tempo/result-ocr.txt

		either cb/data [
			clear tbuffer
			clear result/data
			tt: read output
			tbuffer: split tt "^/"
			nl: length? tbuffer 
			i: 1
			while [i <= nl][
				ligne: tbuffer/:i
				ll: length? ligne
				if  ll > 1 [append result/data rejoin [ligne lf]]
				i: i + 1
			]
			result/text: copy form result/data]
			[result/text: read output]
	]
	isProcessed?: true
]



; ***************** Test Program Interface ****************************
view win: layout [
		title "Tesseract OCR with Red"
		button  "Load Image" [loadImage]	
		text 60 middle "Language"
		dp1: drop-down 180 data tessdata
		select 24
		on-change [ 
			s: dp1/data/(face/selected)
			lang: first split s " "
		]
		text 80 middle  "OCR mode" 
		dp2: drop-down 230 data ocr
		select 4
		on-change [ocrMode: face/selected - 1]
		cb: check "Lines" false
		button "Process" 		[processFile]
		button "Clear"			[clear result/text]
		button "Quit" 			[if exists? output [delete output] Quit]
		return
		pad 10x0 text middle "Voices "
		dp3: drop-down 100 data voices 
		select 18
		on-change [
			flag: face/selected
			f0/text: codes/(face/selected)
			f1/text: voices2/(face/selected)
		]
		f0: field center 	;--codes
		f1: field 200		;--labels
		button "Talk" [if isProcessed? [generate2]]
		return
		canvas: base gsize img
		result: area white gsize wrap font [name: "Arial" size: 16 color: black] 
			data []		
		return
		f2: field  452 f3: field 40 center
		
		text middle "Font"
		drop-list 120
			data  ["Arial" "Consolas" "Comic Sans MS" "Times" "Hannotate TC"]
			react [result/font/name: pick face/data any [face/selected 1]]
			select 1
		fs: field 50 "14" 
		react [result/font/size: fs/data]
		button 30 "+"  [fs/data: fs/data + 1]
		button 30 "-"  [fs/data: max 1 fs/data - 1]
		drop-list 100
			data  ["black" "blue" "green" "yellow" "red"]
			react [result/font/color: reduce to-word pick face/data any [face/selected 1]]
			select 1
		do [f2/text: copy form appDir unless exists? filename [getVoices] loadVoices]
]
