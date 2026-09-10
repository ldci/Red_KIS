#!/usr/local/bin/red-view
Red [
	needs: view
]
view [
	title "On-Over"
	t: area 200x200 blue
	on-down [quit] ;[print t] ;
	on-over [either t/color = red [t/color: blue][t/color: red]]
]