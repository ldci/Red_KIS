#!/usr/local/bin/red-cli
Red [ 
 Title: "WaveFrequency" 
 Version: 1.0.0 
 Author: @ldci
 Purpose: {This program calculates wave frequencies.} 
] 
 
 
comment[
Based on Sylvain Maltais's code for Rebol 2 ;'
Tanh: function [A] [Result] [
   Result: ((-(exp(- A)) / ((exp A) + (exp(- A))) * 2.0) + 1.0)
]
 
DispersionWave: function [WaveNumber Depth Gravity] [Result] [
   Result: (square-root (WaveNumber * Gravity * (Tanh (WaveNumber * Depth))))
]
]


tanh: func [x [number!]
][
	sinh: (exp x) - (exp negate x) / 2.0
	cosh: (exp x) + (exp negate x) / 2.0
	result: sinh / cosh	
]

coTanh: func [x [number!]
][
	sinh: (exp x) - (exp negate x) / 2.0
	cosh: (exp x) + (exp negate x) / 2.0
	result: cosh / sinh	
]

waveDispersion: func [waveNumber depth gravity [number!]
][
   	result: sqrt (waveNumber * gravity * (tanh (waveNumber * depth)))
]

print "Nombre de vagues Frequence des vagues"
waveNumber: 0.01
while [waveNumber < 2] [
    w: waveDispersion waveNumber 2 9.8066
    print [waveNumber ":          " w]
    waveNumber: waveNumber + 0.1
]

comment [
;--expected 
Nombre de vague 	Frequence de vague
0.01                0.0442838405346847
0.11                0.483284245969315
0.21                0.904120000135606
0.31                1.29439350996723
0.41                1.64750037820416
0.51                1.96223961769009
0.61                2.24116780044981
0.71                2.48877439250178
0.81                2.71009411116294
0.91                2.90988655848262
1.01                3.09226456180236
1.11                3.26060035427737
1.21                3.4175734276094
1.31                3.56527459565709
1.41                3.70532058634234
1.51                3.83895838612317
1.61                3.96715215371979
1.71                4.09065210263135
1.81                4.21004747750794
1.91                4.32580654215394
]

;--notes
;1 cycle respiratoire = 1 inspiration + 1 expiration
;la fréquence respiratoire dont les normes varient avec l’âge, 
;< 60 cycles /min chez le nouveau-né, < 50 chez le moins de 1 an, 
;< 40 chez le moins de 5 ans et < 30 cycles/min pour le plus de 5 ans. 
;La bradypnée, rare, est un signe d’épuisement ;