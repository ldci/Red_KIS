#!/usr/local/bin/red-cli
Red [
]

min3: function [
	a	[number!]
	b 	[number!]
	c	[number!]
][
	;either a < b [mini: a] [mini: b]
	;if c < mini [mini: c]
	mini: min min a b c
]

max3: function [
	a	[number!]
	b 	[number!]
	c	[number!]
][
	;either a > b [maxi: a] [maxi: b]
	;if c > maxi [maxi: c]
	maxi: max max a b c
]


prin min3 1 2 3 prin " " print max3 1 2 3
prin min3 3 2 1 prin " " print max3 1 2 3
prin min3 3 1 2 prin " " print max3 1 2 3
prin min3 1 1 2 prin " " print max3 1 2 3

