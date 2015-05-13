Func RequestCC()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		If $aCCPos[0] = -1 Then
			LocateClanCastle()
			SaveConfig()
			If _Sleep(1000) Then Return
		EndIf

		SetLog("Requesting Clan Castle Troops", $COLOR_BLUE)
		Click($aCCPos[0], $aCCPos[1])
		If _Sleep(1000) Then Return
		_CaptureRegion()
		$RequestTroop = _PixelSearch(310, 580, 553, 622, Hex(0x608C90, 6), 10)
		If IsArray($RequestTroop) Then
			Click($RequestTroop[0], $RequestTroop[1])
			If _Sleep(1000) Then Return
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(340, 245), Hex(0xCC4010, 6), 20) Then
				If $sTxtRequest <> "" Then
					Click(430, 140) ;Select text for request
					If _Sleep(1000) Then Return
					ControlSend($Title, "", "", $sTxtRequest, 0)
				Else
					Click(430, 140) ;Select text for request, default request text of the game will be sent by making box empty
				EndIf
				If _Sleep(1000) Then Return
				Click(524, 228)
				If _Sleep(2000) Then Return
				;Click(340, 228)
			Else
				SetLog("Request has already been made", $COLOR_RED)
				Click(1, 1, 2)
			EndIf
		Else
			SetLog("Join a clan to donate troops", $COLOR_RED)
		EndIf
	EndIf
EndFunc   ;==>RequestCC
