; #FUNCTION# ====================================================================================================================
; Name ..........: algorith_AllTroops
; Description ...: This file contens all functions to attack algorithm will all Troops , using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
; Syntax ........: SetSleep() , OldDropTroop() , DropOnEdge () , DropOnEdges() , LauchTroop() , algorithm_AllTroops()
; Parameters ....: None
; Return values .: None
; Author ........: Didipe from Gamebot.org
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func SetSleep($type)
	Switch $type
		Case 0
			If $iRandomspeedatk = 1 Then
				Return Round(Random(1, 10)) * 10
			Else
				Return ($icmbUnitDelay + 1) * 10
			EndIf
		Case 1
			If $iRandomspeedatk = 1 Then
				Return Round(Random(1, 10)) * 100
			Else
				Return ($icmbWaveDelay + 1) * 100
			EndIf
	EndSwitch
EndFunc   ;==>SetSleep

; Old mecanism, not used anymore
Func OldDropTroop($troop, $position, $nbperspot)
	SelectDropTroop($troop) ;Select Troop
	If _Sleep(100) Then Return
	For $i = 0 To 4
		Click($position[$i][0], $position[$i][1], $nbperspot, 1)
		If _Sleep(50) Then Return
	Next
EndFunc   ;==>OldDropTroop


; improved function, that avoids to only drop on 5 discret drop points :
Func DropOnEdge($troop, $edge, $number, $slotsPerEdge = 0, $edge2 = -1, $x = -1)
	If $number = 0 Then Return
	If _Sleep(100) Then Return
	SelectDropTroop($troop) ;Select Troop
	If _Sleep(300) Then Return
	If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
	If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
		Click($edge[2][0], $edge[2][1], $number, 250)
		If $edge2 <> -1 Then Click($edge2[2][0], $edge2[2][1], $number, 250)
		If _Sleep(50) Then Return
	ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
		Local $half = Ceiling($number / 2)
		Click($edge[1][0], $edge[1][1], $half)
		If $edge2 <> -1 Then
			If _Sleep(SetSleep(0)) Then Return
			Click($edge2[1][0], $edge2[1][1], $half)
		EndIf
		If _Sleep(SetSleep(0)) Then Return
		Click($edge[3][0], $edge[3][1], $number - $half)
		If $edge2 <> -1 Then
			If _Sleep(SetSleep(0)) Then Return
			Click($edge2[3][0], $edge2[3][1], $number - $half)
		EndIf
		If _Sleep(SetSleep(0)) Then Return
	Else
		Local $minX = $edge[0][0]
		Local $maxX = $edge[4][0]
		Local $minY = $edge[0][1]
		Local $maxY = $edge[4][1]
		If $edge2 <> -1 Then
			Local $minX2 = $edge2[0][0]
			Local $maxX2 = $edge2[4][0]
			Local $minY2 = $edge2[0][1]
			Local $maxY2 = $edge2[4][1]
		EndIf
		Local $nbTroopsLeft = $number
		For $i = 0 To $slotsPerEdge - 1
			Local $nbtroopPerSlot = Round($nbTroopsLeft / ($slotsPerEdge - $i)) ; progressively adapt the number of drops to fill at the best
			Local $posX = $minX + (($maxX - $minX) * $i) / ($slotsPerEdge - 1)
			Local $posY = $minY + (($maxY - $minY) * $i) / ($slotsPerEdge - 1)
			Click($posX, $posY, $nbtroopPerSlot)
			If $edge2 <> -1 Then ; for 2, 3 and 4 sides attack use 2x dropping
				Local $posX2 = $maxX2 - (($maxX2 - $minX2) * $i) / ($slotsPerEdge - 1)
				Local $posY2 = $maxY2 - (($maxY2 - $minY2) * $i) / ($slotsPerEdge - 1)
				;If $x = 0 Then
				;  If _Sleep(SetSleep(0)) Then Return ; add delay for first wave attack to prevent skip dropping troops, must add for 4 sides attack
				;EndIf
				Click($posX2, $posY2, $nbtroopPerSlot)
				$nbTroopsLeft -= $nbtroopPerSlot
			Else
				$nbTroopsLeft -= $nbtroopPerSlot
			EndIf
			If _Sleep(SetSleep(0)) Then Return
		Next
	EndIf
EndFunc   ;==>DropOnEdge

Func DropOnEdges($troop, $nbSides, $number, $slotsPerEdge = 0)
	If $nbSides = 0 Or $number = 1 Then
		OldDropTroop($troop, $Edges[0], $number);
		Return
	EndIf
	If $nbSides < 1 Then Return
	Local $nbTroopsLeft = $number
	If $nbSides = 4 Then
		For $i = 0 To $nbSides - 3
			Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
			DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i + 2], $i)
			$nbTroopsLeft -= $nbTroopsPerEdge * 2
		Next
		Return
	EndIf
	For $i = 0 To $nbSides - 1
		If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
			Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i))
			DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge)
			$nbTroopsLeft -= $nbTroopsPerEdge
		ElseIf ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
			Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
			DropOnEdge($troop, $Edges[$i + 3], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i + 1])
			$nbTroopsLeft -= $nbTroopsPerEdge * 2
		EndIf
	Next
EndFunc   ;==>DropOnEdges

Func LauchTroop($troopKind, $nbSides, $waveNb, $maxWaveNb, $slotsPerEdge = 0)
	Local $troop = -1
	Local $troopNb = 0
	Local $name = ""
	For $i = 0 To 8 ; identify the position of this kind of troop
		If $atkTroops[$i][0] = $troopKind Then
			$troop = $i
			$troopNb = Ceiling($atkTroops[$i][1] / $maxWaveNb)
			Local $plural = 0
			If $troopNb > 1 Then $plural = 1
			$name = NameOfTroop($troopKind, $plural)
		EndIf
	Next

	If ($troop = -1) Or ($troopNb = 0) Then
		;if $waveNb > 0 Then SetLog("Skipping wave of " & $name & " (" & $troopKind & ") : nothing to drop" )
		Return False; nothing to do => skip this wave
	EndIf

	Local $waveName = "first"
	If $waveNb = 2 Then $waveName = "second"
	If $waveNb = 3 Then $waveName = "third"
	If $maxWaveNb = 1 Then $waveName = "only"
	If $waveNb = 0 Then $waveName = "last"
	SetLog("Dropping " & $waveName & " wave of " & $troopNb & " " & $name, $COLOR_GREEN)

	DropTroop($troop, $nbSides, $troopNb, $slotsPerEdge)
	Return True
EndFunc   ;==>LauchTroop


