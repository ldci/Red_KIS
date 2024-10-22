#! /usr/local/bin/red-view
Red [
	Needs:	View
	Author: "ldci"
]

flag: 1
punct: rejoin [",.;:!?-_(){}'@#&" form #"^""]	;--exclude punctation symbols

loadFile: does [
	tmp: request-file
	unless none? tmp [
		txt: lowercase read tmp	;--lowercase for all text
		trim/lines txt			;--suppress all line breaks and extra spaces in text
		ar/text: read tmp		;--copy orginal text to area
		countWords				;--count words in text
	]
]

removePunct1: function [
	aText [string!]
][
	trim/with aText punct						;--trim method
]

removePunct2: function [
	aText [string!]
][
	remove-each c aText [find punct c]			;--remove-each method
]

removePunct3: function [
	aText [string!]
][
	_punct: charset punct
	parse aText [any [remove _punct | skip]]	;--parse method
]


countWords: does [
	foreach fcval [wordsList f1 f2] [face: get fcval clear face/text]	;--clear faces
	copycat: copy txt				;--a copy since methods modify text
	t1: now/time/precise				
	switch flag [
		1	[removePunct1 copycat]	;--trim method
		2	[removePunct2 copycat]	;--remove-each method
		3	[removePunct3 copycat]	;--parse method
	]
	wordBlock: split copycat space	;--get all words
	sort wordBlock				   	;--sort words a..z
	n: (length? wordBlock) ;- 1
	count: 1
	wordCount: copy []
	i: 1
	key2: wordBlock/(i + 1)											;--for while loop
	while [not none? key2] [
		key1: wordBlock/(i) key2: wordBlock/(i + 1)					;--test keys
		either key1 == key2 
			[count: count + 1]										;--increment count
			[append wordCount rejoin [key1 ": " count] count: 1] 	;--new entry with count = 1
		i: i + 1
	]
	
	wordsList/text: copy ""
	foreach v wordCount [append wordsList/text rejoin [v newline]]
	t2: now/time/precise
	elapsed: to-integer (third t2 - t1) * 1000
	f1/text: rejoin [form n + 1 " words"]
	f2/text: rejoin ["in " form elapsed " ms"]
]

mainWin: layout [
	title "Word Count: Tests" 
	button "Load" 		[loadFile]
	drop-down 80 data 	["Trim" "Remove" "Parse"]
		select 1
		on-change 		[flag: face/selected countWords]
	f1: field 120 center
	f2: field 100 center
	pad 140x0
	button "Quit" 	[Quit]
	return
	ar: area white 400x400 wrap
	font [name: "Arial" size: 14 color: black] 
	wordsList: area black 200x400 
	font [name: "Arial" size: 14 color: green] 
] 

view mainWin
