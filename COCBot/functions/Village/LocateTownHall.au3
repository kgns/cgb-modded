
; #FUNCTION# ====================================================================================================================
; Name ..........: LocateTownHall
; Description ...: Locates TownHall for Rearm Function
; Syntax ........: LocateTownHall()
; Parameters ....:
; Return values .: None
; Author ........:
; Modified ......: KNowJack (June 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateTownHall($bLocationOnly = False)

	Local $stext, $MsgBox
	SetLog("Locating Town Hall ...", $COLOR_BLUE)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = "Click OK then click on your TownHall" & @CRLF & "Do not move mouse quickly after clicking location"
		$MsgBox = _ExtMsgBox(32, "OK", "Locate TownHall", $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$TownHallPos[0] = FindPos()[0]
			$TownHallPos[1] = FindPos()[1]
			If isInsideDiamond($TownHallPos) = False Then
				SetLog("Location not valid, try again", $COLOR_RED)
				ContinueLoop
			EndIf
			SetLog("Townhall: " & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd

	ClickP($aTopLeftClient, 2, 200, "#0209")

	If $bLocationOnly = False Then GetTownHallLevel() ; Get/Save the users updated TH level

EndFunc   ;==>LocateTownHall
