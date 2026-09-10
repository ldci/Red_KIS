#!/usr/local/bin/red-cli
Red [ 
] 
;--based on Modula2: https://www.modula2.org/projects/pi_by_montecarlo.php
random/seed now/time/precise
rounding: 0.0001
cTotal: 1000000
cInside: 0
print ["Calculating" cTotal "values..."] 
t: dt [
	repeat i cTotal [
		x: random 1.0
		y: random 1.0
		d: (x * x) + (y * y)
		if d <= 1.0 [cInside: cInside + 1]
	]
]
estimatedPI: 4.0 * (cInside / cTotal)
print ["PI by Monte Carlo estimation =" round/to estimatedPI rounding]
print ["Red PI value                 =" round/to pi rounding]
print ["Estimation duration          =" round/to third t 0.01 "sec"]