Red [
    title: "Image OCR to Speech"
    author: "ldci and Sensei"
]

;--version including voice speed 
;--red-cli ocr-speak2.red images/francais.jpg fra Thomas 200
args: system/options/args
either empty? args [
    print "Usage: red ocr-speak.red <image.png> [lang_ocr] [voix] [vitesse]"
    print "Exemple: red ocr-speak.red scan.png fra Thomas 200"
][
    img: args/1
    lang: any [args/2 "eng"]          
    voice: any [args/3 "Alex"]  
    rate: any [args/4 ""]        ; ex: 200 (mots/min)

    ; 1. OCR vers la mémoire
    cmd-ocr: rejoin ["tesseract " img " stdout -l " lang]
    call/output/wait cmd-ocr txt: copy ""

    ; 2. Lecture vocale avec surbrillance
    if not empty? trim txt [
        safe-txt: replace/all copy txt {"} {\"}
        cmd-tts: rejoin [
            "say -v " voice 
            either empty? rate [""] [rejoin [" -r " rate]] 
            " --interactive=/red " {"} safe-txt {"}
        ]
        call/console cmd-tts
    ]
]