;Returns color of pixel in the coordinations

Func _GetPixelColor($iX, $iY, $isCapture = false)
	If not $isCapture Then
		$aPixelColor = _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
	Else
		_CaptureRegion($iX - 1, $iY - 1, $iX+1, $iY+1)
		$aPixelColor = _GDIPlus_BitmapGetPixel($hBitmap, 1, 1)
	EndIf
	Return Hex($aPixelColor, 6)
EndFunc   ;==>_GetPixelColor