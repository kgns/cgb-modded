Func RequestCC()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		If $aCCPos[0] = -1 Then
			LocateClanCastle()
			SaveConfig()
			If _Sleep(1000) Then Return
		EndIf

		SetLog("Requesting Clan Castle Troops", $COLOR_BLUE)
		Click($aCCPos[0], $aCCPos[1])
		If _Sleep(600) Then Return
		$aRequestTroop = _PixelSearch(310, 580, 553, 622, Hex(0x608C90, 6), 10)
		If IsArray($aRequestTroop) Then
			If $debugSetlog = 1 Then Setlog("Requestpixel: (" & $aRequestTroop[0] & "," & $aRequestTroop[1] & ")")

			_CaptureRegion($aRequestTroop[0], $aRequestTroop[1] - 35, $aRequestTroop[0] + 15, $aRequestTroop[1])
			If _ColorCheck(_GetPixelColor(7, 8), Hex(0xD3EC74, 6), 20) Then ;check for gem on Request button
				SetLog("Request has already been made", $COLOR_RED)
				Click(1, 1, 2)
			ElseIf _ColorCheck(_GetPixelColor(0, 8), Hex(0xFAFAFA, 6), 30) Then ;check for full on Request button
				SetLog("Your Clan Castle is already full", $COLOR_GREEN)
				Click(1, 1, 2)
			Else
				Click($aRequestTroop[0], $aRequestTroop[1]) ; click Request button
				If _Sleep(600) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(340, 245), Hex(0xCC4010, 6), 20) Then
					If $sTxtRequest <> "" Then
						Click(430, 140) ;Select text for request
						If _Sleep(250) Then Return
						ControlSend($Title, "", "", $sTxtRequest, 0)
					Else
						Click(430, 140) ;Select text for request, default request text of the game will be sent by making box empty
					EndIf
					If _Sleep(600) Then Return
					Click(524, 228)
					If _Sleep(1000) Then Return
					;Click(340, 228)
				Else
					SetLog("Unable to request, or request has already been made", $COLOR_RED)
					Click(1, 1, 2)
				EndIf
			EndIf
		Else
			SetLog("Join a clan to donate troops", $COLOR_RED)
		EndIf
	EndIf
EndFunc   ;==>RequestCC
