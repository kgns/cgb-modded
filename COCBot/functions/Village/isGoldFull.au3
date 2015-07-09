
; #FUNCTION# ====================================================================================================================
; Name ..........: isGoldFull
; Description ...: Checks if your Gold Storages are maxed out
; Syntax ........: isGoldFull()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #57 (send more bananas please!)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func isGoldFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(658, 33), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(660, 33), Hex(0xD4B100, 6), 6) Then ;Hex if color of gold (orange)
			SetLog("Gold Storages are full!", $COLOR_GREEN)
			Return True
		EndIf
	EndIf

	Return False
EndFunc   ;==>isGoldFull