#!/usr/local/bin/red-view
Red [
	Title:   "Draw Image Resizing Test"
	Author:  [REBOL version "Carl Sassenrath" Red port "Gregg Irwin"]
	Version: 0.0.1
	Needs:   View
]

;--Adapted to Red 0.6.5 with point2D! (ldci)

;ii Red is very flexible, allowing you to structure your code in
;ii many different ways. While it's almost never a good idea to
;ii write "clever" code, it can be very powerful to write code 
;ii that leverages context and minimizes the number of things you
;ii have to keep in your head. 


;ii Part of Red's heritage comes from the Forth language. A core
;ii idea in forth is to write small programs where you build up a
;ii vocabulary that is specific to your needs. That is, you define
;ii a lot of little words and phrases that you then use to write
;ii the rest of the program.

;ii Here we have 3 different distance functions, each working at
;ii a slightly higher level of abstraction. The first is distance
;ii from absolute 0, the second the distance between two points,
;ii and the third, the distance from a grab handle's offset. It
;ii won't be clear on a first, sequential reading how the last one
;ii works, because you don't know what a handle or its position
;ii index are. This points out another important aspect when 
;ii reading Red. Because it's easy to refactor things as you work
;ii on them, you can't expect that the code was written in straight
;ii line order as you see it. It was very likely reworked a number
;ii of times as the author learned more. As they say, good writing
;ii is rewriting.

distance: func ["Distance from a 0x0 offset" pos [pair! point2D!]][
	square-root add pos/x ** 2 pos/y ** 2
]

dist-between: function [a [pair! point2D!] b [pair! point2D!]][distance a - b]

dist-from-handle: func [pos [pair! point2D!] handle [block!]][
	dist-between pos handle/:IDX_G_POS
]

;ii Now we have a few things related to determining if the mouse is
;ii over a grab handle. Notice how each piece builds on the one
;ii before, abstracting more details, until finally we have a single
;ii function that can return an actual grab handle given only the 
;ii position where a mouse event occurred.

grab-size: 5									; The size of our grab handles

hit?: func [dist] [dist <= grab-size]

hit-handle?: func [pos handle] [hit? dist-from-handle pos handle]

d-grab-tl: none		; top-left grab handle
d-grab-br: none		; bottom-right grab handle

;!! If you add more grab handles, you'll need to update this.
all-grab-handles: does [reduce [d-grab-tl d-grab-br]]

grab-hit: func [
	"Return the grab handle at position; none if no handle there."
	pos [pair! point2D!]
][
	;ii There is no z-order handling for overlapping handles in this
	;ii simple demo. The first handle we find that gets a hit wins.
	foreach handle all-grab-handles [
		if hit-handle? pos handle [return handle]
	]
]

draw-idx-from-handle: func [
	"Map a grab handle to the TL/BR position for the image in the draw block."
	handle
][
	select/only reduce [
		d-grab-tl IDX_I_TL
		d-grab-br IDX_I_BR
	] handle
]

;ii They can also click and drag the image itself.

image-size: does [d-img/:IDX_I_BR - d-img/:IDX_I_TL]

image-hit-pos: func [
	"Return the position where the image was hit; none if no hit."
	pos [pair! point2D!]
][
	if within? pos d-img/:IDX_I_TL image-size [pos]
]

;ii Mouse event handling area.

grabbed-handle: none							; The handle the user grabbed. May be NONE.
drag-image-start: none							; Pos where they started an image drag from. May be NONE.

mouse-down: func [event][
	if not grabbed-handle: grab-hit event/offset [
		drag-image-start: image-hit-pos event/offset
	]
]

mouse-up: func [event][
	grabbed-handle: none
	drag-image-start: none
]

