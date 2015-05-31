
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
	SetLog("Checking if the battle has finished", $COLOR_BLUE)
	While 1
		$Gold1 = getGold(51, 66)
		$Elixir1 = getElixir(51, 66 + 29)
		Local $iBegin = TimerInit(), $x = $sTimeStopAtk*1000
		While TimerDiff($iBegin) < $x
			If $FoundDarkSideAtk = 1 And (($dropKing = True) Or ($dropQueen = True)) Then
			   DELow()
			   If $DarkLow = 1 Then ExitLoop
			EndIf
			CheckHeroesHealth()
			If $checkKPower Or $checkQPower Or ($DarkLow = 0) Then
				If _Sleep(500) Then Return
			else
				If _Sleep(1000) Then Return
			endif
			$Gold2 = getGold(51, 66)
			if $Gold2 = "" then
				If _Sleep(500) Then Return
				$Gold2 = getGold(51, 66)
			endif
			$Elixir2 = getElixir(51, 66 + 29)

			If $Gold2 <> "" Or $Elixir2 <> "" Then
			   $GoldChange = $Gold2
			   $ElixirChange = $Elixir2
			EndIf

			If ($Gold2 = "" And $Elixir2 = "") Then
				If _Sleep(500) Then Return
				if getGold(51, 66) = "" and getElixir(51, 66 + 29) = "" then
					SetLog("Battle has finished", $COLOR_GREEN)
					ExitLoop
				endif
			EndIf
			;If (GUICtrlRead($cmbBoostBarracks) > 0) And ($boostsEnabled = 1) Then $x = $sTimeStopAtk*1000
		WEnd
		If ($Gold1 = $Gold2 And $Elixir1 = $Elixir2) Or ($Gold2 = "" And $Elixir2 = "") Then
			GUICtrlSetData($lblresultvillagesattacked, GUICtrlRead($lblresultvillagesattacked)+1)
			Return False
		Else
			SetLog("Gold & Elixir change detected, waiting...", $COLOR_GREEN)
			Return True
		 EndIf
		ExitLoop
	WEnd
EndFunc   ;==>GoldElixirChange
