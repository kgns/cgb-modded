;	Uses the location of manually set Barracks to train specified troops
;	coded by HungLe from gamebot.org
;	Train the troops (Fill the barracks)
;	edit 2015-06 Sardo and Promac



Func GetTrainPos($troopKind)
	;If $debugSetlog = 1 Then SetLog("Func GetTrainPos " & $troopKind)
	For $i = 0 To UBound($TroopName) - 1
		If Eval("e" & $TroopName[$i]) = $troopKind Then
			Return Eval("Train" & $TroopName[$i])
		EndIf
	Next
	For $i = 0 To UBound($TroopDarkName) - 1
		If Eval("e" & $TroopDarkName[$i]) = $troopKind Then
			Return Eval("Train" & $TroopDarkName[$i])
		EndIf
	Next

	SetLog("Don't know how to train the troop " & $troopKind & " yet")
	Return 0
EndFunc   ;==>GetTrainPos

Func GetFullName($TroopKind)
		If $debugSetlog = 1 Then SetLog("Func GetFullName " & $troopKind)
	For $i = 0 To UBound($TroopName) - 1
		If Eval("e" & $TroopName[$i]) = $troopKind Then
			Return Eval("Full" & $TroopName[$i])
		EndIf
	Next
	For $i = 0 To UBound($TroopDarkName) - 1
		If Eval("e" & $TroopDarkName[$i]) = $troopKind Then
			Return Eval("Full" & $TroopDarkName[$i])
		EndIf
	Next

	SetLog("Don't know how to find the troop " & $troopKind & " yet")
	Return 0
EndFunc ;==>>GetFullName

Func GetGemName($TroopKind)
		If $debugSetlog = 1 Then SetLog("Func GetGemName " & $troopKind)
	For $i = 0 To UBound($TroopName) - 1
		If Eval("e" & $TroopName[$i]) = $troopKind Then
			Return Eval("Gem" & $TroopName[$i])
		EndIf
	Next
	For $i = 0 To UBound($TroopDarkName) - 1
		If Eval("e" & $TroopDarkName[$i]) = $troopKind Then
			Return Eval("Gem" & $TroopDarkName[$i])
		EndIf
	Next

	SetLog("Don't know how to find the troop " & $troopKind & " yet")
	Return 0
EndFunc ;==>>GetGemName


Func TrainIt($troopKind, $howMuch = 1, $iSleep = 400)
	;If $debugSetlog = 1 Then SetLog("Func TrainIt " & $troopKind & " " & $howMuch & " " & $iSleep)
	_CaptureRegion()
	Local $pos = GetTrainPos($troopKind)
	If IsArray($pos) Then
		If _CheckPixel($pos, $bNoCapturePixel) Then
			Local $GemName = GetGemName($TroopKind)
			If IsArray($GemName) Then
				Local $FullName = GetFullName($TroopKind)
				If IsArray($FullName) Then
					TrainClickP($pos, $howMuch, $isldTrainITDelay, $FullName, $GemName, "#0266")
					If _Sleep($iSleep) Then Return False
					If $OutOfElixir = 1 Then
						Setlog("Not enough Elixir to train troops!", $COLOR_RED)
						Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_RED)
						$ichkBotStop = 1  ; set halt attack variable
						$icmbBotCond = 16  ; set stay online
						GUICtrlSetState($chkBotStop, $GUI_CHECKED)
						_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)
						$Restart = True
						Return  False ; We are out of Elixir stop training.
					EndIf
					Return True
				Else
					Setlog("Bad troop full position found in TrainIt", $COLOR_RED)
				EndIf
			Else
				Setlog("Bad troop Gem position found in TrainIt", $COLOR_RED)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>TrainIt


Func Train()
	If $debugSetlog = 1 Then SetLog("Func Train ")
	If $bTrainEnabled = False Then Return

	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
		checkArmyCamp()
	EndIf

