#!/usr/local/bin/red-view
Red[
	Needs: 'View
]

;--Celsius Scale
centToDelisle: function [
	celsius [number!]	;--Celsius value
] [
 	 (celsius * 1.5) + -100
]
centToFahr: function [
	celsius [number!]	;--Celsius value
] [
 	1.8 * celsius + 32.0
]

centToKelvin: function 
[
	celsius [number!]	;--Celsius value
][
 	celsius + 273.16
]

centToNewton: function [
	celsius [number!]	;--Celsius value
][
 	celsius / 3.03030303
]

centToRankine: function [
	celsius [number!]	;--celsius value
][
 	celsius * 1.8 + 491.69
]

centToReaumur: function [
	celsius [number!]	;--celsius value
][
 	celsius / 1.25
]

centToRomer: function [
	celsius [number!]	;--celsius value
][
 	(celsius / 1.9047619) + 7.5
]

;--Delisle scale
delisleToCent: function [
	delisle [number!]	;--delisle value
][
 	(delisle - -100) / 1.49999999
]

delisleToFahr: function [
	delisle [number!]	;--delisle value
][
 	((delisle - -100) * 1.2) + 32
]

delisleToKelvin: function [
	delisle [number!]	;--delisle value
][
 	((delisle - -100) / 1.49999999) + 273.15
]

delisleToNewton: function [
	delisle [number!]	;--delisle value
][
 	(delisle - -100) / 4.54545455
]

delisleToRankine: function [
	delisle [number!]	;--delisle value
][
 	((delisle - -100) * 1.2) + 491.67
]

delisleToReaumur: function [
	delisle [number!]	;--delisle value
][
 	(delisle - -100) / 1.87500001
]

delisleToRomer: function [
	delisle [number!]	;--delisle value
][
 	((delisle - -100) / 2.85714286) + 7.5
]


;--Fahrenheit Scale
fahrToCent: function [
	fahr [number!]	;--Fahrenheit value
] [
 	(5.0 / 9.0) * (fahr - 32.0)
]

fahrToDelisle: function [
	fahr [number!]	;--Fahrenheit value
] [
 	((fahr - 32) / 1.2) + -100
]

fahrToKelvin: function 
[
	fahr [number!]	;--Fahrenheit value
][
	(fahr - 32) * (5 / 9) + 273.15
]

fahrToNewton: function [
	fahr [number!]		;--Fahrenheit value
][
 	fahr - 32 / 5.45454555
]

fahrToRankine: function [
	fahr [number!]	;--Fahrenheit value
][
 	fahr + 459.67
]

fahrToReaumur: function [
	fahr [number!]		;--Fahrenheit value
][
 	fahr - 32 / 2.25000002
]

fahrToRomer: function [
	fahr [number!]		;--Fahrenheit value
][
 	((fahr - 32) / 3.42857139) + 7.5
]

;--Kelvin Scale
kelvinToCent: function [
	kelvin [number!]	;--kelvin value
][
 	kelvin - 273.15
]

kelvinToDelisle: function [
	kelvin [number!]	;--kelvin value
][
 	((kelvin - 273.15) * 1.5) + -100
]
kelvinToFarh: function [
	kelvin [number!]	;--kelvin value
][
 	((kelvin - 273.15) * 1.8) + 32
]

kelvinToNewton: function [
	kelvin [number!]	;--kelvin value
][
 	(kelvin - 273.15) / 3.03030303
]
 
kelvinToRankine: function [
	kelvin [number!]	;--kelvin value
][
 	((kelvin - 273.15) * 1.8) + 491.67
]

kelvinToReaumur: function [
	kelvin [number!]	;--kelvin value
][
 	(kelvin - 273.15) / 1.25
]

kelvinToRomer: function [
	kelvin [number!]	;--kelvin value
][
 	((kelvin - 273.15) / 1.9047619) + 7.5
]

;--Newton Scale
newtonToCent: function [
	newton [number!]	;--Newton value
][
 	newton * 100 / 33
]
newtonToDelisle: function [
	newton [number!]	;--Newton value
][
 	(newton * 4.54545455) + -100
]

newtonToFahr: function [
	newton [number!]	;--Newton value
][
 	(newton * 5.45454545) + 32
]


newtonToKelvin: function [
	newton [number!]	;--Newton value
][
 	(newton * 3.03030303) + 273.15
]

newtonToRankine: function [
	newton [number!]	;--Newton value
][
 	(newton * 5.45454545) + 491.67
]

newtonToReaumur: function [
	newton [number!]	;--Newton value
][
 	newton * 2.42424242
]

newtonToRomer: function [
	newton [number!]	;--Newton value
][
 	(newton * 1.59090909) + 7.5
]

;--Rankine Scale
rankineToCent: function[
	rankine [number!]	;--rankine value
][
	(rankine - 491.67) / 1.8
]
rankineToDelisle: function[
	rankine [number!]	;--rankine value
][
	((rankine - 491.67) / 1.2) + -100
]

rankineToFahr: function[
	rankine [number!]	;--rankine value
][
	rankine - 459.69
]

rankineToKelvin: function[
	rankine [number!]	;--rankine value
][
	((rankine - 491.67) / 1.79999999) + 273.15
]

rankineToNewton: function[
	rankine [number!]	;--rankine value
][
	(rankine - 491.67) / 5.45454555
]

rankineToReaumur: function[
	rankine [number!]	;--rankine value
][
	(rankine - 491.67) / 2.25000002
]

rankineToRomer: function[
	rankine [number!]	;--rankine value
][
	((rankine - 491.67) / 3.42857139) + 7.5
]


;--Reaumur Scale

reaumurToCent: function [
	reaumur [number!]	;--Reaumur value
][
 	reaumur * 5 / 4
]

reaumurToDelisle: function [
	reaumur [number!]	;--Reaumur value
][
 	(reaumur * 1.875) + -100
]

reaumurToFahr: function [
	reaumur [number!]	;--Reaumur value
][
 	(reaumur * 2.25) + 32
]

reaumurToKelvin: function [
	reaumur [number!]	;--Reaumur value
][
 	(reaumur * 1.25) + 273.15
]

reaumurToNewton: function [
	reaumur [number!]	;--Reaumur value
][
 	 reaumur / 2.42424242
]

reaumurToRankine: function [
	reaumur [number!]	;--Reaumur value
][
 	 (reaumur * 2.25) + 491.67
]

reaumurToRomer: function [
	reaumur [number!]	;--Reaumur value
][
	(reaumur / 1.52380952) + 7.5
]

;--Romer Scale

romerToCent: function [
	romer [number!]	;--Romer value
][
 	(romer - 7.5) * 1.9047619
]
romerToDelisle: function [
	romer [number!]	;--Romer value
][
 	((romer - 7.5) * 2.85714286) + -100
]

romerToFahr: function [
	romer [number!]	;--Romer value
][
 	((romer - 7.5) * 3.42857143) + 32
]

romerToKelvin: function [
	romer [number!]	;--Romer value
][
 	((romer - 7.5) * 1.9047619) + 273.15
]

romerToNewton: function [
	romer [number!]	;--Romer value
][
 	(romer - 7.5) / 1.59090909
]

romerToRankine: function [
	romer [number!]	;--Romer value
][
 	((romer - 7.5) * 3.42857143) + 491.67
]

romerToReaumur: function [
	romer [number!]	;--Romer value
][
 	(romer - 7.5) * 1.52380952
]