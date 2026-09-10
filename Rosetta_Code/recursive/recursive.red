#! /usr/local/bin/red-cli
Red [
	Title:		"Red Tests: Recursivity"
	Author:		"F. Jouen & D. Cadieu"
	License:    "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
]


; from rosettacode.org (Didier Cadieu)

table: [1000 M 900 CM 500 D 400 CD 100 C 90 XC 50 L 40 XL 10 X 5 V 4 IV 1 I]
table-r2a: reverse [1000 "M" 900 "CM" 500 "D" 400 "CD" 100 "C" 90 "XC" 50 "L" 40 "XL" 10 "X" 9 "IX" 5 "V" 4 "IV" 1 "I"]
 
to-arabic: func [r [string!] /local a b e] [
	a: 0
	parse r [
		any [
			b: ["I" ["V" | "X" | none] 
			| "X" ["L" | "C" | none] 
			| "C" ["D" | "M" | none] 
			| "V" | "L" | "D" | "M"] 
			e: (a: a + select table-r2a copy/part b e)
		]
	]
	a
]

;--some variants
to-Roman: function [n [integer!] return: [string!]][
    out: copy ""
    foreach [a r] table [while [n >= a][append out r n: n - a]]
    out
]
 
foreach number [40 33 1888 2016][print [number ":" to-Roman number]]

 
to-Roman: func [n [integer!] return: [string!]][
    case [
        tail? table [table: head table copy ""]
        table/1 > n [table: skip table 2 to-Roman n]
        'else       [append copy form table/2 to-Roman n - table/1]
    ]
]
 
foreach number [40 33 1888 2016][print [number ":" to-Roman number]]

to-Roman: function [n [integer!]] reduce [
    'case collect [
        foreach [a r] [1000 M 900 CM 500 D 400 CD 100 C 90 XC 50 L 40 XL 10 X 9 IX 5 V 4 IV 1 I][
            keep compose/deep [n >= (a) [append copy (form r) any [to-Roman n - (a) copy ""]]]
        ]	
    ]
]
 
foreach number [40 33 1888 2016][print [number ":" to-Roman number]]

print [to-arabic "MCMXCIX" ":" to-Roman 1999]



;-- ldci  tests
;--Roman Notation

rvalue: function [c [char!]return: [integer!]][
	switch c [
		 #"M" [v: 1000]
		 #"D" [v: 500]
		 #"C" [v: 100]
		 #"L" [v: 50]
		 #"X" [v: 10]
		 #"V" [v: 5]
		 #"I" [v: 1]
	]
	v
]

;--from Roman to Arabic notation with recursivity
toArabic: function [s [string!] return: [integer!]] [
		nc: length? s 
		either nc = 1 [r: rvalue s/1] [
			n1: rvalue  s/1
			if n1 < rvalue s/2 [n1: negate n1]
			s: next s
			r: n1 + toArabic s
		]
	r
]


repeat i 100  [s: to-Roman i print [i ":" s ":" toArabic s ]]

{
print ["I:" toArabic "I"]
print ["III:" toArabic "III"]
print ["IV:" toArabic "IV"]
print ["V:" toArabic "V"]
print ["VI:" toArabic "VI"]
print ["IX:" toArabic "IX"]
print ["XXI:" toArabic "XXI"]
print ["MCDXC:" toArabic "MCDXC"]
print ["MCMXCIX:" toArabic "MCMXCIX"]
}