Func LaunchTroop2($listInfoDeploy, $CC, $King, $Queen)

	Local $listListInfoDeployTroopPixel[0]


	If ($chkRedArea = 1) Then
		For $i = 0 To UBound($listInfoDeploy) - 1
			Local $troop = -1
			Local $troopNb = 0
			Local $name = ""
			$troopKind = $listInfoDeploy[$i][0]
			$nbSides = $listInfoDeploy[$i][1]
			$waveNb = $listInfoDeploy[$i][2]
			$maxWaveNb = $listInfoDeploy[$i][3]
			$slotsPerEdge = $listInfoDeploy[$i][4]
			If (IsNumber($troopKind)) Then
				For $j = 0 To 8 ; identify the position of this kind of troop
					If $atkTroops[$j][0] = $troopKind Then
						$troop = $j
						$troopNb = Ceiling($atkTroops[$j][1] / $maxWaveNb)
						Local $plural = 0
						If $troopNb > 1 Then $plural = 1
						$name = NameOfTroop($troopKind, $plural)
					EndIf
				Next
			EndIf
			If ($troop <> -1 And $troopNb > 0) Or IsString($troopKind) Then
				Local $listInfoDeployTroopPixel
				If (UBound($listListInfoDeployTroopPixel) < $waveNb) Then
					ReDim $listListInfoDeployTroopPixel[$waveNb]
					Local $newListInfoDeployTroopPixel[0]
					$listListInfoDeployTroopPixel[$waveNb - 1] = $newListInfoDeployTroopPixel
				EndIf
				$listInfoDeployTroopPixel = $listListInfoDeployTroopPixel[$waveNb - 1]

				ReDim $listInfoDeployTroopPixel[UBound($listInfoDeployTroopPixel) + 1]
				If (IsString($troopKind)) Then
					Local $arrCCorHeroes[1] = [$troopKind]
					$listInfoDeployTroopPixel[UBound($listInfoDeployTroopPixel) - 1] = $arrCCorHeroes
				Else
					Local $infoDropTroop = DropTroop2($troop, $nbSides, $troopNb, $slotsPerEdge, $name)
					$listInfoDeployTroopPixel[UBound($listInfoDeployTroopPixel) - 1] = $infoDropTroop
				EndIf
				$listListInfoDeployTroopPixel[$waveNb - 1] = $listInfoDeployTroopPixel
			EndIf
		Next
		Local $isCCDropped = False
		Local $isHeroesDropped = False
		If ($iCmbSmartDeploy = 0) Then
			For $numWave = 0 To UBound($listListInfoDeployTroopPixel) - 1
				Local $listInfoDeployTroopPixel = $listListInfoDeployTroopPixel[$numWave]
				For $i = 0 To UBound($listInfoDeployTroopPixel) - 1
					Local $infoPixelDropTroop = $listInfoDeployTroopPixel[$i]
					If (IsString($infoPixelDropTroop[0]) And ($infoPixelDropTroop[0] = "CC" Or $infoPixelDropTroop[0] = "HEROES")) Then
						Local $pixelRandomDrop = $PixelRedArea[Round(Random(0, UBound($PixelRedArea) - 1))]
						If ($infoPixelDropTroop[0] = "CC") Then
							dropCC($pixelRandomDrop[0], $pixelRandomDrop[1], $CC)
						ElseIf ($infoPixelDropTroop[0] = "HEROES") Then
							dropHeroes($pixelRandomDrop[0], $pixelRandomDrop[1], $King, $Queen)
							$isHeroesDropped = True
						EndIf
					Else
						If _Sleep(100) Then Return
						SelectDropTroop($infoPixelDropTroop[0]) ;Select Troop
						If _Sleep(100) Then Return
						Local $waveName = "first"
						If $numWave + 1 = 2 Then $waveName = "second"
						If $numWave + 1 = 3 Then $waveName = "third"
						If $numWave + 1 = 0 Then $waveName = "last"
						SetLog("Dropping " & $waveName & " wave of " & $infoPixelDropTroop[5] & " " & $infoPixelDropTroop[4], $COLOR_GREEN)


						DropOnPixel($infoPixelDropTroop[0], $infoPixelDropTroop[1], $infoPixelDropTroop[2], $infoPixelDropTroop[3])
					EndIf
					If ($isHeroesDropped) Then
						CheckHeroesHealth()
					EndIf
					If _Sleep(SetSleep(1)) Then Return
				Next
			Next
		Else

			For $numWave = 0 To UBound($listListInfoDeployTroopPixel) - 1
				Local $listInfoDeployTroopPixel = $listListInfoDeployTroopPixel[$numWave]
				If (UBound($listInfoDeployTroopPixel) > 0) Then
					Local $infoTroopListArrPixel = $listInfoDeployTroopPixel[0]
					Local $numberSidesDropTroop = 1

					For $i = 0 To UBound($listInfoDeployTroopPixel) - 1
						$infoTroopListArrPixel = $listInfoDeployTroopPixel[$i]
						If (UBound($infoTroopListArrPixel) > 1) Then
							Local $infoListArrPixel = $infoTroopListArrPixel[1]
							$numberSidesDropTroop = UBound($infoListArrPixel)
							ExitLoop
						EndIf
					Next

					If ($numberSidesDropTroop > 0) Then
						For $i = 0 To $numberSidesDropTroop - 1
							For $j = 0 To UBound($listInfoDeployTroopPixel) - 1
								$infoTroopListArrPixel = $listInfoDeployTroopPixel[$j]
								If (IsString($infoTroopListArrPixel[0]) And ($infoTroopListArrPixel[0] = "CC" Or $infoTroopListArrPixel[0] = "HEROES")) Then
									Local $pixelRandomDrop = $PixelRedArea[Round(Random(0, UBound($PixelRedArea) - 1))]
									If ($isCCDropped = False And $infoTroopListArrPixel[0] = "CC") Then
										dropCC($pixelRandomDrop[0], $pixelRandomDrop[1], $CC)
										$isCCDropped = True
									ElseIf ($isHeroesDropped = False And $infoTroopListArrPixel[0] = "HEROES" And $i = $numberSidesDropTroop - 1) Then
										dropHeroes($pixelRandomDrop[0], $pixelRandomDrop[1], $King, $Queen)
										$isHeroesDropped = True
									EndIf
								Else
									$infoListArrPixel = $infoTroopListArrPixel[1]
									$listPixel = $infoListArrPixel[$i]
									;infoPixelDropTroop : First element in array contains troop and list of array to drop troop
									If _Sleep(100) Then Return
									SelectDropTroop($infoTroopListArrPixel[0]) ;Select Troop
									If _Sleep(300) Then Return
									SetLog("Dropping " & $infoTroopListArrPixel[2] & "  of " & $infoTroopListArrPixel[5] & " => on each side (side : " & $i + 1 & ")", $COLOR_GREEN)
									Local $pixelDropTroop[1] = [$listPixel]
									DropOnPixel($infoTroopListArrPixel[0], $pixelDropTroop, $infoTroopListArrPixel[2], $infoTroopListArrPixel[3])
								EndIf
								If ($isHeroesDropped) Then
									CheckHeroesHealth()
								EndIf
							Next
						Next
					EndIf
				EndIf
				If _Sleep(SetSleep(1)) Then Return
			Next
		EndIf
		For $numWave = 0 To UBound($listListInfoDeployTroopPixel) - 1
			Local $listInfoDeployTroopPixel = $listListInfoDeployTroopPixel[$numWave]
			For $i = 0 To UBound($listInfoDeployTroopPixel) - 1
				Local $infoPixelDropTroop = $listInfoDeployTroopPixel[$i]
				If Not(IsString($infoPixelDropTroop[0]) And ($infoPixelDropTroop[0] = "CC" Or $infoPixelDropTroop[0] = "HEROES")) Then
					Local $numberLeft = ReadTroopQuantity($infoPixelDropTroop[0])
					SetLog("NumberLeft : "&$numberLeft)
					If ($numberLeft > 0) Then
						If _Sleep(100) Then Return
						SelectDropTroop($infoPixelDropTroop[0]) ;Select Troop
						If _Sleep(300) Then Return
						SetLog("Dropping last " & $numberLeft & "  of " & $infoPixelDropTroop[5], $COLOR_GREEN)

						DropOnPixel($infoPixelDropTroop[0], $infoPixelDropTroop[1], Ceiling($numberLeft / UBound($infoPixelDropTroop[1])), $infoPixelDropTroop[3])
					EndIf
				EndIf
			Next
		Next

	Else
		For $i = 0 To UBound($listInfoDeploy) - 1
			If (IsString($listInfoDeploy[$i][0]) And ($listInfoDeploy[$i][0] = "CC" Or $listInfoDeploy[$i][0] = "HEROES")) Then
				Local $RandomEdge = $Edges[Round(Random(0, 3))]
				Local $RandomXY = Round(Random(0, 4))
				If ($listInfoDeploy[$i][0] = "CC") Then
					dropCC($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $CC)
				ElseIf ($listInfoDeploy[$i][0] = "HEROES") Then
					dropHeroes($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $King, $Queen)
				EndIf
			Else
				If LauchTroop($listInfoDeploy[$i][0], $listInfoDeploy[$i][1], $listInfoDeploy[$i][2], $listInfoDeploy[$i][3], $listInfoDeploy[$i][4]) Then
					If _Sleep(SetSleep(1)) Then Return
				EndIf
			EndIf
		Next

	EndIf
	Return True

