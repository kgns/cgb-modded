;Checks for your Barrack, Dark Barrack or Spell Factory

Func isBarrack()
	;-----------------------------------------------------------------------------
	;If _ColorCheck(_GetPixelColor(218, 294, True), Hex(0xBBBBBB, 6), 10) Or _ColorCheck(_GetPixelColor(217, 297, True), Hex(0xF8AD20, 6), 10) Then
	;	Return True
	;EndIf
	;If _ColorCheck(_GetPixelColor(217, 318, True), Hex(0xFFBD21, 6), 20)  Then 		Return True
	If _ColorCheck(_GetPixelColor(235, 565, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Barrack1 selected")
		Return True ;barrack1
		EndIf
	If _ColorCheck(_GetPixelColor(295, 565, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Barrack2 selected")
		Return True ;barrack2
		EndIf
	If _ColorCheck(_GetPixelColor(355, 565, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Barrack3 selected")
		Return True ;barrack3
		EndIf
	If _ColorCheck(_GetPixelColor(415, 565, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Barrack4 selected")
		Return True ;barrack4
		EndIf
	if $debugSetlog = 1 then SetLog("This is not a Barrack")
	Return False
EndFunc   ;==>isBarrack

Func isDarkBarrack()
	;_CaptureRegion()
	;-----------------------------------------------------------------------------
	;	If _ColorCheck(_GetPixelColor(639, 456, True), Hex(0xD7DBC8, 6), 10) Or _ColorCheck(_GetPixelColor(526, 419, True), Hex(0xC9CCBB, 6), 10) Then
	;	Return True
	;EndIf
	;If _ColorCheck(_GetPixelColor(219, 347, True), Hex(0x4884B0, 6), 20)  Then 		Return True ;dark barrack1
	If _ColorCheck(_GetPixelColor(505, 565, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Dark Barrack1 selected")
		Return True ;dark barrack1
		EndIf
	If _ColorCheck(_GetPixelColor(565, 565, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Dark Barrack2 selected")
		Return True ;dark barrack2
		EndIf
	if $debugSetlog = 1 then SetLog("This is not a Dark Barrack")
	Return False
EndFunc   ;==>isDarkBarrack

Func isSpellFactory()
	;_CaptureRegion()
	;-----------------------------------------------------------------------------
	;If _ColorCheck(_GetPixelColor(717, 440, True), Hex(0x8F8D7E, 6), 10) Or _ColorCheck(_GetPixelColor(211, 324, True), Hex(0x0830E8, 6), 10) Then
	;	Return True
	;EndIf
	If _ColorCheck(_GetPixelColor(640, 530, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Spell FactoryDark  selected")
		Return True ;Spell Factory
		EndIf
Return True ;Spell
	If _ColorCheck(_GetPixelColor(700, 530, True), Hex(0xeceee8, 6), 10)  Then
		if $debugSetlog = 1 then SetLog("Dark Spell Factory  selected")
		Return True ;dark Spell Factory
		EndIf
	Return False
EndFunc   ;==>isSpellFactory
