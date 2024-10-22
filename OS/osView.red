#!/usr/local/bin/red
Red [
	File: 	 %osView.red
]

workstation?: system/view/platform/product = 1
os-version: system/view/platform/version
prin "OS version: "
#switch config/OS [
	Windows [
		print [
			"Windows" switch os-version [
				11.0.0	[pick ["11"			 "11 Server"	 ] workstation?]
				10.0.0	[pick ["10"			 "10 Server"	 ] workstation?]
				6.3.0	[pick ["8.1"		 "Server 2012 R2"] workstation?]
				6.2.0	[pick ["8"			 "Server 2012"	 ] workstation?]
				6.1.0	[pick ["7"			 "Server 2008 R1"] workstation?]
				6.0.0	[pick ["Vista"		 "Server 2008"	 ] workstation?]
				5.2.0	[pick ["Server 2003" "Server 2003 R2"] workstation?]
				5.1.0	["XP"]
				5.0.0	["2000"]
			] 
			"build" system/view/platform/build
		]
	]
	macOS [
		print [
			"macOS" switch os-version and 255.255.0 [
				14.0.0  ["Sonoma"] 		;--64-bit (for the future)
				13.0.0  ["Ventura"] 	;--64-bit (for the future)
				12.0.0  ["Monterey"] 	;--64-bit (for the future)
				11.0.0  ["Big Sur"] 	;--64-bit (for the future)
				10.15.0 ["Catalina"]	;--64-bit (for the future)
				10.14.0	["Mojave"]		;--last 32-bit 
				10.13.0	["High Sierra"]
				10.12.0	["Sierra"]
				10.11.0	["El Capitan"]
				10.10.0	["Yosemite"]
				10.9.0	["Mavericks"]
				10.8.0	["Mountain Lion"]
				10.7.0	["Lion"]
				10.6.0	["Snow Leopard"]
			] os-version
			"build" system/view/platform/build
		]
	]
]
