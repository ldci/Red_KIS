#Deep Learning Text Recognition (OCR) using Tesseract and Red

I'm frequently using OCR Tesseract when I have to recognize text in images. 
Tesseract was initially developed  by Hewlett Packard Labs. In 2005, it was open sourced by HP, and since 2006 it has been actively developed by Google and open source community.

From version 4, Tesseract has implemented a long short term memory (LSTM) recognition engine which is a kind of recurrent neural network (RNN) very efficient for OCR.

Tesseract library includes a command line tool *tesseract* which can be used  to perform OCR on images and output the result in a text file.

## Install Tesseract
First of all you need to install Tesseract library accoding to your main OS such as *sudo apt install tesseract-ocr* for Linux or  *brew install tesseract* for macOS. 

If you want multi-language support (about 170 languages) you have to install *tesseract-lang* package. 

## Using Tesseract with Red Language

This operation is really trivial since Red includes a *call* fonction which makes possible to use tesseract command line tool. You have to use call/wait refinment in order to wait tessearact execution. You can use different languages according to your documents.

## Code Sample



```
#! /usr/local/bin/red-view
Red [
	Title:   "OCR"
	Author:  "Francois Jouen"
	File: 	 %tesseract.red
	Needs:	 View
	icon:	%red.ico
]

;--only for image files. Non support for pdf files

appDir: to-red-file "/Users/fjouen/Programmation/Red_ARM/Code/Tesseract"
output: %tempo/result-ocr
change-dir appDir
dSize: 512
gsize: as-pair dSize dSize
img: make image! reduce [gSize black]
lang: "eng"
ocrMode: 3
tmpf: none
tBuffer: copy []
#include %languages/tessdata.red

loadImage: does [
	tmpf: request-file
	isFile: false
	if not none? tmpf [
		clear result/text
		img: load tmpf
		canvas/image: img
		tFile: form tmpf
		isFile: true	
	]
]

ocr: [
"Original Tesseract only"
"Neural nets LSTM only"
"Tesseract + LSTM"
"Default, based on what is available"
]


processFile: does [
	if isFile [
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
		
	    f2/text: form ret: call/wait prog
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
		canvas: base gsize img
		result: area white gsize wrap font [name: "Arial" size: 16 color: black] 
			data []		
		return
		f: field  452 f2: field 40 center
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
		do [f/text: copy form appDir]
]

```


## Result

This is an example for simplified chinese document. 

![](https://github.com/ldci/Red_KIS/tree/main/Tesseract/pub)


 

