; #FUNCTION# ====================================================================================================================
; Name ..........: Unbreakable.au3
; Description ...: This file Includes function to perform defense farming.
; Syntax ........:
; Parameters ....: None
; Return values .: False if regular farming is needed to refill storage
; Author ........: KnowJack (2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func Unbreakable()
	;
	; Special mode to complete unbreakable achievement
	; Need to set max/min trophy on Misc tab to range where base can win defenses
	; Enable mode with checkbox, and set desired time to be offline getting defense wins before base is reset.
	; Set absolute minimum loot required to still farm for more loot in Farm Minimum setting, and Save Minimum setting loot that will atttact enemy attackers
	;
	Local $x, $y, $iTime

	Switch $iUnbreakableMode
		Case 2
			If ($GoldVillage > $iUnBrkMaxGold) And ($ElixirVillage > $iUnBrkMaxElixir) And ($DarkVillage > $iUnBrkMaxDark) Then
				SetLog(" ====== Unbreakable Mode restarted! ====== ", $COLOR_GREEN)
				$iUnbreakableMode = 1
			Else
				SetLog(" = Unbreakable Mode Paused, Farming to Refill Storages =", $COLOR_BLUE)
				Return False
			EndIf
		Case 1
			SetLog(" ====== Unbreakable Mode enabled! ====== ", $COLOR_GREEN)
		Case Else
			SetLog(">>> Programmer Humor, You shouldn't ever see this message, RUN! <<<", $COLOR_PURPLE)
	EndSwitch

	If $CurCamp < 1 Then
		SetLog("Oops, wait for troops", $COLOR_RED)
		Return True ; no troops then cycle again
	EndIf

	Local $sMissingLoot = ""
	If (($GoldVillage - $iUnBrkMinGold) < 0) Then
		$sMissingLoot &= " Gold, "
	EndIf
	If (($ElixirVillage - $iUnBrkMinElixir) < 0) Then
		$sMissingLoot &= " Elixir, "
	EndIf
	If (($DarkVillage - $iUnBrkMinDark) < 0) Then
		$sMissingLoot &= " Dark Elxir,"
	EndIf
	If $sMissingLoot <> "" Then
		SetLog("Oops, Out of" & $sMissingLoot & " - back to farming", $COLOR_RED)
		$iUnbreakableMode = 2 ; go back to farming mode.
		Return False
	EndIf

	DropTrophy()

	ClickP($aTopLeftClient, 2, 100, "#0112") ;clear screen, 2 clicks 100ms delay

	PrepareSearch() ; Break Shield
	If _Sleep(3000) Then Return

	SetLog("Returning Home For Defense", $COLOR_BLUE)

	ClickP($aTopLeftClient, 2, 100, "#0113") ;clear screen selection
	$i = 0
	While _ColorCheck(_GetPixelColor(63, 532, True), Hex(0xC00000, 6), 20) = False
		If _Sleep(1000) Then Return ; wait for clouds to disappear and the end battle button to appear
		If $i > 30 Then
			Setlog("Excess Cloud Watching Time, Try again", $COLOR_RED)
			Return
		EndIf
		$i += 1
	WEnd
	$i = 0
	While _ColorCheck(_GetPixelColor(63, 532, True), Hex(0xC00000, 6), 20) = True
		PureClickP($aSurrenderButton, 1, 0, "#0114") ;Click End Battle
		If _Sleep(1000) Then Return ; wait for button to disappear
		If $i > 15 Then ExitLoop
		$i += 1
	WEnd

	ClickP($aTopLeftClient, 2, 50, "#0115") ;clear screen selections
	If _Sleep(1000) Then Return

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title))

	SetLog("Closing Clash Of Clans", $COLOR_BLUE)

	$i = 0
	While _ColorCheck(_GetPixelColor(515, 410, True), Hex(0x60B010, 6), 20) = False
		PureClick(50, 700, 1, 0, "#0116") ; Hit BS Back button till confirm exit dialog appears
		If _Sleep(1000) Then Return
		If $i > 15 Then ExitLoop
		$i += 1
	WEnd
	PureClick(515, 400, 1, 0, "#0117") ;Click Confirm to stop CoC

	$iTime = Number($iUnbreakableWait)
	If $iTime < 1 Then $iTime = 1 ;error check user time input

	SetLog("Waiting " & $iTime & " Minutes for Defense Attacks", $COLOR_GREEN)
	If _SleepStatus($iTime * 60 * 1000) Then Return ; Eenemy attack time Wait

	$HWnD = WinGetHandle($Title)
	Local $RunApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "RunApp")
	Run($RunApp & " Android com.supercell.clashofclans com.supercell.clashofclans.GameApp")
	If _Sleep(15000) Then Return ; Wait for CoC restart

	ZoomOut()
	If _Sleep(1000) Then Return

	Return True

EndFunc   ;==>Unbreakable
