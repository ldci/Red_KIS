#!/usr/local/bin/red-cli
Red [
	author: @ldci
]

do %basicStats.red				;--our tools

v1: make vector! [integer! 32 [1 4 6 12 12 11 16 9 5 4 3 2 5]]	;--sample 1
v2: make vector! [integer! 32 [1 3 4 4 11 13 10 10 9 5 5 10]]	;--sample 2
v3: make vector! [integer! 32[1 4 6 12 12 11 16 9 5 4 3 2 5 1 3 4 4 11 13 10 10 9 5 5 10]];--population

;--Makes contingence table
data: []
median: median v3 ;--population median

plusM: minusM: 0
foreach v v1 [either v > median [plusM: plusM + 1] [minusM: minusM + 1]]
append/only data reduce [plusM minusM 0]

plusM: minusM: 0
foreach v v2 [either v > median [plusM: plusM + 1] [minusM: minusM + 1]]
append/only data reduce [plusM minusM 0]

append/only data [0 0 0]		;--for lines sums

;--Calculates marginal sums
data/1/3: data/1/1 + data/1/2	;--by line
data/2/3: data/2/1 + data/2/2	;--by line
data/3/1: data/1/1 + data/2/1	;--by column
data/3/2: data/1/2 + data/2/2	;--by column
data/3/3: data/3/1 + data/3/2	;--total 

;--Calculates theoretical numbers
e1: data/1/3 * data/3/1 / data/3/3  
e2: data/1/3 * data/3/2 / data/3/3	
e3: data/3/1 * data/2/3 / data/3/3	
e4: data/3/1 * data/1/3 / data/3/3	
;probe  data

;--Calculates khi2 with 1 degree of freedom 
e: reduce [e1 e2 e3 e4]							;--theoretical values						
o: reduce [data/1/1 data/1/2 data/2/1 data/2/2]	;--observed values

k2: 0.0
repeat i 4 [k2: k2 + (o/:i - e/:i ** 2 / e/:i)]
print ""
print ["Median test =" round/to k2 0.001 "Non Significant"]