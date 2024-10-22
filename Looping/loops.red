#!/usr/local/bin/red-cli
Red [
	Title: "Loops"
	Author: "ldci"
	Notes: {Loops for beginners}
	Needs: none
]

;--Why we don't need a for loop in Red
;--'first use loop or repeat
loop 3 [prin ["Hello "]]
print [" --> Loop done" lf]

;--interation counter is always initialized to 1	
repeat i 5 [prin [i " "]] 
print [" --> Repeat done" lf]

;-- for loop can be simulated by while (for all number!) 
i: -10.0
while  [i <= 10.0] [
	prin [i " "] 
	i: i + 0.5
]
print [" --> While done" lf]


;-until can  be also used
i: 4 
until [
	prin [i " "] 
	i: i - 0.5               
    i < 0	;--exit condition 
]
print [" --> Until done" lf ]




