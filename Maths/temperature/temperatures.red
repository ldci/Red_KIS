#!/usr/local/bin/red-view
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
print "Fahrenheit to Celsius"
print ["0 Fahrenheit to Celsius  = " fahrToCent 0]				;-- -17.7777777777778
print ["32 Fahrenheit to Celsius = " fahrToCent 32]				;-- 0.0
print ["80 Fahrenheit to Celsius = " fahrToCent 80]				;-- 26.6666666666667

print-horizontal-line
print "Celsius to Fahrenheit"
print ["0 Celsius to Fahrenheit   = " centToFahr 0]				;-- 32.0
print ["30 Celsius to Fahrenheit  = " centToFahr 30]			;-- 86.0
print ["100 Celsius to Fahrenheit = " centToFahr 100]			;-- 212.0

print-horizontal-line
print "Celsius to Kelvin"
print ["-273.16 Celsius to Kelvin = " centToKelvin -273.16]		;-- 0.0
print ["0 Celsius to  Kelvin      = " centToKelvin 0]			;-- 273.16	
print ["100 Celsius to Kelvin 	  = " centToKelvin 100]			;-- 373.16

print-horizontal-line
print "Fahrenheit to Kelvin"
print ["32 Fahrenheit to Kelvin = " fahrToKelvin 32]			;-- 273.15
print ["80 Fahrenheit to Kelvin = " fahrToKelvin 80]			;-- 299,817

print-horizontal-line
print "Kelvin to Celsius"
print ["0 Kelvin to Celsius      = " kelvinToCent 0]			;-- -273.16
print ["273.16 Kelvin to Celsius = " kelvinToCent 273.16]		;-- 0.0
print ["373.16 Kelvin to Celsius = " kelvinToCent 373.16]		;-- 100.0

print-horizontal-line
print "Kelvin to Fahrenheit"
print ["0 Kelvin to Fahrenheit      = " kelvinToFarh 0]			;-- -459.688
print ["273.16 Kelvin to Fahrenheit = " kelvinToFarh 273.16]	;-- 32.0
print ["373.16 Kelvin to Fahrenheit = " kelvinToFarh 373.16]	;-- 212.0

print-horizontal-line
print "Celsius to Rankine"
print ["-273.16 Celsius to Rankine = " centToRankine -273.16]	;-- 0.00199999999995271
print ["0 Celsius to Rankine       = " centToRankine 0]			;-- 491.69	
print ["100 Celsius to Rankine     = " centToRankine 100.0]		;-- 671.69

print-horizontal-line
print "Fahrenheit to Rankine"
print ["-17 Fahrenheit to Rankine     = " fahrToRankine -17.77]	;-- 441.9
print ["0 Fahrenheit to Rankine       = " fahrToRankine 0]		;-- 459.67	
print ["100 Fahrenheit to Rankine     = " fahrToRankine 100.0]	;-- 559.67

print-horizontal-line
print "Rankine to Celsius"
print ["0 Rankine to Celsius      = " rankineToCent 0]			;-- -273.161111111111
print ["491.69 Rankine to Celsius = " rankineToCent 491.69]		;-- 0.0
print ["671.69 Rankine to Celsius = " rankineToCent 671.69]		;-- 100.0

print-horizontal-line
print "Rankine to Fahrenheit"
print ["0 Rankine to Fahrenheit      = " rankineToFahr 0]		;-- -459.69	
print ["491.69 Rankine to Fahrenheit = " rankineToFahr 491.69]	;-- 32.0
print ["671.69 Rankine to Fahrenheit = " rankineToFahr 671.69]	;-- 212.0

print-horizontal-line
print "Celsius to Reaumur"
print ["0 celsius to reaumur  = " centToReaumur 0]				;-- 0.0
print ["30 celsius to reaumur = " centToReaumur 30]				;-- 24.0

print-horizontal-line
print "Fahrenheit to Reaumur"
print ["0 Fahrenheit to reaumur   = " fahrToReaumur 0]			;-- -14.222
print ["100 Fahrenheit to reaumur = " fahrToReaumur 100]			;-- 30.222

print-horizontal-line
print "Reaumur to Celsius"
print ["0 reaumur to Celsius   = " reaumurToCent 0]				;-- 0
print ["80 reaumur to Celsius  = " reaumurToCent 80]			;-- 100
print ["100 reaumur to Celsius = " reaumurToCent 100]			;-- 125

print-horizontal-line
print "Reaumur to Fahrenheit"
print ["0 reaumur to Fahrenheit   = " reaumurToFahr 0]			;-- 32.0
print ["80 reaumur to Fahrenheit  = " reaumurToFahr 80]			;-- 212.0
print ["100 reaumur to Fahrenheit = " reaumurToFahr 100]			;-- 257.0

print-horizontal-line
print "Celsius to Newton"
print ["0 celsius to Newton    = " centToNewton 0]				;-- 0.0
print ["30 celsius to Newton   = " centToNewton 30]				;-- 9.9000
print ["100 celsius to Newton  = " centToNewton 100]			;-- 33.000000003

print-horizontal-line
print "Fahrenheit to Newton"
print ["0 Fahrenheit to Newton    = " fahrToNewton 0]			;-- -5.8667
print ["30 Fahrenheit to Newton   = " fahrToNewton 30]			;-- 0.36667
print ["200 Fahrenheit to Newton  = " fahrToNewton 200]			;-- 30.800

print-horizontal-line
print "Newton to Celsius"
print ["0 Newton to Celsius   = " newtonToCent 0]				;-- 0.0
print ["100 Newton to Celsius = " newtonToCent 100]				;-- 303.030303030303
print ["200 Newton to Celsius = " newtonToCent 200]				;-- 606.060606060606

print-horizontal-line
print "Newton to Fahrenheit"
print ["0 Newton to Fahrenheit   = " newtonToFahr 0]			;-- 32.0
print ["100 Newton to Fahrenheit = " newtonToFahr 100]			;-- 577.45
print ["200 Newton to Fahrenheit = " newtonToFahr 200]			;-- 1122.9

print-horizontal-line
print "tests"
print ["10 Celsius to Delise   = " centToDelisle 10]			;-- -85.0
print ["10 Celsius to Romer    = " centToRomer 10]				;-- 12.7500


