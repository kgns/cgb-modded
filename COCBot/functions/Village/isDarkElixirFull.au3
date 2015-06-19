;Checks if your Dark Elixir Storages are maxed out

Func isDarkElixirFull()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(707, 132), Hex(0x000000, 6), 6) Then ;Hex is black
		If _ColorCheck(_GetPixelColor(709, 132), Hex(0x190026, 6), 6) Then ;Hex if color of darkk elixir (close to black)
			SetLog("Dark Elixir Storages are full!", $COLOR_GREEN)
			Return True
		EndIf
	EndIf

	Return False
EndFunc   ;==>isDarkElixirFull++