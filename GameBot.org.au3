; #FUNCTION# ====================================================================================================================
; Name ..........: CGB Bot
; Description ...: This file contens the Sequence that runs all CGB Bot
; Author ........:  (2014)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

#RequireAdmin
#AutoIt3Wrapper_UseX64=n
#include <WindowsConstants.au3>
#include <WinAPI.au3>

#pragma compile(Icon, "Icons\cocbot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free Clash of Clans bot - https://gamebot.org)
#pragma compile(ProductName, Clash Game Bot)

#pragma compile(ProductVersion, 4.0.1)
#pragma compile(FileVersion, 4.0.1)
#pragma compile(LegalCopyright, © http://gamebot.org)

$sBotVersion = "v4.0.1"
$sBotTitle = "Clash Game Bot " & $sBotVersion
Global $sBotDll = @ScriptDir & "\CGBPlugin.dll"

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, "", "Bot is already running.")
	Exit
 EndIf

If @AutoItX64 = 1 Then
	MsgBox(0, "", "Don't Run/Compile the Script as (x64)! try to Run/Compile the Script as (x86) to get the bot to work." & @CRLF & _
				  "If this message still appears, try to re-install AutoIt.")
	Exit
EndIf

If Not FileExists(@ScriptDir & "\License.txt") Then
	$license = InetGet("http://www.gnu.org/licenses/gpl-3.0.txt", @ScriptDir & "\License.txt")
	InetClose($license)
EndIf

#include "COCBot\CGB Global Variables.au3"
#include "COCBot\CGB GUI Design.au3"
#include "COCBot\CGB GUI Control.au3"
#include "COCBot\CGB Functions.au3"

CheckPrerequisites() ; check for VC2010 and .NET software