EndFunc   ;==>LaunchTroop2


Func algorithm_AllTroops() ;Attack Algorithm for all existing troops
	If ($chkRedArea) Then
		SetLog("Calculating Smart Attack Strategy", $COLOR_BLUE)
		Local $hTimer = TimerInit()
		_WinAPI_DeleteObject($hBitmapFirst)
		$hBitmapFirst = _CaptureRegion2()
		_GetRedArea()

		SetLog("Calculated  (in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds) :")
		;SetLog("	[" & UBound($PixelTopLeft) & "] pixels TopLeft")
		;SetLog("	[" & UBound($PixelTopRight) & "] pixels TopRight")
		;SetLog("	[" & UBound($PixelBottomLeft) & "] pixels BottomLeft")
		;SetLog("	[" & UBound($PixelBottomRight) & "] pixels BottomRight")

		If $bBtnAttackNowPressed = True Then
			If  $ichkAtkNowMines = True Then
				SetLog("Locating Village Pump & Mines", $COLOR_BLUE)
				$hTimer = TimerInit()
				Global $PixelMine[0]
				Global $PixelElixir[0]
				Global $PixelDarkElixir[0]
				Global $PixelNearCollector[0]
				$PixelMine = GetLocationMine()
				If (IsArray($PixelMine)) Then
					_ArrayAdd($PixelNearCollector, $PixelMine)
				EndIf
				$PixelElixir = GetLocationElixir()
				If (IsArray($PixelElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelElixir)
				EndIf
				$PixelDarkElixir = GetLocationDarkElixir()
				If (IsArray($PixelDarkElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelDarkElixir)
				EndIf
				SetLog("Located  (in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds) :")
				SetLog("[" & UBound($PixelMine) & "] Gold Mines")
				SetLog("[" & UBound($PixelElixir) & "] Elixir Collectors")
				SetLog("[" & UBound($PixelDarkElixir) & "] Dark Elixir Drill/s")
			EndIf
		ElseIf ($chkSmartAttack[0] = 1 Or $chkSmartAttack[1] = 1 Or $chkSmartAttack[2] = 1) Then
			SetLog("Locating Village Pump & Mines", $COLOR_BLUE)
			$hTimer = TimerInit()
			Global $PixelMine[0]
			Global $PixelElixir[0]
			Global $PixelDarkElixir[0]
			Global $PixelNearCollector[0]
			; If drop troop near gold mine
			If ($chkSmartAttack[0] = 1) Then
				$PixelMine = GetLocationMine()
				If (IsArray($PixelMine)) Then
					_ArrayAdd($PixelNearCollector, $PixelMine)
				EndIf
			EndIf
			; If drop troop near elixir collector
			If ($chkSmartAttack[1] = 1) Then
				$PixelElixir = GetLocationElixir()
				If (IsArray($PixelElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelElixir)
				EndIf
			EndIf
			; If drop troop near dark elixir drill
			If ($chkSmartAttack[2] = 1) Then
				$PixelDarkElixir = GetLocationDarkElixir()
				If (IsArray($PixelDarkElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelDarkElixir)
				EndIf
			EndIf
			SetLog("Located  (in " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds) :")
			SetLog("[" & UBound($PixelMine) & "] Gold Mines")
			SetLog("[" & UBound($PixelElixir) & "] Elixir Collectors")
			SetLog("[" & UBound($PixelDarkElixir) & "] Dark Elixir Drill/s")
		EndIf

	EndIf
	$King = -1
	$Queen = -1
	$CC = -1
	For $i = 0 To 8
		If $atkTroops[$i][0] = $eCastle Then
			$CC = $i
		ElseIf $atkTroops[$i][0] = $eKing Then
			$King = $i
		ElseIf $atkTroops[$i][0] = $eQueen Then
			$Queen = $i
		EndIf
	Next

	If _Sleep(2000) Then Return

	If SearchTownHallLoc() And GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
		Switch $AttackTHType
			Case 0
				algorithmTH()
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(746, 498), Hex(0x0E1306, 6), 20) Then AttackTHNormal() ;if 'no star' use another attack mode.
			Case 1
				AttackTHNormal();Good for Masters
			Case 2
				AttackTHXtreme();Good for Champ
			Case 3
				AttackTHgbarch(); good for masters+
		EndSwitch

		If $OptTrophyMode = 1 And SearchTownHallLoc() Then; Return ;Exit attacking if trophy hunting and not bullymode

			For $i = 1 To 30
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(746, 498), Hex(0x0E1306, 6), 20) = False Then ExitLoop ;exit if not 'no star'
				_Sleep(1000)
			Next

			Click(62, 519) ;Click Surrender
			If _Sleep(3000) Then Return
			Click(512, 394) ;Click Confirm
			Return
		EndIf
	EndIf

	;############################################# LSpell Attack ############################################################
	DropLSpell()
	;########################################################################################################################
	Local $nbSides = 0
	If $bBtnAttackNowPressed = True Then
		$nbSides = ($icmbAtkNowDeploy + 1)
	Else
		$nbSides = ($deploySettings + 1)
	EndIf
	Switch $nbSides
		Case 1 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on a single side", $COLOR_BLUE)
		Case 2 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on two sides", $COLOR_BLUE)
		Case 3 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on three sides", $COLOR_BLUE)
		Case 4 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog("Attacking on all sides", $COLOR_BLUE)
	EndSwitch
	If ($nbSides = 0) Then Return
	If _Sleep(1000) Then Return

	Local $listInfoDeploy[13][5] = [[$eGiant, $nbSides, 1, 1, 2] _
			, [$eBarb, $nbSides, 1, 2, 0] _
			, [$eWall, $nbSides, 1, 1, 1] _
			, [$eArch, $nbSides, 1, 2, 0] _
			, [$eBarb, $nbSides, 2, 2, 0] _
			, [$eGobl, $nbSides, 1, 2, 0] _
			, ["CC", 1, 1, 1, 1] _
			, [$eHogs, $nbSides, 1, 1, 1] _
			, [$eWiza, $nbSides, 1, 1, 0] _
			, [$eMini, $nbSides, 1, 1, 0] _
			, [$eArch, $nbSides, 2, 2, 0] _
			, [$eGobl, $nbSides, 2, 2, 0] _
			, ["HEROES", 1, 2, 1, 1] _
			]


	LaunchTroop2($listInfoDeploy, $CC, $King, $Queen)

	If _Sleep(100) Then Return
	SetLog("Dropping left over troops", $COLOR_BLUE)
	For $x = 0 To 1
		PrepareAttack(True) ;Check remaining quantities
		For $i = $eBarb To $eLava ; lauch all remaining troops
			;If $i = $eBarb Or $i = $eArch Then
			LauchTroop($i, $nbSides, 0, 1)
			CheckHeroesHealth()
			;Else
			;	 LauchTroop($i, $nbSides, 0, 1, 2)
			;EndIf
			If _Sleep(500) Then Return
		Next
	Next

	;Activate KQ's power
	If ($checkKPower Or $checkQPower) And $iActivateKQCondition = "Manual" Then
		SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating Hero abilities", $COLOR_BLUE)
		_Sleep($delayActivateKQ)
		If $checkKPower Then
			SetLog("Activating King's power", $COLOR_BLUE)
			SelectDropTroop($King)
			$checkKPower = False
		EndIf
		If $checkQPower Then
			SetLog("Activating Queen's power", $COLOR_BLUE)
			SelectDropTroop($Queen)
			$checkQPower = False
		EndIf
	EndIf

	SetLog("Finished Attacking, waiting for the battle to end")
EndFunc   ;==>algorithm_AllTroops

Func GetLocationMine()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationMineExtractor", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationMine

Func GetLocationElixir()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationElixirExtractor", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationElixir

Func GetLocationDarkElixir()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationDarkElixirExtractor", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationDarkElixir

Func GetLocationDarkElixirStorage()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationDarkElixirStorage", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationDarkElixirStorage
; Strategy :
; 			Search red area
;			Split the result in 4 sides (global var) : Top Left / Bottom Left / Top Right / Bottom Right
;			Remove bad pixel (Suppose that pixel to deploy are in the green area)
;			Get pixel next the "out zone" , indeed the red color is very different and more uncertain
;			Sort each sides
;			Add each sides in one array (not use, but it can help to get closer pixel of all the red area)
Func _GetRedArea()
	$nameFunc = "[_GetRedArea] "
	debugRedArea($nameFunc & " IN")


	Local $colorVariation = 40
	Local $xSkip = 1
	Local $ySkip = 5

	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getRedArea", "ptr", $hBitmapFirst, "int", $xSkip, "int", $ySkip, "int", $colorVariation)
	Local $listPixelBySide = StringSplit($result[0], "#")
	$PixelTopLeft = GetPixelSide($listPixelBySide, 1)
	$PixelBottomLeft = GetPixelSide($listPixelBySide, 2)
	$PixelBottomRight = GetPixelSide($listPixelBySide, 3)
	$PixelTopRight = GetPixelSide($listPixelBySide, 4)

	Local $offsetArcher = 15
	Global $PixelTopLeftFurther[UBound($PixelTopLeft)]
	Global $PixelRedArea[UBound($PixelTopLeft) + UBound($PixelBottomLeft) + UBound($PixelTopRight) + UBound($PixelBottomRight)]
	Global $PixelRedAreaFuther[UBound($PixelTopLeft) + UBound($PixelBottomLeft) + UBound($PixelTopRight) + UBound($PixelBottomRight)]
	$count = 0
	For $i = 0 To UBound($PixelTopLeft) - 1
		$PixelTopLeftFurther[$i] = _GetOffsetTroopFurther($PixelTopLeft[$i], $eVectorLeftTop, $offsetArcher)
		$PixelRedArea[$count] = $PixelTopLeft[$i]
		$PixelRedAreaFuther[$count] = $PixelTopLeftFurther[$i]
		$count += 1
	Next
	Global $PixelBottomLeftFurther[UBound($PixelBottomLeft)]
	For $i = 0 To UBound($PixelBottomLeft) - 1
		$PixelBottomLeftFurther[$i] = _GetOffsetTroopFurther($PixelBottomLeft[$i], $eVectorLeftBottom, $offsetArcher)
		$PixelRedArea[$count] = $PixelBottomLeft[$i]
		$PixelRedAreaFuther[$count] = $PixelBottomLeftFurther[$i]
		$count += 1
	Next
	Global $PixelTopRightFurther[UBound($PixelTopRight)]
	For $i = 0 To UBound($PixelTopRight) - 1
		$PixelTopRightFurther[$i] = _GetOffsetTroopFurther($PixelTopRight[$i], $eVectorRightTop, $offsetArcher)
		$PixelRedArea[$count] = $PixelTopRight[$i]
		$PixelRedAreaFuther[$count] = $PixelTopRightFurther[$i]
		$count += 1
	Next
	Global $PixelBottomRightFurther[UBound($PixelBottomRight)]
	For $i = 0 To UBound($PixelBottomRight) - 1
		$PixelBottomRightFurther[$i] = _GetOffsetTroopFurther($PixelBottomRight[$i], $eVectorRightBottom, $offsetArcher)
		$PixelRedArea[$count] = $PixelBottomRight[$i]
		$PixelRedAreaFuther[$count] = $PixelBottomRightFurther[$i]
		$count += 1
	Next
	debugRedArea("PixelTopLeftFurther " + UBound($PixelTopLeftFurther))


	If UBound($PixelTopLeft) < 10 Then
		$PixelTopLeft = _GetVectorOutZone($eVectorLeftTop)
		$PixelTopLeftFurther = $PixelTopLeft
	EndIf
	If UBound($PixelBottomLeft) < 10 Then
		$PixelBottomLeft = _GetVectorOutZone($eVectorLeftBottom)
		$PixelBottomLeftFurther = $PixelBottomLeft
	EndIf
	If UBound($PixelTopRight) < 10 Then
		$PixelTopRight = _GetVectorOutZone($eVectorRightTop)
		$PixelTopRightFurther = $PixelTopRight
	EndIf
	If UBound($PixelBottomRight) < 10 Then
		$PixelBottomRight = _GetVectorOutZone($eVectorRightBottom)
		$PixelBottomRightFurther = $PixelBottomRight
	EndIf

	debugRedArea($nameFunc & "  Size of arr pixel for TopLeft [" & UBound($PixelTopLeft) & "] /  BottomLeft [" & UBound($PixelBottomLeft) & "] /  TopRight [" & UBound($PixelTopRight) & "] /  BottomRight [" & UBound($PixelBottomRight) & "] ")

	debugRedArea($nameFunc & " OUT ")
EndFunc   ;==>_GetRedArea

Func GetPixelSide($listPixel, $index)
	Return GetListPixel($listPixel[$index])
EndFunc   ;==>GetPixelSide

; Search the closer array of pixel in the array of pixel
Func _FindPixelCloser($arrPixel, $pixel, $nb = 1)
	Local $arrPixelCloser[0]
	For $j = 0 To $nb
		Local $PixelCloser = $arrPixel[0]
		For $i = 0 To UBound($arrPixel) - 1
			$alreadyExist = False
			Local $arrTemp = $arrPixel[$i]
			Local $found = False
			;search closer only on y
			If ($pixel[0] = -1) Then
				If (Abs($arrTemp[1] - $pixel[1]) < Abs($PixelCloser[1] - $pixel[1])) Then
					$found = True
				EndIf
				;search closer only on x
			ElseIf ($pixel[1] = -1) Then
				If (Abs($arrTemp[0] - $pixel[0]) < Abs($PixelCloser[0] - $pixel[0])) Then
					$found = True
				EndIf
				;search closer on x/y
			Else
				If ((Abs($arrTemp[0] - $pixel[0]) + Abs($arrTemp[1] - $pixel[1])) < (Abs($PixelCloser[0] - $pixel[0]) + Abs($PixelCloser[1] - $pixel[1]))) Then
					$found = True
				EndIf
			EndIf
			If ($found) Then
				For $k = 0 To UBound($arrPixelCloser) - 1
					Local $arrTemp2 = $arrPixelCloser[$k]
					If ($arrTemp[0] = $arrTemp2[0] And $arrTemp[1] = $arrTemp2[1]) Then
						$alreadyExist = True
						ExitLoop
					EndIf
				Next
				If ($alreadyExist = False) Then
					$PixelCloser = $arrTemp
				EndIf
			EndIf
		Next
		ReDim $arrPixelCloser[UBound($arrPixelCloser) + 1]
		$arrPixelCloser[UBound($arrPixelCloser) - 1] = $PixelCloser

	Next
	Return $arrPixelCloser
EndFunc   ;==>_FindPixelCloser

Func _ReduceMemory($PID)
	Local $dll = DllOpen("kernel32.dll")
	Local $ai_Handle = DllCall($dll, 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $PID)
	Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
	DllCall($dll, 'int', 'CloseHandle', 'int', $ai_Handle[0])
	DllClose($dll)
	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory

Func debugRedArea($string)
	If $debugRedArea = 1 Then
		_FileWriteLog(FileOpen($dirLogs & "debugRedArea.log", $FO_APPEND), $string)
	EndIf
EndFunc   ;==>debugRedArea



Func _GetOffsetTroopFurther($pixel, $eVectorType, $offset)
	debugRedArea("_GetOffsetTroopFurther IN")
	Local $xMin, $xMax, $yMin, $yMax, $xStep, $yStep, $xOffset, $yOffset
	Local $vectorRedArea[0]
	Local $pixelOffset = GetOffestPixelRedArea2($pixel, $eVectorType, $offset)
	If ($eVectorType = $eVectorLeftTop) Then
		$xMin = 74
		$xMax = 433
		$yMin = 320
		$yMax = 60
		$xStep = 4
		$yStep = -3
		$yOffset = -1 * $offset
		$xOffset = Floor($yOffset)
	ElseIf ($eVectorType = $eVectorRightTop) Then
		$xMin = 417
		$xMax = 800
		$yMin = 39
		$yMax = 320
		$xStep = 4
		$yStep = 3
		$yOffset = -1 * $offset
		$xOffset = Floor($yOffset) * -1
	ElseIf ($eVectorType = $eVectorLeftBottom) Then
		$xMin = 75
		$xMax = 451
		$yMin = 298
		$yMax = 580
		$xStep = 4
		$yStep = 3
		$yOffset = $offset
		$xOffset = Floor($yOffset) * -1
	Else
		$xMin = 433
		$xMax = 800
		$yMin = 570
		$yMax = 300
		$xStep = 4
		$yStep = -3
		$yOffset = $offset
		$xOffset = Floor($yOffset)
	EndIf



	Local $y = $yMin
	Local $found = False
	For $x = $xMin To $xMax Step $xStep
		If ($eVectorType = $eVectorRightBottom And $y > $yMax And $pixelOffset[0] > $x And $pixelOffset[1] > $y) Then
			$pixelOffset[0] = $x + $xOffset
			$pixelOffset[1] = $y + $yOffset
			$found = True
		ElseIf ($eVectorType = $eVectorLeftBottom And $y < $yMax And $pixelOffset[0] < $x And $pixelOffset[1] > $y) Then
			$pixelOffset[0] = $x + $xOffset
			$pixelOffset[1] = $y + $yOffset
			$found = True
		ElseIf ($eVectorType = $eVectorLeftTop And $y > $yMax And $pixelOffset[0] < $x And $pixelOffset[1] < $y) Then
			$pixelOffset[0] = $x + $xOffset
			$pixelOffset[1] = $y + $yOffset

			$found = True
		ElseIf ($eVectorType = $eVectorRightTop And $y < $yMax And $pixelOffset[0] > $x And $pixelOffset[1] < $y) Then
			$pixelOffset[0] = $x + $xOffset
			$pixelOffset[1] = $y + $yOffset
			$found = True
		EndIf

		$y += $yStep
		If ($found) Then ExitLoop
	Next
	; Not select pixel in menu of troop
	If $pixelOffset[1] > 547 Then
		$pixelOffset[1] = 547
	EndIf
	debugRedArea("$pixelOffset x : [" + $pixelOffset[0] + "] / y : [" + $pixelOffset[1] + "]")

	Return $pixelOffset
EndFunc   ;==>_GetOffsetTroopFurther



; Param : 	$pixel : The pixel to add an offset
;			$xSign : The translation on X
;			$ySign : The translation on Y
;			$hBitmap : handle of bitmap
; Return : 	The pixel with offset
; Strategy :
; 			According to the type of translation search the color of pixels around the current pixel
;			With the different of red color, we know how to make the offset (top,bottom,left,right)
Func GetOffestPixelRedArea2($pixel, $eVectorType, $offset = 3)
	; $nameFunc = "[GetOffestPixelRedArea] "
	;  debugRedArea($nameFunc&" IN")
	Local $pixelOffest = $pixel

	If ($eVectorType = $eVectorLeftTop) Then
		$pixelOffest[0] = Round($pixel[0] - $offset * 4 / 3)
		$pixelOffest[1] = $pixel[1] - $offset
	ElseIf ($eVectorType = $eVectorRightBottom) Then
		$pixelOffest[0] = Round($pixel[0] + $offset * 4 / 3)
		$pixelOffest[1] = $pixel[1] + $offset
	ElseIf ($eVectorType = $eVectorLeftBottom) Then
		$pixelOffest[0] = Round($pixel[0] - $offset * 4 / 3)
		$pixelOffest[1] = $pixel[1] + $offset
	ElseIf ($eVectorType = $eVectorRightTop) Then
		$pixelOffest[0] = Round($pixel[0] + $offset * 4 / 3)
		$pixelOffest[1] = $pixel[1] - $offset
	EndIf
	; Not select pixel in menu of troop
	If $pixelOffest[1] > 547 Then
		$pixelOffest[1] = 547
	EndIf
	; debugRedArea($nameFunc&" OUT")
	Return $pixelOffest


EndFunc   ;==>GetOffestPixelRedArea2


; Param : 	$troop : Troop to deploy
;			$arrPixel : Array of pixel where troop are deploy
;			$number : Number of troop to deploy
; Strategy :
; While troop left :
;	If number of troop > number of pixel => Search the number of troop to deploy by pixel
;	Else Search the offset to browse the tab of pixel
;	Browse the tab of pixel and send troop
Func DropOnPixel($troop, $listArrPixel, $number, $slotsPerEdge = 0)

	$nameFunc = "[DropOnPixel]"
	debugRedArea($nameFunc & " IN ")
	debugRedArea("troop : [" & $troop & "] / size arrPixel [" & UBound($listArrPixel) & "] / number [" & $number & "]/ $slotsPerEdge [" & $slotsPerEdge & "] ")
	If ($number = 0 Or UBound($listArrPixel) = 0) Then Return
	If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
		For $i = 0 To UBound($listArrPixel) - 1
			debugRedArea("$listArrPixel $i : [" & $i & "] ")
			Local $arrPixel = $listArrPixel[$i]
			debugRedArea("$arrPixel $UBound($arrPixel) : [" & UBound($arrPixel) & "] ")
			If UBound($arrPixel) > 0 Then
				Local $pixel = $arrPixel[0]
				Click($pixel[0], $pixel[1], $number, 250)
			EndIf
			If _Sleep(50) Then Return
		Next
	ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
		For $i = 0 To UBound($listArrPixel) - 1
			Local $arrPixel = $listArrPixel[$i]
			If UBound($arrPixel) > 0 Then
				Local $pixel = $arrPixel[0]
				Click($pixel[0], $pixel[1], $number)
				If _Sleep(SetSleep(0)) Then Return
			EndIf
			If _Sleep(SetSleep(1)) Then Return
		Next
	Else
		For $i = 0 To UBound($listArrPixel) - 1
			debugRedArea("$listArrPixel $i : [" & $i & "] ")
			Local $nbTroopsLeft = $number
			Local $offset = 1
			Local $nbTroopByPixel = 1
			Local $arrPixel = $listArrPixel[$i]
			;	SetLog("UBound($edge) " & UBound($arrPixel) & "$number :"& $number , $COLOR_GREEN)
			While ($nbTroopsLeft > 0)
				If (UBound($arrPixel) = 0) Then
					ExitLoop
				EndIf
				If (UBound($arrPixel) > $nbTroopsLeft) Then
					$offset = UBound($arrPixel) / $nbTroopsLeft
				Else
					$nbTroopByPixel = Floor($number / UBound($arrPixel))
				EndIf
				If ($offset < 1) Then
					$offset = 1
				EndIf
				If ($nbTroopByPixel < 1) Then
					$nbTroopByPixel = 1
				EndIf
				For $j = 0 To UBound($arrPixel) - 1 Step $offset
					Local $index = Round($j)
					If ($index > UBound($arrPixel) - 1) Then
						$index = UBound($arrPixel) - 1
					EndIf
					Local $currentPixel = $arrPixel[Floor($index)]
					Click($currentPixel[0], $currentPixel[1], $nbTroopByPixel)
					$nbTroopsLeft -= $nbTroopByPixel


					If _Sleep(SetSleep(0)) Then Return
				Next
			WEnd
		Next
	EndIf
	debugRedArea($nameFunc & " OUT ")
EndFunc   ;==>DropOnPixel


; Param : 	$arrPixel : Array of pixel where troop are deploy
;			$vectorDirection : The vector direction => 0 = Left To Right (x asc) / 1 = Top to Bottom (y asc)
;			$sizeVector : Number of pixel for the vector
; Return : 	The vector of pixel
; Strategy :
; 			Get min / max pixel of array pixel
;			Get min / max value of x or y (depends vector direction)
;			Get the offset to browse the array pixel (depends of size vector)
;			For min to max with offset , get pixel closer and add to the vector
Func GetVectorPixelToDeploy($arrPixel, $vectorDirection, $sizeVector)
	Local $vectorPixel[0]
	debugRedArea("GetVectorPixelToDeploy IN")
	debugRedArea("size " & UBound($arrPixel))
	If (UBound($arrPixel) > 1) Then
		Local $pixelSearch[2] = [-1, -1]
		Local $minPixel = $arrPixel[0]
		Local $maxPixel = $arrPixel[UBound($arrPixel) - 1]
		Local $min = $minPixel[$vectorDirection]
		Local $max = $maxPixel[$vectorDirection]
		Local $offset = ($max - $min) / $sizeVector
		debugRedArea("min : [" & $min & "] / max [" & $max & "] / offset [" & $offset & "]")
		if($min <= $max And $offset <= 0) Then
			$offset = 1
		ElseIf($min >= $max And $offset >= 0) Then
			$offset = -1
		EndIf
		For $i = $min To $max Step $offset
			$pixelSearch[$vectorDirection] = $i
			Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
			ReDim $vectorPixel[UBound($vectorPixel) + 1]
			$vectorPixel[UBound($vectorPixel) - 1] = $arrPixelCloser[0]
		Next

	EndIf
	Return $vectorPixel
EndFunc   ;==>GetVectorPixelToDeploy

Func GetVectorPixelAverage($arrPixel, $vectorDirection)
	Local $vectorPixelAverage[1]
	debugRedArea("GetVectorPixelAverage IN $vectorDirection [" & $vectorDirection & "]")
	If (UBound($arrPixel) > 1) Then
		Local $pixelSearch[2] = [-1, -1]
		Local $minPixel = $arrPixel[0]
		Local $maxPixel = $arrPixel[UBound($arrPixel) - 1]
		Local $min = $minPixel[$vectorDirection]
		Local $max = $maxPixel[$vectorDirection]
		Local $posAverage = ($max - $min) / 2
		debugRedArea("GetVectorPixelAverage IN $min [" & $min & "]")
		debugRedArea("GetVectorPixelAverage IN $max [" & $max & "]")

		$pixelSearch[$vectorDirection] = $min + $posAverage
		debugRedArea("GetVectorPixelAverage $pixelSearch x : [" & $pixelSearch[0] & "] / y [" & $pixelSearch[1] & "] ")
		Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
		Local $arrTemp = $arrPixelCloser[0]
		debugRedArea("GetVectorPixelAverage $arrTemp x : [" & $arrTemp[0] & "] / y [" & $arrTemp[1] & "] ")
		$vectorPixelAverage[0] = $arrPixelCloser[0]


	EndIf
	Return $vectorPixelAverage
EndFunc   ;==>GetVectorPixelAverage

Func GetVectorPixelOnEachSide($arrPixel, $vectorDirection)
	Local $vectorPixelEachSide[2]
	If (UBound($arrPixel) > 1) Then
		Local $pixelSearch[2] = [-1, -1]
		Local $minPixel = $arrPixel[0]
		Local $maxPixel = $arrPixel[UBound($arrPixel) - 1]
		Local $min = $minPixel[$vectorDirection]
		Local $max = $maxPixel[$vectorDirection]
		Local $posSide = ($max - $min) / 4

		$pixelSearch[$vectorDirection] = $min + $posSide
		Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
		$vectorPixelEachSide[0] = $arrPixelCloser[0]

		$pixelSearch[$vectorDirection] = $min + $posSide * 3
		Local $arrPixelCloser = _FindPixelCloser($arrPixel, $pixelSearch, 1)
		$vectorPixelEachSide[1] = $arrPixelCloser[0]


	EndIf
	Return $vectorPixelEachSide
EndFunc   ;==>GetVectorPixelOnEachSide


Func DropTroop($troop, $nbSides, $number, $slotsPerEdge = 0, $indexToAttack = -1)
	$nameFunc = "[DropTroop]"
	debugRedArea($nameFunc & " IN ")
	debugRedArea("troop : [" & $troop & "] / nbSides : [" & $nbSides & "] / number : [" & $number & "] / slotsPerEdge [" & $slotsPerEdge & "]")


	If ($chkRedArea) Then
		If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
		If _Sleep(100) Then Return
		SelectDropTroop($troop) ;Select Troop
		If _Sleep(300) Then Return

		If $nbSides < 1 Then Return
		Local $nbTroopsLeft = $number
		If ($chkSmartAttack[0] = 0 And $chkSmartAttack[1] = 0 And $chkSmartAttack[2] = 0) Then

			If $nbSides = 4 Then
				Local $edgesPixelToDrop = GetPixelDropTroop($troop, $number, $slotsPerEdge)

				For $i = 0 To $nbSides - 3
					Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
					If ($number > 0 And $nbTroopsPerEdge = 0) Then $nbTroopsPerEdge = 1
					Local $listEdgesPixelToDrop[2] = [$edgesPixelToDrop[$i], $edgesPixelToDrop[$i + 2]]
					DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)
					$nbTroopsLeft -= $nbTroopsPerEdge * 2
				Next
				Return
			EndIf


			For $i = 0 To $nbSides - 1

				If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then

					Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i))
					If ($number > 0 And $nbTroopsPerEdge = 0) Then $nbTroopsPerEdge = 1
					Local $edgesPixelToDrop = GetPixelDropTroop($troop, $nbTroopsPerEdge, $slotsPerEdge)
					Local $listEdgesPixelToDrop[1] = [$edgesPixelToDrop[$i]]
					DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)
					$nbTroopsLeft -= $nbTroopsPerEdge
				ElseIf ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
					Local $nbTroopsPerEdge = Round($nbTroopsLeft / ($nbSides - $i * 2))
					If ($number > 0 And $nbTroopsPerEdge = 0) Then $nbTroopsPerEdge = 1
					Local $edgesPixelToDrop = GetPixelDropTroop($troop, $nbTroopsPerEdge, $slotsPerEdge)
					Local $listEdgesPixelToDrop[2] = [$edgesPixelToDrop[$i + 3], $edgesPixelToDrop[$i + 1]]

					DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)
					$nbTroopsLeft -= $nbTroopsPerEdge * 2
				EndIf
			Next
		Else
			Local $listEdgesPixelToDrop[0]
			If ($indexToAttack <> -1) Then
				Local $nbTroopsPerEdge = $number
				Local $maxElementNearCollector = $indexToAttack
				Local $startIndex = $indexToAttack
			Else
				Local $nbTroopsPerEdge = Round($number / UBound($PixelNearCollector))
				Local $maxElementNearCollector = UBound($PixelNearCollector) - 1
				Local $startIndex = 0
			EndIf
			If ($number > 0 And $nbTroopsPerEdge = 0) Then $nbTroopsPerEdge = 1
			For $i = $startIndex To $maxElementNearCollector
				$pixel = $PixelNearCollector[$i]
				ReDim $listEdgesPixelToDrop[UBound($listEdgesPixelToDrop) + 1]
				If ($troop = $eArch Or $troop = $eWiza Or $troop = $eMini) Then
					$listEdgesPixelToDrop[UBound($listEdgesPixelToDrop) - 1] = _FindPixelCloser($PixelRedAreaFuther, $pixel, 5)
				Else
					$listEdgesPixelToDrop[UBound($listEdgesPixelToDrop) - 1] = _FindPixelCloser($PixelRedArea, $pixel, 5)
				EndIf
			Next
			DropOnPixel($troop, $listEdgesPixelToDrop, $nbTroopsPerEdge, $slotsPerEdge)

		EndIf
	Else
		DropOnEdges($troop, $nbSides, $number, $slotsPerEdge)
	EndIf

	debugRedArea($nameFunc & " OUT ")

