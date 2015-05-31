;Reads config file and sets variables

Func readConfig() ;Reads config and sets it to the variables
	If FileExists($building) Then
		$TownHallPos[0] = IniRead($building, "other", "xTownHall", "-1")
		$TownHallPos[1] = IniRead($building, "other", "yTownHall", "-1")

		$aCCPos[0] = IniRead($building, "other", "xCCPos", "0")
		$aCCPos[1] = IniRead($building, "other", "yCCPos", "0")

		$barrackPos[0] = IniRead($building, "other", "xBarrack", "0")
		$barrackPos[1] = IniRead($building, "other", "yBarrack", "0")

		$ArmyPos[0] = IniRead($building, "other", "xArmy", "0")
		$ArmyPos[1] = IniRead($building, "other", "yArmy", "0")

		$SFPos[0] = IniRead($building, "other", "xspellfactory", "-1")
		$SFPos[1] = IniRead($building, "other", "yspellfactory", "-1")

		$KingPos[0] = IniRead($building, "other", "xKing", "0")
		$KingPos[1] = IniRead($building, "other", "yKing", "0")
		$QueenPos[0] = IniRead($building, "other", "xQueen", "0")
		$QueenPos[1] = IniRead($building, "other", "yQueen", "0")

		$barrackNum = IniRead($building, "other", "barrackNum", "0")
		$barrackDarkNum = IniRead($building, "other", "barrackDarkNum", "0")

		$listResourceLocation = IniRead($building, "other", "listResource", "")

		$ichkUpgrade1 = IniRead($building, "other", "BuildUpgrade1", "0")
		$ichkUpgrade2 = IniRead($building, "other", "BuildUpgrade2", "0")
		$ichkUpgrade3 = IniRead($building, "other", "BuildUpgrade3", "0")
		$ichkUpgrade4 = IniRead($building, "other", "BuildUpgrade4", "0")
		$itxtUpgradeX1 = IniRead($building, "other", "BuildUpgradeX1", "0")
		$itxtUpgradeY1 = IniRead($building, "other", "BuildUpgradeY1", "0")
		$itxtUpgradeX2 = IniRead($building, "other", "BuildUpgradeX2", "0")
		$itxtUpgradeY2 = IniRead($building, "other", "BuildUpgradeY2", "0")
		$itxtUpgradeX3 = IniRead($building, "other", "BuildUpgradeX3", "0")
		$itxtUpgradeY3 = IniRead($building, "other", "BuildUpgradeY3", "0")
		$itxtUpgradeX4 = IniRead($building, "other", "BuildUpgradeX4", "0")
		$itxtUpgradeY4 = IniRead($building, "other", "BuildUpgradeY4", "0")
	endif
	If FileExists($config) Then

		;General Settings--------------------------------------------------------------------------
		$frmBotPosX = IniRead($config, "general", "frmBotPosX", "900")
		$frmBotPosY = IniRead($config, "general", "frmBotPosY", "20")

		$ichkAutoStart = IniRead($config, "general", "AutoStart", "0")
		$restarted = IniRead($config, "general", "Restarted", "0")
		$ichkBackground = IniRead($config, "general", "Background", "0")
		$ichkBotStop = IniRead($config, "general", "BotStop", "0")
		$icmbBotCommand = IniRead($config, "general", "Command", "0")
		$icmbBotCond = IniRead($config, "general", "Cond", "0")
		$icmbHoursStop = IniRead($config, "general", "Hour", "0")

		;Search Settings------------------------------------------------------------------------
		$iradAttackMode = IniRead($config, "search", "mode", "0")
		$iWBMortar = IniRead($config, "search", "iwbmortar", "5")
		$iWBWizTower = IniRead($config, "search", "iwbwiztower", "5")
		$iWBXbow = IniRead($config, "search", "iwbxbow", "0")

		$iChkSearchReduction = IniRead($config, "search", "reduction", "1")
		$ReduceCount = IniRead($config, "search", "reduceCount", "20")
		$ReduceGold = IniRead($config, "search", "reduceGold", "2000")
		$ReduceElixir = IniRead($config, "search", "reduceElixir", "2000")
		$ReduceGoldPlusElixir = IniRead($config, "search", "reduceGoldPlusElixir", "4000")
		$ReduceDark = IniRead($config, "search", "reduceDark", "100")
		$ReduceTrophy = IniRead($config, "search", "reduceTrophy", "2")

		$chkConditions[0] = IniRead($config, "search", "conditionGoldElixir", "0")
		$chkConditions[3] = IniRead($config, "search", "conditionGoldorElixir", "0")
		$chkConditions[6] = IniRead($config, "search", "conditionGoldPlusElixir", "0")
		$chkConditions[1] = IniRead($config, "search", "conditionDark", "0")
		$chkConditions[2] = IniRead($config, "search", "conditionTrophy", "0")
		$chkConditions[4] = IniRead($config, "search", "conditionTownHall", "0")
		$chkConditions[5] = IniRead($config, "search", "conditionTownHallO", "0")
		$ichkMeetOne = IniRead($config, "search", "conditionOne", "0")

		$MinGold = IniRead($config, "search", "searchGold", "80000")
		$MinElixir = IniRead($config, "search", "searchElixir", "80000")
		$MinGoldPlusElixir = IniRead($config, "search", "searchGoldPlusElixir", "160000")
		$MinDark = IniRead($config, "search", "searchDark", "0")
		$MinTrophy = IniRead($config, "search", "searchTrophy", "0")
		$icmbTH = IniRead($config, "search", "THLevel", "0")
		
		;Use selected troops
		$icmbSelectTroop = IniRead($config, "attack", "SelectTroop", "8")

		$AlertSearch = IniRead($config, "search", "AlertSearch", "0")

		;Attack Basics Settings-------------------------------------------------------------------------
		$deploySettings = IniRead($config, "attack", "deploy", "3")
		$icmbTroopComp = IniRead($config, "attack", "composition", "0")
	    $icmbUnitDelay = IniRead($config, "attack", "UnitD", "0")
	    $icmbWaveDelay = IniRead($config, "attack", "WaveD", "0")
	    $iRandomspeedatk = IniRead($config, "attack", "randomatk", "0")

		$chkRedArea = IniRead($config, "attack", "deployRedArea", "1")
		$iCmbSmartDeploy = IniRead($config, "attack", "smartAttackDeploy", "0")

		$chkSmartAttack[0] = IniRead($config, "attack", "smartAttackGoldMine", "0")
		$chkSmartAttack[1] = IniRead($config, "attack", "smartAttackElixirCollector", "0")
		$chkSmartAttack[2] = IniRead($config, "attack", "smartAttackDarkElixirDrill", "0")

		$KingAttack[0] = IniRead($config, "attack", "king-dead", "0")
		$KingAttack[1] = IniRead($config, "attack", "king-weak", "0")
		$KingAttack[2] = IniRead($config, "attack", "king-all", "0")

		$QueenAttack[0] = IniRead($config, "attack", "queen-dead", "0")
		$QueenAttack[1] = IniRead($config, "attack", "queen-weak", "0")
		$QueenAttack[2] = IniRead($config, "attack", "queen-all", "0")

		$checkUseClanCastle = IniRead($config, "attack", "use-cc", "0")
	    $checkUseClanCastleBalanced = IniRead($config, "attack", "use-cc-balanced", "0")
	    $ratioNumeratorDonated = IniRead($config, "attack", "use-cc-balanced-ratio-donated", "1")
	    $ratioDenominatorReceived = IniRead($config, "attack", "use-cc-balanced-ratio-received", "1")

		$iActivateKQCondition = IniRead($config, "attack", "ActivateKQ", "Manual")
		$delayActivateKQ = (1000 * IniRead($config, "attack", "delayActivateKQ", "9"))

		$sTimeStopAtk = IniRead($config, "attack", "txtTimeStopAtk", "0")

		$TakeLootSnapShot = IniRead($config, "attack", "TakeLootSnapShot", "0")
		$ScreenshotLootInfo =  IniRead($config, "attack", "ScreenshotLootInfo", "0")

		;Attack Adv. Settings--------------------------------------------------------------------------
		$iChkAttackNow = IniRead($config, "advanced", "attacknow", "0")
		$iAttackNowDelay = IniRead($config, "advanced", "attacknowdelay", "3")

		$chkATH = IniRead($config, "advanced", "townhall", "0")
		$iChkSnipeWhileTrain = IniRead($config, "advanced", "chkSnipeWhileTrain", "0") ; Snipe While Train MOD by ChiefM3
		$iChkLightSpell = IniRead($config, "advanced", "hitDElightning", "0")
		$SpellMinDarkStorage = IniRead($config, "advanced", "txtMinDarkStorage", "500")
        $iLSpellQ = IniRead ($config, "advanced", "QLSpell", "3")
		$OptZapAndRun = IniRead($config, "advanced","chkZapAndRun","0")

		$OptBullyMode = IniRead($config, "advanced", "BullyMode", "0")
		$ATBullyMode = IniRead($config, "advanced", "ATBullyMode", "0")
		$YourTH = IniRead($config, "advanced", "YourTH", "0")

		$OptTrophyMode = IniRead($config, "advanced", "TrophyMode", "0")
		$THaddtiles = IniRead($config, "advanced", "THaddTiles", "0")
		$AttackTHType = IniRead($config, "advanced", "AttackTHType", "0")
		$OptTrophyModeDE = IniRead($config, "advanced", "TrophyModeDE", "0")

