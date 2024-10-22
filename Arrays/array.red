#!/usr/local/bin/red-cli
Red [
]
a1: [1 2 3 4 5 6]

print "1D Array"
probe a1
print  ["Elements number: " form length? a1]

a2: [
	[1 2]
	[3 4]
	[5 6]
]
print "2D: 3x2 Array"
probe a2
print rejoin ["Lines number:   " form length? a2]
print rejoin ["Columns number: " form (length? a2/1)]

print "3D: 3x2x3 Array"
a3: [
	[1 [1 2 3] 2 [31 32 33]]
	[3 [4 5 6] 4 [41 42 43]]
	[5 [7 8 9] 5 [51 52 53]]
]
probe a3
print rejoin ["Cells number:   " form length? a3/1/2]
print rejoin ["Lines number:   " form length? a3]
print rejoin ["Columns number: " form (length? a3/1) / 2]
print "Reading cell values"
print a3/1/4/1 ;Line 1 col 2 Element 1
print a3/2/4/2 ;Line 2 col 2 Element 2
print a3/3/4/3 ;Line 3 col 2 Element 3

nBins: 16
array: copy []
append/only array make vector! nBins 
append/only array make vector! nBins 
append/only array make vector! nBins
print "Array of vectors"
probe array

