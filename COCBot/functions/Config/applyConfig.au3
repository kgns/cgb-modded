;Applies all of the  variable to the GUI

Func applyConfig() ;Applies the data from config to the controls in GUI

	;General Settings--------------------------------------------------------------------------
	If $frmBotPosX <> -32000 Then WinMove($sBotTitle, "", $frmBotPosX, $frmBotPosY)

	If $ichkAutoStart = 1 Then
		GUICtrlSetState($chkAutoStart, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAutoStart, $GUI_UNCHECKED)
	EndIf
	If $ichkBackground = 1 Then
		GUICtrlSetState($chkBackground, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBackground, $GUI_UNCHECKED)
	EndIf
	chkBackground() ;Applies it to hidden button

	If $ichkBotStop = 1 Then
		GUICtrlSetState($chkBotStop, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbBotCommand, $icmbBotCommand)
	_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)
	_GUICtrlComboBox_SetCurSel($cmbHoursStop, $icmbHoursStop)
	cmbBotCond()

	;Search Settings------------------------------------------------------------------------

	Switch $iradAttackMode
		Case 0
			GUICtrlSetState($radDeadBases, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($radWeakBases, $GUI_CHECKED)
			_GUICtrlComboBox_SetCurSel($cmbWBMortar, $iWBMortar)
			_GUICtrlComboBox_SetCurSel($cmbWBWizTower, $iWBWizTower)
			;_GUICtrlComboBox_SetCurSel($cmbWBXbow, $iWBXbow)
			radWeakBases()
		Case 2
			GUICtrlSetState($radAllBases, $GUI_CHECKED)
	EndSwitch

	If $iChkSearchReduction = 1 Then
		GUICtrlSetState($chkSearchReduction, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkSearchReduction, $GUI_UNCHECKED)
	EndIf
	chkSearchReduction()

	GUICtrlSetData($txtSearchReduceCount, $ReduceCount)
	GUICtrlSetData($txtSearchReduceGold, $ReduceGold)
	GUICtrlSetData($txtSearchReduceElixir, $ReduceElixir)
	GUICtrlSetData($txtSearchReduceGoldPlusElixir, $ReduceGoldPlusElixir)
	GUICtrlSetData($txtSearchReduceDark, $ReduceDark)
	GUICtrlSetData($txtSearchReduceTrophy, $ReduceTrophy)

	If $chkConditions[0] = 1 Then
		GUICtrlSetState($chkMeetGxE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGxE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[3] = 1 Then
		GUICtrlSetState($chkMeetGorE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGorE, $GUI_UNCHECKED)
	EndIf
	If $chkConditions[6] = 1 Then
		GUICtrlSetState($chkMeetGpE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGpE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[1] = 1 Then
		GUICtrlSetState($chkMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetDE, $GUI_UNCHECKED)
	EndIf
	chkMeetDE()

	If $chkConditions[2] = 1 Then
		GUICtrlSetState($chkMeetTrophy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTrophy, $GUI_UNCHECKED)
	EndIf
	chkMeetTrophy()

	If $chkConditions[4] = 1 Then
		GUICtrlSetState($chkMeetTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTH, $GUI_UNCHECKED)
	EndIf
	chkMeetTH()

	If $chkConditions[5] = 1 Then
		GUICtrlSetState($chkMeetTHO, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTHO, $GUI_UNCHECKED)
	EndIf

   If $ichkMeetOne = 1 Then
		GUICtrlSetState($chkMeetOne, $GUI_CHECKED)
   Else
		GUICtrlSetState($chkMeetOne, $GUI_UNCHECKED)
	 EndIf

	GUICtrlSetData($txtMinGold, $MinGold)
	GUICtrlSetData($txtMinElixir, $MinElixir)
	GUICtrlSetData($txtMinGoldPlusElixir, $MinGoldPlusElixir)
	GUICtrlSetData($txtMinDarkElixir, $MinDark)
	GUICtrlSetData($txtMinTrophy, $MinTrophy)

	For $i = 0 To 4
	   If $icmbTH = $i Then $MaxTH = $THText[$i]
    Next
	_GUICtrlComboBox_SetCurSel($cmbTH, $icmbTH)

	If $AlertSearch = 1 Then
		GUICtrlSetState($chkAlertSearch, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAlertSearch, $GUI_UNCHECKED)
	EndIf
	
	;Use only selected troops
	_GUICtrlComboBox_SetCurSel($cmbSelectTroop, $icmbSelectTroop)
	
	;Attack Settings-------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbDeploy, $deploySettings)
	_GUICtrlComboBox_SetCurSel($cmbTroopComp, $icmbTroopComp)
	_GUICtrlComboBox_SetCurSel($cmbUnitDelay, $icmbUnitDelay)
	_GUICtrlComboBox_SetCurSel($cmbWaveDelay, $icmbWaveDelay)
	If $iRandomspeedatk = 1 Then
		GUICtrlSetState($Randomspeedatk, $GUI_CHECKED)
	Else
		GUICtrlSetState($Randomspeedatk, $GUI_UNCHECKED)
	EndIf
	Randomspeedatk()

	If $chkRedArea = 1 Then
		GUICtrlSetState($chkDeployRedArea, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeployRedArea, $GUI_UNCHECKED)
	EndIf
	chkDeployRedArea()

	_GUICtrlComboBox_SetCurSel($cmbSmartDeploy, $iCmbSmartDeploy)

	If $chkSmartAttack[0] = 1 Then
		GUICtrlSetState($chkAttackNearGoldMine, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAttackNearGoldMine, $GUI_UNCHECKED)
	EndIf

	If $chkSmartAttack[1] = 1 Then
		GUICtrlSetState($chkAttackNearElixirCollector, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAttackNearElixirCollector, $GUI_UNCHECKED)
	EndIf

	If $chkSmartAttack[2] = 1 Then
		GUICtrlSetState($chkAttackNearDarkElixirDrill, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAttackNearDarkElixirDrill, $GUI_UNCHECKED)
	EndIf

	If $KingAttack[0] = 1 Then
		GUICtrlSetState($chkKingAttackDeadBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackDeadBases, $GUI_UNCHECKED)
	EndIf
	If $KingAttack[1] = 1 Then
		GUICtrlSetState($chkKingAttackWeakBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackWeakBases, $GUI_UNCHECKED)
	EndIf
	If $KingAttack[2] = 1 Then
		GUICtrlSetState($chkKingAttackAllBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackAllBases, $GUI_UNCHECKED)
	EndIf

	If $QueenAttack[0] = 1 Then
		GUICtrlSetState($chkQueenAttackDeadBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackDeadBases, $GUI_UNCHECKED)
	EndIf
	If $QueenAttack[1] = 1 Then
		GUICtrlSetState($chkQueenAttackWeakBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackWeakBases, $GUI_UNCHECKED)
	EndIf
	If $QueenAttack[2] = 1 Then
		GUICtrlSetState($chkQueenAttackAllBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackAllBases, $GUI_UNCHECKED)
	EndIf

	If $checkUseClanCastle = 1 Then
		GUICtrlSetState($chkUseClanCastle, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseClanCastle, $GUI_UNCHECKED)
	EndIf

    If $checkUseClanCastleBalanced = 1 Then
	    GUICtrlSetState($chkUseClanCastleBalanced, $GUI_CHECKED)
    Else
	    GUICtrlSetState($chkUseClanCastleBalanced, $GUI_UNCHECKED)
    EndIf

   _GUICtrlComboBox_SetCurSel($cmbRatioNumeratorDonated, $ratioNumeratorDonated)
   _GUICtrlComboBox_SetCurSel($cmbRatioDenominatorReceived, $ratioDenominatorReceived -1)

	chkDropInBattle()
	chkBalanceDR()


	Switch $iActivateKQCondition
		Case "Manual"
			GUICtrlSetState($radManAbilities, $GUI_CHECKED)
		Case "Auto"
			GUICtrlSetState($radAutoAbilities, $GUI_CHECKED)
	EndSwitch

	GUICtrlSetData($txtManAbilities, ($delayActivateKQ / 1000))

	GUICtrlSetData($txtTimeStopAtk, $sTimeStopAtk)

	If $TakeLootSnapShot = 1 Then
		GUICtrlSetState($chkTakeLootSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeLootSS, $GUI_UNCHECKED)
	EndIf

	If $ScreenshotLootInfo = 1 Then
		GUICtrlSetState($chkScreenshotLootInfo, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkScreenshotLootInfo, $GUI_UNCHECKED)
	EndIf

	;Attack Adv. Settings--------------------------------------------------------------------------
	If $iChkAttackNow = 1 Then
		GUICtrlSetState($chkAttackNow, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAttackNow, $GUI_UNCHECKED)
	EndIf
	chkAttackNow()

	_GUICtrlComboBox_SetCurSel($cmbAttackNowDelay, $iAttackNowDelay - 1)

	If $chkATH = 1 Then
		GUICtrlSetState($chkAttackTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAttackTH, $GUI_UNCHECKED)
	EndIf

    If $iChkSnipeWhileTrain = 1 Then ; Snipe While Train MOD by ChiefM3
		GUICtrlSetState($chkSnipeWhileTrain, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkSnipeWhileTrain, $GUI_UNCHECKED)
	EndIf
	If $iChkLightSpell = 1 Then
		GUICtrlSetState($chkLightSpell, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkLightSpell, $GUI_UNCHECKED)
	EndIf
	GUILightSpell()
	GUICtrlSetData($txtMinDarkStorage, $SpellMinDarkStorage)

	_GUICtrlComboBox_SetCurSel($cmbiLSpellQ, $iLSpellQ - 1)
	if $OptZapAndRun = 1 Then
	   GUICtrlSetState($chkZapAndRun, $GUI_CHECKED)
    Else
	   GUICtrlSetState($chkZapAndRun, $GUI_UNCHECKED)
    EndIf

	If $OptBullyMode = 1 Then
		GUICtrlSetState($chkBullyMode, $GUI_CHECKED)
	ElseIf $OptBullyMode = 0 Then
		GUICtrlSetState($chkBullyMode, $GUI_UNCHECKED)
	 EndIf
	GUICtrlSetData($txtATBullyMode, $ATBullyMode)
	_GUICtrlComboBox_SetCurSel($cmbYourTH, $YourTH)
	chkBullyMode()

	If $OptTrophyMode = 1 Then
		GUICtrlSetState($chkTrophyMode, $GUI_CHECKED)
	ElseIf $OptTrophyMode = 0 Then
		GUICtrlSetState($chkTrophyMode, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtTHaddTiles, $THaddTiles)
	_GUICtrlComboBox_SetCurSel($cmbAttackTHType, $AttackTHType)
	chkSnipeMode()
	If $OptTrophyModeDE = 1 Then
		GUICtrlSetState($chkTHSnipeLightningDE, $GUI_CHECKED)
	ElseIf $OptTrophyModeDE = 0 Then
		GUICtrlSetState($chkTHSnipeLightningDE, $GUI_UNCHECKED)
	EndIf

;	If $iUnbreakableMode = 1 Then
;		GUICtrlSetState($chkUnbreakable, $GUI_CHECKED)
;	Else
;		GUICtrlSetState($chkUnbreakable, $GUI_UNCHECKED)
;	EndIf
	GUICtrlSetData($txtUnbreakable, $iUnbreakableWait)
	GUICtrlSetData($txtUnBrkMinGold, $iUnBrkMinGold)
	GUICtrlSetData($txtUnBrkMinElixir, $iUnBrkMinElixir)
	GUICtrlSetData($txtUnBrkMaxGold, $iUnBrkMaxGold)
	GUICtrlSetData($txtUnBrkMaxElixir, $iUnBrkMaxElixir)
	chkUnbreakable()

	;attk their king
	;attk their queen

	;Donate Settings-------------------------------------------------------------------------
	If $ichkRequest = 1 Then
		GUICtrlSetState($chkRequest, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRequest, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtRequest, $sTxtRequest)
	chkRequest()

	If $ichkDonateBarbarians = 1 Then
		GUICtrlSetState($chkDonateBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
	EndIf
	chkDonateBarbarians()
	GUICtrlSetData($txtDonateBarbarians, $sTxtDonateBarbarians)
	GUICtrlSetData($txtBlacklistBarbarians, $sTxtBlacklistBarbarians)

	If $ichkDonateArchers = 1 Then
		GUICtrlSetState($chkDonateArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
	EndIf
	chkDonateArchers()
	GUICtrlSetData($txtDonateArchers, $sTxtDonateArchers)
	GUICtrlSetData($txtBlacklistArchers, $sTxtBlacklistArchers)

	If $ichkDonateGiants = 1 Then
		GUICtrlSetState($chkDonateGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)
	EndIf
	chkDonateGiants()
	GUICtrlSetData($txtDonateGiants, $sTxtDonateGiants)
	GUICtrlSetData($txtBlacklistGiants, $sTxtBlacklistGiants)

	If $ichkDonateGoblins = 1 Then
		GUICtrlSetState($chkDonateGoblins, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGoblins, $GUI_UNCHECKED)
	EndIf
	chkDonateGoblins()
	GUICtrlSetData($txtDonateGoblins, $sTxtDonateGoblins)
	GUICtrlSetData($txtBlacklistGoblins, $sTxtBlacklistGoblins)

	If $ichkDonateWallBreakers = 1 Then
		GUICtrlSetState($chkDonateWallBreakers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateWallBreakers, $GUI_UNCHECKED)
	EndIf
	chkDonateWallBreakers()
	GUICtrlSetData($txtDonateWallBreakers, $sTxtDonateWallBreakers)
	GUICtrlSetData($txtBlacklistWallBreakers, $sTxtBlacklistWallBreakers)

	If $ichkDonateBalloons = 1 Then
		GUICtrlSetState($chkDonateBalloons, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateBalloons, $GUI_UNCHECKED)
	EndIf
	chkDonateBalloons()
	GUICtrlSetData($txtDonateBalloons, $sTxtDonateBalloons)
	GUICtrlSetData($txtBlacklistBalloons, $sTxtBlacklistBalloons)

	If $ichkDonateWizards = 1 Then
		GUICtrlSetState($chkDonateWizards, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateWizards, $GUI_UNCHECKED)
	EndIf
	chkDonateWizards()
	GUICtrlSetData($txtDonateWizards, $sTxtDonateWizards)
	GUICtrlSetData($txtBlacklistWizards, $sTxtBlacklistWizards)

	If $ichkDonateHealers = 1 Then
		GUICtrlSetState($chkDonateHealers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateHealers, $GUI_UNCHECKED)
	EndIf
	chkDonateHealers()
	GUICtrlSetData($txtDonateHealers, $sTxtDonateHealers)
	GUICtrlSetData($txtBlacklistHealers, $sTxtBlacklistHealers)

	If $ichkDonateDragons = 1 Then
		GUICtrlSetState($chkDonateDragons, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateDragons, $GUI_UNCHECKED)
	EndIf
	chkDonateDragons()
	GUICtrlSetData($txtDonateDragons, $sTxtDonateDragons)
	GUICtrlSetData($txtBlacklistDragons, $sTxtBlacklistDragons)

	If $ichkDonatePekkas = 1 Then
		GUICtrlSetState($chkDonatePekkas, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonatePekkas, $GUI_UNCHECKED)
	EndIf
	chkDonatePekkas()
	GUICtrlSetData($txtDonatePekkas, $sTxtDonatePekkas)
	GUICtrlSetData($txtBlacklistPekkas, $sTxtBlacklistPekkas)

	If $ichkDonateMinions = 1 Then
		GUICtrlSetState($chkDonateMinions, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateMinions, $GUI_UNCHECKED)
	EndIf
	chkDonateMinions()
	GUICtrlSetData($txtDonateMinions, $sTxtDonateMinions)
	GUICtrlSetData($txtBlacklistMinions, $sTxtBlacklistMinions)

	If $ichkDonateHogRiders = 1 Then
		GUICtrlSetState($chkDonateHogRiders, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateHogRiders, $GUI_UNCHECKED)
	EndIf
	chkDonateHogRiders()
	GUICtrlSetData($txtDonateHogRiders, $sTxtDonateHogRiders)
	GUICtrlSetData($txtBlacklistHogRiders, $sTxtBlacklistHogRiders)

	If $ichkDonateValkyries = 1 Then
		GUICtrlSetState($chkDonateValkyries, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateValkyries, $GUI_UNCHECKED)
	EndIf
	chkDonateValkyries()
	GUICtrlSetData($txtDonateValkyries, $sTxtDonateValkyries)
	GUICtrlSetData($txtBlacklistValkyries, $sTxtBlacklistValkyries)

	If $ichkDonateGolems = 1 Then
		GUICtrlSetState($chkDonateGolems, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGolems, $GUI_UNCHECKED)
	EndIf
	chkDonateGolems()
	GUICtrlSetData($txtDonateGolems, $sTxtDonateGolems)
	GUICtrlSetData($txtBlacklistGolems, $sTxtBlacklistGolems)

	If $ichkDonateWitches = 1 Then
		GUICtrlSetState($chkDonateWitches, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateWitches, $GUI_UNCHECKED)
	EndIf
	chkDonateWitches()
	GUICtrlSetData($txtDonateWitches, $sTxtDonateWitches)
	GUICtrlSetData($txtBlacklistWitches, $sTxtBlacklistWitches)

	If $ichkDonateLavaHounds = 1 Then
		GUICtrlSetState($chkDonateLavaHounds, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateLavaHounds, $GUI_UNCHECKED)
	EndIf
	chkDonateLavaHounds()
	GUICtrlSetData($txtDonateLavaHounds, $sTxtDonateLavaHounds)
	GUICtrlSetData($txtBlacklistLavaHounds, $sTxtBlacklistLavaHounds)

	;;; Custom Combination Donate by ChiefM3
	If $ichkDonateCustom = 1 Then
		GUICtrlSetState($chkDonateCustom, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateCustom, $GUI_UNCHECKED)
	EndIf

	chkDonateCustom()

	GUICtrlSetData($txtDonateCustom, $sTxtDonateCustom)
	GUICtrlSetData($txtBlacklistCustom, $sTxtBlacklistCustom)
	_GUICtrlComboBox_SetCurSel($cmbDonateCustom1, $varDonateCustom[0][0])
	GUICtrlSetData($txtDonateCustom1, $varDonateCustom[0][1])
	_GUICtrlComboBox_SetCurSel($cmbDonateCustom2, $varDonateCustom[1][0])
	GUICtrlSetData($txtDonateCustom2, $varDonateCustom[1][1])
	_GUICtrlComboBox_SetCurSel($cmbDonateCustom3, $varDonateCustom[2][0])
	GUICtrlSetData($txtDonateCustom3, $varDonateCustom[2][1])

	GUICtrlSetData($txtBlacklist, $sTxtBlacklist)

	If $ichkDonateAllBarbarians = 1 Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_CHECKED)
		_DonateAllControls($eBarb, True)
	Else
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllArchers = 1 Then
		GUICtrlSetState($chkDonateAllArchers, $GUI_CHECKED)
		_DonateAllControls($eArch, True)
	Else
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllGiants = 1 Then
		GUICtrlSetState($chkDonateAllGiants, $GUI_CHECKED)
		_DonateAllControls($eGiant, True)
	Else
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllGoblins = 1 Then
		GUICtrlSetState($chkDonateAllGoblins, $GUI_CHECKED)
		_DonateAllControls($eGobl, True)
	Else
		GUICtrlSetState($chkDonateAllGoblins, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllWallBreakers = 1 Then
		GUICtrlSetState($chkDonateAllWallBreakers, $GUI_CHECKED)
		_DonateAllControls($eWall, True)
	Else
		GUICtrlSetState($chkDonateAllWallBreakers, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllBalloons = 1 Then
		GUICtrlSetState($chkDonateAllBalloons, $GUI_CHECKED)
		_DonateAllControls($eBall, True)
	Else
		GUICtrlSetState($chkDonateAllBalloons, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllWizards = 1 Then
		GUICtrlSetState($chkDonateAllWizards, $GUI_CHECKED)
		_DonateAllControls($eWiza, True)
	Else
		GUICtrlSetState($chkDonateAllWizards, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllHealers = 1 Then
		GUICtrlSetState($chkDonateAllHealers, $GUI_CHECKED)
		_DonateAllControls($eHeal, True)
	Else
		GUICtrlSetState($chkDonateAllHealers, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllDragons = 1 Then
		GUICtrlSetState($chkDonateAllDragons, $GUI_CHECKED)
		_DonateAllControls($eDrag, True)
	Else
		GUICtrlSetState($chkDonateAllDragons, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllPekkas = 1 Then
		GUICtrlSetState($chkDonateAllPekkas, $GUI_CHECKED)
		_DonateAllControls($ePekk, True)
	Else
		GUICtrlSetState($chkDonateAllPekkas, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllMinions = 1 Then
		GUICtrlSetState($chkDonateAllMinions, $GUI_CHECKED)
		_DonateAllControls($eMini, True)
	Else
		GUICtrlSetState($chkDonateAllMinions, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllHogRiders = 1 Then
		GUICtrlSetState($chkDonateAllHogRiders, $GUI_CHECKED)
		_DonateAllControls($eHogs, True)
	Else
		GUICtrlSetState($chkDonateAllHogRiders, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllValkyries = 1 Then
		GUICtrlSetState($chkDonateAllValkyries, $GUI_CHECKED)
		_DonateAllControls($eValk, True)
	Else
		GUICtrlSetState($chkDonateAllValkyries, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllGolems = 1 Then
		GUICtrlSetState($chkDonateAllGolems, $GUI_CHECKED)
		_DonateAllControls($eGole, True)
	Else
		GUICtrlSetState($chkDonateAllGolems, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllWitches = 1 Then
		GUICtrlSetState($chkDonateAllWitches, $GUI_CHECKED)
		_DonateAllControls($eWitc, True)
	Else
		GUICtrlSetState($chkDonateAllWitches, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllLavaHounds = 1 Then
		GUICtrlSetState($chkDonateAllLavaHounds, $GUI_CHECKED)
		_DonateAllControls($eLava, True)
	Else
		GUICtrlSetState($chkDonateAllLavaHounds, $GUI_UNCHECKED)
	EndIf

	;Troop Settings--------------------------------------------------------------------------
	for $i=0 to Ubound($TroopName) - 1
		GUICtrlSetData(eval("txtNum" & $TroopName[$i]), eval($TroopName[$i]&"Comp"))
	next
	for $i=0 to Ubound($TroopDarkName) - 1
		GUICtrlSetData(eval("txtNum" & $TroopDarkName[$i]), eval($TroopDarkName[$i]&"Comp"))
	next
	SetComboTroopComp()
	lblTotalCount()

	_GUICtrlComboBox_SetCurSel($cmbBarrack1, $barrackTroop[0])
	_GUICtrlComboBox_SetCurSel($cmbBarrack2, $barrackTroop[1])
	_GUICtrlComboBox_SetCurSel($cmbBarrack3, $barrackTroop[2])
	_GUICtrlComboBox_SetCurSel($cmbBarrack4, $barrackTroop[3])

	GUICtrlSetData($txtFullTroop, $fulltroop)
	
	GUICtrlSetData($sldTrainITDelay, $isldTrainITDelay)
	GUICtrlSetData($lbltxtTrainITDelay, "delay " & $isldTrainITDelay & " ms.")
	;barracks boost not saved (no use)


	;PushBullet-----------------------------------------------------------------------------

    GUICtrlSetData($PushBTokenValue, $PushToken)
	if $iOrigPushB = "" then
	  GUICtrlSetData($OrigPushB, "MyVillage")
    Else
	  GUICtrlSetData($OrigPushB, $iOrigPushB)
   EndIf

	If $iAlertPBVillage = 1 Then
	   GUICtrlSetState($chkAlertPBVillage, $GUI_CHECKED)
    ElseIf $iAlertPBVillage = 0 Then
	   GUICtrlSetState($chkAlertPBVillage, $GUI_UNCHECKED)
    EndIf


	If $pEnabled = 1 Then
	   GUICtrlSetState($chkPBenabled, $GUI_CHECKED)
	   chkPBenabled()
	Elseif $pEnabled = 0 Then
	   GUICtrlSetState($chkPBenabled, $GUI_UNCHECKED)
	   chkPBenabled()
   EndIf

	If $pRemote = 1 Then
	   GUICtrlSetState($chkPBRemote, $GUI_CHECKED)
	Elseif $pRemote = 0 Then
	   GUICtrlSetState($chkPBRemote, $GUI_UNCHECKED)
    EndIf

	If $iDeleteAllPushes = 1 Then
		GUICtrlSetState($chkDeleteAllPushes, $GUI_CHECKED)
	ElseIf $iDeleteAllPushes = 0 Then
		GUICtrlSetState($chkDeleteAllPushes, $GUI_UNCHECKED)
    EndIf

	_GUICtrlComboBox_SetCurSel($cmbHoursPushBullet, $icmbHoursPushBullet -1)

	If $pMatchFound = 1 Then
	   GUICtrlSetState($chkAlertPBVMFound, $GUI_CHECKED)
	Elseif $pMatchFound = 0 Then
	   GUICtrlSetState($chkAlertPBVMFound, $GUI_UNCHECKED)
    EndIf

	If $pLastRaidImg = 1 Then
	   GUICtrlSetState($chkAlertPBLastRaid, $GUI_CHECKED)
	Elseif $pLastRaidImg = 0 Then
	   GUICtrlSetState($chkAlertPBLastRaid, $GUI_UNCHECKED)
    EndIf

	If $iAlertPBLastRaidTxt  = 1 Then
	   GUICtrlSetState($chkAlertPBLastRaidTxt, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkAlertPBLastRaidTxt, $GUI_UNCHECKED)
    EndIf

	If $pWallUpgrade = 1 Then
	   GUICtrlSetState($chkAlertPBWallUpgrade, $GUI_CHECKED)
	Elseif $pWallUpgrade = 0 Then
	   GUICtrlSetState($chkAlertPBWallUpgrade, $GUI_UNCHECKED)
    EndIf

	If $pOOS = 1 Then
	   GUICtrlSetState($chkAlertPBOOS, $GUI_CHECKED)
	Elseif $pOOS = 0 Then
	   GUICtrlSetState($chkAlertPBOOS, $GUI_UNCHECKED)
    EndIf

	If $pLabUpgrade = 1 Then
	   GUICtrlSetState($chkAlertPBLab, $GUI_CHECKED)
	Elseif $pLabUpgrade = 0 Then
	   GUICtrlSetState($chkAlertPBLab, $GUI_UNCHECKED)
    EndIf

	If $pTakeAbreak = 1 Then
	   GUICtrlSetState($chkAlertPBVBreak, $GUI_CHECKED)
	Elseif $pTakeAbreak = 0 Then
	   GUICtrlSetState($chkAlertPBVBreak, $GUI_UNCHECKED)
    EndIf

	If $pAnotherDevice = 1 Then
	   GUICtrlSetState($chkAlertPBOtherDevice, $GUI_CHECKED)
	Elseif $pAnotherDevice = 0 Then
	   GUICtrlSetState($chkAlertPBOtherDevice, $GUI_UNCHECKED)
    EndIf

	If $ichkDeleteOldPushes = 1 Then
		GUICtrlSetState($chkDeleteOldPushes, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeleteOldPushes, $GUI_UNCHECKED)
	EndIf
	chkDeleteOldPushes()

	; laboratory tab
	;Lab
		If $ichkLab = 1 Then
		GUICtrlSetState($chkLab, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkLab, $GUI_UNCHECKED)
	EndIf


	_GUICtrlComboBox_SetCurSel($cmbLaboratory, $icmbLaboratory)
	GUICtrlSetData($txtLabX, $itxtLabX)
	GUICtrlSetData($txtLabY, $itxtLabY)
	;Other Settings--------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbWalls, $icmbWalls)
	Switch $iUseStorage
		Case 0
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($UseElixir, $GUI_CHECKED)
		Case 2
			GUICtrlSetState($UseElixirGold, $GUI_CHECKED)
    EndSwitch

	GUICtrlSetData($txtWallMinGold, $itxtWallMinGold)
	GUICtrlSetData($txtWallMinElixir, $itxtWallMinElixir)
	cmbwalls()

	If $ichkWalls = 1 Then
		GUICtrlSetState($chkWalls, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkWalls, $GUI_UNCHECKED)
	EndIf
	chkWalls()

	If $ichkUpgrade1 = 1 Then
		GUICtrlSetState($chkUpgrade1, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
	EndIf
	If $ichkUpgrade2 = 1 Then
		GUICtrlSetState($chkUpgrade2, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade2, $GUI_UNCHECKED)
	EndIf
	If $ichkUpgrade3 = 1 Then
		GUICtrlSetState($chkUpgrade3, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade3, $GUI_UNCHECKED)
	EndIf
		If $ichkUpgrade4 = 1 Then
		GUICtrlSetState($chkUpgrade4, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade4, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtUpgradeX1, $itxtUpgradeX1)
	GUICtrlSetData($txtUpgradeY1, $itxtUpgradeY1)
	GUICtrlSetData($txtUpgradeX2, $itxtUpgradeX2)
	GUICtrlSetData($txtUpgradeY2, $itxtUpgradeY2)
	GUICtrlSetData($txtUpgradeX3, $itxtUpgradeX3)
	GUICtrlSetData($txtUpgradeY3, $itxtUpgradeY3)
	GUICtrlSetData($txtUpgradeX4, $itxtUpgradeX4)
	GUICtrlSetData($txtUpgradeY4, $itxtUpgradeY4)

	GUICtrlSetData($txtBuildMinGold, $itxtBuildMinGold)
	GUICtrlSetData($txtBuildMinElixir, $itxtBuildMinElixir)
	GUICtrlSetData($txtBuildMinDark, $itxtBuildMinDark)
	GUICtrlSetData($txtBuilderKeepFree, $itxtBuilderKeepFree)

	If $ichkUpgradeKing = 1 Then ;==>upgradeking
		GUICtrlSetState($chkUpgradeKing, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgradeKing, $GUI_UNCHECKED)
	EndIf

	If $ichkUpgradeQueen = 1 Then ;==>upgradequeen
		GUICtrlSetState($chkUpgradeQueen, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgradeQueen, $GUI_UNCHECKED)
	EndIf

	;Mow the lawn
	If $ichkTrees = 1 Then
		GUICtrlSetState($chkTrees, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrees, $GUI_UNCHECKED)
	EndIf
	If $ichkTombs = 1 Then
		GUICtrlSetState($chkTombs, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTombs, $GUI_UNCHECKED)
	EndIf
	chkTrees()
	;End Mow the lawn

	If $ichkTrap = 1 Then
		GUICtrlSetState($chkTrap, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrap, $GUI_UNCHECKED)
	EndIf
	chkTrap()

	If $iChkCollect = 1 Then
		GUICtrlSetState($chkCollect, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkCollect, $GUI_UNCHECKED)
	EndIf

	GUICtrlSetData($txtTimeWakeUp, $sTimeWakeUp)

	GUICtrlSetData($sldVSDelay, $iVSDelay)
	GUICtrlSetData($lblVSDelay, $iVSDelay)

	GUICtrlSetData($txtMaxTrophy, $itxtMaxTrophy)
	GUICtrlSetData($txtdropTrophy, $itxtdropTrophy)

	If $iChkTrophyHeroes = 1 Then
		GUICtrlSetState($chkTrophyHeroes, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrophyHeroes, $GUI_UNCHECKED)
	EndIf

	If $iChkTrophyAtkDead = 1 Then
		GUICtrlSetState($chkTrophyAtkDead, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrophyAtkDead, $GUI_UNCHECKED)
	EndIf

	;location of TH, CC, Army Camp, Barrack and Spell Fact. not Applied, only read

EndFunc   ;==>applyConfig
