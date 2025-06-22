#!/usr/local/bin/red-cli
Red[
]

;--based on Gregg Irwin's notes about for

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


;--Delta-time tests

n: 100000
t1: dt [
	repeat i n [v: i * 100]
]

t2: dt [
	i: 1 
	while [i <= n] [
		v: i * 100
		i: i + 1
	]
]

t3: dt [
	i: 1
	until [
		v: i * 100
		i: i + 1
		i = n
	]
]

t4: dt [
	for i 1 n 1 [v: i * 100]
]

print ["Loop  :" n]
print ["Repeat:"  (third t1) * 1000 "ms"]
print ["While :"  (third t2) * 1000 "ms"]
print ["Until :"  (third t3) * 1000 "ms"]
print ["For   :"  (third t4) * 1000 "ms"]