#!/usr/local/bin/red-cli
Red [
	author: @ldci
]

{Khi2: Compare the efficacy of two drugs acting on the same disease.
The results are recorded in the following table.
		|drug 1 | drug 2
---------------------------
Cure	|44 	|156
---------------------------
No cure	|6		|44
---------------------------
}

;--Test of Khi2 independence
data: [
	[44 156 0] 	;--cure
	[6 44 0]	;--no cure
	[0 0 0]		;--0 for sums
]

;--Calculates marginal sums
data/1/3: data/1/1 + data/1/2	;--by line
data/2/3: data/2/1 + data/2/2	;--by line
data/3/1: data/1/1 + data/2/1	;--by column
data/3/2: data/1/2 + data/2/2	;--by column
data/3/3: data/3/1 + data/3/2	;--total 

probe data 

;--Calculates theoretical staff numbers
e1: data/1/3 * data/3/1 / data/3/3  ;--0K 40
e2: data/1/3 * data/3/2 / data/3/3	;--OK 160
e3: data/3/1 * data/2/3 / data/3/3	;--OK 10
e4: data/3/1 * data/1/3 / data/3/3	;--OK 40

e: reduce [e1 e2 e3 e4]
o: reduce [data/1/1 data/1/2 data/2/1 data/2/2]

k2: 0.0
repeat i 4 [
	k2: k2 + (o/:i - e/:i ** 2 / e/:i)
]
print ""
print ["Khi2 =" k2 "Non significant"]

{The test variable is approximately 2.5, 
while the critical value, for a 5% risk level is 3.84. 
We can therefore reasonably estimate that both drugs are comparable}