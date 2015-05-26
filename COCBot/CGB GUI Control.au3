; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GkevinOD (2014)
; Modified ......: Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Opt("GUIOnEventMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 10)
Opt("TrayMenuMode", 3)

#include-once
#include "functions\Other\GUICtrlGetBkColor.au3" ; Included here to use on GUI Control

;Dynamic declaration of Array controls, cannot be on global variables because the GUI has to be created first for these control-id's to be known.
Local $aChkDonateControls[17] = [$chkDonateBarbarians, $chkDonateArchers, $chkDonateGiants, $chkDonateGoblins, $chkDonateWallBreakers, $chkDonateBalloons, $chkDonateWizards, $chkDonateHealers, $chkDonateDragons, $chkDonatePekkas, $chkDonateMinions, $chkDonateHogRiders, $chkDonateValkyries, $chkDonateGolems, $chkDonateWitches, $chkDonateLavaHounds, $chkDonateCustom]
Local $aChkDonateAllControls[17] = [$chkDonateAllBarbarians, $chkDonateAllArchers, $chkDonateAllGiants, $chkDonateAllGoblins, $chkDonateAllWallBreakers, $chkDonateAllBalloons, $chkDonateAllWizards, $chkDonateAllHealers, $chkDonateAllDragons, $chkDonateAllPekkas, $chkDonateAllMinions, $chkDonateAllHogRiders, $chkDonateAllValkyries, $chkDonateAllGolems, $chkDonateAllWitches, $chkDonateAllLavaHounds, $chkDonateAllCustom]
Local $aTxtDonateControls[17] = [$txtDonateBarbarians, $txtDonateArchers, $txtDonateGiants, $txtDonateGoblins, $txtDonateWallBreakers, $txtDonateBalloons, $txtDonateWizards, $txtDonateHealers, $txtDonateDragons, $txtDonatePekkas, $txtDonateMinions, $txtDonateHogRiders, $txtDonateValkyries, $txtDonateGolems, $txtDonateWitches, $txtDonateLavaHounds, $txtDonateCustom]
Local $aTxtBlacklistControls[17] = [$txtBlacklistBarbarians, $txtBlacklistArchers, $txtBlacklistGiants, $txtBlacklistGoblins, $txtBlacklistWallBreakers, $txtBlacklistBalloons, $txtBlacklistWizards, $txtBlacklistHealers, $txtBlacklistDragons, $txtBlacklistPekkas, $txtBlacklistMinions, $txtBlacklistHogRiders, $txtBlacklistValkyries, $txtBlacklistGolems, $txtBlacklistWitches, $txtBlacklistLavaHounds, $txtBlacklistCustom]
Local $aLblBtnControls[17] = [$lblBtnBarbarians, $lblBtnArchers, $lblBtnGiants, $lblBtnGoblins, $lblBtnWallBreakers, $lblBtnBalloons, $lblBtnWizards, $lblBtnHealers, $lblBtnDragons, $lblBtnPekkas, $lblBtnMinions, $lblBtnHogRiders, $lblBtnValkyries, $lblBtnGolems, $lblBtnWitches, $lblBtnLavaHounds, $lblBtnCustom]

_GDIPlus_Startup()
Global Const $64Bit = StringInStr(@OSArch, "64") > 0
Global Const $DEFAULT_HEIGHT = 720
Global Const $DEFAULT_WIDTH = 860
Global $Initiate = 0
Global Const $REGISTRY_KEY_DIRECTORY = "HKEY_LOCAL_MACHINE\SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0"

Func GUIControl($hWind, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	#forceref $hWind, $iMsg, $wParam, $lParam
	Switch $iMsg
		Case 273
			Switch $nID
				Case $GUI_EVENT_CLOSE
					; Clean up resources
					_GDIPlus_ImageDispose($hBitmap)
					_WinAPI_DeleteObject($hHBitmap)
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($txtLog)
					SaveConfig()
					Exit
				Case $labelGameBotURL
					ShellExecute("https://GameBot.org") ;open web site when clicking label
				Case $labelClashGameBotURL
					ShellExecute("https://www.ClashGameBot.com") ;open web site when clicking label
				Case $labelForumURL
					ShellExecute("https://GameBot.org/forums/forumdisplay.php?fid=2") ;open web site when clicking label
				Case $labelModForumURL
					ShellExecute("https://GameBot.org/forums/thread-2682.html") ;open web site when clicking label
				Case $btnStop
					If $RunState Then btnStop()
				Case $btnPause
					If $RunState Then btnPause()
				Case $btnResume
					If $RunState Then btnResume()
				Case $btnHide
					If $RunState Then btnHide()
				Case $btnAttackNow
					If $RunState Then btnAttackNow()
				Case $btnDonate
					ShellExecute("https://gamebot.org/forums/misc.php?action=mydonations")
				Case $btnDeletePBMessages
					If $RunState Then
						btnDeletePBMessages() ; call with flag when bot is running to execute on _sleep() idle
					Else
						PushMsg("DeleteAllPBMessages") ; call directly when bot is stopped
					EndIf
				Case $btnResetStats
					btnResetStats()
			EndSwitch
		Case 274
			Switch $wParam
				Case 0xf060
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($txtLog)
					SaveConfig()
					Exit
			EndSwitch
	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl

Func PushBulletRemoteControl()
    If GUICtrlRead($chkPBenabled) = $GUI_CHECKED AND GUICtrlRead($chkPBRemote) = $GUI_CHECKED Then _RemoteControl()
EndFunc   ;==>PushBulletRemoteControl
Func SetTime()
	Local $time = _TicksToTime(Int(TimerDiff($sTimer) + $iTimePassed), $hour, $min, $sec)
	If _GUICtrlTab_GetCurSel($tabMain) = 9 Then GUICtrlSetData($lblresultruntime, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
	;If $pEnabled = 1 And $pRemote = 1 And StringFormat("%02i", $sec) = "50" Then _RemoteControl()
	If $pEnabled = 1 And $ichkDeleteOldPushes = 1 And Mod($min + 1, 20) = 0 And $sec = "0" Then _DeleteOldPushes() ; check every 20 min if must to delete old pushbullet messages
EndFunc   ;==>SetTime

Func Initiate()

	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
		Local $BSsize = [ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[2], ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[3]]
		Local $fullScreenRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "FullScreen")
		Local $guestHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestHeight")
		Local $guestWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestWidth")
		Local $windowHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowHeight")
		Local $windowWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowWidth")
		Local $BSx = ($BSsize[0] > $BSsize[1]) ? $BSsize[0] : $BSsize[1]
		Local $BSy = ($BSsize[0] > $BSsize[1]) ? $BSsize[1] : $BSsize[0]
		$RunState = True
		If $BSx <> 860 Or $BSy <> 720 Then
			RegWrite($REGISTRY_KEY_DIRECTORY, "FullScreen", "REG_DWORD", "0")
			RegWrite($REGISTRY_KEY_DIRECTORY, "GuestHeight", "REG_DWORD", $DEFAULT_HEIGHT)
			RegWrite($REGISTRY_KEY_DIRECTORY, "GuestWidth", "REG_DWORD", $DEFAULT_WIDTH)
			RegWrite($REGISTRY_KEY_DIRECTORY, "WindowHeight", "REG_DWORD", $DEFAULT_HEIGHT)
			RegWrite($REGISTRY_KEY_DIRECTORY, "WindowWidth", "REG_DWORD", $DEFAULT_WIDTH)
			SetLog("Please restart your computer for the applied changes to take effect.", $COLOR_ORANGE)
			_Sleep(3000)
			$MsgRet = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), "Restart Computer", "Restart your computer for the applied changes to take effect." & @CRLF & "If your BlueStacks is the correct size  (860 x 720), click OK.", 10)
			If $MsgRet <> $IDOK Then
				btnStop()
				Return
			EndIf
		EndIf

		WinActivate($Title)
		SetLog(_PadStringCenter(" " & $sBotTitle & " Powered by GameBot.org ", 50, "~"), $COLOR_PURPLE)
		SetLog($Compiled & " running on " & @OSVersion & " " & @OSServicePack & " " & @OSArch)
		SetLog(_PadStringCenter(" Bot Start ", 50, "="), $COLOR_GREEN)
		$AttackNow = False
		$FirstStart = True
		$Checkrearm = True

		If $iDeleteAllPushes = 1 Then
			_DeletePush($PushToken)
			SetLog("Delete all previous PushBullet messages...", $COLOR_BLUE)
		EndIf

		$sTimer = TimerInit()

		$RunState = True
		For $i = $FirstControlToHide To $LastControlToHide ; Save state of all controls on tabs
			If $i = $tabGeneral Or $i = $tabSearch Or $i = $tabAttack Or $i = $tabAttackAdv Or $i = $tabDonate Or $i = $tabTroops Or $i = $tabMisc Or $i = $tabNotify Or $i = $tabUpgrade Then $i += 1 ; exclude tabs
			If $pEnabled And $i = $btnDeletePBmessages Then $i += 1 ; exclude the DeleteAllMesages button when PushBullet is enabled
			$iPrevState[$i] = GUICtrlGetState($i)
		Next
		For $i = $FirstControlToHide To $LastControlToHide ; Disable all controls in 1 go on all tabs
			If $i = $tabGeneral Or $i = $tabSearch Or $i = $tabAttack Or $i = $tabAttackAdv Or $i = $tabDonate Or $i = $tabTroops Or $i = $tabMisc Or $i = $tabNotify Or $i = $tabUpgrade Then $i += 1 ; exclude tabs
			If $pEnabled And $i = $btnDeletePBmessages Then $i += 1 ; exclude the DeleteAllMesages button when PushBullet is enabled
			GUICtrlSetState($i, $GUI_DISABLE)
		Next

		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		GUICtrlSetState($btnStart, $GUI_HIDE)
		GUICtrlSetState($btnStop, $GUI_SHOW)
		GUICtrlSetState($btnPause, $GUI_SHOW)
		GUICtrlSetState($btnResume, $GUI_HIDE)

		AdlibRegister("SetTime", 1000)
		If $restarted = 1 Then
			$restarted = 0
			IniWrite($config, "general", "Restarted", 0)
			_Push($iOrigPushB & ": Bot restarted", "")
		EndIf
		checkMainScreen()
		ZoomOut()
		BotDetectFirstTime()
		runBot()
	Else
		SetLog("Not in Game!", $COLOR_RED)
		btnStop()
	EndIf
