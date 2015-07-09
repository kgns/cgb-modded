
; #FUNCTION# ====================================================================================================================
; Name ..........: LocateSpellFactory
; Description ...: Locates Spell Factory manually
; Syntax ........: LocateSpellFactory()
; Parameters ....:
; Return values .: None
; Author ........: saviart
; Modified ......: KnowJack (June 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateSpellFactory()
	Local $stext, $MsgBox

	SetLog("Locating Spell Factory...", $COLOR_BLUE)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = "Click OK then click on your Spell Factory" & @CRLF & "Do not move mouse quickly after clicking location"
		$MsgBox = _ExtMsgBox(32, "OK", "Locate Spell Factory", $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$SFPos[0] = FindPos()[0]
			$SFPos[1] = FindPos()[1]
			If isInsideDiamond($SFPos) = False Then
				SetLog("Location not valid, try again", $COLOR_RED)
				ContinueLoop
			EndIf
			SetLog("Spell Factory: " & "(" & $SFPos[0] & "," & $SFPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd

	ClickP($aTopLeftClient, 2, 200, "#0208")

EndFunc   ;==>LocateSpellFactory
