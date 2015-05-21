; #FUNCTION# ====================================================================================================================
; Name ..........: CheckTombs.au3
; Description ...: This file Includes function to perform defense farming.
; Syntax ........:
; Parameters ....: None
; Return values .: False if regular farming is needed to refill storage
; Author ........: barracoda/KnowJack (2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func CheckTombs()

	Local $TombX, $TombY
	$tomb = @ScriptDir & "\images\tomb.png"
	If Not FileExists($tomb) Then Return False
	$TombLoc = 0
	_CaptureRegion()
	If _Sleep(500) Then Return
	For $TombTol = 0 To 12
		If $TombLoc = 0 Then
			$TombLoc = _ImageSearch($tomb, 1, $TombX, $TombY, $TombTol) ; Getting Tree Location
			If $TombLoc = 1 And $TombX > 35 And $TombY < 610 Then
				SetLog("Found tombstone, Removing...", $COLOR_GREEN)
				Click($TombX, $TombY)
				If _Sleep(2000) Then Return
				Click(1, 1) ; click away
				If _Sleep(500) Then Return
				Return True
			EndIf
		EndIf
	Next
	SetLog("Cannot find tombstone, moving on...", $COLOR_RED)

EndFunc   ;==>CheckTombs
