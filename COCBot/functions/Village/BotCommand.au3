; There are Commands to Shutdown, Sleep, Halt Attack and Halt Training mode

Func BotCommand()
	If GUICtrlRead($chkBotStop) = $GUI_CHECKED Then
	   $itxtMaxTrophy = GUICtrlRead($txtMaxTrophy)
	   $itxtdropTrophy = GUICtrlRead($txtdropTrophy)
	   $icmbBotCond = _GUICtrlComboBox_GetCurSel($cmbBotCond)
	   $icmbBotCommand = _GUICtrlComboBox_GetCurSel($cmbBotCommand)
	   $icmbHoursStop = _GUICtrlComboBox_GetCurSel($cmbHoursStop)
	   If $icmbBotCond = 13 And $icmbHoursStop <> 0 Then $TimeToStop = $icmbHoursStop*3600000 ; 3600000 = 1 Hours

		Local $TrophyCount = getOther(50, 74, "Trophy")
		Local $TrophyMax = Number($TrophyCount) > Number($itxtMaxTrophy)
		If $TrophyMax Then
			$Trophy = "Max. Trophy Reached!"
		Else
			$Trophy = ""
		EndIf

		Switch $icmbBotCond
			Case 0
				If isGoldFull() And isElixirFull() And $TrophyMax Then $MeetCondStop = True
			Case 1
				If (isGoldFull() And isElixirFull()) Or $TrophyMax Then $MeetCondStop = True
			Case 2
				If (isGoldFull() Or isElixirFull()) And $TrophyMax Then $MeetCondStop = True
			Case 3
				If isGoldFull() Or isElixirFull() Or $TrophyMax Then $MeetCondStop = True
			Case 4
				If isGoldFull() And isElixirFull() Then $MeetCondStop = True
			Case 5
				If isGoldFull() Or isElixirFull() Then $MeetCondStop = True
			Case 6
				If isGoldFull() And $TrophyMax Then $MeetCondStop = True
			Case 7
				If isElixirFull() And $TrophyMax Then $MeetCondStop = True
			Case 8
				If isGoldFull() Or $TrophyMax Then $MeetCondStop = True
			Case 9
				If isElixirFull() Or $TrophyMax Then $MeetCondStop = True
			Case 10
				If isGoldFull() Then $MeetCondStop = True
			Case 11
				If isElixirFull() Then $MeetCondStop = True
			Case 12
				If $TrophyMax Then $MeetCondStop = True
			Case 13
				If $UseTimeStop = -1 Then
				   $UseTimeStop = 1
			    EndIf
				If Round(TimerDiff($sTimer)) > $TimeToStop Then $MeetCondStop = True
		    Case 14
			    $MeetCondStop = True
		EndSwitch

		If $MeetCondStop Then
			If $icmbBotCond <> 4 And $icmbBotCond <> 5 And $icmbBotCond <> 10 And $icmbBotCond <> 11 Then
				If $Trophy <> "" Then SetLog($Trophy, $COLOR_GREEN)
				If _Sleep(500) Then Return
			EndIf
			Switch $icmbBotCommand
				Case 0
					SetLog("Halt Attack, Stay Online/Train/Collect/Donate...", $COLOR_BLUE)
					$CommandStop = 0 ; Halt Attack
					If _Sleep(500) Then Return
				Case 1
					SetLog("Force Shutdown PC...", $COLOR_BLUE)
					If _Sleep(500) Then Return
					Shutdown(5) ; Force Shutdown
					Return True
				Case 2
					SetLog("Sleeping PC...", $COLOR_BLUE)
					If _Sleep(500) Then Return
					Shutdown(32) ; Sleep / Stand by
					Return True
			EndSwitch
		EndIf
	EndIf
	Return False
EndFunc