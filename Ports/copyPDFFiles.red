#!/usr/local/bin/red-view
Red[
	Needs: 'View
]

;--for @sp1d3r_99 (tested with macOS)
;--default values  for tests
fileName: %test.pdf
url: https://static.red-lang.org/A_BNF_grammar_of_Red_System.pdf

;--CopyFile pdf files function
copyFile: func [url [url!] file [file!] 
][
	data: read/binary url write/binary file data
]

;--GUI interface
win: layout [
	title "Get a pdf file from the Internet"
	text "URL" f1: field 300x50 wrap
	return
	text "File Name" f2: field 300 
	return 
	text "Status" f3: field 300
	return
	pad 130x0
	button "Get" [
		url: to-url f1/text f: to-file f2/text
		attempt [
			copyFile url f 
			f3/text: "Done"
			;--macOS command to open the pdf (must be adapted for other OS)
			call/shell rejoin ["open " to-string f]
		]
	]
	button "Quit" [quit]
	do [f1/text: form url f2/text: form fileName]
]
view win