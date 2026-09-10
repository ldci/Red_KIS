#!/usr/local/bin/red-cli
Red [
	author: @ldci
]
do %basicStats.red				;--our tools

print-horizontal-line: does [
	s: copy ""
	append/dup s "-" 80
	print s
]

v1: make vector! [integer! 32 [0 1 2 3 4 5 6 7 8 9]]
v2: make vector! [integer! 32 [10 11 12 13 14 15 16 17 18 19]]
v3: make vector! [integer! 32 [-5 2 -3 2 -3 3 -4 1 -1 2]] ;--difference of 2 vectors 

n1: to float! (length? v1)
n2: to float! (length? v2)
n3: to float! (length? v3)
sd1: deviation/sample-sd v1
sd2: deviation/sample-sd v2
sd3: deviation/sample-sd v3

print-horizontal-line
;--1 sample
mu: 5
print "One sample"
print ["t  = " t: absolute (mean v1 - mu) / (sd1 / sqrt n1)]
print ["df = " n1 - 1]
print ["p  =  0.005 Non significant"]
print-horizontal-line


;--paired
print "Paired"
print ["t  = " t: absolute (mean v3 - 0) / (sd3 / sqrt n3)]
print ["df = " n3 - 1]
print ["p  =  0.005 Non significant"]
print-horizontal-line

;--independent samples
print "Two independent samples"
print ["t  = " t: absolute (mean v1 - mean v2) / sqrt((sd1 ** 2 / n1) + (sd2 ** 2 / n2))]
print ["df = " n1 + n2 - 2]
print ["p  =  0.001 Significant"]

print-horizontal-line

;-- for t-table reading uncomment the next line
;browse https://www.sjsu.edu/faculty/gerstman/StatPrimer/t-table.pdf
;--for a nice open-source statistical tool: https://jasp-stats.org
