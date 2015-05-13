
 Func CheckZoomOut()
					 _CaptureRegion()
					 If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then
						   SetLog("Not Zoomed Out! Exiting to MainScreen...", $COLOR_RED)
						   checkMainScreen() ;exit battle screen
						   $Restart = True
						   Return False
						Else
						   Return True
						EndIf
EndFunc