EndFunc   ;==>DropTroop

Func DropTroop2($troop, $nbSides, $number, $slotsPerEdge = 0, $name = "")
	$nameFunc = "[DropTroop]"
	debugRedArea($nameFunc & " IN ")
	debugRedArea("troop : [" & $troop & "] / nbSides : [" & $nbSides & "] / number : [" & $number & "] / slotsPerEdge [" & $slotsPerEdge & "]")
	Local $listInfoPixelDropTroop[0]


	If ($chkRedArea) Then
		If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
		;If _Sleep(100) Then Return
		;SelectDropTroop($troop) ;Select Troop
		;If _Sleep(300) Then Return

		If $nbSides < 1 Then Return
		Local $nbTroopsLeft = $number
		Local $nbTroopsPerEdge = Round($nbTroopsLeft / $nbSides)
		If ($chkSmartAttack[0] = 0 And $chkSmartAttack[1] = 0 And $chkSmartAttack[2] = 0) Then
			If ($number > 0 And $nbTroopsPerEdge = 0) Then $nbTroopsPerEdge = 1
			If $nbSides = 4 Then
				ReDim $listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) + 4]
				Local $listInfoPixelDropTroop = GetPixelDropTroop($troop, $number, $slotsPerEdge)

			Else
				For $i = 0 To $nbSides - 1
					If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
						Local $edgesPixelToDrop = GetPixelDropTroop($troop, $nbTroopsPerEdge, $slotsPerEdge)
						ReDim $listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) + 1]
						$listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) - 1] = $edgesPixelToDrop[$i]
					ElseIf ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
						Local $edgesPixelToDrop = GetPixelDropTroop($troop, $nbTroopsPerEdge, $slotsPerEdge)
						ReDim $listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) + 2]
						$listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) - 2] = $edgesPixelToDrop[$i + 3]
						$listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) - 1] = $edgesPixelToDrop[$i + 1]
					EndIf
				Next
			EndIf



		Else
			Local $listEdgesPixelToDrop[0]

			Local $nbTroopsPerEdge = Round($number / UBound($PixelNearCollector))
			If ($number > 0 And $nbTroopsPerEdge = 0) Then $nbTroopsPerEdge = 1
			Local $maxElementNearCollector = UBound($PixelNearCollector) - 1
			Local $startIndex = 0
			Local $troopFurther = False
			If ($troop = $eArch Or $troop = $eWiza Or $troop = $eMini) Then
				$troopFurther = True
			EndIf
			Local $centerPixel[2] = [430, 313]
			For $i = $startIndex To $maxElementNearCollector
				$pixel = $PixelNearCollector[$i]
				ReDim $listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) + 1]
				Local $arrPixelToSearch
				If ($pixel[0] < $centerPixel[0] And $pixel[1] < $centerPixel[1]) Then
					If ($troopFurther) Then
						$arrPixelToSearch = $PixelTopLeftFurther
					Else
						$arrPixelToSearch = $PixelTopLeft
					EndIf
				ElseIf ($pixel[0] < $centerPixel[0] And $pixel[1] > $centerPixel[1]) Then
					If ($troopFurther) Then
						$arrPixelToSearch = $PixelBottomLeftFurther
					Else
						$arrPixelToSearch = $PixelBottomLeft
					EndIf
				ElseIf ($pixel[0] > $centerPixel[0] And $pixel[1] > $centerPixel[1]) Then
					If ($troopFurther) Then
						$arrPixelToSearch = $PixelBottomRightFurther
					Else
						$arrPixelToSearch = $PixelBottomRight
					EndIf
				Else
					If ($troopFurther) Then
						$arrPixelToSearch = $PixelTopRightFurther
					Else
						$arrPixelToSearch = $PixelTopRight
					EndIf
				EndIf

				$listInfoPixelDropTroop[UBound($listInfoPixelDropTroop) - 1] = _FindPixelCloser($arrPixelToSearch, $pixel, 1)

			Next

		EndIf
	Else
		DropOnEdges($troop, $nbSides, $number, $slotsPerEdge)
	EndIf

	Local $infoDropTroop[6] = [$troop, $listInfoPixelDropTroop, $nbTroopsPerEdge, $slotsPerEdge, $number, $name]
	Return $infoDropTroop
	debugRedArea($nameFunc & " OUT ")

