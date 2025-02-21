#!/usr/local/bin/red-view
Red [
	Title:   "Test camera Red VID "
	Author:  "ldci"
	File: 	 %cam.red
	Needs:	 View
]
cam: none 				;--for camera object
camSize: 1280x720 		;--default Apple FaceTime Camera size (macBook Pro)
iSize: camSize / 2		;--reduce size by 2
margins: 10x10

view win: layout [
		title "Red Camera"
		origin margins space margins
		style cToggle: base 80x25
    	on-create [
            face/extra: object [
            	fSize: bSize: face/size
            	;--calculate box size and offset
         		bSize/x: to-integer fSize/x * 0.25
         		bSize/x: min bSize/x 10						;--max x size: 10 or less
         		bSize/y: to-integer fSize/y * 0.90
         		yOffset:  fSize/y / 2 - (bSize/y / 2) * 2
         		xyoff: as-pair 2 yOffset	
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
                	switch face/data [
                		0 [face/data: 1 face/image: face/extra/bOn]
                		1 [face/data: 0 face/image: face/extra/bOff]
                	]    
                ]
        	]
        	;--style default values
        	face/color: snow
            face/data: 0
            face/image: face/extra/bOff
    	]
    	
		cam: camera iSize
		return
		cam-list: drop-list 220 on-create [face/data: cam/data]
		ctoggle green 70x25 "Start" false  [
			face/extra/bClick face
			either cam/selected [cam/selected: none face/text: "Start"]
								[cam/selected: cam-list/selected  face/text: "Stop"]	
		] 		
		pad 275x0 button "Quit" 50 [quit]
		do [cam-list/selected: 1 cam/selected: none]
]