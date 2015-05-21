Func GetLocationMine()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationMineExtractor", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationMine

Func GetLocationElixir()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationElixirExtractor", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationElixir

Func GetLocationDarkElixir()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationDarkElixirExtractor", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationDarkElixir

Func GetLocationDarkElixirStorage()
	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getLocationDarkElixirStorage", "ptr", $hBitmapFirst)
	Return GetListPixel($result[0])
EndFunc   ;==>GetLocationDarkElixirStorage