EndFunc   ;==>Initiate

Func Open()
	If $64Bit Then ;If 64-Bit
		ShellExecute("C:\Program Files (x86)\BlueStacks\HD-StartLauncher.exe")
		SetLog("Starting BlueStacks", $COLOR_GREEN)
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	Else ;If 32-Bit
		ShellExecute("C:\Program Files\BlueStacks\HD-StartLauncher.exe")
		SetLog("Starting BlueStacks", $COLOR_GREEN)
		Sleep(290)
		SetLog("Waiting for BlueStacks to initiate...", $COLOR_GREEN)
		Check()
	EndIf
EndFunc   ;==>Open

Func Check()
	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
		SetLog("BlueStacks Loaded, took " & ($Initiate) & " seconds to begin.", $COLOR_GREEN)
		Initiate()
	Else
		Sleep(1000)
		$Initiate = $Initiate + 1

		Check()
	EndIf
EndFunc   ;==>Check

Func btnStart()
	GUICtrlSetState($btnStart, $GUI_HIDE)
	GUICtrlSetState($btnStop, $GUI_SHOW)
	GUICtrlSetState($btnPause, $GUI_SHOW)
	$NoMoreWalls = 0
	$DontTouchMe = False
	$IAmSelfish = False
	$MeetCondStop = False
	CreateLogFile()


	SaveConfig()
	readConfig()
	applyConfig()

	_GUICtrlEdit_SetText($txtLog, "")


	If WinExists($Title) Then
		DisableBS($HWnD, $SC_MINIMIZE)
		DisableBS($HWnD, $SC_CLOSE)
		Initiate()

	Else
		Open()
	EndIf
EndFunc   ;==>btnStart

Func btnStop()
	If $RunState Then
		$RunState = False
		;$FirstStart = true
		EnableBS($HWnD, $SC_MINIMIZE)
		EnableBS($HWnD, $SC_CLOSE)
		For $i = $FirstControlToHide To $LastControlToHide ; Restore previous state of controls
			If $i = $tabGeneral Or $i = $tabSearch Or $i = $tabAttack Or $i = $tabAttackAdv Or $i = $tabDonate Or $i = $tabTroops Or $i = $tabMisc Or $i = $tabNotify Or $i = $tabUpgrade Then $i += 1 ; exclude tabs
			If $pEnabled And $i = $btnDeletePBmessages Then $i += 1 ; exclude the DeleteAllMesages button when PushBullet is enabled
			GUICtrlSetState($i, $iPrevState[$i])
		Next

		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)
		GUICtrlSetState($btnPause, $GUI_HIDE)
		GUICtrlSetState($btnResume, $GUI_HIDE)
		;GUICtrlSetState($btnDeletePBmessages, $GUI_ENABLE)
		If Not $TPaused Then $iTimePassed += Int(TimerDiff($sTimer))
		AdlibUnRegister("SetTime")
		_BlockInputEx(0, "", "", $HWnD)
		$Restart = True
		FileClose($hLogFileHandle)
		SetLog(_PadStringCenter(" Bot Stop ", 50, "="), $COLOR_ORANGE)
	EndIf
EndFunc   ;==>btnStop

Func btnPause()
	Send("{PAUSE}")
EndFunc   ;==>btnPause

Func btnResume()
	$NoMoreWalls = 0
	Send("{PAUSE}")
EndFunc   ;==>btnResume

Func btnAttackNow()
	If $RunState Then
		$bBtnAttackNowPressed = True
		$icmbAtkNowDeploy = _GUICtrlComboBox_GetCurSel($cmbAtkNowDeploy)
		If GUICtrlRead($chkAtkNowMines) = $GUI_CHECKED Then
			$ichkAtkNowMines = True
		Else
			$ichkAtkNowMines = False
		EndIf
		If GUICtrlRead($chkAtkNowLSpell) = $GUI_CHECKED Then
			$ichkAtkNowLSpell = 1
		Else
			$ichkAtkNowLSpell = 0
		EndIf
	EndIf
EndFunc   ;==>btnAttackNow

Func chkUnbreakable()
	If GUICtrlRead($chkUnbreakable) = $GUI_CHECKED Then
		GUICtrlSetState($txtUnbreakable, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinGold, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxGold, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinElixir, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxElixir, $GUI_ENABLE)
		$iUnbreakableMode = 1
	ElseIf GUICtrlRead($chkUnbreakable) = $GUI_UNCHECKED Then
		GUICtrlSetState($txtUnbreakable, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinGold, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxGold, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinElixir, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxElixir, $GUI_DISABLE)
		$iUnbreakableMode = 0
	EndIf