EndFunc   ;==>DropTroop2

Func GetPixelDropTroop($troop, $number, $slotsPerEdge)
	Local $newPixelTopLeft
	Local $newPixelBottomLeft
	Local $newPixelTopRight
	Local $newPixelBottomRight

	If ($troop = $eArch Or $troop = $eWiza Or $troop = $eMini) Then
		$newPixelTopLeft = $PixelTopLeftFurther
		$newPixelBottomLeft = $PixelBottomLeftFurther
		$newPixelTopRight = $PixelTopRightFurther
		$newPixelBottomRight = $PixelBottomRightFurther

	Else
		$newPixelTopLeft = $PixelTopLeft
		$newPixelBottomLeft = $PixelBottomLeft
		$newPixelTopRight = $PixelTopRight
		$newPixelBottomRight = $PixelBottomRight
	EndIf

	If ($slotsPerEdge = 1) Then
		$newPixelTopLeft = GetVectorPixelAverage($newPixelTopLeft, 0)
		$newPixelBottomLeft = GetVectorPixelAverage($newPixelBottomLeft, 1)
		$newPixelTopRight = GetVectorPixelAverage($newPixelTopRight, 1)
		$newPixelBottomRight = GetVectorPixelAverage($newPixelBottomRight, 0)
	ElseIf ($slotsPerEdge = 2) Then
		$newPixelTopLeft = GetVectorPixelOnEachSide($newPixelTopLeft, 0)
		$newPixelBottomLeft = GetVectorPixelOnEachSide($newPixelBottomLeft, 1)
		$newPixelTopRight = GetVectorPixelOnEachSide($newPixelTopRight, 1)
		$newPixelBottomRight = GetVectorPixelOnEachSide($newPixelBottomRight, 0)
	Else
		debugRedArea("GetPixelDropTroop :  $slotsPerEdge [" & $slotsPerEdge & "] ")
		$newPixelTopLeft = GetVectorPixelToDeploy($newPixelTopLeft, 0, $slotsPerEdge)
		$newPixelBottomLeft = GetVectorPixelToDeploy($newPixelBottomLeft, 1, $slotsPerEdge)
		$newPixelTopRight = GetVectorPixelToDeploy($newPixelTopRight, 1, $slotsPerEdge)
		$newPixelBottomRight = GetVectorPixelToDeploy($newPixelBottomRight, 0, $slotsPerEdge)

	EndIf
	Local $edgesPixelToDrop[4] = [$newPixelBottomRight, $newPixelTopLeft, $newPixelBottomLeft, $newPixelTopRight]
	Return $edgesPixelToDrop
