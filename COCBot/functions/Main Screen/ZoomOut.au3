; #FUNCTION# ====================================================================================================================
; Name ..........: ZoomOut
; Description ...: Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.
;							Only does it for 20 zoom outs, no more than that.
; Syntax ........: ZoomOut()
; Parameters ....:
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func ZoomOut() ;Zooms out
	Local $i = 0
	_CaptureRegion(0, 0, 860, 2)
	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1]) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1]) <> Hex($aTopRightClient[2], 6) Then SetLog("Zooming Out", $COLOR_BLUE)
	While _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1]) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1]) <> Hex($aTopRightClient[2], 6)
		If _Sleep(200) Then Return
		If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
		If $i > 20 Then
			If _Sleep(1000) Then Return
		EndIf
		If $i = 40 Then Return
		_CaptureRegion(0, 0, 860, 2)
	WEnd
EndFunc   ;==>ZoomOut