EndFunc   ;==>chkUnbreakable

Func btnLocateBarracks()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateBarracks

Func btnLab()
   $RunState = True
	While 1
		ZoomOut()
		LocateLab()
		ExitLoop
	WEnd
	$RunState = False
   EndFunc

Func btnLocateArmyCamp()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack(True)
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateArmyCamp

Func btnLocateClanCastle()
	$RunState = True
	While 1
		ZoomOut()
		LocateClanCastle()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateClanCastle

Func btnLocateSpellfactory()
	$RunState = True
	While 1
		ZoomOut()
		LocateSpellFactory()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateSpellfactory

Func btnLocateTownHall()
	$RunState = True
	While 1
		ZoomOut()
		LocateTownHall()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateTownHall

Func btnLocateKing()
	$RunState = True
	While 1
		ZoomOut()
		LocateKing()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateKing

Func btnLocateQueen()
	$RunState = True
	While 1
		ZoomOut()
		LocateQueen()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateQueen

Func btnSearchMode()
	While 1
		GUICtrlSetState($btnStart, $GUI_HIDE)
		GUICtrlSetState($btnStop, $GUI_SHOW)

		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_DISABLE)
		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_DISABLE)

		$RunState = True
		PrepareSearch()
		If _Sleep(1000) Then Return
		VillageSearch()
		$RunState = False

		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)

		GUICtrlSetState($btnLocateBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_ENABLE)
		ExitLoop
	WEnd
EndFunc   ;==>btnSearchMode

Func btnHide()
   If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
	If $Hide = False Then
		GUICtrlSetData($btnHide, "Show BS")
		$botPos[0] = WinGetPos($Title)[0]
		$botPos[1] = WinGetPos($Title)[1]
		WinMove($Title, "", -32000, -32000)
		$Hide = True
	Else
		GUICtrlSetData($btnHide, "Hide BS")

		If $botPos[0] = -32000 Then
			WinMove($Title, "", 0, 0)
		Else
			WinMove($Title, "", $botPos[0], $botPos[1])
			WinActivate($Title)
		EndIf
		$Hide = False
	EndIf
   EndIf
EndFunc   ;==>btnHide

Func btnResetStats()
	GUICtrlSetState($btnResetStats, $GUI_DISABLE)
	$FirstRun = 1
	$totalLootGold = 0
	$totalLootElixir = 0
	$totalLootDarkElixir = 0
	$totalLootTrophies = 0
	$totalLootZapAndRun = 0
	GUICtrlSetState($lblLastAttackTemp, $GUI_SHOW)
	GUICtrlSetState($lblTotalLootTemp, $GUI_SHOW)
	GUICtrlSetState($lblHourlyStatsTemp, $GUI_SHOW) ;; added for hourly stats
	GUICtrlSetData($lblresultruntime, "00:00:00")
	GUICtrlSetData($lblWallgoldmake, "0")
	$wallgoldmake = 0
	GUICtrlSetData($lblWallelixirmake, "0")
	$wallelixirmake = 0
	GUICtrlSetData($lblresultoutofsync, "0")
	GUICtrlSetData($lblresulttrophiesdropped, "0")
	GUICtrlSetData($lblresultvillagesskipped, "0")
	GUICtrlSetData($lblresultvillagesattacked, "0")
	GUICtrlSetData($lblZapAndRunHitCount, "0")
	GUICtrlSetData($lblZapAndRunUsedLSpell, "0")
	GUICtrlSetData($lblZapAndRunTotalDE, "0")
	GUICtrlSetData($lblGoldLastAttack, "")
	GUICtrlSetData($lblElixirLastAttack, "")
	GUICtrlSetData($lblDarkLastAttack, "")
	GUICtrlSetData($lblTrophyLastAttack, "")
	GUICtrlSetData($lblGoldLoot, "")
	GUICtrlSetData($lblElixirLoot, "")
	GUICtrlSetData($lblDarkLoot, "")
	GUICtrlSetData($lblTrophyLoot, "")
	GUICtrlSetData($lblHourlyStatsGold, "")
	GUICtrlSetData($lblHourlyStatsElixir, "")
	GUICtrlSetData($lblHourlyStatsDark, "")
	GUICtrlSetData($lblHourlyStatsTrophy, "")
	$iTimePassed = 0
	$sTimer = TimerInit()
	UpdateStats()
EndFunc   ;==>btnResetStats

Func chkDeployRedArea()
	If GUICtrlRead($chkDeployRedArea) = $GUI_CHECKED Then
		$chkRedArea = 1
		For $i = $lblSmartDeploy To $chkAttackNearDarkElixirDrill
			GUICtrlSetState($i, $GUI_SHOW)
		Next
	Else
		$chkRedArea = 0
		For $i = $lblSmartDeploy To $chkAttackNearDarkElixirDrill
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	EndIf
EndFunc   ;==>chkDeployRedArea


Func chkDropInBattle()
if GUICtrlRead($chkUseClanCastle) = $GUI_CHECKED Then
   GUICtrlSetState($chkUseClanCastleBalanced, $GUI_ENABLE)
   if GUICtrlRead($chkUseClanCastleBalanced) = $GUI_CHECKED Then
	  GUICtrlSetState($cmbRatioNumeratorDonated, $GUI_ENABLE)
	  GUICtrlSetState($cmbRatioDenominatorReceived, $GUI_ENABLE)
   Else
	  GUICtrlSetState($cmbRatioNumeratorDonated, $GUI_DISABLE)
	  GUICtrlSetState($cmbRatioDenominatorReceived, $GUI_DISABLE)
   EndIf
 Else
   GUICtrlSetState($chkUseClanCastleBalanced, $GUI_DISABLE)
   GUICtrlSetState($cmbRatioNumeratorDonated, $GUI_DISABLE)
   GUICtrlSetState($cmbRatioDenominatorReceived, $GUI_DISABLE)
 EndIf
EndFunc   ;==>chkDropInBattle

Func chkBalanceDR()
  if GUICtrlRead($chkUseClanCastleBalanced) =  $GUI_CHECKED and   GUICtrlRead($chkUseClanCastle) = $GUI_CHECKED Then
	 GUICtrlSetState($cmbRatioNumeratorDonated, $GUI_ENABLE)
	 GUICtrlSetState($cmbRatioDenominatorReceived, $GUI_ENABLE)
  Else
	 GUICtrlSetState($cmbRatioNumeratorDonated, $GUI_DISABLE)
	 GUICtrlSetState($cmbRatioDenominatorReceived, $GUI_DISABLE)
  EndIf

EndFunc   ;==>chkBalanceDR


Func cmbTroopComp()
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> $icmbTroopComp Then
		$icmbTroopComp = _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		For $i = 0 To UBound($TroopName) - 1
			Assign("Cur" & $TroopName[$i], 1)
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			Assign("Cur" & $TroopDarkName[$i], 1)
		Next
		SetComboTroopComp()
	EndIf
EndFunc   ;==>cmbTroopComp

