
; #FUNCTION# ====================================================================================================================
; Name ..........: waitMainScreen
; Description ...: Waits 5 minutes for the pixel of mainscreen to be located, checks for obstacles every 2 seconds.  After five minutes, will try to restart bluestacks.
; Syntax ........: waitMainScreen()
; Parameters ....:
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func waitMainScreen() ;Waits for main screen to popup
	Local $iTried, $iCount
	SetLog("Waiting for Main Screen")
	For $i = 0 To 105 ;120*2000 = 3.5 Minutes
		_CaptureRegion()
		If _CheckPixel($aIsMain, $bNoCapturepixel) = False Then ;Checks for Main Screen
			If _Sleep(2000) Then Return
			If checkObstacles() Then $i = 0 ;See if there is anything in the way of mainscreen
		Else
			Return
		EndIf
	Next
	$iCount = 0
	While 1
		SetLog("Unable to load Clash Of Clans, Restarting...", $COLOR_RED)
		$iTimeTroops = 0
		Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
		Run($RestartApp & " Android")
		If _Sleep(10000) Then Return
		$iTried = 0
		Do
			If $iTried > 9  Then
				SetLog("Unable to Restart BS...", $COLOR_RED)
				ExitLoop
			EndIf
			If _Sleep(5000) Then Return
			$iTried += 1
		Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
		$iCount += 1
		If $iCount = 2 Then
			SetLog("Stuck trying to Restart BS...", $COLOR_RED)
			Return
		EndIf
	WEnd
EndFunc   ;==>waitMainScreen
