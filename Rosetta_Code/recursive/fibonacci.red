#! /usr/local/bin/red-cli
;--can also be use with r3
Red [
	Title:	"Red Tests: Recursivity (Fibonacci's series )"
	Author:	"ldci"
	Notes: 	{variant samples come from Rosetta Code Website. 
	Thanks to @iiamboris for dt use and vector suggestions
	}
]
nMax: 16 ;--47 max value due to integer 32-bit limitation
;--Fibonacci's suite ;'

;--Recursive memoized with map! datatype
fib1: function [n] [
	;m: #(0 0 1 1 2 1) 	;--red 0.64
	m: #[0 0 1 1 2 1]	;--red 0.65
	any [m/:n m/:n: (fib1 n - 1) + (fib1 n - 2)]
]
;--with negative integers
fib2: function [n] [
	x: fib1 absolute n
	if all [negative? n even? n] [x: negate x]
	x
]

;--symetrical distribution
fib3: function [n] [
	x: fib absolute n
	if negative? n [x: negate x]
	x
]

;--Binet formula 
analytic: function [n] [
	p: (1 + sqrt 5.0) / 2
	to-integer (p ** n / sqrt 5.0) + 0.5
]

analytic2: function [n] [
	p: (1 + sqrt 5.0) / 2
	q: (1 - sqrt 5.0) / 2
	to-integer ((p ** n) - (q ** n)) / sqrt 5.0
]

;--*********** Tests *************************
print "Recursive memoized"
i: 0
while [i < nMax] [
	prin [fib1 i sp]
	i: i + 1
]
print ""
t: third dt (reduce [fib1 nMax])
print ["Recursive memoized: " round/to t * 1000 0.0001 "ms"]

print "Analytic 1"
i: 0
while [i < nMax] [
	prin [analytic i sp]
	i: i + 1
]
print ""
t: third dt (reduce [analytic nMax])
print ["Analytic 1: " round/to t * 1000 0.0001 "ms"]

print "Analytic 2"
i: 0
while [i < nMax] [
	prin [analytic i sp]
	i: i + 1
]
print ""
t: third dt (reduce [analytic2 nMax])
print ["Analytic 2: " round/to t * 1000 0.0001 "ms"]











    