;		$iUnbreakableMode = IniRead($config, "advanced", "chkUnbreakable", "0")
		$iUnbreakableWait = IniRead($config, "advanced", "UnbreakableWait", "5")
		$iUnBrkMinGold = IniRead($config, "advanced", "minUnBrkgold", "50000")
		$iUnBrkMinElixir= IniRead($config, "advanced", "minUnBrkelixir", "50000")
		$iUnBrkMaxGold = IniRead($config, "advanced", "maxUnBrkgold", "600000")
		$iUnBrkMaxElixir = IniRead($config, "advanced", "maxUnBrkelixir", "600000")

		;atk their king
		;atk their queen

		;Donate Settings-------------------------------------------------------------------------
		$iChkRequest = IniRead($config, "donate", "chkRequest", "0")
		$sTxtRequest = IniRead($config, "donate", "txtRequest", "")

		$ichkDonateBarbarians = IniRead($config, "donate", "chkDonateBarbarians", "0")
		$ichkDonateAllBarbarians = IniRead($config, "donate", "chkDonateAllBarbarians", "0")
		$sTxtDonateBarbarians = StringReplace(IniRead($config, "donate", "txtDonateBarbarians", "barbarians|barb|any"), "|", @CRLF)
		$sTxtBlacklistBarbarians = StringReplace(IniRead($config, "donate", "txtBlacklistBarbarians", "no barbarians|no barb|barbarians no|barb no"), "|", @CRLF)
		$aDonBarbarians = StringSplit($sTxtDonateBarbarians, @CRLF, $STR_ENTIRESPLIT)
		$aBlkBarbarians = StringSplit($sTxtBlackListBarbarians, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateArchers = IniRead($config, "donate", "chkDonateArchers", "0")
		$ichkDonateAllArchers = IniRead($config, "donate", "chkDonateAllArchers", "0")
		$sTxtDonateArchers = StringReplace(IniRead($config, "donate", "txtDonateArchers", "archers|arch|any"), "|", @CRLF)
		$sTxtBlacklistArchers = StringReplace(IniRead($config, "donate", "txtBlacklistArchers", "no archers|no arch|archers no|arch no"), "|", @CRLF)
		$aDonArchers = StringSplit($sTxtDonateArchers, @CRLF, $STR_ENTIRESPLIT)
		$aBlkArchers = StringSplit($sTxtBlackListArchers, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateGiants = IniRead($config, "donate", "chkDonateGiants", "0")
		$ichkDonateAllGiants = IniRead($config, "donate", "chkDonateAllGiants", "0")
		$sTxtDonateGiants = StringReplace(IniRead($config, "donate", "txtDonateGiants", "giants|giant|any"), "|", @CRLF)
		$sTxtBlacklistGiants = StringReplace(IniRead($config, "donate", "txtBlacklistGiants", "no giants|giants no"), "|", @CRLF)
		$aDonGiants = StringSplit($sTxtDonateGiants, @CRLF, $STR_ENTIRESPLIT)
		$aBlkGiants = StringSplit($sTxtBlackListGiants, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateGoblins = IniRead($config, "donate", "chkDonateGoblins", "0")
		$ichkDonateAllGoblins = IniRead($config, "donate", "chkDonateAllGoblins", "0")
		$sTxtDonateGoblins = StringReplace(IniRead($config, "donate", "txtDonateGoblins", "goblins|goblin"), "|", @CRLF)
		$sTxtBlacklistGoblins = StringReplace(IniRead($config, "donate", "txtBlacklistGoblins", "no goblins|goblins no"), "|", @CRLF)
		$aDonGoblins = StringSplit($sTxtDonateGoblins, @CRLF, $STR_ENTIRESPLIT)
		$aBlkGoblins = StringSplit($sTxtBlackListGoblins, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateWallBreakers = IniRead($config, "donate", "chkDonateWallBreakers", "0")
		$ichkDonateAllWallBreakers = IniRead($config, "donate", "chkDonateAllWallBreakers", "0")
		$sTxtDonateWallBreakers = StringReplace(IniRead($config, "donate", "txtDonateWallBreakers", "wall breakers|wb"), "|", @CRLF)
		$sTxtBlacklistWallBreakers = StringReplace(IniRead($config, "donate", "txtBlacklistWallBreakers", "no wallbreakers|wb no"), "|", @CRLF)
		$aDonWallBreakers = StringSplit($sTxtDonateWallBreakers, @CRLF, $STR_ENTIRESPLIT)
		$aBlkWallBreakers = StringSplit($sTxtBlackListWallBreakers, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateBalloons = IniRead($config, "donate", "chkDonateBalloons", "0")
		$ichkDonateAllBalloons = IniRead($config, "donate", "chkDonateAllBalloons", "0")
		$sTxtDonateBalloons = StringReplace(IniRead($config, "donate", "txtDonateBalloons", "balloons|balloon"), "|", @CRLF)
		$sTxtBlacklistBalloons = StringReplace(IniRead($config, "donate", "txtBlacklistBalloons", "no balloons|balloons no"), "|", @CRLF)
		$aDonBalloons = StringSplit($sTxtDonateBalloons, @CRLF, $STR_ENTIRESPLIT)
		$aBlkBalloons = StringSplit($sTxtBlackListBalloons, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateWizards = IniRead($config, "donate", "chkDonateWizards", "0")
		$ichkDonateAllWizards = IniRead($config, "donate", "chkDonateAllWizards", "0")
		$sTxtDonateWizards = StringReplace(IniRead($config, "donate", "txtDonateWizards", "wizards|wizard"), "|", @CRLF)
		$sTxtBlacklistWizards = StringReplace(IniRead($config, "donate", "txtBlacklistWizards", "no wizards|wizards no"), "|", @CRLF)
		$aDonWizards = StringSplit($sTxtDonateWizards, @CRLF, $STR_ENTIRESPLIT)
		$aBlkWizards = StringSplit($sTxtBlackListWizards, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateHealers = IniRead($config, "donate", "chkDonateHealers", "0")
		$ichkDonateAllHealers = IniRead($config, "donate", "chkDonateAllHealers", "0")
		$sTxtDonateHealers = StringReplace(IniRead($config, "donate", "txtDonateHealers", "healer"), "|", @CRLF)
		$sTxtBlacklistHealers = StringReplace(IniRead($config, "donate", "txtBlacklistHealers", "no healer|healer no"), "|", @CRLF)
		$aDonHealers = StringSplit($sTxtDonateHealers, @CRLF, $STR_ENTIRESPLIT)
		$aBlkHealers = StringSplit($sTxtBlackListHealers, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateDragons = IniRead($config, "donate", "chkDonateDragons", "0")
		$ichkDonateAllDragons = IniRead($config, "donate", "chkDonateAllDragons", "0")
		$sTxtDonateDragons = StringReplace(IniRead($config, "donate", "txtDonateDragons", "dragon"), "|", @CRLF)
		$sTxtBlacklistDragons = StringReplace(IniRead($config, "donate", "txtBlacklistDragons", "no dragon|dragon no"), "|", @CRLF)
		$aDonDragons = StringSplit($sTxtDonateDragons, @CRLF, $STR_ENTIRESPLIT)
		$aBlkDragons = StringSplit($sTxtBlackListDragons, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonatePekkas = IniRead($config, "donate", "chkDonatePekkas", "0")
		$ichkDonateAllPekkas = IniRead($config, "donate", "chkDonateAllPekkas", "0")
		$sTxtDonatePekkas = StringReplace(IniRead($config, "donate", "txtDonatePekkas", "pekka"), "|", @CRLF)
		$sTxtBlacklistPekkas = StringReplace(IniRead($config, "donate", "txtBlacklistPekkas", "no pekka|pekka no"), "|", @CRLF)
		$aDonPekkas = StringSplit($sTxtDonatePekkas, @CRLF, $STR_ENTIRESPLIT)
		$aBlkPekkas = StringSplit($sTxtBlackListPekkas, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateMinions = IniRead($config, "donate", "chkDonateMinions", "0")
		$ichkDonateAllMinions = IniRead($config, "donate", "chkDonateAllMinions", "0")
		$sTxtDonateMinions = StringReplace(IniRead($config, "donate", "txtDonateMinions", "minions|minion"), "|", @CRLF)
		$sTxtBlacklistMinions = StringReplace(IniRead($config, "donate", "txtBlacklistMinions", "no minions|minions no"), "|", @CRLF)
		$aDonMinions = StringSplit($sTxtDonateMinions, @CRLF, $STR_ENTIRESPLIT)
		$aBlkMinions = StringSplit($sTxtBlackListMinions, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateHogRiders = IniRead($config, "donate", "chkDonateHogRiders", "0")
		$ichkDonateAllHogRiders = IniRead($config, "donate", "chkDonateAllHogRiders", "0")
		$sTxtDonateHogRiders = StringReplace(IniRead($config, "donate", "txtDonateHogRiders", "hogriders|hogs|hog"), "|", @CRLF)
		$sTxtBlacklistHogRiders = StringReplace(IniRead($config, "donate", "txtBlacklistHogRiders", "no hogriders|hogriders no|no hogs|hogs no"), "|", @CRLF)
		$aDonHogRiders = StringSplit($sTxtDonateHogRiders, @CRLF, $STR_ENTIRESPLIT)
		$aBlkHogRiders = StringSplit($sTxtBlackListHogRiders, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateValkyries = IniRead($config, "donate", "chkDonateValkyries", "0")
		$ichkDonateAllValkyries = IniRead($config, "donate", "chkDonateAllValkyries", "0")
		$sTxtDonateValkyries = StringReplace(IniRead($config, "donate", "txtDonateValkyries", "valkyries|valkyrie"), "|", @CRLF)
		$sTxtBlacklistValkyries = StringReplace(IniRead($config, "donate", "txtBlacklistValkyries", "no valkyries|valkyries no"), "|", @CRLF)
		$aDonValkyries = StringSplit($sTxtDonateValkyries, @CRLF, $STR_ENTIRESPLIT)
		$aBlkValkyries = StringSplit($sTxtBlackListValkyries, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateGolems = IniRead($config, "donate", "chkDonateGolems", "0")
		$ichkDonateAllGolems = IniRead($config, "donate", "chkDonateAllGolems", "0")
		$sTxtDonateGolems = StringReplace(IniRead($config, "donate", "txtDonateGolems", "golem"), "|", @CRLF)
		$sTxtBlacklistGolems = StringReplace(IniRead($config, "donate", "txtBlacklistGolems", "no golem|golem no"), "|", @CRLF)
		$aDonGolems = StringSplit($sTxtDonateGolems, @CRLF, $STR_ENTIRESPLIT)
		$aBlkGolems = StringSplit($sTxtBlackListGolems, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateWitches = IniRead($config, "donate", "chkDonateWitches", "0")
		$ichkDonateAllWitches = IniRead($config, "donate", "chkDonateAllWitches", "0")
		$sTxtDonateWitches = StringReplace(IniRead($config, "donate", "txtDonateWitches", "witches|witch"), "|", @CRLF)
		$sTxtBlacklistWitches = StringReplace(IniRead($config, "donate", "txtBlacklistWitches", "no witches|witches no"), "|", @CRLF)
		$aDonWitches = StringSplit($sTxtDonateWitches, @CRLF, $STR_ENTIRESPLIT)
		$aBlkWitches = StringSplit($sTxtBlackListWitches, @CRLF, $STR_ENTIRESPLIT)

		$ichkDonateLavaHounds = IniRead($config, "donate", "chkDonateLavaHounds", "0")
		$ichkDonateAllLavaHounds = IniRead($config, "donate", "chkDonateAllLavaHounds", "0")
		$sTxtDonateLavaHounds = StringReplace(IniRead($config, "donate", "txtDonateLavaHounds", "lavahounds|hound|lava"), "|", @CRLF)
		$sTxtBlacklistLavaHounds = StringReplace(IniRead($config, "donate", "txtBlacklistLavaHounds", "no lavahound|hound no"), "|", @CRLF)
		$aDonLavaHounds = StringSplit($sTxtDonateLavaHounds, @CRLF, $STR_ENTIRESPLIT)
		$aBlkLavaHounds = StringSplit($sTxtBlackListLavaHounds, @CRLF, $STR_ENTIRESPLIT)

		;;; Custom Combination Donate by ChiefM3
		$ichkDonateCustom = IniRead($config, "donate", "chkDonateCustom", "0")
		$ichkDonateAllCustom = IniRead($config, "donate", "chkDonateAllCustom", "0")
		$sTxtDonateCustom = StringReplace(IniRead($config, "donate", "txtDonateCustom", "any|need"), "|", @CRLF)
		$sTxtBlacklistCustom = StringReplace(IniRead($config, "donate", "txtBlacklistCustom", "no|cw|war"), "|", @CRLF)
		$aDonCustom = StringSplit($sTxtDonateCustom, @CRLF, $STR_ENTIRESPLIT)
		$aBlkCustom = StringSplit($sTxtBlacklistCustom, @CRLF, $STR_ENTIRESPLIT)
		For $i = 0 To 2
		   $varDonateCustom[$i][0] = IniRead($config, "donate", "cmbDonateCustom" & ($i + 1), "0")
		   $varDonateCustom[$i][1] = IniRead($config, "donate", "txtDonateCustom" & ($i + 1), "0")
	    Next

		$sTxtBlacklist = StringReplace(IniRead($config, "donate", "txtBlacklist", "clan war|war|cw"), "|", @CRLF)
		$aBlackList = StringSplit($sTxtBlackList, @CRLF, $STR_ENTIRESPLIT)

		;Troop Settings--------------------------------------------------------------------------
		for $i=0 to Ubound($TroopName) - 1
			assign($TroopName[$i] & "Comp", IniRead($config, "troop", $TroopName[$i], "0"))
		next
		for $i=0 to Ubound($TroopDarkName) - 1
			assign($TroopDarkName[$i] & "Comp", IniRead($config, "troop", $TroopDarkName[$i], "0"))
		next

		For $i = 0 To 3 ;Covers all 4 Barracks
			$barrackTroop[$i] = IniRead($config, "troop", "troop" & $i + 1, "0")
		Next

		$fulltroop = IniRead($config, "troop", "fullTroop", "100")
		$isldTrainITDelay = IniRead($config, "troop", "TrainITDelay", "20")
		;barracks boost not saved (no use)
; labo
;Laboratory
		$ichkLab = IniRead($config, "upgrade", "auto-uptroops", "0")
		$icmbLaboratory = IniRead($config, "upgrade", "troops-name", "0")
		$itxtLabX = IniRead($config, "upgrade", "LabPosX", "0")
		$itxtLabY = IniRead($config, "upgrade", "LabPosY", "0")
		;Misc Settings--------------------------------------------------------------------------

        $itxtBuildMinGold = IniRead($config, "other", "minbuildgold", "0")
        $itxtBuildMinElixir = IniRead($config, "other", "minbuildelixir", "0")
        $itxtBuildMinDark = IniRead($config, "other", "minbuildark", "0")
        $itxtBuilderKeepFree = IniRead($config, "other", "builderkeepfree", "0")

		$ichkUpgradeKing = IniRead($config, "other", "UpKing", "0") ;==>upgradeking
		$ichkUpgradeQueen = IniRead($config, "other", "UpQueen", "0") ;==>upgradequeen

		$ichkWalls = IniRead($config, "other", "auto-wall", "0")
		$iUseStorage = IniRead($config, "other", "use-storage", "0")

		$icmbWalls = IniRead($config, "other", "walllvl", "0")
		$itxtWallMinGold = IniRead($config, "other", "minwallgold", "0")
		$itxtWallMinElixir = IniRead($config, "other", "minwallelixir", "0")

		$ichkTrees =  IniRead($config, "other", "remove-trees", "0")
		$ichkTombs =  IniRead($config, "other", "remove-tombs", "0")

		$ichkTrap = IniRead($config, "other", "chkTrap", "0")
		$iChkCollect = IniRead($config, "other", "chkCollect", "1")
		$sTimeWakeUp = IniRead($config, "other", "txtTimeWakeUp", "0")
		$iVSDelay = IniRead($config, "other", "VSDelay", "0")

		$itxtMaxTrophy = IniRead($config, "other", "MaxTrophy", "3000")
		$itxtdropTrophy = IniRead($config, "other", "MinTrophy", "3000")
		$iChkTrophyHeroes = IniRead($config, "other", "chkTrophyHeroes", "0")
		$iChkTrophyAtkDead = IniRead($config, "other", "chkTrophyAtkDead", "0")

	    ;PushBullet Settings ---------------------------------------------
		$PushToken = IniRead($config, "pushbullet", "AccountToken", "")
		$iOrigPushB = IniRead($config, "pushbullet", "OrigPushB", "")

		$iAlertPBVillage = IniRead($config, "pushbullet", "AlertPBVillage", "0")
		$pEnabled = IniRead($config, "pushbullet", "PBEnabled", "0")
		$pRemote = IniRead($config, "pushbullet", "PBRemote", "0")
		$iDeleteAllPushes = IniRead($config, "pushbullet", "DeleteAllPBPushes", "0")
	    $pMatchFound = IniRead($config, "pushbullet", "AlertPBVMFound", "0")
	    $pLastRaidImg = IniRead($config, "pushbullet", "AlertPBLastRaid", "0")
        $iAlertPBLastRaidTxt = IniRead($config, "pushbullet", "AlertPBLastRaidTxt", "0")
	    $pWallUpgrade = IniRead($config, "pushbullet", "AlertPBWallUpgrade", "0")
	    $pOOS = IniRead($config, "pushbullet", "AlertPBOOS", "0")
	    $pLabUpgrade = IniRead($config, "pushbullet", "AlertPBLab", "0")
	    $pTakeAbreak = IniRead($config, "pushbullet", "AlertPBVBreak", "0")
	    $pAnotherDevice = IniRead($config, "pushbullet", "AlertPBOtherDevice", "0")
		$icmbHoursPushBullet = IniRead($config, "pushbullet", "HoursPushBullet", "4")
		$ichkDeleteOldPushes = IniRead($config, "pushbullet", "DeleteOldPushes", "0")




	    $debug_getdigitlarge = IniRead($config, "debug", "debug_getdigitlarge", "0")

	Else
		Return False
	EndIf
EndFunc   ;==>readConfig
