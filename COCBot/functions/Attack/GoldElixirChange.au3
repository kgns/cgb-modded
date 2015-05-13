
;==========================================================================
; Function name: GoldElixirChange
; Authored by:
; Edited by: Samota,
;
; Description: Checks if the gold/elixir changes values within 20 seconds, Returns True if changed. Also
; checks every 5 seconds if gold/elixir = "", meaning battle is over. If either condition is met, return
; false.
;
; Notes: If all troops are used, the battle will end when they are all dead, the timer runs out, or the
; base has been 3-starred. When the battle ends, it is detected within 5 seconds, otherwise it takes up
; to 20 seconds.
;
;==========================================================================
Func GoldElixirChange()
	Local $Gold1, $Gold2
	Local $GoldChange, $ElixirChange
	Local $Elixir1, $Elixir2
	Local $Dark1
	SetLog("Checking if the battle has finished", $COLOR_BLUE)
	While 1
		$Gold1 = getGold(51, 66)
		$Elixir1 = getElixir(51, 66 + 29)
		Local $iBegin = TimerInit(), $x = $sTimeStopAtk*1000
		While TimerDiff($iBegin) < $x
			If($checkHeroesByHealth = True) Then
				CheckHeroesHealth()
				If $checkKPower Or $checkQPower Then
					If _Sleep(500) Then Return
				else
					$checkHeroesByHealth = False
					If _Sleep(1000) Then Return
				endif
			EndIf
			$Gold2 = getGold(51, 66)
			$Elixir2 = getElixir(51, 66 + 29)
			If $Gold2 <> "" Or $Elixir2 <> "" Then
			   $GoldChange = $Gold2
			   $ElixirChange = $Elixir2
			   If $searchDark <> 0 Then $Dark1 = getDarkElixir(51, 66 + 57)
			EndIf
			If ($Gold2 = "" And $Elixir2 = "") Then
				If _Sleep(500) Then Return
				if getGold(51, 66) = "" and getElixir(51, 66 + 29) = "" then
					SetLog("Battle has finished", $COLOR_GREEN)
					$checkHeroesByHealth = False
					ExitLoop
				endif
			EndIf
			;If (GUICtrlRead($cmbBoostBarracks) > 0) And ($boostsEnabled = 1) Then $x = $sTimeStopAtk*1000
		WEnd
		If ($Gold1 = $Gold2 And $Elixir1 = $Elixir2) Or ($Gold2 = "" And $Elixir2 = "") Then
			$checkHeroesByHealth = False
			GUICtrlSetData($lblresultvillagesattacked, GUICtrlRead($lblresultvillagesattacked)+1)
			Return False
		Else
			SetLog("Gold & Elixir change detected, waiting...", $COLOR_GREEN)
			Return True
		 EndIf
		ExitLoop
	WEnd
EndFunc   ;==>GoldElixirChange

Func CheckHeroesHealth()
	If $checkKPower Or $checkQPower Then
		_CaptureRegion(0, 553, 660, 557)
		If $checkKPower Then
			If _ColorCheck(_GetPixelColor(68 + (72 * $King), 555 - 553), Hex(0x00B4A0, 6), 10, "Red") Then
			 SetLog("King is getting weak, Activating King's power", $COLOR_BLUE)
			 SelectDropTroop($King)
			 $checkKPower = false
		   EndIf
		EndIf
		If $checkQPower Then
		   If _ColorCheck(_GetPixelColor(68 + (72 * $Queen), 555 - 553), Hex(0x007E1E, 6), 10, "Red") Then
			  SetLog("Queen is getting weak, Activating Queen's power", $COLOR_BLUE)
			  SelectDropTroop($Queen)
			  $checkQPower = false
		   EndIf
		EndIf
	EndIf

EndFunc
