
; #FUNCTION# ====================================================================================================================
; Name ..........: LocateClanCastle
; Description ...: Locates Clan Castle manually (Temporary)
; Syntax ........: LocateClanCastle()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #69
; Modified ......: KnowJack (June 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateClanCastle()
	Local $stext, $MsgBox

	SetLog("Locating Clan Castle...", $COLOR_BLUE)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = "Click OK then click on your Clan Castle" & @CRLF & "Do not move mouse quickly after clicking location"
		$MsgBox = _ExtMsgBox(32, "OK", "Locate Clan Castle", $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$aCCPos[0] = FindPos()[0]
			$aCCPos[1] = FindPos()[1]
			If isInsideDiamond($aCCPos) = False Then
				SetLog("Location not valid, try again", $COLOR_RED)
				ContinueLoop
			EndIf
			SetLog("Clan Castle: " & "(" & $aCCPos[0] & "," & $aCCPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd

	ClickP($aTopLeftClient, 2, 200, "#0327")

EndFunc   ;==>LocateClanCastle
