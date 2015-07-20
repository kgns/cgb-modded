; #FUNCTION# ====================================================================================================================
; Name ..........: CheckFullArmy
; Description ...: Checks for Full army camp status when Training window is open to one of the barracks tabs
; Syntax ........: CheckFullArmy()
; Parameters ....: None
; Return values .: None
; Author ........: Code Monkey #18
; Modified ......: KnowJack (July 2015) Update for July CoC changes
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func CheckFullArmy()

	If _sleep(200) Then Return
	Local $Pixel = _CheckPixel($aArmyCampFull, True)
	If $debugSetlog = 1 Then Setlog ( "Checking for full army [!]" & $Pixel)
;~ 	If Not $Pixel Then
;~ 		If _sleep(200) Then Return
;~ 		$Pixel = (_ColorCheck(_GetPixelColor(653, 247, True), Hex(0x888888, 6), 20) And Not _ColorCheck(_GetPixelColor(475, 214, True), Hex(0xD1D0C2, 6), 20)) ; check for gray button and not empty barrack
;~ 	EndIf
	If $Pixel Then
		$fullArmy = True
	ElseIf $iCmbTroopComp = 1 Then
		$fullArmy = False
	EndIf

EndFunc   ;==>CheckFullArmy
