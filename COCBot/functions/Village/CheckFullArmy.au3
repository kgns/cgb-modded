;Checks if red pixel located in the popup baracks window is available

; #FUNCTION# ====================================================================================================================
; Name ..........: CheckFullArmy
; Description ...:
; Syntax ........: CheckFullArmy()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #18
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func CheckFullArmy()
	_CaptureRegion()
	$Pixel = _ColorCheck(_GetPixelColor(327, 520), Hex(0xD03838, 6), 20)
	if not $Pixel then
		if _sleep(200) then return
		_CaptureRegion()
		$Pixel = (_ColorCheck(_GetPixelColor(653, 247), Hex(0xE0E4D0, 6), 20) AND Not _ColorCheck(_GetPixelColor(475, 214), Hex(0xE0E4D0, 6), 20))
	endif
	If $Pixel Then
		$fullArmy = True
	ElseIf _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 1 Then
		$fullArmy = False
	EndIf
EndFunc   ;==>CheckFullArmy