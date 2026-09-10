#!/usr/local/bin/red-cli
Red [ 
] 
{put system/codecs 'json context [
    Title:     "JSON codec"
    Name:      'JSON
    Mime-Type: [application/json]
    Suffixes:  [%.json]
    encode: func [data [any-type!] where [file! url! none!]] [
        to-json data
    ]
    decode: func [text [string! binary! file!]] [
        if file? text [text: read text]
        if binary? text [text: to string! text]
        load-json text
    ]
]}


f: %test1.json
;jsonFile: load-json f		;--Script error: load-json does not allow #(file!) for its input argument
jsonFile: read f			;--read file as a string
map: load-json jsonFile		;--json string -> rebol map object
keys: keys-of map			;--a block of keys
values: values-of map		;--a block of values 
n: length? keys
repeat i n [print [keys/:i values/:i]]
print to-json map
save %test.json map			;--save map as json file

m: #[name "Paul" age 35 city "Paris"]
print to-json m
;save %test.json m

blk: [name "Pierre" age 40 city "Rouen"]
print to-json to-map blk

;--Arrays in objects
m: #[name "John" age: 50 cars ["Ford" "BMW" "Fiat"]]
probe m
print to-json m
;save %test.json m
