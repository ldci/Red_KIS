#!/usr/local/bin/red-cli
Red [ 
	author: @ldci
]

minmax: func  [
	"Compute [min max] pair along values"
	values [block! vector!]
][
	sample: sort copy values
	reduce [first sample last sample]
]

_mean: func    [
	"Calculates the mean value of a series"
	values [block! vector!] 
][
	sample: copy values
	sum sample / (length? sample)
]

mean: func    [
	"Calculates the mean value of a series"
	values [block! vector!] 
][
	sigma: 0.0
	foreach v values [sigma: sigma + v]
	sigma / (length? values)
]

median: func   [
	"from @@hiiamboris. Returns the sample median"
	values [block! vector!]
][
    sample: sort copy values
    n: length? sample
    case [
    	odd?  n [pick sample n + 1 / 2]
    	even? n [(pick sample n / 2) + (pick sample n / 2 + 1) / 2]
    	zero? n [none]
    ]
]

mode: func   [
	"Calculates modal value of a series. Must be improved for bi or multi modal"
	values [block! vector!]
][
	sample: sort copy values
	n: length? sample
	counter: copy []
	i: count: 1
	key2: sample/(i + 1)	
	while [not none? key2] [
		key1: sample/(i) key2: sample/(i + 1)					;--test keys
		either key1 == key2 
			[count: count + 1]											;--increment count
			[append/only counter reduce [count key1] count: 1] 	;--new entry with count = 1
		i: i + 1 
	]
	second last sort counter
]

variance: func [
	"Calculates the variance of a series"
	values [block! vector!] 
][
	mu: mean values			;--Red
	sigma: 0.0
	foreach v values [sigma: sigma + (v - mu ** 2)]
	sigma / (length? values)
]

deviation: func [
	"Calculates the standard deviation of a series"
	values [block! vector!] 
	/population-sd
	/sample-sd 	
][
	mu: mean values			;--Red
	sigma: 0.0
	foreach v values [sigma: sigma + (v - mu ** 2)]
	if population-sd [return sqrt sigma / (length? values)]
	if sample-sd [return sqrt sigma / ((length? values) - 1)]
]

comment [
vect: make vector! [float! 64 [1.62 1.72 1.64 1.7 1.78 1.64 1.65 1.64 1.66 1.74]]
probe vect
print ["Length:   " length? vect]
print ["Mean:     " mean vect]
print ["Mode:     " mode vect]
print ["Median:   " median vect]
print ["Sum:      " sum vect]
print ["Minimum:  " mini: first minmax vect]
print ["Maximum:  " maxi: second minmax vect]
print ["Range:    " maxi - mini]
print ["Variance: " round/to variance vect 0.001]
print ["Deviation:" round/to deviation/population-sd vect 0.001]
print ["Deviation:" round/to deviation/sample-sd vect 0.001]
]