Func SetComboTroopComp()
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 0
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumArch, "100")
		Case 1
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumBarb, "100")
		Case 2
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumGobl, "100")
		Case 3
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			GUICtrlSetData($txtNumBarb, "50")
			GUICtrlSetData($txtNumArch, "50")
		Case 4
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			_GUICtrlEdit_SetReadOnly($txtNumGiant, False)

			GUICtrlSetData($txtNumBarb, "60")
			GUICtrlSetData($txtNumArch, "30")
			GUICtrlSetData($txtNumGobl, "10")

			GUICtrlSetData($txtNumGiant, $GiantComp)
		Case 5
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			_GUICtrlEdit_SetReadOnly($txtNumGiant, False)

			GUICtrlSetData($txtNumBarb, "50")
			GUICtrlSetData($txtNumArch, "50")

			GUICtrlSetData($txtNumGiant, $GiantComp)
		Case 6
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next
			GUICtrlSetData($txtNumBarb, "60")
			GUICtrlSetData($txtNumArch, "30")
			GUICtrlSetData($txtNumGobl, "10")
		Case 7
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), True)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), True)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), "0")
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), "0")
			Next

			_GUICtrlEdit_SetReadOnly($txtNumGiant, False)
			_GUICtrlEdit_SetReadOnly($txtNumWall, False)

			GUICtrlSetData($txtNumBarb, "60")
			GUICtrlSetData($txtNumArch, "30")
			GUICtrlSetData($txtNumGobl, "10")

			GUICtrlSetData($txtNumGiant, $GiantComp)
			GUICtrlSetData($txtNumWall, $WallComp)
			GUICtrlSetData($txtNumWiza, $WizaComp)
			GUICtrlSetData($txtNumMini, $MiniComp)
			GUICtrlSetData($txtNumHogs, $HogsComp)
		Case 8
			GUICtrlSetState($cmbBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_ENABLE)
			;GUICtrlSetState($txtCapacity, $GUI_DISABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_DISABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), False)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "Comp"))
			Next
		Case 9
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopName[$i]), $GUI_ENABLE)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetState(Eval("txtNum" & $TroopDarkName[$i]), $GUI_ENABLE)
			Next

			For $i = 0 To UBound($TroopName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopName[$i]), False)
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				_GUICtrlEdit_SetReadOnly(Eval("txtNum" & $TroopDarkName[$i]), False)
			Next

			For $i = 0 To UBound($TroopName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopName[$i]), Eval($TroopName[$i] & "Comp"))
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				GUICtrlSetData(Eval("txtNum" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "Comp"))
			Next

	EndSwitch
	lblTotalCount()
EndFunc   ;==>SetComboTroopComp

Func cmbBotCond()
	If _GUICtrlComboBox_GetCurSel($cmbBotCond) = 13 Then
		If _GUICtrlComboBox_GetCurSel($cmbHoursStop) = 0 Then _GUICtrlComboBox_SetCurSel($cmbHoursStop, 1)
		GUICtrlSetState($cmbHoursStop, $GUI_ENABLE)
	Else
		_GUICtrlComboBox_SetCurSel($cmbHoursStop, 0)
		GUICtrlSetState($cmbHoursStop, $GUI_DISABLE)
	EndIf
EndFunc   ;==>cmbBotCond

Func Randomspeedatk()
	If GUICtrlRead($Randomspeedatk) = $GUI_CHECKED Then
		$iRandomspeedatk = 1
		GUICtrlSetState($cmbUnitDelay, $GUI_DISABLE)
		GUICtrlSetState($cmbWaveDelay, $GUI_DISABLE)
	Else
		$iRandomspeedatk = 0
		GUICtrlSetState($cmbUnitDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbWaveDelay, $GUI_ENABLE)
	EndIf
EndFunc   ;==>Randomspeedatk

Func chkSearchReduction()
	If GUICtrlRead($chkSearchReduction) = $GUI_CHECKED Then
		_GUICtrlEdit_SetReadOnly($txtSearchReduceCount, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceGold, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceElixir, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceGoldPlusElixir, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceDark, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceTrophy, False)
	Else
		_GUICtrlEdit_SetReadOnly($txtSearchReduceCount, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceGold, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceElixir, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceGoldPlusElixir, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceDark, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceTrophy, True)
	EndIf
EndFunc   ;==>chkSearchReduction

Func chkMeetDE()
	If GUICtrlRead($chkMeetDE) = $GUI_CHECKED Then
		_GUICtrlEdit_SetReadOnly($txtMinDarkElixir, False)
	Else
		_GUICtrlEdit_SetReadOnly($txtMinDarkElixir, True)
	EndIf
EndFunc   ;==>chkMeetDE

Func chkMeetTrophy()
	If GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED Then
		_GUICtrlEdit_SetReadOnly($txtMinTrophy, False)
	Else
		_GUICtrlEdit_SetReadOnly($txtMinTrophy, True)
	EndIf
EndFunc   ;==>chkMeetTrophy

Func chkMeetTH()
	If GUICtrlRead($chkMeetTH) = $GUI_CHECKED Then
		GUICtrlSetState($cmbTH, $GUI_ENABLE)
	Else
		GUICtrlSetState($cmbTH, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkMeetTH

Func chkBackground()
	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		$ichkBackground = 1
		GUICtrlSetState($btnHide, $GUI_ENABLE)
	Else
		$ichkBackground = 0
		GUICtrlSetState($btnHide, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBackground

Func radWeakBases()
	GUICtrlSetState($grpWeakBaseSettings, $GUI_ENABLE)
	GUICtrlSetState($lblWBMortar, $GUI_ENABLE)
	GUICtrlSetState($cmbWBMortar, $GUI_ENABLE)
	GUICtrlSetState($lblWBWizTower, $GUI_ENABLE)
	GUICtrlSetState($cmbWBWizTower, $GUI_ENABLE)
	;GUICtrlSetState($lblWBXBow, $GUI_ENABLE)
	;GUICtrlSetState($cmbWBXbow, $GUI_ENABLE)
EndFunc   ;==>radWeakBases

Func radNotWeakBases()
	GUICtrlSetState($grpWeakBaseSettings, $GUI_DISABLE)
	GUICtrlSetState($lblWBMortar, $GUI_DISABLE)
	GUICtrlSetState($cmbWBMortar, $GUI_DISABLE)
	GUICtrlSetState($lblWBWizTower, $GUI_DISABLE)
	GUICtrlSetState($cmbWBWizTower, $GUI_DISABLE)
	GUICtrlSetState($lblWBXBow, $GUI_DISABLE)
	GUICtrlSetState($cmbWBXbow, $GUI_DISABLE)
EndFunc   ;==>radNotWeakBases

Func chkAttackNow()
	If GUICtrlRead($chkAttackNow) = $GUI_CHECKED Then
		$iChkAttackNow = 1
		GUICtrlSetState($lblAttackNow, $GUI_ENABLE)
		GUICtrlSetState($lblAttackNowSec, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_ENABLE)
	Else
		$iChkAttackNow = 0
		GUICtrlSetState($lblAttackNow, $GUI_DISABLE)
		GUICtrlSetState($lblAttackNowSec, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkAttackNow

Func GUILightSpell()
	If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
		$iChkLightSpell = 1
		GUICtrlSetState($txtMinDarkStorage, $GUI_ENABLE)
		GUICtrlSetState($lblSpellDarkStorage, $GUI_ENABLE)
		GUICtrlSetState($lbliLSpellQ, $GUI_ENABLE)
		GUICtrlSetState($cmbiLSpellQ, $GUI_ENABLE)
		GUICtrlSetState($lbliLSpellQ2, $GUI_ENABLE)
		GUICtrlSetState($chkZapAndRun, $GUI_ENABLE)
		If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
			GUICtrlSetState($chkTHSnipeLightningDE, $GUI_ENABLE)
		EndIf
	Else
		$iChkLightSpell = 0
		GUICtrlSetState($txtMinDarkStorage, $GUI_DISABLE)
		GUICtrlSetState($lblSpellDarkStorage, $GUI_DISABLE)
		GUICtrlSetState($lbliLSpellQ, $GUI_DISABLE)
		GUICtrlSetState($cmbiLSpellQ, $GUI_DISABLE)
		GUICtrlSetState($lbliLSpellQ2, $GUI_DISABLE)
		GUICtrlSetState($chkZapAndRun, $GUI_DISABLE)
		GUICtrlSetState($chkTHSnipeLightningDE, $GUI_DISABLE)
	EndIf
EndFunc   ;==>GUILightSpell

Func chkBullyMode()
	If GUICtrlRead($chkBullyMode) = $GUI_CHECKED Then
		$OptBullyMode = 1
		GUICtrlSetState($txtATBullyMode, $GUI_ENABLE)
		GUICtrlSetState($cmbYourTH, $GUI_ENABLE)
	Else
		$OptBullyMode = 0
		GUICtrlSetState($txtATBullyMode, $GUI_DISABLE)
		GUICtrlSetState($cmbYourTH, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBullyMode

Func chkSnipeMode()
	If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
		$OptTrophyMode = 1
		GUICtrlSetState($txtTHaddtiles, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_ENABLE)
		If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
			GUICtrlSetState($chkTHSnipeLightningDE, $GUI_ENABLE)
		EndIf
	Else
		$OptTrophyMode = 0
		GUICtrlSetState($txtTHaddtiles, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_DISABLE)
		GUICtrlSetState($chkTHSnipeLightningDE, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkSnipeMode

Func chkRequest()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		$ichkRequest = 1
		GUICtrlSetState($txtRequest, $GUI_ENABLE)
		GUICtrlSetState($btnLocateClanCastle, $GUI_SHOW)
	Else
		$ichkRequest = 0
		GUICtrlSetState($txtRequest, $GUI_DISABLE)
		GUICtrlSetState($btnLocateClanCastle, $GUI_HIDE)
	EndIf
EndFunc   ;==>chkRequest

Func lblTotalCount()
	GUICtrlSetData($lblTotalCount, GUICtrlRead($txtNumBarb) + GUICtrlRead($txtNumArch) + GUICtrlRead($txtNumGobl))
	If GUICtrlRead($lblTotalCount) = "100" Then
		GUICtrlSetBkColor($lblTotalCount, $COLOR_MONEYGREEN)
	ElseIf GUICtrlRead($lblTotalCount) = "0" Then
		GUICtrlSetBkColor($lblTotalCount, $COLOR_ORANGE)
	Else
		GUICtrlSetBkColor($lblTotalCount, $COLOR_RED)
	EndIf
EndFunc   ;==>lblTotalCount

Func btnTroopsBarbarians()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,0)
	   EndSelect
EndFunc

Func btnTroopsArchers()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,1)
	   EndSelect
EndFunc

Func btnTroopsGiants()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,2)
	   EndSelect
EndFunc

Func btnTroopsGoblins()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,3)
	   EndSelect
EndFunc

Func btnTroopsWallBreakers()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,5)
	   EndSelect
