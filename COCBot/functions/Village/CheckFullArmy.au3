;Checks if red pixel located in the popup baracks window is available

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