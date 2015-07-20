; #FUNCTION# ====================================================================================================================
; Name ..........: ZoomOut
; Description ...: Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.
; Syntax ........: ZoomOut()
; Parameters ....:
; Return values .: None
; Author ........: Code Gorilla #94
; Modified ......: KnowJack (July 2015) stop endless loop
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func ZoomOut() ;Zooms out
	Local $i = 0
	_CaptureRegion(0, 0, 860, 2)
	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1]) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1]) <> Hex($aTopRightClient[2], 6) Then
		If _Sleep(1500) Then Return
		SetLog("Zooming Out", $COLOR_BLUE)
		While _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1]) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1]) <> Hex($aTopRightClient[2], 6)
			If $debugsetlog = 1 Then Setlog("Index = "&$i, $COLOR_PURPLE) ; Index=2X loop count if success, will be odd value or increment by 1 if controlsend fail
			If _Sleep(200) Then Return
			If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
			If $i > 20 Then
				If _Sleep(1000) Then Return
			EndIf
			If $i > 80 Then Return
			If IsProblemAffect(True) Then  ; added to catch errors during Zoomout
				Setlog("BS Error window detected", $COLOR_RED)
				If checkObstacles() = True Then Setlog("Error window cleared, continue Zoom out", $COLOR_BLUE)  ; call to clear normal errors
			EndIf
			$i += 1  ; add one to index value to prevent endless loop if controlsend fails
			_CaptureRegion(0, 0, 860, 2)
		WEnd
	EndIf
EndFunc   ;==>ZoomOut
