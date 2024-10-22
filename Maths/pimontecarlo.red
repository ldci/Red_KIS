#!/usr/local/bin/red-cli
Red [ 
] 
;--based on Modula2: https://www.modula2.org/projects/pi_by_montecarlo.php
random/seed now/time/precise
cTotal: 1000000
cInside: 0
print "Calculating..."

repeat i cTotal [
	x: random 1.0
	y: random 1.0
	d: (x * x) + (y * y)
	if d <= 1.0 [cInside: cInside + 1 ]
]

estimatedPI: 4.0 * (cInside / cTotal)
print ["PI by Monte Carlo estimation =" round/to estimatedPI 0.00001]
print ["Red 3 pi value               =" round/to pi 0.00001]