Red [
    title: "Image OCR to Speech"
    author: "ldci and Sensei"
]

args: system/options/args
;--red ocr-speak.red mon_image.png fra Thomas
;--red-cli ocr-speak.red images/francais.jpg fra Thomas
;--red-cli ocr-speak.red images/francais.jpg fra Amélie

either empty? args [
    print "Usage: red ocr-speak.red <image.png> [lang_ocr] [voix]"
    print "Exemple: red ocr-speak.red scan.png fra Thomas"
][
	print "ocr call"
    img: args/1
    lang: any [args/2 "eng"]          ; anglais par défaut
    voice: any [args/3 "Alex"]        ; voix par défaut

    ; 1. OCR vers la mémoire
    cmd-ocr: rejoin ["tesseract " img " stdout -l " lang]
    ret: call/output/wait cmd-ocr txt: copy ""
    print ["ocr: " ret]
	print "tts call"
    ; 2. Lecture vocale
    if not empty? trim txt [
        safe-txt: replace/all copy txt {"} {\"}
        ;cmd-tts: rejoin ["say -v " voice " " {"} safe-txt {"}]
        cmd-tts: rejoin ["say -v " voice " " "--interactive=/red " {"} safe-txt {"}]
        ret: call/console cmd-tts
    ]
]