EndFunc

Func btnTroopsBalloons()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,4)
	   EndSelect
EndFunc

Func btnTroopsWizards()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,6)
	   EndSelect
EndFunc

Func btnTroopsHealers()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,7)
	   EndSelect
EndFunc

Func btnTroopsDragons()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,8)
	   EndSelect
EndFunc

Func btnTroopsMinions()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,15)
	   EndSelect
EndFunc


Func btnTroopsHogRiders()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,16)
	   EndSelect
EndFunc

Func btnTroopsValkyries()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,17)
	   EndSelect
EndFunc

Func btnTroopsGolems()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,18)
	   EndSelect
EndFunc

Func btnTroopsWitches()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,19)
	   EndSelect
EndFunc

Func btnTroopsLavaHounds()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,20)
	   EndSelect
EndFunc

Func btnTroopsPekkas()
	Select
	Case $cmbLaboratory
	   _GUICtrlComboBox_SetCurSel($cmbLaboratory,9)
	   EndSelect
EndFunc

Func btnDonateBarbarians()
	If GUICtrlGetState($grpBarbarians) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpBarbarians, $txtBlacklistBarbarians) ;Hide/Show controls on Donate tab
	EndIf
EndFunc   ;==>btnDonateBarbarians

Func btnDonateArchers()
	If GUICtrlGetState($grpArchers) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpArchers, $txtBlacklistArchers)
	EndIf
EndFunc   ;==>btnDonateArchers

Func btnDonateGiants()
	If GUICtrlGetState($grpGiants) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpGiants, $txtBlacklistGiants)
	EndIf
EndFunc   ;==>btnDonateGiants

Func btnDonateGoblins()
	If GUICtrlGetState($grpGoblins) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpGoblins, $txtBlacklistGoblins)
	EndIf
EndFunc   ;==>btnDonateGoblins

Func btnDonateWallBreakers()
	If GUICtrlGetState($grpWallBreakers) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpWallBreakers, $txtBlacklistWallBreakers)
	EndIf
EndFunc   ;==>btnDonateWallBreakers

Func btnDonateBalloons()
	If GUICtrlGetState($grpBalloons) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpBalloons, $txtBlacklistBalloons)
	EndIf
EndFunc   ;==>btnDonateBalloons

Func btnDonateWizards()
	If GUICtrlGetState($grpWizards) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpWizards, $txtBlacklistWizards)
	EndIf
EndFunc   ;==>btnDonateWizards

Func btnDonateHealers()
	If GUICtrlGetState($grpHealers) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpHealers, $txtBlacklistHealers)
	EndIf
EndFunc   ;==>btnDonateHealers

Func btnDonateDragons()
	If GUICtrlGetState($grpDragons) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpDragons, $txtBlacklistDragons)
	EndIf
EndFunc   ;==>btnDonateDragons

Func btnDonatePekkas()
	If GUICtrlGetState($grpPekkas) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpPekkas, $txtBlacklistPekkas)
	EndIf
EndFunc   ;==>btnDonatePekkas

Func btnDonateMinions()
	If GUICtrlGetState($grpMinions) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpMinions, $txtBlacklistMinions)
	EndIf
EndFunc   ;==>btnDonateMinions

Func btnDonateHogRiders()
	If GUICtrlGetState($grpHogRiders) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpHogRiders, $txtBlacklistHogRiders)
	EndIf
EndFunc   ;==>btnDonateHogRiders

Func btnDonateValkyries()
	If GUICtrlGetState($grpValkyries) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpValkyries, $txtBlacklistValkyries)
	EndIf
EndFunc   ;==>btnDonateValkyries

Func btnDonateGolems()
	If GUICtrlGetState($grpGolems) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpGolems, $txtBlacklistGolems)
	EndIf
EndFunc   ;==>btnDonateGolems

Func btnDonateWitches()
	If GUICtrlGetState($grpWitches) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpWitches, $txtBlacklistWitches)
	EndIf
EndFunc   ;==>btnDonateWitches

Func btnDonateLavaHounds()
	If GUICtrlGetState($grpLavaHounds) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpLavaHounds, $txtBlacklistLavaHounds)
	EndIf
EndFunc   ;==>btnDonateLavaHounds

;;; Custom Combination Donate by ChiefM3
Func btnDonateCustom()
	If GUICtrlGetState($grpCustom) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpCustom, $txtBlacklistCustom)
	EndIf
EndFunc   ;==>btnDonateCustom

Func btnDonateBlacklist()
	If GUICtrlGetState($grpBlacklist) = BitOR($GUI_HIDE, $GUI_ENABLE) Then
		_DonateBtn($grpBlacklist, $txtBlacklist)
	EndIf
