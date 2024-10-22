#! /usr/local/bin/red-cli
Red [
]

nMax: 16 ;-- 47 max value due to integer 32-bit limitation
;--Fibonacci's suite

;--Recursive memoized with map! datatype
fib: function [n] [
	;m: #(0 0 1 1 2 1)	;--red 0.64 
	m: #[0 0 1 1 2 1]	;--red 0.65
	any [m/:n m/:n: (fib n - 1) + (fib n - 2)]
]

;--with negative integers
nfib: function [n] [
	x: fib absolute n
	if all [negative? n even? n] [x: negate x]
	x
]

;--Binet's formula 
analytic: function [n] [
	p: (1 + sqrt 5) / 2
	to-integer (p ** n / sqrt 5) + 0.5
]

analytic2: function [n] [
	p: (1 + sqrt 5) / 2
	q: (1 - sqrt 5) / 2
	to-integer ((p ** n) - (q ** n)) / sqrt 5
]

print "Fibonacci Tests"

i: 0
t1: now/time/precise
while [i < nMax] [
	prin [fib i sp]
	i: i + 1
]
t2: now/time/precise
print [lf "Recursive: " third (t2 - t1)  *  1000 "ms" lf]

i: 0
t1: now/time/precise
while [i < nMax][
	prin [analytic i sp]
	i: i + 1
]

t2: now/time/precise
print [lf "Analytic 1: " third (t2 - t1)  *  1000 "ms" lf]

i: 0
t1: now/time/precise
while [i < nMax][
	prin [analytic2 i sp]
	i: i + 1
]
t2: now/time/precise
print [lf "Analytic 2: " third (t2 - t1)  *  1000 "ms"]
print lf

i: -15
t1: now/time/precise
while [i < nMax][
	prin [nfib i sp]
	i: i + 1
]
t2: now/time/precise
print [lf "Negative: " third (t2 - t1)  *  1000 "ms"]

;--Hiiamboris's suggestion
t: third dt (reduce [nfib -16])
print [round/to t * 1000 0.01 "ms"]

v: make vector! 16 
add v 1 
v/1: 0
v: at v 3 
forall v [v + v/-2] 
print head v




    



