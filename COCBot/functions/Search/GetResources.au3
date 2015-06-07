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
		If $i >= 100 or isProblemAffect(true) Then ; wait max 20 sec then Restart Bot
			checkMainScreen()
			if $Restart then
				SetLog("Cannot locate Next button, Restarting Bot..." , $COLOR_RED)
				Pushmsg("OoSResources")
				$Is_ClientSyncError = True
				GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync)+ 1)
				$iStuck = 0
				If $isSnipeWhileTrain Then ; When OoS occured during Snipe While Train MOD no need to go to search
			   		TurnOffSnipeWhileTrain()
				EndIf
				Return
			else
				SetLog("Have strange problem can not determine, Restarting Bot..." , $COLOR_RED)
				$Is_ClientSyncError = True
				$iStuck = 0
				$Restart = true
				If $isSnipeWhileTrain Then ; When OoS occured during Snipe While Train MOD no need to go to search
			   		TurnOffSnipeWhileTrain()
				EndIf
				Return
			endif
		EndIf
	WEnd


	$searchElixir = getElixir(51, 66 + 29)

	$searchTrophy = getTrophy(51, 66 + 90)

	If $searchGold = $searchGold2 Then $iStuck += 1
	If $searchGold <> $searchGold2 Then $iStuck = 0

	$searchGold2 = $searchGold
	If $iStuck >= 5 Then
		checkMainScreen()
		if $Restart then
			SetLog("Cannot locate Next button, Restarting Bot..." , $COLOR_RED)
			Pushmsg("OoSResources")
			$Is_ClientSyncError = True
			GUICtrlSetData($lblresultoutofsync, GUICtrlRead($lblresultoutofsync)+ 1)
			$iStuck = 0
			If $isSnipeWhileTrain Then ; When OoS occured during Snipe While Train MOD no need to go to search
		  		TurnOffSnipeWhileTrain()
			EndIf
			Return
		else
			SetLog("Have strange problem can not determine, Restarting Bot..." , $COLOR_RED)
			$Is_ClientSyncError = True
			$iStuck = 0
			$Restart = true
				If $isSnipeWhileTrain Then ; When OoS occured during Snipe While Train MOD no need to go to search
			   		TurnOffSnipeWhileTrain()
				EndIf
			Return
		endif
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

	;Do something after "X" amount of searches mod
	$SearchCount += 1 ; Counter for number of searches
	SetLog(StringFormat("%3s", $SearchCount) & "> [G]:" & StringFormat("%7s", $searchGold) & " [E]:" & StringFormat("%7s", $searchElixir) & " [D]:" & StringFormat("%5s", $searchDark) & " [T]:" & StringFormat("%2s", $searchTrophy) & $THString, $COLOR_BLACK, "Lucida Console", 7.5)

	$itxtSrcCon=GUICtrlRead($txtSearchConne)
	If GUICtrlRead($chkSearchConne)=$GUI_CHECKED Then
             If $SearchCount = $itxtSrcCon+1 Then
	If _GUICtrlComboBox_GetCurSel($cmbDoWhenReach)=0 Then ;Return Home
		Setlog( "Search Count reached. Returning Home...",$COLOR_RED)
		_Sleep(1000)
		ReturnHome(0,False)
		$Restart=True
		$SearchCount = 0
 	ElseIf _GUICtrlComboBox_GetCurSel($cmbDoWhenReach)=1 Then ;Simulate OOS
		Setlog( "Search Count reached. Simulating OOS...",$COLOR_RED)
		_Sleep(1000)
		$Is_ClientSyncError = True
		$iStuck = 0
        	$Restart=True
 	ElseIf _GUICtrlComboBox_GetCurSel($cmbDoWhenReach)=2 Then ; Restart BS
		Setlog( "Search Count reached. Restarting BS...",$COLOR_RED)
		_Sleep(1000)
		WinKill("BlueStacks App Player")
		_Sleep(5000)
	If $64Bit Then ;If 64-Bit
		ShellExecute("C:\Program Files (x86)\BlueStacks\HD-StartLauncher.exe")
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	Else ;If 32-Bit
		ShellExecute("C:\Program Files\BlueStacks\HD-StartLauncher.exe")
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	EndIf
 	ElseIf _GUICtrlComboBox_GetCurSel($cmbDoWhenReach)=3 Then ;Change COC Language
		Setlog( "Search Count reached. Changing Language...",$COLOR_RED)
		_Sleep(1000)
		ReturnHome(0,False)
		_Sleep(2000)
		Click(820,524) ;Open Settings
		_Sleep(1000)
		Click(199,389)  ;Click Language
		Local $RandomLanguagex[5]=["149","288","422","556","682"]
		Local $RandomLanguagey[2]=["193","291"]
		Local $Clickxx=$RandomLanguagex[Random(0,4,1)]
		Local $Clickyy=$RandomLanguagey[Random(0,1,1)]
		_Sleep(1000)
		Click($Clickxx,$Clickyy)
		_Sleep(1000)
		Click(516,395)
		$Restart=True
		$SearchCount = 0
		Check()
 	ElseIf _GUICtrlComboBox_GetCurSel($cmbDoWhenReach)=4 Then ;Restart PC
		Setlog( "Search Count reached. Restarting PC...",$COLOR_RED)
		_Sleep(1000)
   		Shutdown(6)
 	 EndIf
	EndIf
	EndIf

EndFunc   ;==>GetResources
