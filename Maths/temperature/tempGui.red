#!/usr/local/bin/red-view
Red[
	Needs: 'View
	Author: "ldci"
]

do %thermalScales.red	;--load conversion functions
ssrc: ["Celsius" "Delisle" "Fahrenheit" "Kelvin" "Newton" "Rankine" "Reaumur" "Romer"]
sdst: ["Celsius" "Delisle" "Fahrenheit" "Kelvin" "Newton" "Rankine" "Reaumur" "Romer"] 

;[]
process: does [
	if error? try [val: to-float f1/text]  [val: 0.0]
	;--source: Celsius
	if dp1/selected = 1 [
		switch dp2/selected [
			1 [res: to-float f1/text]		;--Celsius to Celsius
			2 [res: centToDelisle val]		;--Celsius to Fahrenheit
			3 [res: centToFahr val]			;--Celsius to Fahrenheit
			4 [res: centToKelvin val]		;--Celsius to Kelvin 
			5 [res: centToNewton val]		;--Celsius to Newton
			7 [res: centToRankine val]		;--Celsius to Rankine
			7 [res: centToReaumur val]		;--Celsius to Reaumur
			8 [res: centToRomer val]		;--Celsius to Reaumur
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Delisle
	if dp1/selected = 2 [
		switch dp2/selected [
			1 [res: delisleTocent val]		;--Delisle to Celsius
			2 [res: to-float f1/text]		;--Delisle to Delisle
			3 [res: delisleToFahr val]		;--Delisle to Fahrenheit
			4 [res: delisleToKelvin val]	;--Delisle to Kelvin 
			5 [res: delisleToNewton val]	;--Delisle to Newton
			7 [res: delisleToRankine val]	;--Delisle to Rankine
			7 [res: delisleToReaumur val]	;--Delisle to Reaumur
			8 [res: delisleToRomer val]		;--Delisle to Reaumur
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Fahrenheit
	if dp1/selected = 3 [
		switch dp2/selected [
			1 [res: fahrToCent val]	;--Fahrenheit to Celsius
			2 [res: fahrToDelisle val]		;--Fahrenheit to Delisle	
			3 [res: to-float f1/text]		;--Fahrenheit to Fahrenheit
			4 [res: fahrToKelvin val]		;--Fahrenheit to Kelvin 
			5 [res: fahrToNewton val]		;--Fahrenheit to Newton
			6 [res: fahrToRankine val]		;--Fahrenheit to Rankine
			7 [res: fahrToReaumur val]		;--Fahrenheit to Reaumur
			8 [res: fahrToRomer val]		;--Fahrenheit to Romer
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Kelvin
	if dp1/selected = 4 [
		switch dp2/selected [
			1 [res: kelvinToCent val]		;--Kelvin to Celsius
			2 [res: kelvinToDelisle val]	;--Kelvin to Delisle
			3 [res: kelvinToFarh val]		;--Kelvin to Fahrenheit
			4 [res: to-float f1/text]		;--Kelvin to Kelvin 
			5 [res: kelvinToNewton val]		;--Kelvin to Newton
			6 [res: kelvinToRankine val]	;--Kelvin to Rankine
			7 [res: kelvinToReaumur val]	;--Kelvin to Reaumur
			8 [res: kelvinToRomer val]		;--Kelvin to Romer
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Newton
	if dp1/selected = 5 [
		switch dp2/selected [
			1 [res: newtonToCent val]		;--Newton to Celsius
			2 [res: newtonToDelisle val]	;--Newton to Delisle
			3 [res: newtonToFahr val]		;--Newton to Fahrenheit
			4 [res: newtonToKelvin val]		;--Newton to Kelvin 
			5 [res: to-float f1/text]		;--Newton to Newton
			6 [res: newtonToRankine val]	;--Newton to Rankine
			7 [res: newtonToReaumur val]	;--Newton to Reaumur
			8 [res: newtonToRomer val]		;--Newton to Romer
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Rankine
	if dp1/selected = 6 [
		switch dp2/selected [
			1 [res: rankineToCent val]		;--Rankine to Celsius
			2 [res: rankineToDelisle val]	;--Rankine to Celsius
			3 [res: rankineToFahr val]		;--Rankine to Fahrenheit
			4 [res: rankineToKelvin val]	;--Rankine to Kelvin 
			5 [res: rankineToNewton val]	;--Rankine to Newton
			6 [res: to-float f1/text]		;--Rankine to Rankine
			7 [res: rankineToReaumur val]	;--Rankine to Reaumur
			8 [res: rankineToRomer val]		;--Rankine to Romer
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Reaumur
	if dp1/selected = 7 [
		switch dp2/selected [
			1 [res: reaumurToCent val]		;--Reaumur to Celsius
			2 [res: reaumurToDelisle val]	;--Reaumur to Delisle
			3 [res: reaumurToFahr val]		;--Reaumur to Fahrenheit
			4 [res: reaumurToKelvin val]	;--Reaumur to Kelvin 
			5 [res: reaumurToNewton val]	;--Reaumur to Newton
			6 [res: reaumurToRankine val]	;--Reaumur to Rankine
			7 [res: to-float f1/text]		;--Reaumur to Reaumur
			8 [res: reaumurToRomer val]		;--Reaumur to Romer
		]
		f2/text: form round/to res 0.0001
	]
	;--source: Romer
	if dp1/selected = 8 [
		switch dp2/selected [
			1 [res: romerToCent val]		;--Romer to Celsius
			2 [res: romerToDelisle val]		;--Romer to Delisle
			3 [res: romerToFahr val]		;--Romer to Fahrenheit
			4 [res: romerToKelvin val]		;--Romer to Kelvin 
			5 [res: romerToNewton val]		;--Romer to Newton
			6 [res: romerToRankine val]		;--Romer to Rankine
			7 [res: romerToReaumur val]		;--Romer to Reaumur
			8 [res: to-float f1/text]		;--Romer to Romer
		]
		f2/text: form round/to res 0.0001
	]
] 



view win: layout [
    title "Thermal Conversions"
    text "Scales"
    dp1: drop-list data ssrc select 1	[process]
    dp2: drop-list data sdst select 1	[process]
    return
    text "Values"
    f1: field 100 "25"	[process]
    f2: base 100x22 gold "25" 
    return
    pad 125x0
    button "Quit" [quit]
]
