#!/usr/local/bin/red-cli
Red [
]
;--only CLI-Red for call/console (not supported by GUI-Red)
;--Print the text line by line during synthesis, highlighting words as they are spoken.
txt: {Un texte simple avec un exemple simplifié qui reste très simple, mais alors très simple!}	
call/console rejoin ["say -v thomas --interactive=/red " txt]


