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

#pragma compile(ProductVersion, 3.0)

#pragma compile(FileVersion, 3.0.4)
#pragma compile(LegalCopyright, © http://gamebot.org)

$sBotVersion = "v3.0.4"

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

DirCreate($dirLogs)
DirCreate($dirLoots)
FileChangeDir($LibDir)

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
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			If BotCommand() Then btnStop()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
;			BotDetectFirstTime()
;				If _Sleep(1000) Then Return
;
;				If $Restart = True Then ContinueLoop
			;launch profilereport() only if option balance D/R it's activated
			If $checkUseClanCastleBalanced = 1 then
				ProfileReport()
					If _Sleep(1000) Then Return
					checkMainScreen(False)
					If $Restart = True Then ContinueLoop
			EndIf
			Collect()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			ReArm()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			VillageReport()
		     	If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			;Mow the lawn
			RemoveTrees()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			;End Mow the lawn
			ReportPushBullet()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			Train()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			DonateCC()
				If _Sleep(1000) Then Return
				checkMainDM()
				If $Restart = True Then ContinueLoop
			BoostBarracks()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			BoostSpellFactory()
			    If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			RequestCC()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			If GUICtrlRead($chkUnbreakable) = $GUI_CHECKED Then
				Unbreakable()
				ContinueLoop
			Endif
			Laboratory()
			    If _Sleep(1000) Then Return
			    checkMainScreen(False)
		     	If $Restart = True Then ContinueLoop
			UpgradeWall()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			UpgradeBuilding()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
			Idle()
			If _Sleep(1000) Then Return
			If $Restart = True Then ContinueLoop
			If $CommandStop <> 0 And $CommandStop <> 3 Then
				AttackMain()
					If _Sleep(1000) Then Return

					If $Restart = True Then ContinueLoop
			EndIf
				;
				;If $Restart = True Then ContinueLoop

		Else ;When error occours directly goes to attack
			SetLog("Restarted after Out of Sync Error: Attack Now", $COLOR_RED)
			If $pEnabled = 1 AND $pOOS = 1 Then _Push($iPBVillageName & ": Restarted after Out of Sync Error", "Attacking now...")
			AttackMain()
				If _Sleep(1000) Then Return

				If $Restart = True Then ContinueLoop
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds

	While $fullArmy = False
		If $CommandStop = -1 Then SetLog("====== Waiting for full army ======", $COLOR_GREEN)
		Local $hTimer = TimerInit()
		Local $iReHere = 0
		While $iReHere < 10
			$iReHere += 1
			DonateCC(True)
			If _Sleep(3000) Then ExitLoop
			If $Restart = True Then ExitLoop
		WEnd
		If _Sleep(1500) Then ExitLoop

		If _Sleep(1000) Then ExitLoop
		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			Collect()
			If _Sleep(1000) Or $RunState = False Then ExitLoop

			$iCollectCounter = 0
		EndIf
		$iCollectCounter = $iCollectCounter + 1
		If $CommandStop <> 3 Then
			Train()
			If _Sleep(1000) Then ExitLoop

		EndIf
		If $CommandStop = 0 And $fullArmy Then
			SetLog("Army Camp and Barracks are full, stop Training...", $COLOR_ORANGE)
			$CommandStop = 3
			$fullArmy = False
		EndIf
		If $CommandStop = -1 Then
			DropTrophy()
			If $fullArmy Then ExitLoop
			If _Sleep(1000) Then ExitLoop

		EndIf

		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		SetLog("Time Idle: " & StringFormat("%02i", Floor(Floor($TimeIdle / 60) / 60)) & ":" & StringFormat("%02i", Floor(Mod(Floor($TimeIdle / 60), 60))) & ":" & StringFormat("%02i", Floor(Mod($TimeIdle, 60))), $COLOR_GREEN)
	WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions

	;launch profilereport() only if option balance D/R it's activated
	If $checkUseClanCastleBalanced = 1 then
		ProfileReport()
		If _Sleep(1000) Then Return
	EndIf
	PrepareSearch()
	If _Sleep(1500) Then Return
	VillageSearch()
	If _Sleep(1500) Or $Restart = True Then Return
	PrepareAttack()
	If _Sleep(1500) Then Return
	;checkDarkElix()
	DEAttack()
	If _Sleep(4000) Then Return
	Attack()
	ReturnHome($TakeLootSnapShot)
	If _Sleep(1500) Then Return
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
	SetLog(" ====== Start Attack ====== ", $COLOR_GREEN)
	algorithm_AllTroops()
