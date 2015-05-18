; #FUNCTION# ====================================================================================================================
; Name ..........: VillageReport
; Description ...: This function will report the village free and total builders, gold, elixir, dark elixir and gems.
;                  It will also update the statistics to the GUI.
; Syntax ........: VillageReport()
; Parameters ....: None
; Return values .: None
; Author ........: Hervidero (2015-feb-10)
; Modified ......: Safar46 (2015), Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func VillageReport()
	PureClick($TopLeftClient[0],$TopLeftClient[1]) ;Click Away
	If _Sleep(500) Then Return

	SetLog("Village Report", $COLOR_BLUE)

	$FreeBuilder = GetOther(324, 23, "Builder")
	$TotalBuilders = GetOther(345, 23, "Builder")
	Setlog("No. of Free/Total Builders: " & $FreeBuilder & "/" & $TotalBuilders, $COLOR_GREEN)
	$TrophyCount = getOther(50, 74, "Trophy")

	SetLog("Opening Builder page to read Resources..", $COLOR_BLUE)
	PureClick(388, 30) ; Click Builder Button
	_CaptureRegion()
	Local $i = 0
	While _ColorCheck(_GetPixelColor(819, 39), Hex(0xF8FCFF, 6), 20) = False ; wait for Builder/shop to open
		$i += 1
		If _Sleep(500) Then Return
		_CaptureRegion()
		If $i >= 20 Then ExitLoop
	WEnd
	If _ColorCheck(_GetPixelColor(318, 637), Hex(0xD854D0, 6), 20) Then
		$GoldCount = GetOther(356, 625, "Resource")
		$ElixirCount = GetOther(195, 625, "Resource")
		$GemCount = GetOther(543, 625, "Gems")
		SetLog(" [G]: " & $GoldCount & " [E]: " & $ElixirCount & " [GEM]: " & $GemCount, $COLOR_GREEN)
	Else
		$GoldCount = GetOther(440, 625, "Resource")
		$ElixirCount = GetOther(282, 625, "Resource")
		$DarkCount = GetOther(125, 625, "Resource")
		$GemCount = GetOther(606, 625, "Gems")
		SetLog(" [G]: " & $GoldCount & " [E]: " & $ElixirCount & " [D]: " & $DarkCount & " [GEM]: " & $GemCount, $COLOR_GREEN)
	EndIf

	PureClick(820, 40) ; Close Builder/Shop

	; update stats
	Switch $FirstAttack
		Case 2
			ReportLastTotal()
			ReportCurrent()
		Case 1
			GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)
			GUICtrlSetState($lblTotalLootTemp, $GUI_HIDE)
            GUICtrlSetState($lblHourlyStatsTemp, $GUI_HIDE) ;; added for hourly stats
			ReportLastTotal()
			ReportCurrent()
			$FirstAttack = 2
		Case 0
			ReportStart()
			ReportCurrent()
			$FirstAttack = 1
	EndSwitch

	_CaptureRegion()
	Local $i = 0
	While _ColorCheck(_GetPixelColor(819, 39), Hex(0xF8FCFF, 6), 20) = True ; wait for Builder/shop to close
		$i += 1
		If _Sleep(500) Then Return
		_CaptureRegion()
		If $i >= 20 Then ExitLoop
	WEnd

EndFunc   ;==>VillageReport

