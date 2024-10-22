#! /usr/local/bin/red-cli
Red [
]

;--Recursive memoized with map! datatype
fib: function [n] [
	;m: #(0 0 1 1 2 1) 	;--red 0.64
	m: #[0 0 1 1 2 1]	;--red 0.65
	any [m/:n m/:n: (fib n - 1) + (fib n - 2)]
]

;--with negative integers
fib2: function [n] [
	x: fib absolute n
	if all [negative? n even? n] [x: negate x]
	x
]

;--symetrical distribution
fib3: function [n] [
	x: fib absolute n
	if negative? n [x: negate x]
	x
]

i: -10
while [i < 11][
	print [i fib2 i]
	i: i + 1
]