EndFunc   ;==>btnDonateBlacklist

Func chkDonateAllBarbarians()
	If GUICtrlRead($chkDonateAllBarbarians) = $GUI_CHECKED Then
		_DonateAllControls($eBarb, True)
	Else
		_DonateAllControls($eBarb, False)
	EndIf
EndFunc   ;==>chkDonateAllBarbarians

Func chkDonateAllArchers()
	If GUICtrlRead($chkDonateAllArchers) = $GUI_CHECKED Then
		_DonateAllControls($eArch, True)
	Else
		_DonateAllControls($eArch, False)
	EndIf
EndFunc   ;==>chkDonateAllArchers

Func chkDonateAllGiants()
	If GUICtrlRead($chkDonateAllGiants) = $GUI_CHECKED Then
		_DonateAllControls($eGiant, True)
	Else
		_DonateAllControls($eGiant, False)
	EndIf
EndFunc   ;==>chkDonateAllGiants

Func chkDonateAllGoblins()
	If GUICtrlRead($chkDonateAllGoblins) = $GUI_CHECKED Then
		_DonateAllControls($eGobl, True)
	Else
		_DonateAllControls($eGobl, False)
	EndIf
EndFunc   ;==>chkDonateAllGoblins

Func chkDonateAllWallBreakers()
	If GUICtrlRead($chkDonateAllWallBreakers) = $GUI_CHECKED Then
		_DonateAllControls($eWall, True)
	Else
		_DonateAllControls($eWall, False)
	EndIf
EndFunc   ;==>chkDonateAllWallBreakers

Func chkDonateAllBalloons()
	If GUICtrlRead($chkDonateAllBalloons) = $GUI_CHECKED Then
		_DonateAllControls($eBall, True)
	Else
		_DonateAllControls($eBall, False)
	EndIf
EndFunc   ;==>chkDonateAllBalloons

Func chkDonateAllWizards()
	If GUICtrlRead($chkDonateAllWizards) = $GUI_CHECKED Then
		_DonateAllControls($eWiza, True)
	Else
		_DonateAllControls($eWiza, False)
	EndIf
EndFunc   ;==>chkDonateAllWizards

Func chkDonateAllHealers()
	If GUICtrlRead($chkDonateAllHealers) = $GUI_CHECKED Then
		_DonateAllControls($eHeal, True)
	Else
		_DonateAllControls($eHeal, False)
	EndIf
EndFunc   ;==>chkDonateAllHealers

Func chkDonateAllDragons()
	If GUICtrlRead($chkDonateAllDragons) = $GUI_CHECKED Then
		_DonateAllControls($eDrag, True)
	Else
		_DonateAllControls($eDrag, False)
	EndIf
EndFunc   ;==>chkDonateAllDragons

Func chkDonateAllPekkas()
	If GUICtrlRead($chkDonateAllPekkas) = $GUI_CHECKED Then
		_DonateAllControls($ePekk, True)
	Else
		_DonateAllControls($ePekk, False)
	EndIf
EndFunc   ;==>chkDonateAllPekkas

Func chkDonateAllMinions()
	If GUICtrlRead($chkDonateAllMinions) = $GUI_CHECKED Then
		_DonateAllControls($eMini, True)
	Else
		_DonateAllControls($eMini, False)
	EndIf
EndFunc   ;==>chkDonateAllMinions

Func chkDonateAllHogRiders()
	If GUICtrlRead($chkDonateAllHogRiders) = $GUI_CHECKED Then
		_DonateAllControls($eHogs, True)
	Else
		_DonateAllControls($eHogs, False)
	EndIf
EndFunc   ;==>chkDonateAllHogRiders

Func chkDonateAllValkyries()
	If GUICtrlRead($chkDonateAllValkyries) = $GUI_CHECKED Then
		_DonateAllControls($eValk, True)
	Else
		_DonateAllControls($eValk, False)
	EndIf
EndFunc   ;==>chkDonateAllValkyries

Func chkDonateAllGolems()
	If GUICtrlRead($chkDonateAllGolems) = $GUI_CHECKED Then
		_DonateAllControls($eGole, True)
	Else
		_DonateAllControls($eGole, False)
	EndIf
EndFunc   ;==>chkDonateAllGolems

Func chkDonateAllWitches()
	If GUICtrlRead($chkDonateAllWitches) = $GUI_CHECKED Then
		_DonateAllControls($eWitc, True)
	Else
		_DonateAllControls($eWitc, False)
	EndIf
EndFunc   ;==>chkDonateAllWitches

Func chkDonateAllLavaHounds()
	If GUICtrlRead($chkDonateAllLavaHounds) = $GUI_CHECKED Then
		_DonateAllControls($eLava, True)
	Else
		_DonateAllControls($eLava, False)
	EndIf
EndFunc   ;==>chkDonateAllLavaHounds

;;; Custom Combination Donate by ChiefM3
Func chkDonateAllCustom()
	If GUICtrlRead($chkDonateAllCustom) = $GUI_CHECKED Then
		_DonateAllControls(16, True)
	Else
		_DonateAllControls(16, False)
	EndIf
EndFunc   ;==>chkDonateAllCustom