EndFunc   ;==>Attack

#cs ----------------------------------------------------------------------------
    AutoIt Version: 3.3.6.1
    This function was made to be used with software CoCgameBot v3.0.4
    Author:         KnowJack
    Script Function: unbreakable mode
 CoCgameBot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
 CoCgameBot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty;of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 You should have received a copy of the GNU General Public License along with CoCgameBot.  If not, see ;<[url=http://www.gnu.org/licenses/]http://www.gnu.org/licenses/[/url]>.
 #ce
Func Unbreakable()
;
; Special mode to complete unbreakable achievement
; Need to set max/min trophy on Misc tab to range where base can win defenses
; Enable mode with checkbox, and set desired time to be offline getting defense wins before base is reset.
;
   Local $x, $y, $iTime
   SetLog(" ====== Unbreakable Mode enabled! ====== ", $COLOR_GREEN)
   If $CurCamp < 1 Then
   SetLog("Oops, wait for troops", $COLOR_RED)
   Return ; no troops then cycle again
   EndIf
#comments-start
   _CaptureRegion()
   If _ImageSearch($tombstone, 0, $x, $y, 100) Then
  SetLog("Cleanup Tomb Stones!", $COLOR_BLUE)
  If _Sleep(500) Then Return
  PureClick($x, $y); click on a tombstone to remove them all
  If _Sleep(1000) Then Return
   EndIf
#comments-end
   DropTrophy()
   ClickP($TopLeftClient, 2, 100) ;clear screen, 2 clicks 100ms delay
   PrepareSearch() ; Break Shield
   If _Sleep(3000) Then Return
   SetLog("Returning Home For Defense", $COLOR_BLUE)
   ClickP($TopLeftClient, 2, 100) ;clear screen selection
   $i = 0
   While _ColorCheck(_GetPixelColor(63, 532,True), Hex(0xC00000, 6), 20) = False
   If _Sleep(1000) Then Return  ; wait for clouds to disappear and the end battle button to appear
   If $i > 15 then ExitLoop
   $i+= 1
   WEnd
   $i = 0
   While _ColorCheck(_GetPixelColor(63, 532,True), Hex(0xC00000, 6), 20) = True
   PureClick(62, 519) ;Click End Battle
   If _Sleep(1000) Then Return  ; wait for button to disappear
   If $i > 10 then ExitLoop
   $i+= 1
   WEnd
   ClickP($TopLeftClient, 2, 50) ;clear screen selections
   If _Sleep(1000) Then Return
   _WinAPI_EmptyWorkingSet(WinGetProcess($Title))
   SetLog("Closing Clash Of Clans", $COLOR_BLUE)
   $i = 0
   While _ColorCheck(_GetPixelColor(515, 410, True), Hex(0x60B010, 6), 20) = False
   PureClick(50, 700)  ; Hit BS Back button till confirm exit dialog appears
   If _Sleep(1000) Then Return
   If $i > 10 then ExitLoop
   $i+= 1
   WEnd
   PureClick(515, 400) ;Click Confirm to stop CoC
   Local $iTime = Number(GUICtrlRead($txtUnbreakable))
   If $iTime < 1 then $iTime = 1  ;error check user time input
   SetLog("Waiting " & $iTime & " Minutes for Defense Attacks", $COLOR_GREEN)
   If _Sleep($iTime*60*1000) Then Return  ; Eenemy attack time Wait
   $HWnD = WinGetHandle($Title)
   Local $RunApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "RunApp")
   Run($RunApp & " Android com.supercell.clashofclans com.supercell.clashofclans.GameApp")
   If _Sleep(15000) Then Return  ; Wait for CoC restart
   ZoomOut()
   If _Sleep(1000) Then Return
 EndFunc