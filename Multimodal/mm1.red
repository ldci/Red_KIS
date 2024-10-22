#! /usr/local/bin/red-view
Red [
	Title: "mm1"
	Author: "ldci"
	Needs: view
]
;--use some unicode characters for buttons text
str1: rejoin ["Files " to-char 127899]
str2: rejoin ["Play  " to-char 129302] 
str3: rejoin ["Quit  " to-char 128421] 
;--use macOS say command
msg1: "say -v Samantha Loading game files..."
msg2: "say -v Samantha Starting game 1. Enjoy"
msg3: "say -v Samantha Leaving this game application. Bye-bye folks"

view win: layout [
	title "Multimodal Test with macOS"
	button 100x50 font-size 14 str1	[call/shell/wait msg1 b/text: "Games loaded"]
	button 100x50 font-size 14 str2	[call/shell/wait msg2 b/text: "Starting game 1. Enjoy!"]
	button 100x50 font-size 14 str3 [b/text: "Bye-bye folks !" do-events/no-wait call/shell/wait msg3 quit]
	return
	b: base  330x50 white 
]
