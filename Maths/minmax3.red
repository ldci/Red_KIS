#!/usr/local/bin/red
Red [
]

min3: function [
	a	[number!]
	b 	[number!]
	c	[number!]
][
	either a < b [mini: a] [mini: b]
	if c < mini [mini: c]
	mini
]

max3: function [
	a	[number!]
	b 	[number!]
	c	[number!]
][
	either a > b [maxi: a] [maxi: b]
	if c > maxi [maxi: c]
	maxi
]


prin min3 1 2 3 prin " " print max3 1 2 3
prin min3 3 2 1 prin " " print max3 3 2 1
prin min3 3 1 2 prin " " print max3 3 1 2
prin min3 1 1 2 prin " " print max3 1 1 2

