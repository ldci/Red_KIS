#!/usr/local/bin/red-view
Red [needs: view] 
a: 10	;--for canvas size
b: 5	;--for canvas color
view [
	title  "Using With"
    canvas: base with [
        size:  30x40 * a
        color: 8.20.33 * b
        data:  0
        draw: compose [pen yellow line 0x0 (size)]
    ]
]
