#Deep Learning Text Recognition (OCR) using Tesseract and Red

I'm frequently using OCR Tesseract when I have to recognize text in images. 
Tesseract was initially developed  by Hewlett Packard Labs. In 2005, it was open sourced by HP, and since 2006 it has been actively developed by Google and open source community.

In version 4, Tesseract has implemented a long short term memory (LSTM) recognition engine which is a kind of recurrent neural network (RNN) very efficient for OCR.

Tesseract library includes a command line tool *tesseract* which can be used  to perform OCR on images and output the result in a text file.

## Install Tesseract
First of all you need to install Tesseract library accoding to your main OS such as *sudo apt install tesseract-ocr* for Linux or  *brew install tesseract* for macOS. 

If you want multi-language support (about 170 languages) you have to install *tesseract-lang* package. 

## Using Tesseract with Red Language

This operation is really trivial since Red includes a *call* fonction which makes possible to use tesseract command line tool. You have to use call/wait refinment in order to wait tessearact execution. You can use different languages according to your documents.

## Code Sample



```
Red [
	Title:   "OCR"
	Author:  "Francois Jouen"
	File: 	  %tesseract.red
	Needs:	  View
	icon:	  %red.ico
]
; Languages
`tessdata: [
"afr (Afrikaans)"
"amh (Amharic)"
"ara (Arabic)"
"asm (Assamese)"
"aze (Azerbaijani)"
"aze_cyrl (Azerbaijani - Cyrilic)"
"bel (Belarusian)"
"ben (Bengali)"
"bod (Tibetan)"
"bos (Bosnian)"
"bre (Breton)"
"bul (Bulgarian)"
"cat (Catalan; Valencian)"
"ceb (Cebuano)"
"ces (Czech)"
"chi_sim (Chinese - Simplified)"
"chi_tra (Chinese - Traditional)"
"chr (Cherokee)"
"cym (Welsh)"
"dan (Danish)"
"deu (German)"
"dzo (Dzongkha)"
"ell (Greek Modern (1453-)"
"eng (English)"
"enm (English Middle (1100-1500)"
"epo (Esperanto)"
"equ (Math / equation detection module)"
"est (Estonian)"
"eus (Basque)"
"fas (Persian)"
"fin (Finnish)"
"fra (French)"
"frk (Frankish)"
"frm (French Middle (ca.1400-1600)"
"gle (Irish)"
"glg (Galician)"
"grc (Greek Ancient (to 1453)"
"guj (Gujarati)"
"hat (Haitian; Haitian Creole)"
"heb (Hebrew)"
"hin (Hindi)"
"hrv (Croatian)"
"hun (Hungarian)"
"iku (Inuktitut)"
"ind (Indonesian)"
"isl (Icelandic)"
"ita (Italian)"
"ita_old (Italian - Old)"
"jav (Javanese)"
"jpn (Japanese)"
"kan (Kannada)"
"kat (Georgian)"
"kat_old (Georgian - Old)"
"kaz (Kazakh)"
"khm (Central Khmer)"
"kir (Kirghiz; Kyrgyz)"
"kor (Korean)"
"kor_vert (Korean (vertical)"
"kur (Kurdish)"
"kur_ara (Kurdish (Arabic)"
"lao (Lao)"
"lat (Latin)"
"lav (Latvian)"
"lit (Lithuanian)"
"ltz (Luxembourgish)"
"mal (Malayalam)"
"mar (Marathi)"
"mkd (Macedonian)"
"mlt (Maltese)"
"mon (Mongolian)"
"mri (Maori)"
"msa (Malay)"
"mya (Burmese)"
"nep (Nepali)"
"nld (Dutch; Flemish)"
"nor (Norwegian)"
"oci (Occitan (post 1500)"
"ori (Oriya)"
"osd (Orientation and script detection module)"
"pan (Panjabi; Punjabi)"
"pol (Polish)"
"por (Portuguese)"
"pus (Pushto; Pashto)"
"que (Quechua)"
"ron (Romanian; Moldavian; Moldovan)"
"rus (Russian)"
"san (Sanskrit)"
"sin (Sinhala; Sinhalese)"
"slk (Slovak)"
"slv (Slovenian)"
"snd (Sindhi)"
"spa (Spanish; Castilian)"
"spa_old (Spanish; Castilian - Old)"
"sqi (Albanian)"
"srp (Serbian)"
"srp_latn (Serbian - Latin)"
"sun (Sundanese)"
"swa (Swahili)"
"swe (Swedish)"
"syr (Syriac)"
"tam (Tamil)"
"tat (Tatar)"
"tel (Telugu)"
"tgk (Tajik)"
"tgl (Tagalog)"
"tha (Thai)"
"tir (Tigrinya)"
"ton (Tonga)"
"tur (Turkish)"
"uig (Uighur; Uyghur)"
"ukr (Ukrainian)"
"urd (Urdu)"
"uzb (Uzbek)"
"uzb_cyrl (Uzbek - Cyrilic)"
"vie (Vietnamese)"
"yid (Yiddish)"
"yor (Yoruba)"
]
;OCR Engine Mode
ocr: [
"Original Tesseract only"
"Neural nets LSTM only"
"Tesseract + LSTM"
"Default, based on what is available"
]



appDir: "Please adapt or use what-dir"
appDir: what-dir
tFile: to-file rejoin[appDir "tempo"]
tFileExt: to-file rejoin[appDir "tempo.txt"]
change-dir to-file appDir

dSize: 512
gsize: as-pair dSize dSize
img: make image! reduce [gSize black]
lang: "eng"
ocrMode: 3
tmpf: none
tBuffer: copy []

loadImage: does [
	tmpf: request-file
	isFile: false
	if not none? tmpf [
		clear result/text
		img: load tmpf
		canvas/image: img
		isFile: true	
	]
]

processFile: does [
	if isFile [
		if exists? tFileExt [delete tFileExt]
		clear result/text 
		prog: copy "/usr/local/bin/tesseract " 
		append prog form tmpf 
		append append prog " " form tFile
		case [
			ocrMode = 0 [append append prog " -l " lang]
			ocrMode = 1 [append append prog " -l " lang append append prog " --oem " ocrMode]
			ocrMode = 2 [append append prog " -l " lang]
			ocrMode = 3 [append append prog " -l " lang append append prog " --oem " ocrMode]
		]
		call/wait prog
		either cb/data [
			clear tbuffer
			clear result/data
			tt: read tFileExt
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
		[result/text: read tFileExt]
	]
]

; ***************** Test Program Interface ************************
view win: layout [
		title "Tesseract OCR with Red"
		button  "Load Image" [loadImage]	
		text 60 "Language"
		dp1: drop-down 180 data tessdata
		select 24
		on-change [ 
			s: dp1/data/(face/selected)
			lang: first split s " "
		]
		text 80 "OCR mode" 
		dp2: drop-down 230 data ocr
		select 4
		on-change [ocrMode: face/selected - 1]
		cb: check "Lines" false
		button "Process" 		[processFile]
		button "Clear"			[clear result/text]
		button "Quit" 			[if exists? tFileExt [delete tFileExt] Quit]
		return
		canvas: base gsize img
		result: area  gsize font [name: "Arial" size: 16 color: black] 
			data []		
		return
		f: field  512
		text "Font"
		drop-list 120
			data  ["Arial" "Consolas" "Comic Sans MS" "Times" "Hannotate TC"]
			react [result/font/name: pick face/data any [face/selected 1]]
			select 1
		fs: field 50 "16" 
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

![](/Users/fjouen/Programmation/Red/tesseract/pub/tesseract.jpg)


 