Func ReportStart() ; stats at Start

	$GoldStart = $GoldCount
	$ElixirStart = $ElixirCount
	$DarkStart = $DarkCount
	$TrophyStart = $TrophyCount

	GUICtrlSetState($lblResultStatsTemp, $GUI_HIDE)
	GUICtrlSetState($lblVillageReportTemp, $GUI_HIDE)
	GUICtrlSetState($picResultGoldTemp, $GUI_HIDE)
	GUICtrlSetState($picResultElixirTemp, $GUI_HIDE)
	GUICtrlSetState($picResultDETemp, $GUI_HIDE)

	GUICtrlSetState($lblResultGoldNow, $GUI_SHOW)
	GUICtrlSetState($picResultGoldNow, $GUI_SHOW)
	GUICtrlSetData($lblResultGoldStart, _NumberFormat($GoldCount))

	GUICtrlSetState($lblResultElixirNow, $GUI_SHOW)
	GUICtrlSetState($picResultElixirNow, $GUI_SHOW)
	GUICtrlSetData($lblResultElixirStart, _NumberFormat($ElixirCount))

	If $DarkCount <> "" Then
		GUICtrlSetData($lblResultDEStart, _NumberFormat($DarkCount))
		GUICtrlSetState($lblResultDeNow, $GUI_SHOW)
		GUICtrlSetState($picResultDeNow, $GUI_SHOW)
	Else
		GUICtrlSetState($picResultDEStart, $GUI_HIDE)
		GUICtrlSetState($picDarkLoot, $GUI_HIDE)
		GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
	EndIf

	GUICtrlSetData($lblResultTrophyStart, _NumberFormat($TrophyCount))
	GUICtrlSetState($lblResultTrophyNow, $GUI_SHOW)
	GUICtrlSetState($lblResultBuilderNow, $GUI_SHOW)
	GUICtrlSetState($lblResultGemNow, $GUI_SHOW)

EndFunc

Func ReportCurrent()

	$GoldVillage = $GoldCount
	$ElixirVillage = $ElixirCount
	$DarkVillage = $DarkCount
	$TrophyVillage = $TrophyCount

	GUICtrlSetData($lblResultGoldNow, _NumberFormat($GoldCount))
	GUICtrlSetData($lblResultElixirNow, _NumberFormat($ElixirCount))

	If $DarkCount <> "" Then
		GUICtrlSetData($lblResultDeNow, _NumberFormat($DarkCount))
	EndIf

	GUICtrlSetData($lblResultTrophyNow, _NumberFormat($TrophyCount))
	GUICtrlSetData($lblResultBuilderNow, $FreeBuilder & "/" & $TotalBuilders)
	GUICtrlSetData($lblResultGemNow, _NumberFormat($GemCount))

EndFunc

Func ReportLastTotal()

	;last attack
	$GoldLast = $GoldCount - $GoldVillage
	$ElixirLast = $ElixirCount - $ElixirVillage
	$DarkLast = $DarkCount - $DarkVillage
	$TrophyLast = $TrophyCount - $TrophyVillage

	GUICtrlSetData($lblGoldLastAttack, _NumberFormat($GoldLast))
	GUICtrlSetData($lblElixirLastAttack, _NumberFormat($ElixirLast))
	If $DarkStart <> "" Then
		GUICtrlSetData($lblDarkLastAttack, _NumberFormat($DarkLast))
	EndIf
	GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($TrophyLast))

	;total stats
	$CostGoldWall = $WallGoldMake * $WallCost
	$CostElixirWall = $WallElixirMake * $WallCost

	$iGoldLoot = $GoldCount + $CostGoldWall - $GoldStart
	$iElixirLoot = $ElixirCount + $CostElixirWall - $ElixirStart
	$iDarkLoot = $DarkCount - $DarkStart
	$iTrophyLoot = $TrophyCount - $TrophyStart

	GUICtrlSetData($lblGoldLoot, _NumberFormat($iGoldLoot))
	GUICtrlSetData($lblElixirLoot, _NumberFormat($iElixirLoot))
	If $DarkStart <> "" Then
		GUICtrlSetData($lblDarkLoot, _NumberFormat($iDarkLoot))
	EndIf
	GUICtrlSetData($lblTrophyLoot, _NumberFormat($iTrophyLoot))

	; hourly stats
	GUICtrlSetData($lblHourlyStatsGold, _NumberFormat($iGoldLoot / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600) & "K / h")
	GUICtrlSetData($lblHourlyStatsElixir, _NumberFormat($iElixirLoot / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600) & "K / h")
	GUICtrlSetData($lblHourlyStatsDark, _NumberFormat($iDarkLoot / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000) & " / h")
	GUICtrlSetData($lblHourlyStatsTrophy, _NumberFormat($iTrophyLoot / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000) & " / h")
EndFunc