
; #FUNCTION# ====================================================================================================================
; Name ..........: isElixirFull
; Description ...: Checks if your Elixir Storages are maxed out
; Syntax ........: isElixirFull()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #34 (yes, the good looking one!)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func isElixirFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(658, 84), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(660, 84), Hex(0xAE1AB3, 6), 6) Then ;Hex if color of elixir (purple)
			SetLog("Elixir Storages are full!", $COLOR_GREEN)
			Return True
		EndIf
	EndIf

	Return False
EndFunc   ;==>isElixirFull