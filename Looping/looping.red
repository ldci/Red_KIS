#!/usr/local/bin/red-cli
Red[
]

;--based on Gregg Irwin's notes

for: function [
    'word [word!]		;--iteration counter not local to loop
    start [integer!]	;--starting index
    end   [integer!]	;--ending index
    step  [integer!]	;--index step, default 1
    body  [block!]		;--data block to be executed
][
    do-body: func reduce [word] body
    index: start
    step: any [step 1]
    while [index <= end][
        do-body index
        index: index + step
    ]
]


;--tests
for i 1 10 1 [prin [i " "]]
print lf
for i -10 10 5 [prin [i " "]]
print lf


loop 3 [print "Hello"]	
repeat i 5 [print i] ;--interation counter is  always  1
i: -10.0
while  [i <= 10.0] [
	print i
	i: i + 0.5
]

i: 4 until [
	print i i: i - 1               
    i < 0; <=condition 
]


;--@Moppy_gitlab
_for: func [
	current [integer!] 
	endv 	[integer!] 
	process [block!]
][ 
    unless current > endv [
        inner: func reduce ['i] process
        inner current 
        _for current + 1 endv process
    ]
]

;index-print: func [index [integer!]] [print index]
;_for -5 5 [print i]