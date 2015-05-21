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

Func AttackReport()

	If $debug_getdigitlarge = 1 Then
		_GDIPlus_ImageSaveToFile($hBitmap, $dirLoots & @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & "." & @MIN & ".png")
	EndIf

	If _ColorCheck(_GetPixelColor(459, 372), Hex(0x433350, 6), 20) Then ; if the color of the DE drop detected
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Gold =====", $COLOR_RED)
		$lootGold = GetReturnHome(438, 289, "ReturnResource")
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Elixir =====", $COLOR_RED)
		$lootElixir = GetReturnHome(438, 328, "ReturnResource")
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Dark Elixir =====", $COLOR_RED)
		$lootDarkElixir = GetReturnHome(438, 366, "ReturnResource")
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Trophies =====", $COLOR_RED)
		$lootTrophies = GetReturnHome(438, 402, "ReturnResource")
		SetLog("Loot: [G]: " & _NumberFormat($lootGold) & " [E]: " & _NumberFormat($lootElixir) & " [DE]: " & _NumberFormat($lootDarkElixir) & " [T]: " & $lootTrophies, $COLOR_GREEN)

		If $FirstAttack = 1 Then GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)

		GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
		GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
		GUICtrlSetData($lblDarkLastAttack, _NumberFormat($lootDarkElixir))
		GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))
	Else
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Gold =====", $COLOR_RED)
		$lootGold = GetReturnHome(438, 289, "ReturnResource")
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Elixir =====", $COLOR_RED)
		$lootElixir = GetReturnHome(438, 328, "ReturnResource")
		If $debug_getdigitlarge = 1 Then SetLog("====== Search Trophies =====", $COLOR_RED)
		$lootTrophies = GetReturnHome(438, 365, "ReturnResource") ; 1 pixel higher
		SetLog("Loot: [G]: " & _NumberFormat($lootGold) & " [E]: " & _NumberFormat($lootElixir) & " [DE]: " & "" & " [T]: " & $lootTrophies, $COLOR_GREEN)

		If $FirstAttack = 1 Then GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)

		GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
		GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
		GUICtrlSetData($lblDarkLastAttack, "")
		GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))
	EndIf

EndFunc   ;==>AttackReport
