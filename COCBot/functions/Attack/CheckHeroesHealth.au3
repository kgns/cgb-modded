Func CheckHeroesHealth()
	If $checkKPower Then
		If _ColorCheck(_GetPixelColor(68 + (72 * $King), 555, True), Hex(0x00B4A0, 6), 10, "Red") Then
			SetLog("King is getting weak, Activating King's power", $COLOR_BLUE)
			SelectDropTroop($King)
			$checkKPower = False
		EndIf
	EndIf
	If $checkQPower Then
		If _ColorCheck(_GetPixelColor(68 + (72 * $Queen), 555, True), Hex(0x007E1E, 6), 15, "Red") Then
			SetLog("Queen is getting weak, Activating Queen's power", $COLOR_BLUE)
			SelectDropTroop($Queen)
			$checkQPower = False
		EndIf
	EndIf
EndFunc   ;==>CheckHeroesHealth
