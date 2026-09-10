#!/usr/local/bin/red-view
Red [ 
    Needs: view
    Author: "LDCI"
] 
;--Thanks to Red/Sensei's corrections

;--Global Physical Parameters
k: 0.5
l: 1.0
itime: 0.1

;--Global Numerical Parameters
nx: 100
nt: 1000
dx: l / (nx - 1)
deltaT: itime / nt ;-- (not use dt Red word)


linSpace: function [
    "Generates N linearly spaced numbers from a to b (inclusive)."
    a   [number!]
    b   [number!]
    n   [integer!]
    /no-end
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

init: does [
	clear f1/text
    x: linSpace 0.0 1.0 nx
    t: (x * 2.0 * pi)
    repeat i nx [t/:i: sin t/:i]
    plot: compose [
		text 0x0   "+1.0"
		text 0x192  "0"
		text 0x380  "-1.0"
		pen white
		line 10x200 405x200 
	]
	canvas/draw: plot
]

diffusion: does [
    vect: make vector! reduce ['float! 64 nx]
    posy: 0
    n: 0
    while [n <= nt] [
        j: 2
        while [j < nx] [
            vect/:j: deltaT * k * (t/(j - 1) - (2.0 * t/:j) + t/(j + 1)) / (dx ** 2) ;--make equation
            j: j + 1
        ]
        repeat j nx [t/:j: t/:j + vect/:j]
        if zero? n % 100 [ 
           	acolor: random white
            append plot reduce ['pen (acolor) 'line]		;--a random color for each curve
            xx: 2
            foreach val t [
                append plot as-pair xx * 4 200 - (val * 195) ;--draw the curve
                xx: xx + 1
            ]
            posy: posy + 15
            tt: rejoin ["time: " round/to (n * deltaT) 0.001]
            pos: as-pair 340 posy
            append plot reduce ['fill-pen (acolor) 'text (pos) (tt)] ;--draw label
        ]
        n: n + 1
    ]
    canvas/draw: plot
]

win: layout [
    title "Heat Diffusion"
    b1: button "Initialise" [init b2/enabled?: true] 
    b2: button "Diffusion"  [
    							elapsed: dt [diffusion] 
    							f1/text: rejoin [form (round/to third elapsed 0.01) * 1000 " msec"]
    							b2/enabled?: false
    						]
    button     "Quit" 		[quit]                 
    return
    canvas: base 415x400
    return
    f1: field 415
    do [b2/enabled?: false]
]
view win