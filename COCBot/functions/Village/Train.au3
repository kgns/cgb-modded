;	Uses the location of manually set Barracks to train specified troops
;	coded by HungLe from gamebot.org
;	Train the troops (Fill the barracks)



Func GetTrainPos($troopKind)
	for $i=0 to Ubound($TroopName) - 1
		if eval("e" & $TroopName[$i]) = $troopKind then
			 Return eval("Train" & $TroopName[$i])
		endif
	next
	for $i=0 to Ubound($TroopDarkName) - 1
		if eval("e" & $TroopDarkName[$i]) = $troopKind then
			 Return eval("Train" & $TroopDarkName[$i])
		endif
	next

	SetLog("Don't know how to train the troop " & $troopKind & " yet")
	Return 0
EndFunc

Func TrainIt($troopKind, $howMuch = 1, $iSleep = 400)
   _CaptureRegion()
   Local $pos = GetTrainPos($troopKind)
   If IsArray($pos) Then
	  If CheckPixel($pos) Then
		 ClickP($pos, $howMuch, $isldTrainITDelay)
		 ;if _Sleep($iSleep) Then Return False
		 ;Return True
	  EndIf
   EndIf
EndFunc


Func Train()
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
		checkArmyCamp()
	EndIf

	If $barrackPos[0] = "" Then
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
		If _Sleep(500) Then Return
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

	SetLog("Training Troops...", $COLOR_BLUE)

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If _Sleep(100) Then Return

	Click($barrackPos[0], $barrackPos[1]) ;Click Barrack

	If _Sleep(500) Then Return


	Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x9C7C37, 6), 5) ;Finds Train Troops button
	$icount = 0
	while not IsArray($TrainPos)
		If _Sleep(500) Then Return
		$icount = $icount + 1
		$TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x9C7C37, 6), 5) ;Finds Train Troops button
		if $icount = 10 then ExitLoop
	wend


	If IsArray($TrainPos) = False Then
		SetLog("Your Barrack is not available. (Upgrading? Locate another Barrack on the 'Misc' tab)", $COLOR_RED)
		If _Sleep(500) Then Return
		Return
	Else
		Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
		If _Sleep(500) Then Return
		$icount = 0
		while not isBarrack()
			If _Sleep(500) Then Return
			$icount += 1
			if $icount = 10 then ExitLoop
		wend
		if not $fullArmy then CheckFullArmy()  ;if armycamp not full, check full by barrack
	Endif

	Local $NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
    Local $PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)

	$icount = 0
	while not IsArray($NextPos)
		If _Sleep(100) Then Return
		$NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
		$PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)
		$icount += 1
		if $icount = 20 then ExitLoop
	wend

	$icount = 0
	while not IsArray($PrevPos)
		If _Sleep(100) Then Return
		$PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)
		$icount += 1
		if $icount = 20 then ExitLoop
	wend


	if $isNormalBuild = "" then
		for $i=0 to Ubound($TroopName) - 1
			If GUICtrlRead(eval("txtNum" & $TroopName[$i])) <> "0" Then
				$isNormalBuild = true
			endif
		next
	endif
	if $isNormalBuild = "" then
		$isNormalBuild = false
	endif

	if $isDarkBuild = "" then
		for $i=0 to Ubound($TroopDarkName) - 1
			If GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
				$isDarkBuild = true
			endif
		next
	endif
	if $isDarkBuild = "" then
		$isDarkBuild = false
	endif
	Local $iBarrHere
	$iBarrHere = 0
	while (isBarrack() and ($isNormalBuild or (_GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8)))
		If IsArray($NextPos) Then Click($NextPos[0], $NextPos[1]) ;click next button
		$iBarrHere += 1
		If _Sleep(500) Then ExitLoop
		$icount = 0
		while not isBarrack()
			If _Sleep(100) Then ExitLoop
			$icount = $icount + 1
			if $icount = 5 then ExitLoop
		wend
		if($iBarrHere = $barrackNum) then ExitLoop
	wend

	if $isNormalBuild or (_GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8) then
		If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button
		If _Sleep(1000) Then return
	endif




	If $fullArmy Then
		$BarrackStatus[0] = false
		$BarrackStatus[1] = false
		$BarrackStatus[2] = false
		$BarrackStatus[3] = false
		$BarrackDarkStatus[0] = false
		$BarrackDarkStatus[1] = false
		SetLog("Army Camp is Full", $COLOR_RED)
	Else
		SetLog("Army Camp not Full yet", $COLOR_RED)
	EndIf

	If $fullArmy Then ; reset all to cook again
		$ArmyComp = 0
		for $i=0 to Ubound($TroopName) - 1
			assign("Cur" & $TroopName[$i] , 0)
		next
		for $i=0 to Ubound($TroopDarkName) - 1
			assign("Cur" & $TroopDarkName[$i] , 0)
		next
	Endif

	If $fullArmy and $ArmyComp = 0 Then
		$anotherTroops = 0
		for $i=0 to Ubound($TroopName) - 1
			if $TroopName[$i] <> "Barb" and $TroopName[$i] <> "Arch" and $TroopName[$i] <> "Gobl" then
				assign(("Cur" & $TroopName[$i]) , GUICtrlRead(eval("txtNum" & $TroopName[$i])))
				$anotherTroops += GUICtrlRead(eval("txtNum" & $TroopName[$i])) * $TroopHeight[$i]
			endif
		next
		for $i=0 to Ubound($TroopDarkName) - 1
			assign(("Cur" & $TroopDarkName[$i]) , GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])))
			$anotherTroops += GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
		next
	 	$CurGobl = ($TotalCamp-$anotherTroops)*GUICtrlRead($txtNumGobl)/100
		$CurGobl = Round($CurGobl)
	 	$CurBarb = ($TotalCamp-$anotherTroops)*GUICtrlRead($txtNumBarb)/100
		$CurBarb = Round($CurBarb)
	 	$CurArch = ($TotalCamp-$anotherTroops)*GUICtrlRead($txtNumArch)/100
		$CurArch = Round($CurArch)
	elseif $ArmyComp = 0 or $FirstStart Then
		$anotherTroops = 0
		for $i=0 to Ubound($TroopName) - 1
			if $TroopName[$i] <> "Barb" and $TroopName[$i] <> "Arch" and $TroopName[$i] <> "Gobl" then
				assign(("Cur" & $TroopName[$i]) , eval("Cur" & $TroopName[$i]) + GUICtrlRead(eval("txtNum" & $TroopName[$i])))
				$anotherTroops += GUICtrlRead(eval("txtNum" & $TroopName[$i])) * $TroopHeight[$i]
			endif
		next
		for $i=0 to Ubound($TroopDarkName) - 1
			assign(("Cur" & $TroopDarkName[$i]) , eval("Cur" & $TroopDarkName[$i]) + GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])))
			$anotherTroops += GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
		next
	 	$CurGobl += ($TotalCamp-$anotherTroops)*GUICtrlRead($txtNumGobl)/100
		$CurGobl = Round($CurGobl)
	 	$CurBarb += ($TotalCamp-$anotherTroops)*GUICtrlRead($txtNumBarb)/100
		$CurBarb = Round($CurBarb)
	 	$CurArch += ($TotalCamp-$anotherTroops)*GUICtrlRead($txtNumArch)/100
		$CurArch = Round($CurArch)
	EndIf

	;Local $GiantEBarrack ,$WallEBarrack ,$ArchEBarrack ,$BarbEBarrack ,$GoblinEBarrack,$HogEBarrack,$MinionEBarrack, $WizardEBarrack
	if $barrackNum <> 0 then
		for $i=0 to Ubound($TroopName) - 1
			assign(($TroopName[$i] & "EBarrack") , Floor(eval("Cur" & $TroopName[$i])/$barrackNum))
		next
	else
		for $i=0 to Ubound($TroopName) - 1
			assign(($TroopName[$i] & "EBarrack") , Floor(eval("Cur" & $TroopName[$i])/4))
		next
	endif

	if $barrackDarkNum <> 0 then
		for $i=0 to Ubound($TroopDarkName) - 1
			assign(($TroopDarkName[$i] & "EBarrack") , Floor(eval("Cur" & $TroopDarkName[$i])/$barrackDarkNum))
		next
	else
		for $i=0 to Ubound($TroopDarkName) - 1
			assign(($TroopDarkName[$i] & "EBarrack") , Floor(eval("Cur" & $TroopDarkName[$i])/2))
		next
	endif


	for $i=0 to Ubound($TroopName) - 1
		assign(("troopFirst" & $TroopName[$i]) , 0)
		assign(("troopSecond" & $TroopName[$i]) , 0)
	next
	for $i=0 to Ubound($TroopDarkName) - 1
		assign(("troopFirst" & $TroopDarkName[$i]) , 0)
		assign(("troopSecond" & $TroopDarkName[$i]) , 0)
	next

	$brrNum = 0
	if _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 then
		while isBarrack()
			_CaptureRegion()
			if $FirstStart then
				$icount = 0
				while not _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20)
				    ; Delete your build queue from your barracks when you push Stop and then Start button again
				    Click(496, 197, 10)
					$icount += 1
					if $icount = 20 then ExitLoop
				wend
			endif
		    If _Sleep(500) Then ExitLoop
			$brrNum += 1
			Switch $barrackTroop[$brrNum-1]
				Case 0
					Click(220, 320, 75, 10) ;Barbarian
				Case 1
					Click(331, 320, 75, 10) ;Archer
				Case 2
					Click(432, 320, 15, 10) ;Giant
				Case 3
					Click(546, 320, 75, 10) ;Goblin
				Case 4
					Click(647, 320, 37, 10) ;Wall Breaker
				Case 5
					Click(220, 425, 15, 10) ;Balloon
				Case 6
					Click(331, 425, 18, 10) ;Wizard
				Case 7
					Click(432, 425, 5, 10) ;Healer
				Case 8
					Click(546, 425, 3, 10) ;Dragon
				Case 9
					Click(647, 425, 3, 10) ;PEKKA
			EndSwitch

		    If _Sleep(500) Then ExitLoop
			 Click($PrevPos[0], $PrevPos[1]) ;click prev button
			 If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
			 If _Sleep(1000) Then ExitLoop
			;endif
		wend
	else
		while isBarrack() and $isNormalBuild
			$brrNum += 1
			if $fullArmy or $FirstStart then
				$icount = 0
				while not _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20)
				    Click(496, 197, 10)
					$icount += 1
					if $icount = 100 then exitloop
				wend
			endif
			If _Sleep(100) Then ExitLoop
			for $i=0 to Ubound($TroopName) - 1
				If GUICtrlRead(eval("txtNum" & $TroopName[$i])) <> "0" Then
					$heightTroop = 278
					$positionTroop = $TroopNamePosition[$i]
					if $TroopNamePosition[$i] > 4 then
						$heightTroop = 384
						$positionTroop = $TroopNamePosition[$i] - 5
					endif
					assign(("troopFirst" & $TroopName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					if eval("troopFirst" & $TroopName[$i]) = 0 then
						If _Sleep(100) Then ExitLoop
						assign(("troopFirst" & $TroopName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					endif
				Endif
			next
			Local $TempTroopName = ""
			for $i=0 to Ubound($TroopName) - 1
			   If GUICtrlRead(eval("txtNum" & $TroopName[$i])) <> "0" And eval("Cur" & $TroopName[$i]) > 0 Then
				   If IsOdd($brrNum-1) AND $TroopRotateIndex[$i] <> -1 Then
						; If no need to train the replacement troop, don't rotate order
						If GUICtrlRead(eval("txtNum" & $TroopName[$TroopRotateIndex[$i]])) <> "0" And eval("Cur" & $TroopName[$TroopRotateIndex[$i]]) > 0 Then
							$TempTroopName = $TroopName[$i]
							$TroopName[$i] = $TroopName[$TroopRotateIndex[$i]]
						EndIf
				   EndIf
				   ;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
				   If eval("Cur" & $TroopName[$i]) > 0  Then
						if eval($TroopName[$i] & "EBarrack") = 0 then
							TrainIt(eval("e" & $TroopName[$i]), 1)
							$BarrackStatus[$brrNum-1] = true
						elseif eval($TroopName[$i] & "EBarrack") >= eval("Cur" & $TroopName[$i]) then
							TrainIt(eval("e" & $TroopName[$i]), eval("Cur" & $TroopName[$i]))
							$BarrackStatus[$brrNum-1] = true
						else
							TrainIt(eval("e" & $TroopName[$i]), eval($TroopName[$i] & "EBarrack"))
							$BarrackStatus[$brrNum-1] = true
						endif
				   EndIf
			   EndIf
			   If $TempTroopName <> "" Then
				   $TroopName[$i] = $TempTroopName
				   $TempTroopName = ""
			   EndIf
			next

		   If _Sleep(100) Then ExitLoop

			for $i=0 to Ubound($TroopName) - 1
			   If GUICtrlRead(eval("txtNum" & $TroopName[$i])) <> "0" Then
					$heightTroop = 278
					$positionTroop = $TroopNamePosition[$i]
					if $TroopNamePosition[$i] > 4 then
						$heightTroop = 384
						$positionTroop = $TroopNamePosition[$i] - 5
					endif
					assign(("troopSecond" & $TroopName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					if eval("troopSecond" & $TroopName[$i]) = 0 then
						If _Sleep(100) Then ExitLoop
						assign(("troopSecond" & $TroopName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					endif
				endif
			next

			$troopNameCooking = ""
			for $i=0 to Ubound($TroopName) - 1
			   if eval("troopSecond" & $TroopName[$i]) > eval("troopFirst" & $TroopName[$i]) and GUICtrlRead(eval("txtNum" & $TroopName[$i])) <> "0" then
				   $ArmyComp += (eval("troopSecond" & $TroopName[$i]) - eval("troopFirst" & $TroopName[$i])) * $TroopHeight[$i]
				   assign(("Cur" & $TroopName[$i]) , eval("Cur" & $TroopName[$i]) - (eval("troopSecond" & $TroopName[$i]) - eval("troopFirst" & $TroopName[$i])))
			   endif
			   if eval("troopSecond" & $TroopName[$i]) > 0 then
					$troopNameCooking = $troopNameCooking & $i & ";"
				endif
			next

			;if  _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) then
			if  _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) or $troopNameCooking = "" then
				$BarrackStatus[$brrNum-1] = false
			else
				$BarrackStatus[$brrNum-1] = true
			endif

			if _ColorCheck(_GetPixelColor(327, 520, True), Hex(0xD03838, 6), 20) then
			    $icount = 0
				while not _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20)
				    Click(496, 197, 5)
					$icount += 1
					if $icount = 100 then exitloop
				wend
				If _Sleep(100) Then ExitLoop
				TrainIt($eArch, 20)
			endif

			if $BarrackStatus[0] = false and $BarrackStatus[1] = false and $BarrackStatus[2] = false and $BarrackStatus[3] = false and not $FirstStart then
				if not $isDarkBuild or ($BarrackDarkStatus[0] = false and $BarrackDarkStatus[1] = false) then
					TrainIt($eArch, 20)
				endif
			endif

		   Click($PrevPos[0], $PrevPos[1]) ;click prev button
		   If _Sleep(500) Then ExitLoop
			$icount = 0
			while not isBarrack()
				If _Sleep(200) Then ExitLoop
				$icount = $icount + 1
				if $icount = 5 then ExitLoop
			wend
		   If $brrNum >= $barrackNum Then ExitLoop ; make sure no more infiniti loop
		wend

 EndIf

 ;dark here

	If $isDarkBuild Then
		$iBarrHere = 0
		$brrDarkNum = 0
		while 1
			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			if(isDarkBarrack() or $iBarrHere = 5) then ExitLoop
		wend

		while isDarkBarrack()
			$brrDarkNum += 1
;~ 			; SetLog("====== Barrack: " & $brrDarkNum & " ======", $COLOR_PURPLE)
			if StringInStr($sBotDll, "CGBPlugin.dll") < 1 then
				ExitLoop
			endif
			if $fullArmy or $FirstStart then
				$icount = 0
				while not _ColorCheck(_GetPixelColor(496, 197,True), Hex(0xE0E4D0, 6), 20)
					Click(496, 197, 10)
					$icount += 1
					if $icount = 100 then exitloop
				wend
			endif

			If _Sleep(100) Then ExitLoop
			for $i=0 to Ubound($TroopDarkName) - 1
				If GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$heightTroop = 278
					$positionTroop = $TroopDarkNamePosition[$i]
					if $TroopDarkNamePosition[$i] > 4 then
						$heightTroop = 384
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					endif

					assign(("troopFirst" & $TroopDarkName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					if eval("troopFirst" & $TroopDarkName[$i]) = 0 then
						If _Sleep(100) Then ExitLoop
						assign(("troopFirst" & $TroopDarkName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					endif
				Endif
			next

			for $i=0 to Ubound($TroopDarkName) - 1
			   If GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) <> "0" And eval("Cur" & $TroopDarkName[$i]) > 0 Then
				   ;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
				   If eval("Cur" & $TroopDarkName[$i]) > 0  Then
						if eval($TroopDarkName[$i] & "EBarrack") = 0 then
							TrainIt(eval("e" & $TroopDarkName[$i]), 1)
							$BarrackDarkStatus[$brrDarkNum-1] = true
						elseif eval($TroopDarkName[$i] & "EBarrack") >= eval("Cur" & $TroopDarkName[$i]) then
							TrainIt(eval("e" & $TroopDarkName[$i]), eval("Cur" & $TroopDarkName[$i]))
							$BarrackDarkStatus[$brrDarkNum-1] = true
						else
							TrainIt(eval("e" & $TroopDarkName[$i]), eval($TroopDarkName[$i] & "EBarrack"))
							$BarrackDarkStatus[$brrDarkNum-1] = true
						endif
				   EndIf
			   EndIf
			next

			If _Sleep(100) Then ExitLoop

		   for $i=0 to Ubound($TroopDarkName) - 1
				If GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$heightTroop = 278
					$positionTroop = $TroopDarkNamePosition[$i]
					if $TroopDarkNamePosition[$i] > 4 then
						$heightTroop = 384
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					endif
					assign(("troopSecond" & $TroopDarkName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					if eval("troopSecond" & $TroopDarkName[$i]) = 0 then
						If _Sleep(100) Then ExitLoop
						assign(("troopSecond" & $TroopDarkName[$i]) , Number(getOther(171 + 107 * $positionTroop, $heightTroop, "Barrack")))
					endif
				endif
			next


			for $i=0 to Ubound($TroopDarkName) - 1
			   if eval("troopSecond" & $TroopDarkName[$i]) > eval("troopFirst" & $TroopDarkName[$i]) and GUICtrlRead(eval("txtNum" & $TroopDarkName[$i])) <> "0" then
				   $ArmyComp += (eval("troopSecond" & $TroopDarkName[$i]) - eval("troopFirst" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
				   assign(("Cur" & $TroopDarkName[$i]) , eval("Cur" & $TroopDarkName[$i]) - (eval("troopSecond" & $TroopDarkName[$i]) - eval("troopFirst" & $TroopDarkName[$i])))
				endif
			next

			if  _ColorCheck(_GetPixelColor(496, 197,True), Hex(0xE0E4D0, 6), 20) then
				$BarrackDarkStatus[$brrDarkNum-1] = false
			else
				$BarrackDarkStatus[$brrDarkNum-1] = true
			endif

			if _ColorCheck(_GetPixelColor(327, 520,True), Hex(0xD03838, 6), 20) then
				$icount = 0
				while not _ColorCheck(_GetPixelColor(496, 197,True), Hex(0xE0E4D0, 6), 20)
					Click(496, 197, 5)
					$icount += 1
					if $icount = 100 then exitloop
				wend
				If _Sleep(100) Then ExitLoop
				TrainIt($eMini, 10)
			endif

			if $BarrackDarkStatus[0] = false and $BarrackDarkStatus[1] = false and (not $isNormalBuild) and (not $FirstStart) then
				TrainIt($eMini, 6)
			endif

			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button

		   If _Sleep(500) Then ExitLoop
			$icount = 0
			while not isDarkBarrack()
				If _Sleep(200) Then ExitLoop
				$icount = $icount + 1
				if $icount = 5 then ExitLoop
			wend
			If $brrDarkNum >= $barrackDarkNum Then ExitLoop ; make sure no more infiniti loop
		wend
		;end dark
	EndIf

	if _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 8 and $isNormalBuild and $BarrackStatus[0] = false and $BarrackStatus[1] = false and $BarrackStatus[2] = false and $BarrackStatus[3] = false and not $FirstStart then
		if not $isDarkBuild or ($BarrackDarkStatus[0] = false and $BarrackDarkStatus[1] = false) then
			train()
			return
		endif
	endif

  If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
      $iBarrHere = 0
      while not isSpellFactory()
			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			If $iBarrHere = 7 then ExitLoop
	  wend

		if isSpellFactory() then
			SetLog("Create Lightning Spell", $COLOR_BLUE)
			Local $x = 0
			While 1
				_CaptureRegion()
				If _sleep(500) Then Return
				If  _ColorCheck(_GetPixelColor(237, 354, True), Hex(0xFFFFFF, 6), 20) = False Then
					setlog("Not enough Elixir to create Spell", $COLOR_RED)
					ExitLoop
				Elseif  _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x1A1A1A, 6), 20) Then
					setlog("Spell Factory Full", $COLOR_RED)
					ExitLoop
				Else
					Click(252, 354, 1, 20)
					$x = $x + 1
				EndIf
				If $x = 5 Then
					ExitLoop
				EndIf
			WEnd
			If $x = 0 then
				else
					SetLog("Created " & $x &" Lightning Spell(s)", $COLOR_BLUE)
			Endif
	else
		SetLog("Spell Factory not found...", $COLOR_BLUE)
	endif
   Else
   ;setlog("Spell Factory is not checked, Skip Create", $COLOR_RED)

   EndIf ; End Spell Factory

	If _Sleep(200) Then Return
	Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay

	$FirstStart = false
;~         SetLog("========================", $COLOR_GREEN)
	IF _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
;~ 		SetLog("========================", $COLOR_GREEN)
	EndIf

 EndFunc   ;==>Train

Func checkArmyCamp()
	SetLog("Checking Army Camp...", $COLOR_BLUE)
   If _Sleep(100) Then Return

   ClickP($TopLeftClient) ;Click Away

	If $ArmyPos[0] = "" Then
		LocateBarrack(True)
		SaveConfig()
    else
	   If _Sleep(100) Then Return
	   Click($ArmyPos[0], $ArmyPos[1]) ;Click Army Camp
    endif
	_CaptureRegion()
   If _Sleep(500) Then Return
   Local $BArmyPos = _PixelSearch(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
   $icount = 0
	while not IsArray($BArmyPos)
		If _Sleep(500) Then Return
		$icount = $icount + 1
		$BArmyPos = _PixelSearch(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
		if $icount = 10 then ExitLoop
	wend
   If IsArray($BArmyPos) = False Then
	   SetLog("Your Army Camp is not available", $COLOR_RED)
	   if $TotalCamp = "" and $TotalCamp = 0 then
		   $TotalCamp = InputBox("Question", "Enter your total Army Camp capacity", "200", "", _
				 - 1, -1, 0, 0)
			$TotalCamp = int($TotalCamp)
		 Endif
	   If _Sleep(500) Then Return
   Else
	   Click($BArmyPos[0], $BArmyPos[1]) ;Click Info button
	   If _Sleep(1000) Then Return
	   $CurCamp = Number(getOther(586, 193, "Camp"))
	   if $TotalCamp = "" or $TotalCamp = 0 then
		$TotalCamp = Number(getOther(586, 193, "Camp", True))
	   endif

	   if $TotalCamp = "" and $TotalCamp = 0 then
		   $TotalCamp = InputBox("Question", "Enter your total Army Camp capacity", "200", "", _
				 Default,Default, 600, 300)
			$TotalCamp = int($TotalCamp)
		 Endif
	   If _Sleep(500) Then Return

	   SetLog("Total Army Camp capacity: " & $CurCamp & "/" & $TotalCamp)
	   ;If _ColorCheck(_GetPixelColor(692, 208), Hex(0x90DB38, 6), 20) and $ichkFullTroop = 0 Then

		if ($CurCamp >= ($TotalCamp * $fulltroop/100)) then
			$fullArmy = True
		endif

	   if $fullArmy then
	   elseIf ($CurCamp+1)=$TotalCamp Then
		   $fullArmy = True
	   Else
		  _CaptureRegion()
		  For $i = 0 To 6
			  Local $TroopKind = _GetPixelColor(230 + 71 * $i, 359)
			  Local $TroopKind2 = _GetPixelColor(230 + 71 * $i, 371)
			  Local $TroopKind3 = _GetPixelColor((230 + 71 * $i)-4, 380) ; problens between dragons & Witches
			  Local $TroopName = 0
			  Local $TroopQ = getOther(229 + 71 * $i, 413, "Camp")
			  If _ColorCheck($TroopKind, Hex(0xF85CCB, 6), 20) Then
				 if ($CurArch=0 and $FirstStart) then $CurArch -= $TroopQ
				 $TroopName = "Archers"
			  ElseIf _ColorCheck($TroopKind, Hex(0xF8E439, 6), 20) Then
				 if ($CurBarb=0 and $FirstStart) then $CurBarb -= $TroopQ
				 $TroopName = "Barbarians"
			  ElseIf _ColorCheck($TroopKind, Hex(0xF8D198, 6), 20) Then
				 if ($CurGiant=0 and $FirstStart) then $CurGiant -= $TroopQ
				 $TroopName = "Giants"
			  ElseIf _ColorCheck($TroopKind, Hex(0x93EC60, 6), 20) Then
				 if ($CurGobl=0 and $FirstStart) then $CurGobl -= $TroopQ
				 $TroopName = "Goblins"
			  ElseIf (_ColorCheck($TroopKind, Hex(0x48a6e8, 6), 15) And _
				     _ColorCheck($TroopKind2, Hex(0x413f48, 6), 15)) or _
					( _ColorCheck($TroopKind, Hex(0x48a7e8, 6), 15) And _
					 _ColorCheck($TroopKind2, Hex(0x433c40, 6), 15)) Then
				 if ($CurWall=0 and $FirstStart) then $CurWall -= $TroopQ  ; compensation slot(2) -1 and slot(4) -1 #
				 $TroopName = "Wallbreakers"
			  ElseIf _ColorCheck($TroopKind, Hex(0x861c15, 6), 15) or _
				     _ColorCheck($TroopKind, Hex(0x781c10, 6), 15) or _
                     _ColorCheck($TroopKind, Hex(0x701b10, 6), 15) Then
				  if ($CurBall=0 and $FirstStart) then $CurBall -= $TroopQ   ; compensation slot(2) -1 and slot(4) -1 #
				  $TroopName = "Balloons"
			   ElseIf _ColorCheck($TroopKind, Hex(0xF8F8E0, 6), 15) OR _
				      _ColorCheck($TroopKind, Hex(0xF8FCE0, 6), 15) OR _
				      _ColorCheck($TroopKind, Hex(0xF8F9E0, 6), 15) Then
				  if ($CurHeal=0 and $FirstStart) then $CurHeal -= $TroopQ ; compensation slot(2) -1 and slot(4) -1 #
				  $TroopName = "Healers"
			   ElseIf _ColorCheck($TroopKind, Hex(0xa86c68, 6), 15) Or _
				      _ColorCheck($TroopKind, Hex(0xb8746b, 6), 15) Or _
				      _ColorCheck($TroopKind, Hex(0xb97870, 6), 15) Then
				  if ($CurWiza=0 and $FirstStart) then $CurWiza -= $TroopQ
				  $TroopName = "Wizards"
			   ElseIf _ColorCheck($TroopKind3, Hex(0x302748, 6), 15) OR _
					  _ColorCheck($TroopKind3, Hex(0x302746, 6), 15) OR _
                      _ColorCheck($TroopKind3, Hex(0x2e2440, 6), 15) Then
				  if ($CurDrag=0 and $FirstStart) then $CurDrag -= $TroopQ  ; compensation slot(2) -1 and slot(4) -1 #
			      $TroopName = "Dragons"
			   ElseIf _ColorCheck($TroopKind2, Hex(0x81a1b1, 6), 15) Or _
					  _ColorCheck($TroopKind2, Hex(0x88a3b6, 6), 15) Or _
				      _ColorCheck($TroopKind2, Hex(0x88a6b8, 6), 15) then
				  if ($CurPekk=0 and $FirstStart) then $CurPekk -= $TroopQ
				  $TroopName = "Pekkas"
			  ElseIf _ColorCheck($TroopKind, Hex(0x171f38, 6), 15) Or _
				     _ColorCheck($TroopKind, Hex(0x111c38, 6), 15) Or _
					 _ColorCheck($TroopKind, Hex(0x181c38, 6), 15) Then
				 if ($CurMini=0 and $FirstStart) then $CurMini -= $TroopQ
				 $TroopName = "Minions"
			  ElseIf _ColorCheck($TroopKind3, Hex(0x995242, 6), 15) Or _
                     _ColorCheck($TroopKind3, Hex(0x9e5440, 6), 15) Or _
					 _ColorCheck($TroopKind3, Hex(0x9e4c37, 6), 15) Then
				 if ($CurHogs=0 and $FirstStart) then $CurHogs -= $TroopQ
				 $TroopName = "Hog Riders"
			  ElseIf _ColorCheck($TroopKind, Hex(0x9d3500, 6), 15) Or _
                     _ColorCheck($TroopKind, Hex(0x973b08, 6), 15) Or _
					 _ColorCheck($TroopKind, Hex(0xa03800, 6), 15) Then
				 if ($CurValk=0 and $FirstStart) then $CurValk -= $TroopQ ; compensation slot(2) -1 and slot(4) -1 #
				 $TroopName = "Valkyries"
			  ElseIf _ColorCheck($TroopKind2, Hex(0x6a6151, 6), 15) Or _
                     _ColorCheck($TroopKind2, Hex(0x736453, 6), 15) Or _
					 _ColorCheck($TroopKind2, Hex(0x7c6e5b, 6), 15) Then
				 if ($CurGole=0 and $FirstStart) then $CurGole -= $TroopQ ; compensation slot(2) -1 and slot(4) -1 #
				 $TroopName = "Golems"
			  ElseIf _ColorCheck($TroopKind3, Hex(0xf845ae, 6), 20) Or _
                     _ColorCheck($TroopKind3, Hex(0xf83ba2, 6), 20) Or _
					 _ColorCheck($TroopKind3, Hex(0xf12684, 6), 20) Or _
					 _ColorCheck($TroopKind3, Hex(0xd8155b, 6), 20) Then
				 if ($CurWitc=0 and $FirstStart) then $CurWitc -= $TroopQ ; compensation slot(2) -1 and slot(4) -1 # Slot(6) d8155b
				 $TroopName = "Witches"
			  ElseIf _ColorCheck($TroopKind3, Hex(0x686150, 6), 15) Or _
                     _ColorCheck($TroopKind3, Hex(0x615c4f, 6), 15) Or _
					 _ColorCheck($TroopKind3, Hex(0x60594f, 6), 15) Then
				 if ($CurLava=0 and $FirstStart) then $CurLava -= $TroopQ ; compensation slot(2) -1 and slot(4) -1 #
				 $TroopName = "Lava Hounds"
			  EndIf
			  ;656,359,0xBCBAAC   ---   6  --nothing
			  If $TroopQ <> 0 Then SetLog(" - No. of " & $TroopName & ": " & $TroopQ)
		   Next
		EndIf
		if not $fullArmy and $FirstStart then
			$ArmyComp = $CurCamp
	    endif
	   ClickP($TopLeftClient) ;Click Away
	   $FirstCampView = True
	 EndIf

Endfunc

Func IsOdd($num)
	if (Mod($num, 2) >= 1)  Then
		return True
	Else
		return False
	EndIf
EndFunc

Func SetTroops()
	If $OptTrophyMode = 1 Then
		for $i=0 to Ubound($THSnipeTroopGroup,1) - 1
			$TroopName[$i]         						= $THSnipeTroopGroup[$i][0]
			$TroopNamePosition[$i] 						= $THSnipeTroopGroup[$i][1]
			$TroopHeight[$i]       						= $THSnipeTroopGroup[$i][2]
			$TroopRotateIndex[$i]       				= $THSnipeTroopGroup[$i][3]
		next
	EndIf
EndFunc

Func RevertTroops()
	for $i=0 to Ubound($TroopGroup,1) - 1
		$TroopName[$i]         							= $TroopGroup[$i][0]
		$TroopNamePosition[$i] 							= $TroopGroup[$i][1]
		$TroopHeight[$i]       							= $TroopGroup[$i][2]
		$TroopRotateIndex[$i]       					= $TroopGroup[$i][3]
	next
EndFunc
