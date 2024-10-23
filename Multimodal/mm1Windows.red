#! /usr/local/bin/red-view
Red [
	Title: "mm1"
	Author: "ldci"
	Needs: view
]
;--Windows users have a look here for alternative solutions: 
;--http://redlcv.blogspot.com/2024/10/giving-voices-to-your-apps.html
;--we use some unicode characters for buttons
str1: rejoin ["Files " to-char 127899]
str2: rejoin ["Play  " to-char 129302] 
str3: rejoin ["Quit  " to-char 128421] 
;--we use Windows wsay command
msg1: "wsay Loading..game..files..."
msg2: "wsay  Starting..game..1..Enjoy"
msg3: "wsay  Quit..this..game..application..Bye-bye..folks"

view win: layout [
	title "Multimodal Test with Windows"
	button 100x50 font-size 12 str1	[call/shell/wait msg1 b/text: "Games loaded"]
	button 100x50 font-size 12 str2	[call/shell/wait msg2 b/text: "Starting game 1. Enjoy!"]
	button 100x50 font-size 12 str3 [clear b/text call/shell/wait msg3 quit]
	return
	b: base  330x100 white 
]
