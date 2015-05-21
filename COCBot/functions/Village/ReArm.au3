;==>ReArm
Func ReArm()
	Global $Rearm = $ichkTrap = 1
	If $Rearm = False Then Return
	Local $y = 562

	SetLog("Checking if Village needs Rearming..", $COLOR_BLUE)

	If $TownHallPos[0] = -1 Then
		LocateTownHall()
		SaveConfig()
		If _Sleep(1000) Then Return
	EndIf

	Click(1, 1) ; Click away
	If _Sleep(1000) Then Return
	Click($TownHallPos[0], $TownHallPos[1] + 5)
	If _Sleep(1000) Then Return

	;Traps
	Local $offColors[3][3] = [[0x887d79, 24, 34], [0xF3EC55, 69, 7], [0xECEEE9, 77, 0]] ; 2nd pixel brown wrench, 3rd pixel gold, 4th pixel edge of button
	Global $RearmPixel = _MultiPixelSearch2(240, $y, 670, 600, 1, 1, Hex(0xF6F9F2, 6), $offColors, 30) ; first gray/white pixel of button
	If IsArray($RearmPixel) Then
		If $debugSetlog = 1 Then Setlog (" traps" )
		Click($RearmPixel[0]+ 20, $RearmPixel[1] + 20) ; Click RearmButton
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Rearmed Traps", $COLOR_GREEN)
		EndIf
	EndIf

	;Xbow
	Local $offColors[3][3] = [[0x8F4B9E, 19, 20], [0xFB5CF4, 70, 7], [0xF0F1EC, 77, 0]]; xbow, elixir, edge
	Local $XbowPixel = _MultiPixelSearch2(240, $y, 670, 600, 1, 1, Hex(0xF4F7F0, 6), $offColors, 30) ; button start
	If IsArray($XbowPixel) Then
		If $debugSetlog = 1 Then Setlog (" xbow" )
		Click($XbowPixel[0] + 20, $XbowPixel[1] + 20) ; Click XbowButton
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Reloaded X-Bows", $COLOR_GREEN)
		EndIf
	EndIf

	;Inferno
	Local $offColors[3][3] = [[0x8D7477, 19, 20], [0x574460, 70, 7], [0xF0F1EC, 77, 0]]; inferno, dark, edge
	Global $InfernoPixel = _MultiPixelSearch2(240, $y, 670, 600, 1, 1, Hex(0xF4F7F0, 6), $offColors, 30)
	If IsArray($InfernoPixel) Then
		If $debugSetlog = 1 Then Setlog (" Inferno " )
		Click($InfernoPixel[0] + 20, $InfernoPixel[1] + 20) ; Click InfernoButton
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
			Click(515, 400)
			If _Sleep(500) Then Return
			SetLog("Reloaded Infernos", $COLOR_GREEN)
		EndIf
	EndIf

	Click(1, 1) ; Click away

EndFunc   ;==>ReArm