;~ 	;IF NO BARRACKS FOUND CALL LOCATEBARRACK TO SET
;~ 	If $barrackPos[0] = "" Then
;~ 		ClickP($aTopLeftClient, 2, 250,"#0267"); Click away twice with 250ms delay
;~ 		If _Sleep(500) Then Return
;~ 		LocateBarrack()
;~ 		SaveConfig()
;~ 		If _Sleep(2000) Then Return
;~ 	EndIf

	SetLog("Training Troops...", $COLOR_BLUE)

	If _Sleep(100) Then Return

	ClickP($aTopLeftClient, 1, 0, "#0268") ;Click Away

	;OPEN ARMY OVERVIEW WITH NEW BUTTON
	If _Sleep(100) Then Return
	Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0293") ; Button Army Overview

	;MOVE TO FIST BARRACK (can be improved check with imagepixel what is the first not in up barrack
	If _Sleep(500) Then Return
	Local $icount = 0
	While $icount < 5
		Local $NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
		If IsArray($NextPos) Then ExitLoop
		$icount += 1
	WEnd
	If $icount = 5 Then
		If _Sleep(1000) Then Return
		If $debugSetlog = 1 Then SetLog("Train warning 12")
	EndIf
	If _Sleep(1000) Then Return
	Local $NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)

	Local $icount = 0
	If IsArray($NextPos) Then Click($NextPos[0], $NextPos[1], 1, 0, "#9999") ;click next button
	While Not isBarrack()
		If _Sleep(100) Then ContinueLoop
		$icount = $icount + 1
		If $icount = 5 Then ExitLoop
	WEnd
	If $icount = 5 Then
		SetLog("Cannot locate a normal Barrack")
		If $debugSetlog = 1 Then SetLog("Train warning 11")
	Else
		;SetLog("Normal Barrack found")
	EndIf

	;SEARCH FIRST BARRACK
	If _Sleep(250) Then Return
	$icount = 0
	While Not isBarrack()
		If _Sleep(500) Then Return
		$icount += 1
		If $icount = 10 Then ExitLoop
	WEnd
	If $debugSetlog = 1 And $icount = 10 Then SetLog("Train warning 2")
	If Not $fullArmy Then CheckFullArmy() ;if armycamp not full, check full by barrack

	Local $NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
	Local $PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)

	$icount = 0
	While Not IsArray($NextPos)
		If _Sleep(100) Then Return
		$NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
		$PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)
		$icount += 1
		If $icount = 20 Then ExitLoop
	WEnd
	If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 3")


	$icount = 0
	While Not IsArray($PrevPos)
		If _Sleep(100) Then Return
		$PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)
		$icount += 1
		If $icount = 20 Then ExitLoop
	WEnd
	If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 4")

	;CHECK IF NEED TO MAKE NORMAL TROOPS
	If $isNormalBuild = "" Then
		For $i = 0 To UBound($TroopName) - 1
			If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
				$isNormalBuild = True
			EndIf
		Next
	EndIf
	If $isNormalBuild = "" Then
		$isNormalBuild = False
	EndIf
	If $debugSetlog = 1 Then SetLog("Train: need to make normal troops: " & $isNormalBuild)

	;CHECK IF NEED TO MAKE DARK TROOPS
	If $isDarkBuild = "" Then
		For $i = 0 To UBound($TroopDarkName) - 1
			If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
				$isDarkBuild = True
			EndIf
		Next
	EndIf
	If $isDarkBuild = "" Then
		$isDarkBuild = False
	EndIf
	If $debugSetlog = 1 Then SetLog("Train: need to make dark troops: " & $isDarkBuild)

	;GO TO FIRST NON NORMAL BARRACK...
	Local $iBarrHere
	$iBarrHere = 0
	While (isBarrack() And ($isNormalBuild Or (_GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8)))
		If IsArray($NextPos) Then Click($NextPos[0], $NextPos[1], 1, 0, "#0271") ;click next button
		$iBarrHere += 1
		If _Sleep(500) Then ExitLoop
		$icount = 0
		While Not isBarrack()
			If _Sleep(100) Then ExitLoop
			$icount = $icount + 1
			If $icount = 5 Then ExitLoop
		WEnd
		If $debugSetlog = 1 And $icount = 10 Then SetLog("Train warning 5")
		If ($iBarrHere = $barrackNum) Then ExitLoop
	WEnd

	;RETURN TO LAST NORMAL BARRACK
	If $isNormalBuild Or (_GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8) Then
		If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1], 1, 0, "#0272") ;click prev button
		If _Sleep(1000) Then Return
	EndIf




	;PREPARE TROOPS IF FULL ARMY
	If $fullArmy Then
		$BarrackStatus[0] = False
		$BarrackStatus[1] = False
		$BarrackStatus[2] = False
		$BarrackStatus[3] = False
		$BarrackDarkStatus[0] = False
		$BarrackDarkStatus[1] = False
		SetLog("Your Army Camps are now Full", $COLOR_RED)
		If $pEnabled = 1 And $ichkAlertPBCampFull = 1 Then PushMsg("CampFull")
	Else
	EndIf

	;reset variables
	If $fullArmy Then ; reset all to cook again
		$ArmyComp = 0
		For $i = 0 To UBound($TroopName) - 1
			If $debugSetlog = 1 Then SetLog("RESET AT 0 " & "Cur" & $TroopName[$i])
			Assign("Cur" & $TroopName[$i], 0)
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 Then SetLog("RESET AT 0 " & "Cur" & $TroopDarkName[$i])
			Assign("Cur" & $TroopDarkName[$i], 0)
		Next
	EndIf

	;compute troops to make...
	If $debugSetlog = 1 Then SetLog("---------COMPUTE TROOPS TO MAKE------------------------")
	If $fullArmy And $ArmyComp = 0 Then
		$anotherTroops = 0
		If $debugSetlog = 1 Then SetLog("-- Compute AnotherTroops to train")
		For $i = 0 To UBound($TroopName) - 1
			If $TroopName[$i] <> "Barb" And $TroopName[$i] <> "Arch" And $TroopName[$i] <> "Gobl" Then
				If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) <> 0 Then SetLog("Need to train ASSIGN.... Cur" & $TroopName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
				Assign(("Cur" & $TroopName[$i]), GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
				If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) Then SetLog("-- AnotherTroops to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopName[$i])) & "*" & $TroopHeight[$i])
				$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopName[$i])) * $TroopHeight[$i]
			EndIf
		Next

		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("Need to train ASSIGN.... Cur" & $TroopDarkName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
			Assign(("Cur" & $TroopDarkName[$i]), GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
			If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) Then SetLog("-- AnotherTroops dark to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) & "*" & $TroopDarkHeight[$i])
			$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
		Next
		If $debugSetlog = 1 And Number($anotherTroops) <> 0 Then SetLog("--------------AnotherTroops TOTAL to train:" & $anotherTroops)
		$CurGobl = ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumGobl) / 100
		$CurGobl = Round($CurGobl)
		$CurBarb = ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumBarb) / 100
		$CurBarb = Round($CurBarb)
		$CurArch = ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumArch) / 100
		$CurArch = Round($CurArch)
		If $debugSetlog = 1 Then SetLog("Need to train (height) GOBL:" & $CurGobl & "% BARB: " & $CurBarb & "% ARCH: " & $CurArch & "% AND " & $anotherTroops & " other troops space")
	ElseIf $ArmyComp = 0 Or $FirstStart Then
		$anotherTroops = 0
		For $i = 0 To UBound($TroopName) - 1
			If $TroopName[$i] <> "Barb" And $TroopName[$i] <> "Arch" And $TroopName[$i] <> "Gobl" Then
				Assign(("Cur" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]) + GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
				If $debugSetlog = 1 And Number($anotherTroops + GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) Then SetLog("-- AnotherTroops to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopName[$i])) & "*" & $TroopHeight[$i])
				$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopName[$i])) * $TroopHeight[$i]
				If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) <> 0 Then SetLog("Need to train " & $TroopName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
			EndIf
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			Assign(("Cur" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]) + GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
			If $debugSetlog = 1 And Number($anotherTroops + GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("-- AnotherTroops dark to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) & "*" & $TroopDarkHeight[$i])
			$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
			If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("Need to train " & $TroopDarkName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
		Next
		If $debugSetlog = 1 Then SetLog("--------------AnotherTroops TOTAL to train:" & $anotherTroops)
		$CurGobl += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumGobl) / 100
		$CurGobl = Round($CurGobl)
		$CurBarb += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumBarb) / 100
		$CurBarb = Round($CurBarb)
		$CurArch += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumArch) / 100
		$CurArch = Round($CurArch)
		If $debugSetlog = 1 Then SetLog("Need to train (height) GOBL:" & $CurGobl & "% BARB: " & $CurBarb & "% ARCH: " & $CurArch & "% AND " & $anotherTroops & " other troops space")
	EndIf

	;Local $GiantEBarrack ,$WallEBarrack ,$ArchEBarrack ,$BarbEBarrack ,$GoblinEBarrack,$HogEBarrack,$MinionEBarrack, $WizardEBarrack
	If $debugSetlog = 1 Then SetLog("BARRACKNUM: " & $barrackNum)
	If $barrackNum <> 0 Then
		For $i = 0 To UBound($TroopName) - 1
			If $debugSetlog = 1 And Number(Floor(Eval("Cur" & $TroopName[$i]) / $barrackNum)) <> 0 Then SetLog($TroopName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopName[$i]) / $barrackNum))
			Assign(($TroopName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopName[$i]) / $barrackNum))
		Next
	Else
		For $i = 0 To UBound($TroopName) - 1
			If $debugSetlog = 1 And Floor(Eval("Cur" & $TroopName[$i]) / 4) <> 0 Then SetLog($TroopName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopName[$i]) / 4))
			Assign(($TroopName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopName[$i]) / 4))
		Next
	EndIf

	If $debugSetlog = 1 Then SetLog("DARKBARRACKNUM: " & $barrackDarkNum)
	If $barrackDarkNum <> 0 Then
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 And Number(Floor(Eval("Cur" & $TroopDarkName[$i]) / $barrackNum)) <> 0 Then SetLog($TroopDarkName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopDarkName[$i]) / $barrackNum))
			Assign(($TroopDarkName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopDarkName[$i]) / $barrackDarkNum))
		Next
	Else
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 And Number(Floor(Eval("Cur" & $TroopDarkName[$i]) / 2)) <> 0 Then SetLog($TroopDarkName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopDarkName[$i]) / 2))
			Assign(($TroopDarkName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopDarkName[$i]) / 2))
		Next
	EndIf

	;RESET TROOPFIRST AND TROOPSECOND
	For $i = 0 To UBound($TroopName) - 1
		;If $debugSetlog = 1 Then SetLog("troopFirst" & $TroopName[$i] & ": 0")
		Assign(("troopFirst" & $TroopName[$i]), 0)
		;If $debugSetlog = 1 Then SetLog("troopSecond" & $TroopName[$i] & ": 0")
		Assign(("troopSecond" & $TroopName[$i]), 0)
	Next
	For $i = 0 To UBound($TroopDarkName) - 1
		;If $debugSetlog = 1 Then SetLog("troopFirst" & $TroopDarkName[$i] & ": 0")
		Assign(("troopFirst" & $TroopDarkName[$i]), 0)
		;If $debugSetlog = 1 Then SetLog("troopSecond" & $TroopDarkName[$i] & ": 0")
		Assign(("troopSecond" & $TroopDarkName[$i]), 0)
	Next



	$brrNum = 0
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
		;USE BARRACK
		While isBarrack()
			_CaptureRegion()
			If $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(488, 191, True), Hex(0xD1D0C2, 6), 20)
					Click(496, 197, 10, 0, "#0273")
					$icount += 1
					If $icount = 20 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 6")
			EndIf
			If _Sleep(500) Then ExitLoop
			$brrNum += 1
			Switch $barrackTroop[$brrNum - 1]
				Case 0
					;Click(220, 320, 50, 10, "#0274") ;Barbarian
					TrainClick(220, 320, 50, 10, $FullBarb, $GemBarb, "#0274") ;Barbarian
				Case 1
					;Click(331, 320, 50, 10, "#0275") ;Archer
					TrainClick(331, 320, 50, 10, $FullArch, $GemArch, "#0275") ;Archer
				Case 2
					;Click(432, 320, 50, 10, "#0276") ;Giant
					TrainClick(432, 320, 50, 10, $FullGiant, $GemGiant, "#0276") ;Giant
				Case 3
					;Click(546, 320, 50, 10, "#0277") ;Goblin
					TrainClick(546, 320, 50, 10, $FullGobl, $GemGobl, "#0277") ;Goblin
				Case 4
					;Click(647, 320, 37, 10, "#0278") ;Wall Breaker
					TrainClick(647, 320, 37, 10, $FullWall, $GemWall, "#0278") ;Wall Breaker
				Case 5
					;Click(220, 425, 15, 10, "#0279") ;Balloon
					TrainClick(220, 425, 15, 10, $FullBall, $GemBall, "#0279") ;Balloon
				Case 6
					;Click(331, 425, 18, 10, "#0280") ;Wizard
					TrainClick(331, 425, 18, 10, $FullWiza, $GemWiza, "#0280") ;Wizard
				Case 7
					;Click(432, 425, 5, 10, "#0281") ;Healer
					TrainClick(432, 425, 5, 10, $FullHeal, $GemHeal, "#0281") ;Healer
				Case 8
					;Click(546, 425, 3, 10, "#0282") ;Dragon
					TrainClick(546, 425, 3, 10, $FullDrag, $GemDrag, "#0282") ;;Dragon
				Case 9
					;Click(647, 425, 3, 10, "#0283") ;PEKKA
					TrainClick(647, 425, 3, 10, $FullPekk, $GemPekk, "#0283") ; Pekka
			EndSwitch
			If $OutOfElixir = 1 Then
				Setlog("Not enough Elixir to train troops!", $COLOR_RED)
				Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_RED)
				$ichkBotStop = 1  ; set halt attack variable
				$icmbBotCond = 16  ; set stay online
				GUICtrlSetState($chkBotStop, $GUI_CHECKED)
				_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)
				$Restart = True
				Return  ; We are out of Elixir stop training.
			EndIf

			If _Sleep(500) Then ExitLoop
			Click($PrevPos[0], $PrevPos[1], 1, 0, "#0325") ;click prev button
			If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
			If _Sleep(1000) Then ExitLoop
			;endif
		WEnd
	Else
		While isBarrack() And $isNormalBuild
			$brrNum += 1
			If $fullArmy Or $FirstStart Then
				;CLICK REMOVE TROOPS
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(488, 191, True), Hex(0xD1D0C2, 6), 20)
					Click(496, 197, 10, 0, "#0284") ; remove troops
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 7")
			EndIf
			If _Sleep(100) Then ExitLoop

			For $i = 0 To UBound($TroopName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopNamePosition[$i]
					If $TroopNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst." & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					Assign(("troopFirst" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))

					If Eval("troopFirst" & $TroopName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst." & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
						Assign(("troopFirst" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next

			For $i = 0 To UBound($TroopName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" And Eval("Cur" & $TroopName[$i]) > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If Eval("Cur" & $TroopName[$i]) > 0 Then
						If Eval($TroopName[$i] & "EBarrack") = 0 Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i])
							TrainIt(Eval("e" & $TroopName[$i]), 1)
							$BarrackStatus[$brrNum - 1] = True
						ElseIf Eval($TroopName[$i] & "EBarrack") >= Eval("Cur" & $TroopName[$i]) Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i])
							TrainIt(Eval("e" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]))
							$BarrackStatus[$brrNum - 1] = True
						Else
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i])
							TrainIt(Eval("e" & $TroopName[$i]), Eval($TroopName[$i] & "EBarrack"))
							$BarrackStatus[$brrNum - 1] = True
						EndIf
					EndIf
				EndIf
			Next

			If _Sleep(100) Then ExitLoop

			For $i = 0 To UBound($TroopName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopNamePosition[$i]
					If $TroopNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog(("troopSecond" & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop))))
					Assign(("troopSecond" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopSecond" & $TroopName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN troopSecond" & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
						Assign(("troopSecond" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next

			$troopNameCooking = ""
			For $i = 0 To UBound($TroopName) - 1
				If Eval("troopSecond" & $TroopName[$i]) > Eval("troopFirst" & $TroopName[$i]) And GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
					$ArmyComp += (Eval("troopSecond" & $TroopName[$i]) - Eval("troopFirst" & $TroopName[$i])) * $TroopHeight[$i]
					If $debugSetlog = 1 Then SetLog(("###Cur" & $TroopName[$i]) & " = " & Eval("Cur" & $TroopName[$i]) & " - (" & Eval("troopSecond" & $TroopName[$i]) & " - " & Eval("troopFirst" & $TroopName[$i]) & ")")
					Assign(("Cur" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]) - (Eval("troopSecond" & $TroopName[$i]) - Eval("troopFirst" & $TroopName[$i])))
				EndIf
				If Eval("troopSecond" & $TroopName[$i]) > 0 Then
					$troopNameCooking = $troopNameCooking & $i & ";"
				EndIf
			Next

			;if  _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) then
			If _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) Or $troopNameCooking = "" Then
				$BarrackStatus[$brrNum - 1] = False
			Else
				$BarrackStatus[$brrNum - 1] = True
			EndIf
			If $debugSetlog = 1 Then SetLog("BARRACK " & $brrNum - 1 & " STATUS: " & $BarrackStatus[$brrNum - 1])

			;if armycamp not full, train 20 arch
			If _ColorCheck(_GetPixelColor(392, 155, True), Hex(0xE84D50, 6), 20) Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(560, 202, True), Hex(0xE8E8E0, 6), 20)
					Click(496, 197, 5, 0, "#0285")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 8")

				If _Sleep(100) Then ExitLoop
				If $debugSetlog = 1 Then SetLog("Call Func TrainIt Arch")
				TrainIt($eArch, 20)
			EndIf

			If $BarrackStatus[0] = False And $BarrackStatus[1] = False And $BarrackStatus[2] = False And $BarrackStatus[3] = False And Not $FirstStart Then
				If Not $isDarkBuild Or ($BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False) Then
					If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Arch")
					TrainIt($eArch, 20)
				EndIf
			EndIf

			Click($PrevPos[0], $PrevPos[1], 1, 0, "#0286") ;click prev button
			If _Sleep(500) Then ExitLoop
			$icount = 0
			While Not isBarrack()
				If _Sleep(200) Then ExitLoop
				$icount = $icount + 1
				If $icount = 5 Then ExitLoop
			WEnd
			If $debugSetlog = 1 And $icount = 10 Then SetLog("Train warning 9")

			If $brrNum >= $barrackNum Then ExitLoop ; make sure no more infiniti loop
		WEnd
	EndIf

	;dark here

	If $isDarkBuild Then
		$iBarrHere = 0
		$brrDarkNum = 0
		While 1
			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1], 1, 0, "#0324") ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			If (isDarkBarrack() Or $iBarrHere = 5) Then ExitLoop
		WEnd

		While isDarkBarrack()
			$brrDarkNum += 1
			If $debugSetlog = 1 Then SetLog("====== Check Dark Barrack: " & $brrDarkNum & " ======", $COLOR_PURPLE)
			If StringInStr($sBotDll, "CGBPlugin.dll") < 1 Then
				ExitLoop
			EndIf
			If $fullArmy Or $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(488, 191, True), Hex(0xD1D0C2, 6), 20)
					Click(496, 197, 10, 0, "#0287")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 9")
			EndIf

			If _Sleep(100) Then ExitLoop
			For $i = 0 To UBound($TroopDarkName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopDarkNamePosition[$i]
					If $TroopDarkNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					EndIf

					;read troops in windows troopsfirst
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst.." & $TroopDarkName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					Assign(("troopFirst" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopFirst" & $TroopDarkName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst..." & $TroopDarkName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
						Assign(("troopFirst" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next

			For $i = 0 To UBound($TroopDarkName) - 1
				If $debugSetlog = 1 Then SetLog("** " & $TroopDarkName[$i] & " : " & "txtNum" & $TroopDarkName[$i] & " = " & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) & "  Cur" & $TroopDarkName[$i] & " = " & Eval("Cur" & $TroopDarkName[$i]))
				If $debugSetlog = 1 Then SetLog("*** " & "txtNum" & $TroopDarkName[$i] & "=" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
				If $debugSetlog = 1 Then SetLog("*** " & "Cur" & $TroopDarkName[$i] & "=" & Eval("Cur" & $TroopDarkName[$i]))
				If $debugSetlog = 1 Then SetLog("*** " & $TroopDarkName[$i] & "EBarrack" & "=" & Eval("Cur" & $TroopDarkName[$i]))

				If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" And Eval("Cur" & $TroopDarkName[$i]) > 0 Then

					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If Eval("Cur" & $TroopDarkName[$i]) > 0 Then
						If Eval($TroopDarkName[$i] & "EBarrack") = 0 Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i])
							TrainIt(Eval("e" & $TroopDarkName[$i]), 1)
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						ElseIf Eval($TroopDarkName[$i] & "EBarrack") >= Eval("Cur" & $TroopDarkName[$i]) Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i])
							TrainIt(Eval("e" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]))
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						Else
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i])
							TrainIt(Eval("e" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "EBarrack"))
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						EndIf
					EndIf
				EndIf
			Next

			If _Sleep(100) Then ExitLoop

			For $i = 0 To UBound($TroopDarkName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopDarkNamePosition[$i]
					If $TroopDarkNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 Then SetLog(">>>troopSecond" & $TroopDarkName[$i] & " = " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))

					Assign(("troopSecond" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopSecond" & $TroopDarkName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 Then SetLog(">>>troopSecond" & $TroopDarkName[$i] & " = " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
						Assign(("troopSecond" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next


			For $i = 0 To UBound($TroopDarkName) - 1
				If Eval("troopSecond" & $TroopDarkName[$i]) > Eval("troopFirst" & $TroopDarkName[$i]) And GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$ArmyComp += (Eval("troopSecond" & $TroopDarkName[$i]) - Eval("troopFirst" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
					If $debugSetlog = 1 Then SetLog("#Cur" & $TroopDarkName[$i] & " = " & Eval("Cur" & $TroopDarkName[$i]) & " - (" & Eval("troopSecond" & $TroopDarkName[$i]) & " - " & Eval("troopFirst" & $TroopDarkName[$i]) & ")")
					Assign(("Cur" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]) - (Eval("troopSecond" & $TroopDarkName[$i]) - Eval("troopFirst" & $TroopDarkName[$i])))
					If $debugSetlog = 1 Then SetLog("**** " & "txtNum" & $TroopDarkName[$i] & "=" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
					If $debugSetlog = 1 Then SetLog("**** " & "Cur" & $TroopDarkName[$i] & "=" & Eval("Cur" & $TroopDarkName[$i]))
					If $debugSetlog = 1 Then SetLog("**** " & $TroopDarkName[$i] & "EBarrack" & "=" & Eval("Cur" & $TroopDarkName[$i]))
				EndIf
			Next

			If _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) Then
				$BarrackDarkStatus[$brrDarkNum - 1] = False
			Else
				$BarrackDarkStatus[$brrDarkNum - 1] = True
			EndIf

			; if carmycamp not full, train 10 minions
			If _ColorCheck(_GetPixelColor(392, 155, True), Hex(0xE84D50, 6), 20) Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(560, 202, True), Hex(0xE8E8E0, 6), 20)
					Click(496, 197, 5, 0, "#0288")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 10")
				If _Sleep(100) Then ExitLoop
				If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Mini")
				TrainIt($eMini, 10)
			EndIf

			If $BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False And (Not $isNormalBuild) And (Not $FirstStart) Then
				If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Mini")
				TrainIt($eMini, 6)
			EndIf

			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1], 1, 0, "#0289") ;click prev button

			If _Sleep(500) Then ExitLoop
			$icount = 0
			While Not isDarkBarrack()
				If _Sleep(200) Then ExitLoop
				$icount = $icount + 1
				If $icount = 5 Then ExitLoop
			WEnd
			If $brrDarkNum >= $barrackDarkNum Then ExitLoop ; make sure no more infiniti loop
		WEnd
		;end dark
	EndIf
	If $debugSetlog = 1 Then SetLog("---================================================================---")


	If $icmbTroopComp <> 8 And $isNormalBuild And $BarrackStatus[0] = False And $BarrackStatus[1] = False And $BarrackStatus[2] = False And $BarrackStatus[3] = False And Not $FirstStart Then
		If Not $isDarkBuild Or ($BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False) Then
			Train()
			Return
		EndIf
	EndIf


	If $iChkLightSpell = 1 Then
		$iBarrHere = 0
		While Not isSpellFactory()
			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1], 1, 0, "#0323") ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			If $iBarrHere = 7 Then ExitLoop
		WEnd

		If isSpellFactory() Then
			Local $x = 0
			While 1
				_CaptureRegion()
				If _sleep(500) Then Return
				If _ColorCheck(_GetPixelColor(237, 354, True), Hex(0xFFFFFF, 6), 20) = False Then
					setlog("Not enough Elixir to create Spell", $COLOR_RED)
					ExitLoop
				ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x1A1A1A, 6), 20) Then
					setlog("Spell Factory Full", $COLOR_RED)
					ExitLoop
				Else
					GemClick(252, 354, 1, 20, "#0290")
					$x = $x + 1
				EndIf
				If $x = 5 Then
					ExitLoop
				EndIf
			WEnd
			If $x = 0 Then
			Else
				SetLog("Created " & $x & " Lightning Spell(s)", $COLOR_BLUE)
			EndIf
		Else
			SetLog("Spell Factory not found...", $COLOR_BLUE)
		EndIf
	Else

	EndIf ; End Spell Factory

	If _Sleep(200) Then Return
	ClickP($aTopLeftClient, 2, 250, "#0291"); Click away twice with 250ms delay

	$FirstStart = False
;~         SetLog("========================", $COLOR_GREEN)
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
;~ 		SetLog("========================", $COLOR_GREEN)
	EndIf

EndFunc   ;==>Train

