
; #FUNCTION# ====================================================================================================================
; Name ..........: PrepareSearch
; Description ...: Goes into searching for a match, breaks shield if it has to
; Syntax ........: PrepareSearch()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #4
; Modified ......: KnowJack (June 2015) add gem spend check & new shield button search to avoid dropping troop on enemy base
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func PrepareSearch() ;Click attack button and find match button, will break shield

	SetLog("Going to Attack...", $COLOR_BLUE)

	ClickP($aAttackButton, 1, 0, "#0149") ; Click Attack Button
	If _Sleep(1000) Then Return

	ClickP($aFindMatchButton, 1, 0, "#0150");Click Find a Match Button
	If _Sleep(2000) Then Return
	If isGemOpen(True) = True Then
		Setlog(" Not enough gold to start searching.....", $COLOR_RED)
		Click(585, 252,1,0,"#0151") ; Click close gem window "X"
		If _Sleep(1000) Then Return
		Click(822, 32,1,0,"#0152") ; Click close attack window "X"
		If _Sleep(1000) Then Return
		$OutOfGold = 1 ; Set flag for out of gold to search for attack
		Return
	EndIf
	If _Sleep(500) Then Return

	; Old pixel check for break shield button that can find grass on enemy base and drop troop.
	;	If _CheckPixel($aBreakShield, $bCapturePixel) Then
	;		ClickP($aBreakShield);Click Okay To Break Shield
	;	EndIf

	; New button search
	Local $offColors[3][3] = [[0x000000, 144, 0], [0xFFFFFF, 54, 17], [0xFFFFFF, 54, 27]] ; 2nd Black opposite button, 3rd pixel white "O" center top, 4th pixel White "0" bottom center
	Global $ButtonPixel = _MultiPixelSearch(438, 371, 590, 408, 1, 1, Hex(0x000000, 6), $offColors, 25) ; first vertical black pixel of Okay
	If $debugSetlog = 1 Then Setlog("Shield btn clr chk-#1: " & _GetPixelColor(441, 374, True) & ", #2: " & _GetPixelColor(441 + 144, 374, True) & ", #3: " & _GetPixelColor(441 + 54, 374 + 17, True) & ", #4: " & _GetPixelColor(441 + 54, 374 + 27, True), $COLOR_PURPLE)
	If IsArray($ButtonPixel) Then
		If $debugSetlog = 1 Then
			Setlog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_PURPLE) ;Debug
			Setlog("Pixel color found #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 144, $ButtonPixel[1], True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 54, $ButtonPixel[1] + 17, True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 54, $ButtonPixel[1] + 27, True), $COLOR_PURPLE)
		EndIf
		Click($ButtonPixel[0] + 75, $ButtonPixel[1] + 25,1,0,"#0153") ; Click Okay Button
	EndIf

EndFunc   ;==>PrepareSearch


