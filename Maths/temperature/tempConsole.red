#!/usr/local/bin/red-cli
Red [ 
] 

;--based on R2 code by Sylvain Maltais (https://www.gladir.com/CODER/REBOL/meteoconv.htm)
;--adapted to Oldes's R3 and Red language
;--new functions added

do %thermalScales.red	;--load conversion functions

;--R3 print-horizontal-line does not exist in Red
;--we make something similar

print-horizontal-line: does [
	str: copy ""
	repeat i 80 [append str "-"]
	print str
]

print-horizontal-line
print "Celsius Scale"
print ["10 Celsius to Delise    = " centToDelisle 10]			;-- -85.0
print ["0 Celsius to Fahrenheit = " centToFahr 0]				;-- 32.0
print ["0 Celsius to Kelvin     = " centToKelvin 0]				;-- 273.15
print ["100 Celsius to Newton   = " centToNewton 100]			;-- 33.00
print ["100 Celsius to Rankine  = " centToRankine 100]			;-- 671.67
print ["100 Celsius to Reaumur  = " centToReaumur 100]			;-- 80.00
print ["10 Celsius to Romer     = " centToRomer 10]				;-- 12.75 (12.750000013125)

print-horizontal-line
print "Delisle Scale"
print ["1 Delisle to Celsius    = " delisletoCent 1]			;-- 67.33 (67.33333378222223)
print ["1 Delisle to Fahrenheit = " delisletoFahr 1]			;-- 153.2
print ["1 Delisle to Kelvin     = " delisletoKelvin 1]			;-- 340.4833 (340.483333782222)
print ["1 Delisle to Newton     = " delisletoNewton 1]			;-- 22.22 (22.21999997778)
print ["1 Delisle to Rankine    = " delisletoRankine 1]			;-- 612.87
print ["1 Delisle to Reaumur    = " delisletoReaumur 1]			;-- 53.86667 (53.86666637937778)
print ["1 Delisle to Romer      = " delisletoRomer 1]			;-- 42.85 (42.84999996465)

print-horizontal-line
print "Fahrenheit Scale"
print ["32 Fahrenheit to Celsius  = " fahrToCent 32]			;-- 0.0
print ["32 Fahrenheit to Delisle  = " fahrToDelisle 32]			;-- -100.0
print ["32 Fahrenheit to Kelvin   = " fahrToKelvin 32]			;-- 273.15
print ["212 Fahrenheit to Newton  = " fahrToNewton 212]			;-- 33.00 (32.9999994225)
print ["50 Fahrenheit to Rankine  = " fahrToRankine 50]			;-- 509.67
print ["50 Fahrenheit to Reaumur  = " fahrToReaumur 50]			;-- 8.00 (7.99999992888889)
print ["32 Fahrenheit to Romer    = " fahrToRomer 32]			;-- 7.5

print-horizontal-line
print "Kelvin Scale"
print ["32 Kelvin to Celsius     = " kelvinToCent 32]			;-- -241.15
print ["32 Kelvin to Delisle     = " kelvinToDelisle 32]		;-- -461.725
print ["32 Kelvin to Fahrenheit  = " kelvinToFarh 32]			;-- -402.07
print ["273.15 Kelvin to Newton  = " kelvinToNewton 273.15]		;-- 0.0
print ["273.15 Kelvin to Rankine = " kelvinToRankine 273.15]	;-- 491.67
print ["273.15 Kelvin to Reaumur = " kelvinToReaumur 273.15]	;-- 0.0
print ["273.15 Kelvin to Romer   = " kelvinToRomer 273.15]		;-- 7.5

print-horizontal-line
print "Newton Scale"
print ["1 newton to Celsius     = " newtonToCent 1]				;-- 3.0303 (3.0303030303030
print ["1 newton to Delisle     = " newtonToDelisle 1]			;-- -95.45455 (-95.45454545)
print ["1 newton to Fahrenheit  = " newtonToFahr 1]				;-- 37.45455 (37.45454545)
print ["1 newton to Kelvin      = " newtonToKelvin 1]			;-- 276.1803 (276.18030303)
print ["1 newton to Rankine     = " newtonToRankine 1]			;-- 497.12455 (497.12454545)
print ["1 newton to Reaumur     = " newtonToReaumur 1]			;-- 2.42424 (2.42424242)
print ["1 newton to Romer       = " newtonToRomer 1]			;-- 9.09091 (9.09090909)

print-horizontal-line
print "Rankine Scale"
print ["1 Rankine to Celsius    = " rankineToCent 1]			;-- -272.5944444444444
print ["1 Rankine to Delisle    = " rankineToDelisle 1]			;-- -508.8916666666667
print ["1 Rankine to Fahrenheit = " rankineToFahr 1]			;-- -458.69
print ["1 Rankine to Kelvin  	= " rankineToKelvin 1]			;-- 0.5555540411419315
print ["1 Rankine to Newton  	= " rankineToNewton 1]			;-- -89.95616509243378
print ["1 Rankine to Reaumur  	= " rankineToReaumur 1]			;-- -218.0755536171062
print ["1 Rankine to Romer  	= " rankineToRomer 1]			;-- -135.6120849433443

print-horizontal-line
print "Reaumur Scale"
print ["1 Reaumur to Celsius    = " reaumurToCent 1]			;-- 1.25
print ["1 Reaumur to Delisle    = " reaumurToDelisle 1]			;-- -98.125
print ["1 Reaumur to Fahrenheit = " reaumurToFahr 1]			;-- 34.25
print ["1 Reaumur to Kelvin     = " reaumurToKelvin 1]			;-- 274.4
print ["1 Reaumur to Newton     = " reaumurToNewton 1]			;-- 0.412500000721875
print ["1 Reaumur to Rankine    = " reaumurToRankine 1]			;-- 493.92
print ["1 Reaumur to Romer      = " reaumurToRomer 1]			;-- 8.156250001640625

print-horizontal-line
print "Romer Scale"
print ["1 Romer to Celsius    = " romerToCent 1]				;-- -12.38095235
print ["1 Romer to Delisle    = " romerToDelisle 1]				;-- -118.57142859
print ["1 Romer to Fahrenheit = " romerToFahr 1]				;-- 9.714285705000002
print ["1 Romer to Kelvin     = " romerToKelvin 1]				;-- 260.76904765
print ["1 Romer to Newton     = " romerToNewton 1]				;-- -4.08571428804898
print ["1 Romer to Rankine    = " romerToRankine 1]				;-- 469.384285705
print ["1 Romer to Reaumur    = " romerToReaumur 1]				;-- -9.90476188
