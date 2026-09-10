#! /usr/local/bin/red-view
Red [
]

;--author ?
set [width height limit][1024 200 1000]

view [ 
	title "Sinus"
    base green with [size: as-pair width height] draw collect [
        keep 'line
        repeat i width [
            keep as-pair i multiply height / 2 1 + sin 0.1 * i
        ]
        keep reduce [
            'pen 'red 'line-width 1 
            'line as-pair limit 0 as-pair limit height
        ]
    ]
    button "Quit" [quit]
]