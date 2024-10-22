#! /usr/local/bin/red-view
Red[
	Title:   "Colored Toggles"
	Author:  "ldci"
	File: 	 %toggle.red
	needs: 	 view
	Tabs:	 4
	Rights:  "Copyright (C) 2021 ldci. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

;--inspired by switch-btn. Author: Greg Irvin?


win: layout [
	title "Toggles"
	origin 15x5
    style cToggle: base 80x25
    	on-create [
            face/extra: object [
            	fSize:  face/size
         		bSize:  face/size
         		bSize/x: to-integer fSize/x * 0.1
         		bSize/x: min bSize/x 10
         		bSize/y: to-integer fSize/y * 0.8
         		yOffset:  fSize/y / 2 - (bSize/y / 2) * 2
         		xyoff: as-pair 2 yOffset	
         		;face/text: face/text
         		bColor:  face/color
				;--off state draw
                bOff: draw fSize compose [
                	fill-pen snow box (xyoff) (bSize)
                ]
                ;--on state draw
                bOn: draw fSize compose [
                	fill-pen bColor box (xyoff) (bSize) 
                ]
                ;--click event
                bClick: func [face][     
                    either face/data = 0 [
                    	face/data: 1 face/image: face/extra/bOn
                    	][face/data: 0 face/image: face/extra/bOff]
                ]
        	]
        	face/color: snow
            face/data: 0
            face/image: face/extra/bOff
    ]
    
    space 10x10
    below
    cToggle green 100x25	"Toggle 1" [face/extra/bClick face]
    cToggle red   100x25	"Toggle 2" [face/extra/bClick face]
    cToggle blue  100x100	"Toggle 3" [face/extra/bClick face]
    cToggle cyan  100x150	"Toggle 4" [face/extra/bClick face]
    button 100 "Quit" [Quit]
]

view win