;Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.
;Only does it for 20 zoom outs, no more than that.

Func ZoomOut() ;Zooms out
	Local $i = 0
	_CaptureRegion(0, 0, 860, 2)
	If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then SetLog("Zooming Out", $COLOR_BLUE)
	While _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6)
		If _Sleep(200) Then Return
		If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
		If $i > 20 Then
			If _Sleep(1000) Then Return
		EndIf
		If $i = 40 Then Return
		_CaptureRegion(0, 0, 860, 2)
	WEnd
EndFunc   ;==>ZoomOut