EndFunc   ;==>GetPixelDropTroop

Func _GetVectorOutZone($eVectorType)
	debugRedArea("_GetVectorOutZone IN")
	Local $vectorOutZone[0]

	If ($eVectorType = $eVectorLeftTop) Then
		$xMin = 426
		$yMin = 10
		$xMax = 31
		$yMax = 300
		$xStep = -4
		$yStep = 3
	ElseIf ($eVectorType = $eVectorRightTop) Then
		$xMin = 426
		$yMin = 10
		$xMax = 834
		$yMax = 312
		$xStep = 4
		$yStep = 3
	ElseIf ($eVectorType = $eVectorLeftBottom) Then
		$xMin = 24
		$yMin = 307
		$xMax = 336
		$yMax = 540
		$xStep = 4
		$yStep = 3
	Else
		$xMin = 834
		$yMin = 312
		$xMax = 545
		$yMax = 544
		$xStep = -4
		$yStep = 3
	EndIf


	Local $pixel[2]
	Local $x = $xMin
	For $y = $yMin To $yMax Step $yStep
		$x += $xStep
		$pixel[0] = $x
		$pixel[1] = $y
		ReDim $vectorOutZone[UBound($vectorOutZone) + 1]
		$vectorOutZone[UBound($vectorOutZone) - 1] = $pixel

	Next

	Return $vectorOutZone
EndFunc   ;==>_GetVectorOutZone
