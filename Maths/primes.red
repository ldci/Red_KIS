#!/usr/local/bin/red-cli
Red [
]
;--by Galen Ivanov: very nice

prime-sieve: function [
    "Finds the prime numbers less then or equal to n"
    n [integer!] "upper limit" 
][
    primes: make block! []; n / log-e n
    append primes 2
    ;--make odd values
    i: 1
    odd-n: collect/into [
        while [n >= i: i + 2] [keep i]
    ] make block! [] n / 2
	
    while [not empty? odd-n] [
        append primes prime: take odd-n				;--take first element
        remove-each odd odd-n [zero? odd % prime]	;--select prime values 
    ]
    primes
]

print prime-sieve 200