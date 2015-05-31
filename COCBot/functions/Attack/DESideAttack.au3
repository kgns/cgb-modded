Func GetDEEdge() ;Using $DESLoc x y we are finding which side de is located.
   DExy()
   If $DESLoc = 1 Then
	  If ($DESLocx = 430) And  ($DESLocy = 313) Then
		 SetLog ("DE Storage Located in Middle... Attacking Random Side", $COLOR_BLUE)
		 $DEEdge = (Random(Round(0,3)))
	  ElseIf ($DESLocx >= 430) And  ($DESLocy >= 313) Then
		 SetLog ("DE Storage Located Bottom Right... Attacking Bottom Right", $COLOR_BLUE)
		 $DEEdge = 0
	  ElseIf ($DESLocx > 430) And  ($DESLocy < 313) Then
		 SetLog ("DE Storage Located Top Right... Attacking Top Right", $COLOR_BLUE)
		 $DEEdge = 3
	  ElseIf ($DESLocx <= 430) And  ($DESLocy <= 313) Then
		 SetLog ("DE Storage Located Top Left... Attacking Top Left", $COLOR_BLUE)
		 $DEEdge = 1
	  ElseIf ($DESLocx < 430) And  ($DESLocy > 313) Then
		 SetLog ("DE Storage Located Bottom Left... Attacking Bottom Left", $COLOR_BLUE)
		 $DEEdge = 2
	  EndIf
   ElseIf $DESLoc = 0 Then
	  SetLog ("DE Storage Not Located... Attacking Random Side", $COLOR_BLUE)
	  $DEEdge = (Random(Round(0,3)))
   EndIf
EndFunc   ;==>GetDEEdge

Func DExy()
	   _WinAPI_DeleteObject($hBitmapFirst)
		$hBitmapFirst = _CaptureRegion2(230, 170, 630, 440)
		;SetLog("BitmapFirst done")

		$DESTOLoc = GetLocationDarkElixirStorage()

		;SetLog("Dll Return False location")
		If (UBound($DESTOLoc) > 1) Then
			Local $centerPixel[2] = [430, 313]
			Local $arrPixelCloser = _FindPixelCloser($DESTOLoc, $centerPixel, 1)
			$pixel = $arrPixelCloser[0]
		ElseIf (UBound($DESTOLoc) > 0) Then
			$pixel = $DESTOLoc[0]
		Else
			$pixel = -1
		EndIf
		If $pixel = -1 Then
			$DESLoc = 0
			SetLog(" == DE Storage Not Found ==")
		Else
			$pixel[0] += 230 ; compensate CaptureRegion reduction
			$pixel[1] += 170 ; compensate CaptureRegion reduction
			SetLog("== DE lixir Storage : [" & $pixel[0] & "," & $pixel[1] & "] ==", $COLOR_BLUE)
			If _Sleep(1000) Then Return False
			$DESLocx = $pixel[0] ; compensation for $x center of Storage
			$DESLocy = $pixel[1] ; compensation for $y center of Storage
			$DESLoc = 1
		 EndIf
EndFunc

Func checkDESideResources()
		If $MeetDESDark = 1 Then
			If (Number($searchDark)) < (Number($DESDark)) Then Return False
		EndIf
		If $MeetDESTrophy = 1 Then
			If (Number($searchTrophy)) < (Number($searchTrophy)) Then Return False
		EndIf
		If $MeetDESGPE = 1 Then
			If ((Number($searchGold)) + (Number($searchElixir))) < (Number($DESGPE)) Then Return False
		EndIf
		If $DESTH > 0 Then
			If $searchTH = "-" Then $searchTH = checkTownhall()
			If $searchTH = "-" Then $searchTH = checkTownhallADV()
			If $searchTH <> "-" Then
				If (Number($searchTH)) > ((Number($DESTH))+5) Then Return False
			Else
				Return False
			EndIf
		EndIf
		If ($iDEMortar > 0) Or ($iDEWizTower > 0) Then
			_WinAPI_DeleteObject($hBitmapFirst)
			$hBitmapFirst = _CaptureRegion2()
			Local $resultHere = DllCall($LibDir & "\CGBfunctions.dll", "str", "CheckConditionForWeakBase", "ptr", $hBitmapFirst, "int", ($iDEMortar + 1), "int", ($iDEWizTower + 1), "int", 10)
			If $resultHere[0] = "N" Then Return False
	EndIf
	Return True
EndFunc

Func DERedDropSave()
	$SaveRedArea = $chkRedArea
	$chkRedArea = 0
EndFunc

Func DERedDropRevert()
	$chkRedArea = $SaveRedArea
 EndFunc

 Func DELow()
    Local $Dark2 = ""
	Local $Dchk = 0
	While $Dark2 = ""
		 $Dark2 = getDarkElixir(51, 66 + 57)
		 $Dchk += 1
		 If _Sleep(50) Then Return
		 If $Dchk >= 20 Then
			$Dark2 = 500
			SetLog ("Can't find De", $COLOR_RED)
		 EndIf
   WEnd
   If  ($Dark2 < ($searchDark * 0.15)) Then
	  $Dark2 = getDarkElixir(51, 66 + 57)
	  If _Sleep(50) Then Return
	  If  ($Dark2 < ($searchDark * 0.15)) Then
		 $Dark2 = getDarkElixir(51, 66 + 57)
		 If _Sleep(50) Then Return
		 If  ($Dark2 < ($searchDark * 0.15)) Then
			$Dark2 = getDarkElixir(51, 66 + 57)
			If _Sleep(50) Then Return
			If  ($Dark2 < ($searchDark * 0.15)) Then
			   _CaptureRegion()
			   If _ColorCheck(_GetPixelColor(746,498), Hex(0xc8cac7, 6), 20)=True Then
				  SetLog("Low de. De = ( " & $Dark2 & " ) Return to protect Royals.  Returning immediately", $COLOR_GREEN)
				  $DarkLow = 1
			   Else
				  If _Sleep(1000) Then Return
				  SetLog("Low de. ( " & $Dark2 & " ) Waiting for 1 star", $COLOR_GREEN)
				  $DarkLow = 2
			   EndIf
			EndIf
		 EndIf
	  EndIf
   Else
	  $DarkLow = 0
   EndIf
EndFunc ;==>DELow
