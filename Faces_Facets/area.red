#!/usr/local/bin/red-view
Red [needs: view]

txt: {A key problem of software development today is software bloat, where huge toolchains and development environments are needed in software coding and deployment. 
Red significantly reduces this bloat by offering a minimalist but complete toolchain.}

view [
	title "Area"
	a: area 400x200 txt wrap
	b: button "Quit" [quit]
]
