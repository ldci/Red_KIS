#! /usr/local/bin/red-cli
Red [
	Title:	"Red Tests: Recursivity (Factorial)"
	Author:	"ldci"
	Notes: 	{variant samples come from Rosetta Code Website. 
	Thanks to @iiamboris for dt use suggestion
	}
]


;--iterative factorial n! (0! = 1)
fact1: function [n [integer!] return: [integer!]][
	r: 1
	repeat i n [r: r * i]
	r
]

;--variant
fact2: function [n][repeat i also n n: 1 [n: n * i] n]


;--recursive factorial n!
factorial1: function [n [integer!] return: [integer!]][
    either n > 1 [n * factorial1 n - 1] [1]
]

;--variants
factorial2: func [n][any [if n = 0 [1] n * factorial2 n - 1]]
factorial3: func [n][do pick [[n * factorial3 n - 1] 1] n > 1]

;--Memoized with map! datatype
factorial4: function [n [integer!]
][	
	;m: #(0 1) 	;--red 0.64
	m: #[0 1]	;--red 0.65
	any [m/:n m/:n: n * factorial4 n - 1]]

;--tests
print "Iterative Factorial 1..12"
repeat i 12 [fact1 i]
repeat i 12 [fact2 i]

print "Recursive Factorial 1..12"
repeat i 12 [factorial1 i]
repeat i 12 [factorial2 i]
repeat i 12 [factorial3 i]

print "Memoized  Factorial 1..12"
repeat i 12 [factorial4 i]

print  ["12! =" factorial4 12]
print "Comparaison"
t: third dt (reduce [fact1 12])
print ["Iterative 1: " round/to t * 1000 0.0001 "ms"]
t: third dt (reduce [fact2 12])
print ["Iterative 2: " round/to t * 1000 0.0001 "ms"]
t: third dt (reduce [factorial1 12])
print ["Recursive 1: " round/to t * 1000 0.0001 "ms"]
t: third dt (reduce [factorial2 12])
print ["Recursive 2: " round/to t * 1000 0.0001 "ms"]
t: third dt (reduce [factorial3 12])
print ["Recursive 3: " round/to t * 1000 0.0001 "ms"]
t: third dt (reduce [factorial4 12])
print ["Recursive 4: " round/to t * 1000 0.0001 "ms"]