;ii See https://github.com/red/red/wiki/Red-View-Graphic-System#events
;ii for more information on events.
mouse-move: function [event][
	if drag-image-start [
		delta: event/offset - drag-image-start
		d-img/:IDX_I_TL: d-img/:IDX_I_TL + delta
		d-img/:IDX_I_BR: d-img/:IDX_I_BR + delta
		; Need to move our grab handles too
		d-grab-tl/:IDX_G_POS: d-grab-tl/:IDX_G_POS + delta
		d-grab-br/:IDX_G_POS: d-grab-br/:IDX_G_POS + delta
		;ii FUNCTION captures local words, so we need to use SET here,
		;ii or change to FUNC with /LOCAL words declared.
		set 'drag-image-start event/offset
		;ii See https://github.com/red/red/wiki/Red-View-Graphic-System#event-flow
		;ii for more information about event handler return values.
	    return 'done
	]
	; If grabbed-handle is set, it means they moused down on a grab handle
	; and are now dragging.
	if grabbed-handle [
		;ii In this case, we don't need to check event/down? because 
		;ii grabbed-handle is used to track the mouse down state, by
		;ii clearing it on mouse up. You could remove the mouse-up handler
		;ii and use event/down? check instead, depending on your needs.
		;if event/down? [
			;ii There is more than one way to do some things in Red. In 
			;ii addition to using path notation to update a value in a
			;ii series, you can use POKE to change a value at an index.
			;ii Sometimes that is more convenient than setting a temp
			;ii word to a value, or cleaner looking than using a paren!
			;ii as a path segment. The paren approach is also shown here.
			poke d-img draw-idx-from-handle grabbed-handle event/offset
			;d-img/(draw-idx-from-handle grabbed-handle): event/offset
			
			;ii Path notation is very flexible. Here you can see how a
			;ii word referring to the index we want to change is used.
			;ii By prefixing it with a colon, it becomes a get-word!,
			;ii which the path evaluator knows to dereference. But there
			;ii is also a colon at the end, so Red sees the the whole
			;ii thing as a set-path! value, and updates the target series.
			grabbed-handle/:IDX_G_POS: event/offset
		;]
	]
	; Whether or not a handle was grabbed, we want to set their color
	; based on if the mouse is over them or not.
	either over-handle: grab-hit event/offset [
		; Set the grab handle under the mouse to an active color.
		over-handle/:IDX_G_FILL: green
	][
		; The mouse isn't over a grab handle. Set them all to default color.
		d-grab-tl/:IDX_G_FILL: d-grab-br/:IDX_G_FILL: yellow
	]
]


;img-url: https://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png
;img-url: https://pbs.twimg.com/profile_images/501701094032941056/R-a4YJ5K.png
;img: load/as read/binary img-url 'jpeg
img: load %mandrill.jpg


;-------------------------------------------------------------------------------
;ii This may actually be the most important part of the program, because
;ii it is the primary data structure, along with key global variables,
;ii that everything revolves around. Not only that, it defines the bulk
;ii of the user interface from a user's persepctive.
;ii
;ii Here's how it works. In the code above you saw references to things
;ii like d-img and IDX_G_POS, those are set here, and all refer to the
;ii block of drawing commands used to paint the main canvas, including
;ii the image and grab handles. The set-word! values in the draw block
;ii become references to those *positions* in the draw block, and the
;ii IDX_* words refer to index offsets from those known positions. As
;ii the user clicks and drags, all we do is change values in this block
;ii of commands (offsets and colors) and let Red's View system re-render.
;-------------------------------------------------------------------------------

draw-blk: compose [
	d-img:     image img 100x100 (50x50 + img/size)
	d-grab-tl: fill-pen yellow circle 100x100 (grab-size)
	d-grab-br: fill-pen yellow circle (50x50 + img/size) (grab-size)
]

IDX_I_IMG:	2	; _I_ = image in canvas draw block
IDX_I_TL:	3	; top-left
IDX_I_BR:	4	; bottom-right
IDX_G_FILL:	2	; Grab handle color
IDX_G_POS:	4	; Grab handle center


;ii Finally, the UI.
view [
	title "Draw Image Resizing Test"
	;ii The alignment here is not important to Red at all, only human readers.
	backdrop water
	text water  middle font-color white  "Red resize image test"
	text water  middle font-color yellow "Drag the grab handles or the image itself"
	button "Quit" [quit]
	return
	;ii This is where we set canvas to refer to the block of DRAW commands.
	canvas: base 960x720 water all-over draw draw-blk
		on-down [mouse-down event]
		on-up   [mouse-up   event]
		on-over [mouse-move event]
]
