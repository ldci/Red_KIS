#!/usr/local/bin/red-cli
Red [
	Author:  "ldci"
	File: 	 %os.red
]
print ["OS: " OS: system/platform]
print ["Red version: " system/version]

if any [OS = 'macOS OS = 'Linux ] [home: select list-env "HOME"] 
if any [OS = 'MSDOS OS = 'Windows][home: select list-env "USERPROFILE"]
print ["User home: " home]

