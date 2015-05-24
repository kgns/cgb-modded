;Searches for a village that until meets conditions

Func VillageSearch() ;Control for searching a village that meets conditions
    $zapandrunAvoidAttack = 0
	$iSkipped = 0
	$haltSearch = False ; to halt searches after 10 attempts ; Snipe While Train Mod by ChiefM3

	If $Is_ClientSyncError = False Then
		$AimGold = $MinGold
		$AimElixir = $MinElixir
		$AimGoldPlusElixir = $MinGoldPlusElixir
		$AimDark = $MinDark
		$AimTrophy = $MinTrophy
	EndIf

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title))

	If _Sleep(1000) Then Return

	; Check Break Shield button again
	If _ColorCheck(_GetPixelColor(513, 416, True), Hex(0x5DAC10, 6), 50) Then
		Click(513, 416);Click Okay To Break Shield
	EndIf

	Switch $iradAttackMode
		Case 0
			SetLog(_PadStringCenter(" Searching For Dead Bases ", 54, "="), $COLOR_BLUE)
		Case 1
			SetLog(_PadStringCenter(" Searching For Weak Bases ", 54, "="), $COLOR_BLUE)
		Case 2
			SetLog(_PadStringCenter(" Searching For All Bases ", 54, "="), $COLOR_BLUE)
	EndSwitch

	Local $MeetGxEtext = "", $MeetGorEtext = "", $MeetGplusEtext = "", $MeetDEtext = "", $MeetTrophytext = "", $MeetTHtext = "", $icmbTHtext = "", $MeetTHOtext = "", $MeetOnetext = "", $AimTHtext = ""

	SetLog(_PadStringCenter(" SEARCH CONDITIONS ", 50, "~"), $COLOR_BLUE)

	If $chkConditions[0] = 1 Then $MeetGxEtext = "Meet: Gold and Elixir"
	If $chkConditions[3] = 1 Then $MeetGorEtext = "Meet: Gold or Elixir"
	If $chkConditions[6] = 1 Then $MeetGplusEtext = "Meet: Gold + Elixir"
	If $chkConditions[1] = 1 Then $MeetDEtext = ", Dark"
	If $chkConditions[2] = 1 Then $MeetTrophytext = ", Trophy"
	If $chkConditions[4] = 1 Then $MeetTHtext = ", Max TH " & $MaxTH ;$icmbTH
	If $chkConditions[5] = 1 Then $MeetTHOtext = ", TH Outside"

	SetLog($MeetGxEtext & $MeetGorEtext & $MeetGplusEtext & $MeetDEtext & $MeetTrophytext & $MeetTHtext & $MeetTHOtext)

	If $ichkMeetOne = 1 Then SetLog("Meet One and Attack!")

	SetLog(_PadStringCenter(" RESOURCE CONDITIONS ", 50, "~"), $COLOR_BLUE)
	If $chkConditions[4] = 1 Then $AimTHtext = " [TH]:" & StringFormat("%2s", $MaxTH) ;$icmbTH
	If $chkConditions[5] = 1 Then $AimTHtext &= ", Out"

	SetLog("Aim: [G+E]: " & StringFormat("%7s", $AimGoldPlusElixir) & " [G]:" & StringFormat("%7s", $AimGold) & " [E]:" & StringFormat("%7s", $AimElixir) & " [D]:" & StringFormat("%5s", $AimDark) & " [T]:" & StringFormat("%2s", $AimTrophy) & $AimTHtext, $COLOR_BLUE, "Lucida Console", 7.5)

	If $OptBullyMode + $OptTrophyMode + $chkATH > 0 Then
		SetLog(_PadStringCenter(" ADVANCED SETTINGS ", 50, "~"), $COLOR_BLUE)
		Local $YourTHText = "", $AttackTHTypeText = "", $chkATHText = "", $OptTrophyModeText = ""

		If $OptBullyMode = 1 Then
			For $i = 0 To 4
				If $YourTH = $i Then $YourTHText = "TH" & $THText[$i]
			Next
		EndIf

		If $OptBullyMode = 1 Then SETLOG("THBully Combo @" & $ATBullyMode & " SearchCount, " & $YourTHText)

		If $chkATH = 1 Then $chkATHText = "AttackTH"
		If $chkATH = 1 And $AttackTHType = 0 Then $AttackTHTypeText = ", Barch"
		If $chkATH = 1 And $AttackTHType = 1 Then $AttackTHTypeText = ", Attack1:Normal"
		If $chkATH = 1 And $AttackTHType = 2 Then $AttackTHTypeText = ", Attack2:Extreme"
		If $OptTrophyMode = 1 Then $OptTrophyModeText = "THSnipe Combo, " & $THaddtiles & " Tile(s), "
		If $OptTrophyMode = 1 Or $chkATH = 1 Then Setlog($OptTrophyModeText & $chkATHText & $AttackTHTypeText)
	EndIf

    If $OptZapAndRun = 1 Then
      ; Zap & Run requires to know the number of Lightning spells available
	  ; In case there are not enough spells ready, we avoid avoid Zap & Run mode.
	  PrepareAttack(True)
      $LSpell = -1
	  $LSpellQ = 0
      For $i = 0 To 8
        ;############## LSpell Slot and Quantity ###########
        If $atkTroops[$i][0] = $eLSpell Then
		  $LSpell = $i
		  $LSpellQ = Number ($atkTroops[$i][1])
		  ;############## LSpell detection and Quantity ###########
	    EndIf
      Next
	  if $LSpellQ >= $iLSpellQ Then
		 SetLog(_PadStringCenter("Zap & Run active!", 54, "="), $COLOR_BLUE)
	  Else
		 SetLog(_PadStringCenter("Zap & Run NOT active. Not enough spells.", 54, "="), $COLOR_BLUE)
	  Endif
	EndIf

	SetLog(_StringRepeat("=", 50), $COLOR_BLUE)

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNow, $GUI_SHOW)
		GUICtrlSetState($cmbAtkNowDeploy, $GUI_SHOW)
			_GUICtrlComboBox_SetCurSel($cmbAtkNowDeploy, _GUICtrlComboBox_GetCurSel($cmbDeploy))
		GUICtrlSetState($chkAtkNowMines, $GUI_SHOW)
		If GUICtrlRead($chkAttackNearGoldMine) = $GUI_CHECKED OR GUICtrlRead($chkAttackNearElixirCollector) = $GUI_CHECKED OR GUICtrlRead($chkAttackNearDarkElixirDrill) = $GUI_CHECKED Then
			GUICtrlSetState($chkAtkNowMines, $GUI_CHECKED)
		Else
			GUICtrlSetState($chkAtkNowMines, $GUI_UNCHECKED)
		EndIf
		GUICtrlSetState($chkAtkNowLSpell, $GUI_SHOW)
		GUICtrlSetState($chkAtkNowLSpell, GUICtrlRead($chkLightSpell))
		GUICtrlSetState($pic2arrow, $GUI_HIDE)
		GUICtrlSetState($lblVersion, $GUI_HIDE)
	EndIf

	If $Is_ClientSyncError = False Then
		$SearchCount = 0
	EndIf

	While 1
		$bBtnAttackNowPressed = False
		If $iVSDelay > 0 Then
			If _Sleep(1000 * $iVSDelay) Then Return
		EndIf

		If $Restart = True Then Return ; exit func
		GetResources() ;Reads Resource Values
		If $Restart = True Then Return ; exit func
		If $iChkAttackNow = 1 Then
			If _Sleep(1000 * $iAttackNowDelay) Then Return ; add human reaction time on AttackNow button function
		EndIf
		If $bBtnAttackNowPressed = True Then ExitLoop

		If Mod(($iSkipped + 1), 100) = 0 Then
			_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS memory
			If _Sleep(1000) Then Return
			If CheckZoomOut() = False Then Return
		EndIf

		If CompareResources() Then
			If $bBtnAttackNowPressed = True Then ExitLoop
			If $iradAttackMode = 0 Or $iradAttackMode = 1 Then
				If checkDeadBase() Then
					SetLog(_PadStringCenter(" Dead Base Found! ", 50, "~"), $COLOR_GREEN)
					ExitLoop
				EndIf
				Local $msg = "Not a Dead Base"
				If $OptBullyMode = 1 And ($SearchCount >= $ATBullyMode) Then
					If $SearchTHLResult = 1 Then
						SetLog(_PadStringCenter(" Not a Dead Base, but TH Bully Level Found! ", 50, "~"), $COLOR_GREEN)
						ExitLoop
					Else
						If $bBtnAttackNowPressed = True Then ExitLoop
						$msg &= ", Not TH Bully Level"
					EndIf

				EndIf
				If $OptTrophyMode = 1 Then ;Enables Triple Mode Settings
					If SearchTownHallLoc() Then
						SetLog(_PadStringCenter(" Not a Dead Base, but TH Outside Found! ", 50, "~"), $COLOR_GREEN)
						ExitLoop
					Else
						If $bBtnAttackNowPressed = True Then ExitLoop
						$msg &= ", Not TH Outside!"
					EndIf
				EndIf
				If $iradAttackMode = 1 Then
					_WinAPI_DeleteObject($hBitmapFirst)
					$hBitmapFirst = _CaptureRegion2()
					Local $resultHere = DllCall($LibDir & "\CGBfunctions.dll", "str", "CheckConditionForWeakBase", "ptr", $hBitmapFirst, "int", ($iWBMortar + 1), "int", ($iWBWizTower + 1), "int", 10)
					If $resultHere[0] = "Y" Then
						SetLog(_PadStringCenter(" Weak Base Found! ", 50, "~"), $COLOR_GREEN)
						ExitLoop
					Else
						If $bBtnAttackNowPressed = True Then ExitLoop
						$msg &= ", Not a Weak Base"
					EndIf
				EndIf

				;If _Sleep(1000) Then Return
				If $bBtnAttackNowPressed = True Then ExitLoop
				; Zap And Run
				If $OptZapAndRun = 1 And $LSpellQ >= $iLSpellQ Then
					If (Number($searchDark) >= Number($SpellMinDarkStorage)) Then
						$zapandrunAvoidAttack = 1
						SetLog(_PadStringCenter(" Zap and Run base Found!", 50, "~"), $COLOR_GREEN)
						ExitLoop
					EndIf
				Endif
				SetLog(_PadStringCenter($msg, 50, "~"), $COLOR_ORANGE)
				Click(750, 500) ;Click Next
				$iSkipped = $iSkipped + 1
				GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
				ContinueLoop

			Else
				ExitLoop ; attack Allbase
			EndIf
		ElseIf $OptTrophyMode = 1 Then ;Enables Triple Mode Settings ;---compare resources
			If SearchTownHallLoc() Then ; attack this base anyway because outside TH found to snipe
				SetLog(_PadStringCenter(" TH Outside Found! ", 50, "~"), $COLOR_GREEN)
				ExitLoop
			Else
				; break every 10 searches when Snipe While Train MOD is activated
				If $isSnipeWhileTrain And $iSkipped > 8 Then
					Click(62, 519) ; Click End Battle to return home
					$haltSearch = True ; To Prevent Initiation of Attack
					ExitLoop
				EndIf
				;If _Sleep(1000) Then Return
				If $bBtnAttackNowPressed = True Then ExitLoop
				Click(750, 500) ;Click Next
				$iSkipped = $iSkipped + 1
				GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
				ContinueLoop
			EndIf
		Else
			; Zap And Run
			If $OptZapAndRun = 1 And $LSpellQ >= $iLSpellQ Then
				If (Number($searchDark) >= Number($SpellMinDarkStorage)) Then
					$zapandrunAvoidAttack = 1
					SetLog(_PadStringCenter(" Zap and Run base Found!", 50, "~"), $COLOR_GREEN)
					ExitLoop
				EndIf
			Endif
			;If _Sleep(1000) Then Return
			If $bBtnAttackNowPressed = True Then ExitLoop
			Click(750, 500) ;Click Next
			$iSkipped = $iSkipped + 1
			GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
			ContinueLoop
		EndIf
	WEnd

	If $bBtnAttackNowPressed = True Then
		Setlog(_PadStringCenter(" JVS MOD v1.1 Attack Now Pressed! ", 50, "~"), $COLOR_GREEN)
	EndIf

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNow, $GUI_HIDE)
		GUICtrlSetState($cmbAtkNowDeploy, $GUI_HIDE)
		GUICtrlSetState($chkAtkNowMines, $GUI_HIDE)
		GUICtrlSetState($chkAtkNowLSpell, $GUI_HIDE)
		GUICtrlSetState($pic2arrow, $GUI_SHOW)
		GUICtrlSetState($lblVersion, $GUI_SHOW)
	EndIf

	If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
		TrayTip("Match Found! after " & StringFormat("%3s", $SearchCount) & " skip(s)" , "Gold: " & _NumberFormat($searchGold) & "; Elixir: " & _NumberFormat($searchElixir) & "; Dark: " & _NumberFormat($searchDark) & "; Trophy: " & $searchTrophy, "", 0)
		If FileExists(@WindowsDir & "\media\Festival\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		ElseIf FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
		EndIf
	EndIf

	SetLog(_PadStringCenter(" Search Complete ", 50, "="), $COLOR_BLUE)
	PushMsg("MatchFound")

	; TH Detection Check Once Conditions
	If $OptBullyMode = 0 And $OptTrophyMode = 0 And $chkConditions[4] = 0 And $chkConditions[5] = 0 And $chkATH = 1 Then
		$searchTH = checkTownhallADV()
		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is inside, skip Attack TH")
		ElseIf $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is outside, Attacking Townhall!")
		Else
			SetLog("Checking Townhall location: Could not locate TH, skipping attack TH...")
		EndIf
	EndIf

;~	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS Memory

;~	readConfig()
	_BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys


	$Is_ClientSyncError = False

EndFunc   ;==>VillageSearch
