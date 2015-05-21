Func UpdateStats()
   If $FirstRun = 1 Then
	  $FirstRun = 0
	  $FirstAttack = 1
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
		 GUICtrlSetState($picHourlyStatsDark, $GUI_HIDE)
	  EndIf

	  GUICtrlSetData($lblResultTrophyStart, _NumberFormat($TrophyCount))
	  GUICtrlSetState($lblResultTrophyNow, $GUI_SHOW)
	  GUICtrlSetState($lblResultBuilderNow, $GUI_SHOW)
	  GUICtrlSetState($lblResultGemNow, $GUI_SHOW)
	  
	  GUICtrlSetState($btnResetStats, $GUI_ENABLE)
   Else
	  ; Add last attack numbers to total numbers
	  $totalLootGold += $lootGold
	  $totalLootElixir += $lootElixir
	  $totalLootDarkElixir += $lootDarkElixir
	  $totalLootTrophies += $lootTrophies

	  If $FirstAttack = 1 Then
		 $FirstAttack = 2
		 GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)
		 GUICtrlSetState($lblTotalLootTemp, $GUI_HIDE)
		 GUICtrlSetState($lblHourlyStatsTemp, $GUI_HIDE) ;; added for hourly stats
	  EndIf

	  ; Last Attack stats
	  GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
	  GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblDarkLastAttack, _NumberFormat($lootDarkElixir))
	  EndIf
	  GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))

	  ; Total stats
	  GUICtrlSetData($lblGoldLoot, _NumberFormat($totalLootGold))
	  GUICtrlSetData($lblElixirLoot, _NumberFormat($totalLootElixir))
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblDarkLoot, _NumberFormat($totalLootDarkElixir))
	  EndIf
	  GUICtrlSetData($lblTrophyLoot, _NumberFormat($totalLootTrophies))

	  ; Hourly stats
	  GUICtrlSetData($lblHourlyStatsGold, _NumberFormat(Round($totalLootGold / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
	  GUICtrlSetData($lblHourlyStatsElixir, _NumberFormat(Round($totalLootElixir / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
	  If $DarkStart <> "" Then
		 GUICtrlSetData($lblHourlyStatsDark, _NumberFormat(Round($totalLootDarkElixir / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")
	  EndIf
	  GUICtrlSetData($lblHourlyStatsTrophy, _NumberFormat(Round($totalLootTrophies / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")
   EndIf
EndFunc