Func chkDonateBarbarians()
	If GUICtrlRead($chkDonateBarbarians) = $GUI_CHECKED Then
		_DonateControls($eBarb)
	Else
		GUICtrlSetBkColor($lblBtnBarbarians, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateBarbarians

Func chkDonateArchers()
	If GUICtrlRead($chkDonateArchers) = $GUI_CHECKED Then
		_DonateControls($eArch)
	Else
		GUICtrlSetBkColor($lblBtnArchers, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateArchers

Func chkDonateGiants()
	If GUICtrlRead($chkDonateGiants) = $GUI_CHECKED Then
		_DonateControls($eGiant)
	Else
		GUICtrlSetBkColor($lblBtnGiants, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateGiants

Func chkDonateGoblins()
	If GUICtrlRead($chkDonateGoblins) = $GUI_CHECKED Then
		_DonateControls($eGobl)
	Else
		GUICtrlSetBkColor($lblBtnGoblins, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateGoblins

Func chkDonateWallBreakers()
	If GUICtrlRead($chkDonateWallBreakers) = $GUI_CHECKED Then
		_DonateControls($eWall)
	Else
		GUICtrlSetBkColor($lblBtnWallBreakers, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateWallBreakers

Func chkDonateBalloons()
	If GUICtrlRead($chkDonateBalloons) = $GUI_CHECKED Then
		_DonateControls($eBall)
	Else
		GUICtrlSetBkColor($lblBtnBalloons, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateBalloons

Func chkDonateWizards()
	If GUICtrlRead($chkDonateWizards) = $GUI_CHECKED Then
		_DonateControls($eWiza)
	Else
		GUICtrlSetBkColor($lblBtnWizards, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateWizards

Func chkDonateHealers()
	If GUICtrlRead($chkDonateHealers) = $GUI_CHECKED Then
		_DonateControls($eHeal)
	Else
		GUICtrlSetBkColor($lblBtnHealers, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateHealers

Func chkDonateDragons()
	If GUICtrlRead($chkDonateDragons) = $GUI_CHECKED Then
		_DonateControls($eDrag)
	Else
		GUICtrlSetBkColor($lblBtnDragons, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateDragons

Func chkDonatePekkas()
	If GUICtrlRead($chkDonatePekkas) = $GUI_CHECKED Then
		_DonateControls($ePekk)
	Else
		GUICtrlSetBkColor($lblBtnPekkas, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonatePekkas

Func chkDonateMinions()
	If GUICtrlRead($chkDonateMinions) = $GUI_CHECKED Then
		_DonateControls($eMini)
	Else
		GUICtrlSetBkColor($lblBtnMinions, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateMinions

Func chkDonateHogRiders()
	If GUICtrlRead($chkDonateHogRiders) = $GUI_CHECKED Then
		_DonateControls($eHogs)
	Else
		GUICtrlSetBkColor($lblBtnHogRiders, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateHogRiders

Func chkDonateValkyries()
	If GUICtrlRead($chkDonateValkyries) = $GUI_CHECKED Then
		_DonateControls($eValk)
	Else
		GUICtrlSetBkColor($lblBtnValkyries, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateValkyries

Func chkDonateGolems()
	If GUICtrlRead($chkDonateGolems) = $GUI_CHECKED Then
		_DonateControls($eGole)
	Else
		GUICtrlSetBkColor($lblBtnGolems, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateGolems

Func chkDonateWitches()
	If GUICtrlRead($chkDonateWitches) = $GUI_CHECKED Then
		_DonateControls($eWitc)
	Else
		GUICtrlSetBkColor($lblBtnWitches, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateWitches

Func chkDonateLavaHounds()
	If GUICtrlRead($chkDonateLavaHounds) = $GUI_CHECKED Then
		_DonateControls($eLava)
	Else
		GUICtrlSetBkColor($lblBtnLavaHounds, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateLavaHounds

;;; Custom Combination Donate by ChiefM3
Func chkDonateCustom()
	If GUICtrlRead($chkDonateCustom) = $GUI_CHECKED Then
		_DonateControls(16)
	Else
		GUICtrlSetBkColor($lblBtnCustom, $GUI_BKCOLOR_TRANSPARENT)
	EndIf
EndFunc   ;==>chkDonateCustom

Func chkWalls()
	If GUICtrlRead($chkWalls) = $GUI_CHECKED Then
		GUICtrlSetState($UseGold, $GUI_ENABLE)
		;		GUICtrlSetState($UseElixir, $GUI_ENABLE)
		;		GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
		GUICtrlSetState($cmbWalls, $GUI_ENABLE)
		GUICtrlSetState($txtWallMinGold, $GUI_ENABLE)
		;		GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
		cmbWalls()
	Else
		GUICtrlSetState($UseGold, $GUI_DISABLE)
		GUICtrlSetState($UseElixir, $GUI_DISABLE)
		GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
		GUICtrlSetState($cmbWalls, $GUI_DISABLE)
		GUICtrlSetState($txtWallMinGold, $GUI_DISABLE)
		GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkWalls

;Mow the lawn
Func chkTrees()
	If GUICtrlRead($chkTrees) = $GUI_CHECKED Then
		$ichkTrees = 1
	Else
		$ichkTrees = 0
	EndIf
	If GUICtrlRead($chkTombs) = $GUI_CHECKED Then
		$ichkTombs = 1
	Else
		$ichkTombs = 0
	EndIf
EndFunc   ;==>chkTrees
;End Mow the lawn

Func cmbWalls()
	Switch _GUICtrlComboBox_GetCurSel($cmbWalls)
		Case 0
			$WallCost = 30000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
			GUICtrlSetState($UseElixir, $GUI_DISABLE)
			GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 1
			$WallCost = 75000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
			GUICtrlSetState($UseElixir, $GUI_DISABLE)
			GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 2
			$WallCost = 200000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
			GUICtrlSetState($UseElixir, $GUI_DISABLE)
			GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 3
			$WallCost = 500000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
			GUICtrlSetState($UseElixir, $GUI_DISABLE)
			GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 4
			$WallCost = 1000000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseElixir, $GUI_ENABLE)
			GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
		Case 5
			$WallCost = 3000000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseElixir, $GUI_ENABLE)
			GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
		Case 6
			$WallCost = 4000000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseElixir, $GUI_ENABLE)
			GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
			GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
	EndSwitch
EndFunc   ;==>cmbWalls

Func chkTrap()
	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		$ichkTrap = 1
		GUICtrlSetState($btnLocateTownHall, $GUI_SHOW)
	Else
		$ichkTrap = 0
		GUICtrlSetState($btnLocateTownHall, $GUI_HIDE)
	EndIf
EndFunc   ;==>chkTrap

Func sldVSDelay()
	$iVSDelay = GUICtrlRead($sldVSDelay)
	GUICtrlSetData($lblVSDelay, $iVSDelay)

	If $iVSDelay = 1 Then
		GUICtrlSetData($lbltxtVSDelay, "second")
	Else
		GUICtrlSetData($lbltxtVSDelay, "seconds")
	EndIf
EndFunc   ;==>sldVSDelay

Func chkPBenabled()
	If GUICtrlRead($chkPBenabled) = $GUI_CHECKED Then
		$pEnabled = 1
		GUICtrlSetState($chkPBRemote, $GUI_ENABLE)
		GUICtrlSetState($PushBTokenValue, $GUI_ENABLE)
		GUICtrlSetState($OrigPushB, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBVMFound, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBLastRaid, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBWallUpgrade, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBLastRaidTxt, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBOOS, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBLab, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBVBreak, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBVillage, $GUI_ENABLE)
		GUICtrlSetState($chkAlertPBOtherDevice, $GUI_ENABLE)
		GUICtrlSetState($chkDeleteAllPushes, $GUI_ENABLE)
		GUICtrlSetState($chkDeleteOldPushes, $GUI_ENABLE)
		GUICtrlSetState($btnDeletePBmessages, $GUI_ENABLE)

		If $ichkDeleteOldPushes = 1 Then
			GUICtrlSetState($cmbHoursPushBullet, $GUI_ENABLE)
		EndIf
	Else
		$pEnabled = 0
		GUICtrlSetState($chkPBRemote, $GUI_DISABLE)
		GUICtrlSetState($PushBTokenValue, $GUI_DISABLE)
		GUICtrlSetState($OrigPushB, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBVMFound, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBLastRaid, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBWallUpgrade, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBLastRaidTxt, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBOOS, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBLab, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBVBreak, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBVillage, $GUI_DISABLE)
		GUICtrlSetState($chkAlertPBOtherDevice, $GUI_DISABLE)
		GUICtrlSetState($chkDeleteAllPushes, $GUI_DISABLE)
		GUICtrlSetState($chkDeleteOldPushes, $GUI_DISABLE)
		GUICtrlSetState($btnDeletePBmessages, $GUI_DISABLE)

		GUICtrlSetState($cmbHoursPushBullet, $GUI_DISABLE)

	EndIf
EndFunc   ;==>chkPBenabled

Func chkDeleteOldPushes()
	If GUICtrlRead($chkDeleteOldPushes) = $GUI_CHECKED Then
		$ichkDeleteOldPushes = 1
		If $pEnabled Then GUICtrlSetState($cmbHoursPushBullet, $GUI_ENABLE)
	Else
		$ichkDeleteOldPushes = 0
		GUICtrlSetState($cmbHoursPushBullet, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkDeleteOldPushes

Func btnDeletePBMessages()
	$iDeleteAllPushesNow = True
EndFunc   ;==>btnDeletePBMessages

Func tabMain()
	If GUICtrlRead($tabMain, 1) = $tabGeneral Then
		ControlShow("", "", $txtLog)
	Else
		ControlHide("", "", $txtLog)
	EndIf
EndFunc   ;==>tabMain

Func DisableBS($HWnD, $iButton)
	ConsoleWrite('+ Window Handle: ' & $HWnD & @CRLF)
	$hSysMenu = _GUICtrlMenu_GetSystemMenu($HWnD, 0)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $iButton, False)
	_GUICtrlMenu_DrawMenuBar($HWnD)
EndFunc   ;==>DisableBS

Func EnableBS($HWnD, $iButton)
	ConsoleWrite('+ Window Handle: ' & $HWnD & @CRLF)
	$hSysMenu = _GUICtrlMenu_GetSystemMenu($HWnD, 1)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $iButton, False)
	_GUICtrlMenu_DrawMenuBar($HWnD)
EndFunc   ;==>EnableBS

Func btnLocateUp1()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade1()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp1

Func btnLocateUp2()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade2()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp2

Func btnLocateUp3()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade3()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp3

Func btnLocateUp4()
	$RunState = True
	While 1
		ZoomOut()
		LocateUpgrade4()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateUp4

Func btnLoots()
	Run("Explorer.exe " & @ScriptDir & "\Loots")
EndFunc   ;==>btnLoots

Func btnLogs()
	Run("Explorer.exe " & @ScriptDir & "\Logs")
EndFunc   ;==>btnLogs


;---------------------------------------------------
; Extra Functions used on GUI Control
;---------------------------------------------------

Func _DonateAllControls($TroopType, $Set)
	If $Set = True Then
		For $i = 0 To UBound($aLblBtnControls) - 1
			If $i = $TroopType Then
				GUICtrlSetBkColor($aLblBtnControls[$i], $COLOR_NAVY)
			Else
				GUICtrlSetBkColor($aLblBtnControls[$i], $GUI_BKCOLOR_TRANSPARENT)
			EndIf
		Next

		For $i = 0 To UBound($aChkDonateAllControls) - 1
			If $i <> $TroopType Then
				GUICtrlSetState($aChkDonateAllControls[$i], $GUI_UNCHECKED)
			EndIf
		Next

		For $i = 0 To UBound($aChkDonateControls) - 1
			GUICtrlSetState($aChkDonateControls[$i], $GUI_UNCHECKED)
		Next

		For $i = 0 To UBound($aTxtDonateControls) - 1
			If BitAND(GUICtrlGetState($aTxtDonateControls[$i]), $GUI_ENABLE) = $GUI_ENABLE Then GUICtrlSetState($aTxtDonateControls[$i], $GUI_DISABLE)
		Next

		For $i = 0 To UBound($aTxtBlacklistControls) - 1
			If BitAND(GUICtrlGetState($aTxtBlacklistControls[$i]), $GUI_ENABLE) = $GUI_ENABLE Then GUICtrlSetState($aTxtBlacklistControls[$i], $GUI_DISABLE)
		Next

		If BitAND(GUICtrlGetState($txtBlacklist), $GUI_ENABLE) = $GUI_ENABLE Then GUICtrlSetState($txtBlacklist, $GUI_DISABLE)
	Else
		GUICtrlSetBkColor($aLblBtnControls[$TroopType], $GUI_BKCOLOR_TRANSPARENT)

		For $i = 0 To UBound($aTxtDonateControls) - 1
			If BitAND(GUICtrlGetState($aTxtDonateControls[$i]), $GUI_DISABLE) = $GUI_DISABLE Then GUICtrlSetState($aTxtDonateControls[$i], $GUI_ENABLE)
		Next

		For $i = 0 To UBound($aTxtBlacklistControls) - 1
			If BitAND(GUICtrlGetState($aTxtBlacklistControls[$i]), $GUI_DISABLE) = $GUI_DISABLE Then GUICtrlSetState($aTxtBlacklistControls[$i], $GUI_ENABLE)
		Next

		If BitAND(GUICtrlGetState($txtBlacklist), $GUI_DISABLE) = $GUI_DISABLE Then GUICtrlSetState($txtBlacklist, $GUI_ENABLE)
	EndIf
EndFunc   ;==>_DonateAllControls

Func _DonateControls($TroopType)
	For $i = 0 To UBound($aLblBtnControls) - 1
		If $i = $TroopType Then
			GUICtrlSetBkColor($aLblBtnControls[$i], $COLOR_GREEN)
		Else
			If GUICtrlGetBkColor($aLblBtnControls[$i]) = $COLOR_NAVY Then GUICtrlSetBkColor($aLblBtnControls[$i], $GUI_BKCOLOR_TRANSPARENT)
		EndIf
	Next

	For $i = 0 To UBound($aChkDonateAllControls) - 1
		GUICtrlSetState($aChkDonateAllControls[$i], $GUI_UNCHECKED)
	Next

	For $i = 0 To UBound($aTxtDonateControls) - 1
		If BitAND(GUICtrlGetState($aTxtDonateControls[$i]), $GUI_DISABLE) = $GUI_DISABLE Then GUICtrlSetState($aTxtDonateControls[$i], $GUI_ENABLE)
	Next

	For $i = 0 To UBound($aTxtBlacklistControls) - 1
		If BitAND(GUICtrlGetState($aTxtBlacklistControls[$i]), $GUI_DISABLE) = $GUI_DISABLE Then GUICtrlSetState($aTxtBlacklistControls[$i], $GUI_ENABLE)
	Next
EndFunc   ;==>_DonateControls

Func _DonateBtn($FirstControl, $LastControl)
	; Hide Controls
	If $LastDonateBtn1 = -1 Then
		For $i = $grpBarbarians To $txtBlacklistBarbarians ; 1st time use: Hide Barbarian controls
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	Else
		For $i = $LastDonateBtn1 To $LastDonateBtn2 ; Hide last used controls on Donate Tab
			GUICtrlSetState($i, $GUI_HIDE)
		Next
	EndIf

	$LastDonateBtn1 = $FirstControl
	$LastDonateBtn2 = $LastControl

	;Show Controls
	For $i = $FirstControl To $LastControl ; Show these controls on Donate Tab
		GUICtrlSetState($i, $GUI_SHOW)
	Next
EndFunc   ;==>_DonateBtn

Func _Restart()
	Local $sCmdFile
	FileDelete(@TempDir & "restart.bat")
	$sCmdFile = 'tasklist /FI "IMAGENAME eq ' & @ScriptFullPath & '" | find /i "' & @ScriptFullPath & '"' & @CRLF _
				& 'IF ERRORLEVEL 1 GOTO LAUNCHPROGRAM' & @CRLF _
				&' :LAUNCHPROGRAM '& @CRLF _
				&' start "" "' & @ScriptFullPath & '" '& @CRLF _
				& 'call :deleteSelf&exit /b '& @CRLF _
				& ':deleteSelf '& @CRLF _
				& 'start /b "" cmd /c del "%~f0"&exit /b'
	FileWrite(@TempDir & "restart.bat", $sCmdFile)
	IniWrite($config, "general", "Restarted", 1)
	Run(@TempDir & "restart.bat", @TempDir, @SW_HIDE)
	ProcessClose("HD-Frontend.exe")
	ProcessClose("HD-Agent.exe")
	ProcessClose("CGB Bot.exe")
	Exit
EndFunc

;---------------------------------------------------
If FileExists($config) Then
	readConfig()
	applyConfig()
EndIf
If FileExists($building) Then
	readConfig()
	applyConfig()
EndIf
GUIRegisterMsg($WM_COMMAND, "GUIControl")
GUIRegisterMsg($WM_SYSCOMMAND, "GUIControl")
;---------------------------------------------------
