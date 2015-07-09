; #FUNCTION# ====================================================================================================================
; Name ..........: CheckHeroesHealth
; Description ...:
; Syntax ........: CheckHeroesHealth()
; Parameters ....:
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func CheckHeroesHealth()

	If $debugSetlog = 1 Then
		Setlog(" CheckHeroesHealth started ")
		_CaptureRegion()
		Local $color1 = _GetPixelColor(68 + (72 * $King), 572)
		Local $color2 = _GetPixelColor(68 + (72 * $Queen), 572)
	EndIf

	If $checkKPower Then
		If $debugSetlog = 1 Then Setlog(" _GetPixelColor : " & $color1)
		If not _ColorCheck(_GetPixelColor(68 + (72 * $King), 572, True), Hex(0x4FD404, 6), 120, "Heroes") Then ; At Start RGB - B is 03

			SetLog("King is getting weak, Activating King's power", $COLOR_BLUE)
			SelectDropTroop($King)
			$checkKPower = False
		EndIf
	EndIf
	If $checkQPower Then
		If $debugSetlog = 1 Then Setlog(" _GetPixelColor : " & $color2)
		If not _ColorCheck(_GetPixelColor(68 + (72 * $Queen), 572, True), Hex(0x72F50B, 6), 120, "Heroes") Then ; In the middle RGB - B is 150
			SetLog("Queen is getting weak, Activating Queen's power", $COLOR_BLUE)
			SelectDropTroop($Queen)
			$checkQPower = False
		EndIf
	EndIf
EndFunc   ;==>CheckHeroesHealth