DirCreate($sTemplates)
DirCreate($sProfilePath & "\" & $sCurrProfile)
DirCreate($dirLogs)
DirCreate($dirLoots)
DirCreate($dirTemp)
FileMove(@ScriptDir & "\*.ini", $sProfilePath & "\" & $sCurrProfile, $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Logs", $sProfilePath & "\" & $sCurrProfile & "\Logs", $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Loots", $sProfilePath & "\" & $sCurrProfile & "\Loots", $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Temp", $sProfilePath & "\" & $sCurrProfile & "\Temp", $FC_OVERWRITE + $FC_CREATEPATH)
DirRemove(@ScriptDir & "\Logs", 1)
DirRemove(@ScriptDir & "\Loots", 1)
DirRemove(@ScriptDir & "\Temp", 1)

if $ichkDeleteLogs  = 1 then DeleteFiles($dirLogs ,"*.*",$iDeleteLogsDays ,0)
if $ichkDeleteLoots = 1 then DeleteFiles($dirLoots,"*.*",$iDeleteLootsDays,0)
if $ichkDeleteTemp  = 1 then DeleteFiles($dirTemp ,"*.*",$iDeleteTempDays ,0)
FileChangeDir ( $LibDir )

;CGBfunctions.dll debugger
debugCGBFunctions($debugSearchArea, $debugRedArea, $debugOcr) ; set debug levels

AdlibRegister("PushBulletRemoteControl", $PBRemoteControlInterval)
AdlibRegister("PushBulletDeleteOldPushes", $PBDeleteOldPushesInterval)

CheckVersion() ; check latest version on gamebot.org site

;AutoStart Bot if request
AutoStart()

While 1
	Switch TrayGetMsg()
        Case $tiAbout
			MsgBox(64 + $MB_APPLMODAL + $MB_TOPMOST, $sBotTitle, "Clash of Clans Bot" & @CRLF & @CRLF & _
				"Version: " & $sBotVersion & @CRLF & _
				"Released under the GNU GPLv3 license.", 0, $frmBot)
		Case $tiExit
			ExitLoop
	EndSwitch
WEnd

Func runBot() ;Bot that runs everything in order
	While 1
		$Restart = False
		$fullArmy = False
		$CommandStop = -1
		If _Sleep(1000) Then Return
		checkMainScreen()
		If $Is_ClientSyncError = False Then
			If BotCommand() Then btnStop()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			If $iChkUseCCBalanced = 1 then
			    ProfileReport()
			    If _Sleep(1000) Then Return
			    checkMainScreen(False)
			    If $Restart = True Then ContinueLoop
			EndIf
			if $RequestScreenshot = 1 then PushMsg("RequestScreenshot")
				If _Sleep(1000) Then Return
			Collect()
				If _Sleep(1000) Then Return
			CheckTombs()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			ReArm()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
		    ReplayShare($iShareAttackNow)
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			VillageReport()
		     	If _Sleep(1000) Then Return
				checkMainScreen(False)
				If $OutOfGold = 1  And ($GoldCount >= $itxtRestartGold) Then  ; check if enough gold to begin searching again
					$OutOfGold = 0  ; reset out of gold flag
					Setlog("Switching back to normal after no gold to search ...", $COLOR_RED)
					$ichkBotStop = 0  ; reset halt attack variable
					;GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
				EndIf
				If $OutOfElixir = 1  And ($ElixirCount >= $itxtRestartElixir) And ($DarkCount >= $itxtRestartDark) Then  ; check if enough elixir to begin searching again
					$OutOfElixir = 0  ; reset out of gold flag
					Setlog("Switching back to normal setting after no elixir to train ...", $COLOR_RED)
					$ichkBotStop = 0  ; reset halt attack variable
					;GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
				EndIf
				If $Restart = True Then ContinueLoop
			ReportPushBullet()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			DonateCC()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			Train()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			BoostBarracks()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			BoostSpellFactory()
			    If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			RequestCC()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			If $iUnbreakableMode >= 1 Then
				If Unbreakable() = True Then ContinueLoop
			Endif
			Laboratory()
				If _Sleep(1000) Then Return
				checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			UpgradeBuilding()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			UpgradeWall()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			Idle()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			If $CommandStop <> 0 And $CommandStop <> 3 Then
				AttackMain()
				If $OutOfGold = 1  Then
					Setlog("Switching to Halt Attack, Stay Online/Train/Collect/Donate...", $COLOR_RED)
					$ichkBotStop = 1  ; set halt attack variable
					$icmbBotCond = 14  ; set stay online/train/collect/Donate mode
					;GUICtrlSetState($chkBotStop, $GUI_CHECKED)
					;_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)
					ContinueLoop
				Endif
				If _Sleep(1000) Then Return
				If $Restart = True Then ContinueLoop
			EndIf
				;
		Else ;When error occours directly goes to attack
			SetLog("Restarted after Out of Sync Error: Attack Now", $COLOR_RED)
			PushMsg("OutOfSync")
			checkMainScreen(False)
			AttackMain()
			If $OutOfGold = 1  Then
				Setlog("Switching to Halt Attack, Stay Online/Train/Collect/Donate...", $COLOR_RED)
				$ichkBotStop = 1  ; set halt attack variable
				$icmbBotCond = 14  ; set stay online/train/collect/Donate mode
				;GUICtrlSetState($chkBotStop, $GUI_CHECKED)
				;_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)
				$Is_ClientSyncError = False  ; reset fast restart flag to stop OOS mode and start collecting resources
				ContinueLoop
			Endif
			If _Sleep(1000) Then Return
			If $Restart = True Then ContinueLoop
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds

	While $fullArmy = False
		if $RequestScreenshot = 1 then PushMsg("RequestScreenshot")
		If $CommandStop = -1 Then SetLog("====== Waiting for full army ======", $COLOR_GREEN)
		Local $hTimer = TimerInit()
		Local $iReHere = 0
		While $iReHere < 10
			$iReHere += 1
			DonateCC(true)
			If _Sleep(1500) Then ExitLoop
		    If $Restart = True Then ExitLoop
		WEnd
		If _Sleep(1500) Then ExitLoop

			    checkMainScreen(False)
		If _Sleep(1000) Then ExitLoop

	    ReplayShare($iShareAttackNow)
			If _Sleep(1000) Then Return
				checkMainScreen(False)
			If $Restart = True Then ExitLoop

		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			Collect()
		    If $Restart = True Then ExitLoop
			If _Sleep(1000) Or $RunState = False Then ExitLoop

			$iCollectCounter = 0
		EndIf
		$iCollectCounter = $iCollectCounter + 1
		If $CommandStop <> 3 Then
			Train()
		    If $Restart = True Then ExitLoop
			If _Sleep(1000) Then ExitLoop
			checkMainScreen(False)
		EndIf
		if $CommandStop <> 0 then
			while (not $fullArmy) and ($CurCamp >= ($TotalCamp * 90/100))
				If _Sleep(5000) Then ExitLoop
				Train()
				If $Restart = True Then ExitLoop
				checkMainScreen(False)
			wend
		endif
		If $CommandStop = 0 And $fullArmy Then
			SetLog("Army Camp and Barracks are full, stop Training...", $COLOR_ORANGE)
			$CommandStop = 3
			$fullArmy = False
		EndIf
		If $CommandStop = -1 Then
			   DropTrophy()
		    If $Restart = True Then ExitLoop
			If $fullArmy Then ExitLoop
			If _Sleep(1000) Then ExitLoop
			checkMainScreen(False)
		EndIf
		If $Restart = True Then ExitLoop
		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		SetLog("Time Idle: " & StringFormat("%02i", Floor(Floor($TimeIdle / 60) / 60)) & ":" & StringFormat("%02i", Floor(Mod(Floor($TimeIdle / 60), 60))) & ":" & StringFormat("%02i", Floor(Mod($TimeIdle, 60))), $COLOR_GREEN)
	WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
   ;launch profilereport() only if option balance D/R it's activated
	If $iChkUseCCBalanced = 1 then
	    ProfileReport()
		If _Sleep(1000) Then Return
	EndIf
	checkMainScreen(False)
		If $Restart = True Then Return
	PrepareSearch()
		If $OutOfGold = 1  Then Return ; Check flag for enough gold to search
		If $Restart = True Then Return
	VillageSearch()
		If $OutOfGold = 1  Then Return ; Check flag for enough gold to search
		If $Restart = True Then Return
	PrepareAttack($iMatchMode)
		If $Restart = True Then Return
	;checkDarkElix()
	;DEAttack()
		If $Restart = True Then Return
	Attack()
		If $Restart = True Then Return
	ReturnHome($TakeLootSnapShot)
		If _Sleep(1500) Then Return
	Return True
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
	SetLog(" ====== Start Attack ====== ", $COLOR_GREEN)
	algorithm_AllTroops()
EndFunc   ;==>Attack
