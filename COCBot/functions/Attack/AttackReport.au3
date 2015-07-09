; #FUNCTION# ====================================================================================================================
; Name ..........: AttackReport
; Description ...: This function will report the loot from the last Attack: gold, elixir, dark elixir and trophies.
;                  It will also update the statistics to the GUI (Last Attack).
; Syntax ........: AttackReport()
; Parameters ....: None
; Return values .: None
; Author ........: Hervidero (2015-feb-10), Sardo (may-2015)
; Modified ......: Sardo (may-2015), Hervidero (may-2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Global $BonusLeagueG, $BonusLeagueE, $BonusLeagueD, $LeagueShort
Global $League[16][4] = [ _
		["600", "Bronze III", "0", "B3"], ["800", "Bronze II", "0", "B2"], ["1000", "Bronze I", "0", "B1"], _
		["2000", "Silver III", "0", "S3"], ["3000", "Silver II", "0", "S2"], ["4000", "Silver I", "0", "S1"], _
		["8000", "Gold III", "0", "G3"], ["11000", "Gold II", "0", "G2"], ["14000", "Gold I", "0", "G1"], _
		["35000", "Crystal III", "100", "C3"], ["50000", "Crystal II", "200", "C2"], ["65000", "Crystal I", "300", "C1"], _
		["100000", "Master III", "500", "M3"], ["120000", "Master II", "700", "M2"], ["140000", "Master I", "900", "M1"], _
		["180000", "Champion", "1200", "CA"]]

Func AttackReport()

	If _sleep(500) Then Return
	If _ColorCheck(_GetPixelColor(459, 372), Hex(0x433350, 6), 20) Then ; if the color of the DE drop detected
		$lootGold = getResourcesLoot(333, 289)
		If _sleep(150) Then Return
		$lootElixir = getResourcesLoot(333, 328)
		If _sleep(150) Then Return
		$lootDarkElixir = getResourcesLootDE(365, 365)
		If _sleep(150) Then Return
		$lootTrophies = getResourcesLootT(403, 402)
		If _ColorCheck(_GetPixelColor(327, 189), Hex(0x3B321C, 6), 30) Then
			$lootTrophies = -$lootTrophies
		EndIf
		SetLog("Loot: [G]: " & _NumberFormat($lootGold) & " [E]: " & _NumberFormat($lootElixir) & " [DE]: " & _NumberFormat($lootDarkElixir) & " [T]: " & $lootTrophies, $COLOR_GREEN)

		If $FirstAttack = 1 Then GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)

		GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
		GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
		GUICtrlSetData($lblDarkLastAttack, _NumberFormat($lootDarkElixir))
		GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))
	Else
		$lootGold = getResourcesLoot(333, 289)
		If _sleep(150) Then Return
		$lootElixir = getResourcesLoot(333, 328)
		If _sleep(150) Then Return
		$lootTrophies = getResourcesLootT(403, 365)
		If _ColorCheck(_GetPixelColor(327, 189), Hex(0x3B321C, 6), 30) Then
			$lootTrophies = -$lootTrophies
		Else
			$lootTrophies = 0
		EndIf
		$lootDarkElixir = 0
		SetLog("Loot: [G]: " & _NumberFormat($lootGold) & " [E]: " & _NumberFormat($lootElixir) & " [DE]: " & _NumberFormat($lootElixir) & " [T]: " & $lootTrophies, $COLOR_GREEN)

		If $FirstAttack = 1 Then GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)

		GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
		GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
		GUICtrlSetData($lblDarkLastAttack, "")
		GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))
	EndIf

	If $lootTrophies >= 0 Then
		If _ColorCheck(_GetPixelColor(678, 418), Hex(0x030000, 6), 30) Then
			If _sleep(150) Then Return
			$BonusLeagueG = getResourcesBonus(590, 340)
			$BonusLeagueG = StringReplace($BonusLeagueG, "+", "")
			If _sleep(150) Then Return
			$BonusLeagueE = getResourcesBonus(590, 371)
			$BonusLeagueE = StringReplace($BonusLeagueE, "+", "")
			If _sleep(150) Then Return
			$BonusLeagueD = getResourcesBonus(621, 402)
			$BonusLeagueD = StringReplace($BonusLeagueD, "+", "")
			SetLog("Bonus [G]: " & _NumberFormat($BonusLeagueG) & " [E]: " & _NumberFormat($BonusLeagueE) & " [DE]: " & _NumberFormat($BonusLeagueD), $COLOR_GREEN)
		Else
			If _sleep(150) Then Return
			$BonusLeagueG = getResourcesBonus(590, 340)
			$BonusLeagueG = StringReplace($BonusLeagueG, "+", "")
			If _sleep(150) Then Return
			$BonusLeagueE = getResourcesBonus(590, 371)
			$BonusLeagueE = StringReplace($BonusLeagueE, "+", "")
			SetLog("Bonus [G]: " & _NumberFormat($BonusLeagueG) & " [E]: " & _NumberFormat($BonusLeagueE), $COLOR_GREEN)
		EndIf
		$LeagueShort = "--"
		For $i = 0 To 15
			If _sleep(150) Then Return
			If $League[$i][0] = $BonusLeagueG Then
				SetLog("Your league level is: " & $League[$i][1])
				$LeagueShort = $League[$i][3]
				ExitLoop
			EndIf
		Next
	Else
		$BonusLeagueG = 0
		$BonusLeagueE = 0
		$BonusLeagueD = 0
		$LeagueShort = "--"
	EndIf

	; check stars earned
	Local $starsearned = 0
	If _ColorCheck(_GetPixelColor($aWonOneStarAtkRprt[0], $aWonOneStarAtkRprt[1], True), Hex($aWonOneStarAtkRprt[2], 6), $aWonOneStarAtkRprt[3]) Then $starsearned += 1
	If _ColorCheck(_GetPixelColor($aWonTwoStarAtkRprt[0], $aWonTwoStarAtkRprt[1], True), Hex($aWonTwoStarAtkRprt[2], 6), $aWonTwoStarAtkRprt[3]) Then $starsearned += 1
	If _ColorCheck(_GetPixelColor($aWonThreeStarAtkRprt[0], $aWonThreeStarAtkRprt[1], True), Hex($aWonThreeStarAtkRprt[2], 6), $aWonThreeStarAtkRprt[3]) Then $starsearned += 1
	SetLog("Stars earned: " & $starsearned)

	Local $AtkLogTxt
	$AtkLogTxt = "" & _NowTime(4) & "|"
	$AtkLogTxt &= StringFormat("%5d", $TrophyCount) & "|"
	$AtkLogTxt &= StringFormat("%6d", $SearchCount) & "|"
	$AtkLogTxt &= StringFormat("%7d", $lootGold) & "|"
	$AtkLogTxt &= StringFormat("%7d", $lootElixir) & "|"
	$AtkLogTxt &= StringFormat("%7d", $lootDarkElixir) & "|"
	$AtkLogTxt &= StringFormat("%3d", $lootTrophies) & "|"
	$AtkLogTxt &= StringFormat("%1d", $starsearned) & "|"
	$AtkLogTxt &= StringFormat("%6d", $BonusLeagueG) & "|"
	$AtkLogTxt &= StringFormat("%6d", $BonusLeagueE) & "|"
	$AtkLogTxt &= StringFormat("%4d", $BonusLeagueD) & "|"
	$AtkLogTxt &= $LeagueShort & "|"
	SetAtkLog($AtkLogTxt)

	; Share Replay
	If $iShareAttack = 1 Then
		If (Number($lootGold) >= Number($iShareminGold)) And (Number($lootElixir) >= Number($iShareminElixir)) And (Number($lootDarkElixir) >= Number($iSharemindark)) Then
			SetLog("reach miminum loots values... share Replay")
			$iShareAttackNow = 1
		Else
			SetLog("under miminum loots values... no share Replay")
			$iShareAttackNow = 0
		EndIf
	EndIf


EndFunc   ;==>AttackReport
