; #FUNCTION# ====================================================================================================================
; Name ..........: LocateLab
; Description ...:
; Syntax ........: LocateLab()
; Parameters ....:
; Return values .: None
; Author ........: KnowJack (June 2015)
; Modified ......:
; Remarks .......:This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateLab()
	Local $stext, $MsgBox

	SetLog("Locating Laboratory...", $COLOR_BLUE)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = "Click OK then click on your Laboratory building" & @CRLF & "Do not move mouse quickly after clicking location"
		$MsgBox = _ExtMsgBox(32, "OK", "Locate Laboratory", $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$aLabPos[0] = Int(FindPos()[0])
			$aLabPos[1] = Int(FindPos()[1])
			If isInsideDiamond($aLabPos) = False Then
				SetLog("Location not valid, try again", $COLOR_RED)
				ContinueLoop
			EndIf
			SetLog("Locate Laboratory: " & "(" & $aLabPos[0] & "," & $aLabPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd

	Clickp($aTopLeftClient, 2, 0, "#0207")

EndFunc   ;==>LocateLab
