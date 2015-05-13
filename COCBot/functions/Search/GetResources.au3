; Uses the getGold,getElixir... functions and uses CompareResources until it meets conditions.
; Will wait ten seconds until getGold returns a value other than "", if longer than 10 seconds exits

;HungLe from gamebot.org
Func GetResources() ;Reads resources
	Local $i = 0
	;_CaptureRegion()
	If _Sleep(500) Then Return
	$searchGold = ""
	While $searchGold = "" or $searchGold = $searchGold2; Loops until gold is readable
		If _Sleep(500) Then Return
		$searchGold = getGold(51, 66)
		if $searchGold < 1000 then
			If _Sleep(500) Then Return
			$searchGold = getGold(51, 66)
		endif
		$i += 1

		If $i >= 40 or isProblemAffect(true) Then ; wait max 20 sec then Restart Bot
			SetLog("Cannot locate Next button, Restarting Bot..." , $COLOR_RED)

			$Is_ClientSyncError = True
			GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync)+ 1)
			$iStuck = 0
			checkMainScreen()
			$Restart = True
			Return
		EndIf
	WEnd

	$searchElixir = getElixir(51, 66 + 29)

	$searchTrophy = getTrophy(51, 66 + 90)

	If $searchGold = $searchGold2 Then $iStuck += 1
	If $searchGold <> $searchGold2 Then $iStuck = 0

	$searchGold2 = $searchGold
	If $iStuck >= 5 Then
		SetLog("Cannot locate Next button, Restarting Bot", $COLOR_RED)
		$Is_ClientSyncError = True
		GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync)+ 1)
		$iStuck = 0
		checkMainScreen()
		$Restart = True
		Return
	EndIf

	If $searchTrophy <> "" Then
		$searchDark = getDarkElixir(51, 66 + 57)
	Else
		$searchDark = 0
		$searchTrophy = getTrophy(51, 66 + 60)
	EndIf

	Local $THString = ""
    $searchTH = "-"
	If ($OptBullyMode = 1 And $SearchCount >= $ATBullyMode) Or $OptTrophyMode = 1 Or $chkConditions[4] = 1 Or $chkConditions[5] = 1 Then
		If $chkConditions[5] = 1 Or $OptTrophyMode = 1 Then
			$searchTH = checkTownhallADV()
		Else
			$searchTH = checkTownhall()
		EndIf

		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			$THLoc = "In"
		ElseIf $searchTH <> "-" Then
			$THLoc = "Out"
		Else
			$THLoc = $searchTH
			$THx = 0
			$THy = 0
		EndIf
		$THString = " [TH]:" & StringFormat("%2s", $searchTH) & ", " & $THLoc
	EndIf
	$SearchCount += 1 ; Counter for number of searches
	SetLog(StringFormat("%3s", $SearchCount) & "> [G]:" & StringFormat("%7s", $searchGold) & " [E]:" & StringFormat("%7s", $searchElixir) & " [D]:" & StringFormat("%5s", $searchDark) & " [T]:" & StringFormat("%2s", $searchTrophy) & $THString, $COLOR_BLACK, "Lucida Console", 7.5)
	$LastLoot = StringFormat("%3s", $SearchCount) & "> [G]:" & StringFormat("%7s", $searchGold) & " [E]:" & StringFormat("%7s", $searchElixir) & " [D]:" & StringFormat("%5s", $searchDark) & " [T]:" & StringFormat("%2s", $searchTrophy) & $THString
EndFunc   ;==>GetResources
