
; #FUNCTION# ====================================================================================================================
; Name ..........: TrainClick
; Description ...: Clicks in troop training window with special checks for Barracks Full, and If not enough elxir to train troops or to close the gem window if opened.
; Syntax ........: TrainClick($x, $y, $iTimes, $iSpeed, $aWatchSpot, $aLootSpot, $debugtxt = "")
; Parameters ....: $x                   - X location to click
;                  $y                   - Y location to click
;                  $iTimes              - Number fo times to cliok
;                  $iSpeed              - Wait time after click
;                  $aWatchSpot          - [in/out] an array of [X location, Y location, Hex Color, Tolerance] to check after click if full
;                  $aLootSpot           - [in/out] an array of [X location, Y location, Hex Color, Tolerance] to check after click, color used to see if out of Elixir for more troops
;						 $sdebugtxt				 - String with click debug text
; Return values .: None
; Author ........: KnowJack (July 2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func TrainClick($x, $y, $iTimes, $iSpeed, $aWatchSpot, $aLootSpot, $sdebugtxt = "")

	If $debugClick = 1 Then
		Local $txt = _DecodeDebug($sdebugtxt)
		SetLog("Click " & $x & "," & $y & "," & $iTimes & "," & $iSpeed & " " & $sdebugtxt & $txt, $COLOR_PURPLE, "Verdana", "7.5", 0)
	EndIf

	If $iTimes <> 1 Then
		For $i = 0 To ($iTimes - 1)

			If isProblemAffect(True) Then checkMainScreen(False) ; Check for BS/CoC errors
			;SetLog(_GetPixelColor($aWatchSpot[0], $aWatchSpot[1], True), $COLOR_PURPLE)
			;If _CheckPixel($aWatchSpot, True) = True Then ExitLoop
			If _CheckPixel($aLootSpot, True) = True Then
				$OutOfElixir = 1
				If _Sleep(3000) Then Return
				If IsGemOpen() = True Then ClickP($aTopLeftClient) ;Click Away
				ExitLoop ; Check to see if out of Elixir
			EndIf

			ControlClick($Title, "", "", "left", "1", $x, $y)  ;Click once.
			If _Sleep($iSpeed, False) Then ExitLoop
		Next
		Else
		If isProblemAffect(True) Then checkMainScreen(False)
		;If _CheckPixel($aWatchSpot, True) = True Then Return ; Check to see barrack full
		If _CheckPixel($aLootSpot, True) = True Then
				$OutOfElixir = 1
				If _Sleep(3000) Then Return
				If IsGemOpen() = True Then ClickP($aTopLeftClient) ;Click Away
				Return ; Check to see if out of Elixir
		EndIf

		ControlClick($Title, "", "", "left", "1", $x, $y)

		If _Sleep($iSpeed, False) Then Return
		If _CheckPixel($aLootSpot, True) = True Then
				$OutOfElixir = 1
				If _Sleep(3000) Then Return
				If IsGemOpen() = True Then ClickP($aTopLeftClient) ;Click Away
				Return ; Check to see if out of Elixir
			EndIf

	EndIf

EndFunc   ;==>TrainClick

; TrainClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func TrainClickP($point, $howMany, $speed, $aWatchSpot, $aLootSpot, $debugtxt = "")
	TrainClick($point[0], $point[1], $howMany, $speed, $aWatchSpot, $aLootSpot, $debugtxt)
EndFunc
