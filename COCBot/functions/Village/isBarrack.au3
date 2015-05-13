;Checks for your Barrack, Dark Barrack or Spell Factory

Func isBarrack()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(218, 294,"Y"), Hex(0xBBBBBB, 6), 10) Or _ColorCheck(_GetPixelColor(217, 297,"Y"), Hex(0xF8AD20, 6), 10) Then
		Return True
	EndIf
	Return False
EndFunc   ;==>isBarrack

Func isDarkBarrack()
	;_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(639, 456,"Y"), Hex(0xD7DBC8, 6), 10) Or _ColorCheck(_GetPixelColor(526, 419,"Y"), Hex(0xC9CCBB, 6), 10) Then
		Return True
	EndIf
	Return False
EndFunc   ;==>isDarkBarrack

Func isSpellFactory()
	;_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(717, 440,"Y"), Hex(0x8F8D7E, 6), 10) Or _ColorCheck(_GetPixelColor(211, 324,"Y"), Hex(0x0830E8, 6), 10) Then
		Return True
	EndIf
	Return False
EndFunc   ;==>isSpellFactory
