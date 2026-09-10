#!/usr/local/bin/red-cli
Red [ 
	Needs: view
	Author: "LDCI"
] 
;--Based on Oldes's R3 code
;--Thanks to Red/Sensei for linespace in Red

linSpace: function [
    "Generates N linearly spaced numbers from a to b (inclusive)."
    a   [number!]  "Start"
    b   [number!]  "End"
    n   [integer!] "Number of samples"
    /no-end        "Don't include end value in the result"
][
    either n < 2 [
        vec: make vector! reduce ['float! 64 1]
        vec/1: a
    ][
        vec: make vector! reduce ['float! 64 n]
        div: either no-end [n][n - 1]
        step: (1.0 * (b - a)) / div
        repeat k n [
            vec/:k: a + (step * (k - 1))
        ]
    ]
    vec
]

probe linSpace -1.0 0.0 5
;== make vector! [-1.0 -0.75 -0.5 -0.25 0.0]

probe linSpace -1.0 0.0 1
;== make vector! [-1.0]

probe linSpace/no-end 0 100 10
;== make vector! [0.0 10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0]

probe linSpace 0 100 9
;==make vector! [0.0 12.5 25.0 37.5 50.0 62.5 75.0 87.5 100.0]

x: linSpace/no-end 0.0 (2.0 * pi) 10
n: length? x
y: make vector! reduce ['float! 64 n]
repeat i n [
	y/:i: sin x/:i
]

probe y

