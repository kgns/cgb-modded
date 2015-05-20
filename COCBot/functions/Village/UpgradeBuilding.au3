Func UpgradeBuilding()
  If $ichkUpgrade1 = 0 And $ichkUpgrade2 = 0 And $ichkUpgrade3 = 0 And $ichkUpgrade4 = 0 Then Return
  If GUICtrlRead($txtUpgradeX1) = "" And GUICtrlRead($txtUpgradeX2) = "" And GUICtrlRead($txtUpgradeX3) = "" And GUICtrlRead($txtUpgradeX4) = "" Then
        SetLog("Building location not set, skipping upgrade...", $COLOR_RED)
        ClickP($TopLeftClient) ; Click Away
        Return
  EndIf
  VillageReport()
  If $FreeBuilder <= $itxtBuilderKeepFree Then
      SetLog("No builders available", $COLOR_RED)
      ClickP($TopLeftClient) ; Click Away
      Return
  EndIf

  Local $ElixirUpgrade1 = False
  Local $ElixirUpgrade2 = False
  Local $ElixirUpgrade3 = False

  Local $ElixirUpgrade4 = False
  Local $iMinGold = Number(GUICtrlRead($txtBuildMinGold))
  Local $iMinElixir = Number(GUICtrlRead($txtBuildMinElixir))
  Local $iMinDark = Number(GUICtrlRead($txtBuildMinDark))
  Local $iGoldStorage = Number($GoldCount)
  Local $iElixirStorage = Number($ElixirCount)
  Local $iDarkStorage = Number($DarkCount)

  Local $ichkUpgrade[5] = [0,$ichkUpgrade1,$ichkUpgrade2,$ichkUpgrade3,$ichkUpgrade4]
  Local $txtUpgradeXY[5][2] = [[0,0],[GUICtrlRead($txtUpgradeX1),GUICtrlRead($txtUpgradeY1)],[GUICtrlRead($txtUpgradeX2),GUICtrlRead($txtUpgradeY2)],[GUICtrlRead($txtUpgradeX3),GUICtrlRead($txtUpgradeY3)],[GUICtrlRead($txtUpgradeX4),GUICtrlRead($txtUpgradeY4)]]


  For $i = 1 to 4 step 1
      If $iElixirStorage < $iMinElixir And $iGoldStorage < $iMinGold And $iDarkStorage < $iMinDark Then
         SetLog("Gold Storage: "&$iGoldStorage&" Gold Min: "&$iMinGold)
         SetLog("Elixir Storage: "&$iElixirStorage&" Elixir Min: "&$iMinElixir)
         SetLog("Dark Storage: "&$iDarkStorage&" Dark Min: "&$iMinDark)
         Return
      EndIf

      Local $Type_Resource = 0

      If $ichkUpgrade[$i] = 1 Then

         If Not ($txtUpgradeXY[$i][0] Or $txtUpgradeXY[$i][1]) Then
            SetLog("Building "&$i&" not located")
            Return
         EndIf

         SetLog("Attempting to upgrade Building "&$i&"...")
         If _Sleep(500) Then Return
         Click($txtUpgradeXY[$i][0],$txtUpgradeXY[$i][1]) ; Click on building
         If _Sleep(500) Then Return

         Local $x1 = 290, $y1 = 575, $x2 = 629, $y2 = 615 ;Coordinates for button search
         Local $offColors[2][3] = [[0xE0D4D0, 32, 9], [0xB35533, 36, 16]];, [0x2B2D1F, 76, 0]] ; 2nd pixel brown wrench, 3rd pixel GREY, 4th pixel edge of button
         Local $UpgradeButton = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF2F6F5, 6), $offColors, 20) ; first white pixel of button

         If IsArray($UpgradeButton) = True Then ; if find upgrade button
            Click($UpgradeButton[0], $UpgradeButton[1]) ;Click Upgrade Button
            If _Sleep(1000) Then Return
            Local $UpgradeCheck = _PixelSearch(300, 463, 673, 522, Hex(0xB9E051, 6), 10) ;Confirm Upgrade
            If IsArray($UpgradeCheck) = True Then ;if find green upgrade button
               If _Sleep(1000) Then Return
               _CaptureRegion()

               If _ColorCheck(_GetPixelColor(491, 479), Hex(0xF8EF5F, 6), 30) Then ; GOLD ON BUTTON
                  SetLog("Upgrade using Gold...")
                  SetLog("Gold Storage: "&$iGoldStorage&" Gold Min: "&$iMinGold)
                  If $iGoldStorage < $iMinGold Then
                     SetLog("Gold is below the minimum, skip upgrading...", $COLOR_RED)
                     ClickP($TopLeftClient, 2)
                  Else
                     Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
                     If _Sleep(1000) Then Return
                     _CaptureRegion()
                     If _Sleep(1500) Then Return
                     If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
                        SetLog("Not enough Resoures to upgrade...", $COLOR_RED)
                        ClickP($TopLeftClient, 2)
                     Else
                        SetLog("Building "&$i&" successfully upgraded...", $COLOR_GREEN)
						$Type_Resource = 1
                        If _Sleep(1000) Then Return
                        ClickP($TopLeftClient, 2)
                        ;GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                     EndIf
                  EndIf
               EndIf

               If _ColorCheck(_GetPixelColor(491, 479), Hex(0xE050D8, 6), 30) Then ; ELIXIR ON BUTTON
                  SetLog("Upgrade using Elixir...")
                  SetLog("Elixir Storage: "&$iElixirStorage&" Elixir Min: "&$iMinElixir)
                  If $iElixirStorage < $iMinElixir Then
                     SetLog("Elixir is below the minimum, skip upgrading...", $COLOR_RED)
                     ClickP($TopLeftClient, 2)
                  Else
                     Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
                     If _Sleep(1000) Then Return
                     _CaptureRegion()
                     If _Sleep(1500) Then Return
                     If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then ;;;;;;;;;;;;;;;;;;;;;
                        SetLog("Not enough Resoures to upgrade...", $COLOR_RED)
                        ClickP($TopLeftClient, 2)
                     Else
                        SetLog("Building "&$i&" successfully upgraded...", $COLOR_GREEN)
						$Type_Resource = 1
                        If _Sleep(1000) Then Return
                        ClickP($TopLeftClient, 2)
                        ;GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                     EndIf
                  EndIf
               EndIf

               If _ColorCheck(_GetPixelColor(579, 482), Hex(0x261A2C, 6), 30) Then ; DARK ELIXIR ON BUTTON
                  SetLog("Upgrade using Dark Elixir(HEROES)...")
                  SetLog("Dark Storage: "&$iDarkStorage&" Dark Min: "&$iMinDark)
                  If $iDarkStorage < $iMinDark Then
                     SetLog("Dark is below the minimum, skip upgrading...", $COLOR_RED)
                     ClickP($TopLeftClient, 2)
                  Else
                     Click($UpgradeCheck[0], $UpgradeCheck[1]) ;Click Upgrade Button
                     If _Sleep(1000) Then Return
                     _CaptureRegion()
                     If _Sleep(1500) Then Return
                     If _ColorCheck(_GetPixelColor(571, 263), Hex(0xD90404, 6), 20) Then
                        SetLog("Not enough Resoures to upgrade...", $COLOR_RED)
                        ClickP($TopLeftClient, 2)
                     Else
                        SetLog("Building "&$i&" successfully upgraded...", $COLOR_GREEN)
						$Type_Resource = 1
                        If _Sleep(1000) Then Return
                        ClickP($TopLeftClient, 2)
                        ;GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                     EndIf
                  EndIf
               EndIf

               If $Type_Resource = 0 Then
                  SetLog("Not found Gold/Elixir/Dark Elixir on button...", $COLOR_RED)
                  ClickP($TopLeftClient, 2)
               ElseIf $Type_Resource = 1 Then
                  If $i = 1 Then
                     GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                  ElseIf $i = 2 Then
                     GUICtrlSetState($chkUpgrade2, $GUI_UNCHECKED)
                  ElseIf $i = 3 Then
                     GUICtrlSetState($chkUpgrade3, $GUI_UNCHECKED)
                  ElseIf $i = 4 Then
                     GUICtrlSetState($chkUpgrade4, $GUI_UNCHECKED)
                  EndIf
               EndIf

            Else
               SetLog("No upgrade available for this building..", $COLOR_RED) ; no find green upgrade button
            EndIf
         Else
            SetLog("Not found upgrade button..", $COLOR_RED) ; find upgrade button of building
            ClickP($TopLeftClient, 2)
         EndIf

         If $Type_Resource = 1 Then
            VillageReport()
            If _Sleep(1000) Then Return
            If $FreeBuilder <= $itxtBuilderKeepFree Then
              SetLog("No builders available", $COLOR_RED)
              ClickP($TopLeftClient) ; Click Away
              Return
            EndIf
            If _Sleep(1000) Then Return
            $iGoldStorage = Number($GoldCount)
            $iElixirStorage = Number($ElixirCount)
            $iDarkStorage = Number($DarkCount)
            If _Sleep(2000) Then Return
            ClickP($TopLeftClient, 2)
         EndIf
      EndIf
  Next
EndFunc

Func UpgradeHeroes()
	If $ichkUpgradeKing = 0 And $ichkUpgradeQueen = 0 Then Return

	VillageReport()
	If $FreeBuilder <2 Then
		SetLog("Only 1 builder (or) No Builders available, skip Heroes upgrade to enable Wall upgrade.", $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf
	
	;upgradequeen 
	If $ichkUpgradeQueen = 1 Then
		If $QueenPos[0] = "" Then
			LocateQueen()
			SaveConfig()
			If _Sleep(500) Then Return
			ClickP($TopLeftClient) ;Click Away
		EndIf
		SetLog("Attempting to upgrade Queen...")
		Click($QueenPos[0], $QueenPos[1]) ;Click Queen bed
		If _Sleep(500) Then Return
		_CaptureRegion()
		;If _ColorCheck(_GetPixelColor(603, 575), Hex(0x3E2F46, 6), 20) Then ;Finds DarkElixir Upgrade Button
		If _ColorCheck(_GetPixelColor(595, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
			SetLog("Not enough Dark Elixir to Upgrade Queen.", $COLOR_ORANGE)
			If _Sleep(1000) Then Return
			ClickP($TopLeftClient, 2)
		Else
			If _ColorCheck(_GetPixelColor(554, 570), Hex(0xC8EE6A, 6), 20) Then ; Green color
				SetLog("Queen is already upgrading.", $COLOR_ORANGE)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
			Else
				Click(604, 592) ;Click Upgrade Button
				If _Sleep(2000) Then Return
				Click(578, 512) ;Click Confirm Button
				If _Sleep(500) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(743, 152), Hex(0xE51016, 6), 20) Then ;red arrow
					SetLog("Your hero has reached max level to your TownHall.", $COLOR_RED)
					GUICtrlSetState($chkUpgradeQueen, $GUI_UNCHECKED)
					If _Sleep(500) Then Return
				Else
					SetLog("Queen is successfully upgraded...", $COLOR_BLUE)
					GUICtrlSetState($chkUpgradeQueen, $GUI_UNCHECKED)
					If _Sleep(1000) Then Return
					ClickP($TopLeftClient, 2)
				EndIf
			EndIf
		EndIf

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder <2 Then
			SetLog("Only 1 builder (or) No Builders available, skip Heroes upgrade to enable Wall upgrade.", $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iDarkStorage = Number($DarkCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf

	;upgradeking 
	If $ichkUpgradeKing = 1 Then
		If $KingPos[0] = "" Then
			LocateKing()
			SaveConfig()
			If _Sleep(500) Then Return
			ClickP($TopLeftClient) ;Click Away
		EndIf
		SetLog("Attempting to upgrade King...")
		Click($KingPos[0], $KingPos[1]) ;Click King bed
		If _Sleep(500) Then Return
		_CaptureRegion()
		;If _ColorCheck(_GetPixelColor(603, 575), Hex(0x3E2F46, 6), 20) Then ;Finds DarkElixir Upgrade Button
		If _ColorCheck(_GetPixelColor(595, 570), Hex(0xE70A12, 6), 20) Then ; Red numbers
			SetLog("Not enough Dark Elixir to Upgrade Queen.", $COLOR_ORANGE)
			If _Sleep(1000) Then Return
			ClickP($TopLeftClient, 2)
		Else
			If _ColorCheck(_GetPixelColor(554, 570), Hex(0xC8EE6A, 6), 20) Then ; Green color
				SetLog("King is already upgrading.", $COLOR_ORANGE)
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
			Else
				Click(604, 592) ;Click Upgrade Button
				If _Sleep(2000) Then Return
				Click(578, 512) ;Click Confirm Button
				If _Sleep(500) Then Return
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(743, 152), Hex(0xE51016, 6), 20) Then ;red arrow
					SetLog("Your hero has reached max level to your TownHall.", $COLOR_RED)
					GUICtrlSetState($chkUpgradeKing, $GUI_UNCHECKED)
					If _Sleep(500) Then Return
				Else
					SetLog("King is successfully upgraded...", $COLOR_BLUE)
					GUICtrlSetState($chkUpgradeKing, $GUI_UNCHECKED)
					If _Sleep(1000) Then Return
					ClickP($TopLeftClient, 2)
				EndIf
			EndIf
		EndIf

		VillageReport()
		If _Sleep(1000) Then Return
		If $FreeBuilder <2 Then
			SetLog("Only 1 builder (or) No Builders available, skip Heroes upgrade to enable Wall upgrade.", $COLOR_RED)
			ClickP($TopLeftClient) ; Click Away
			Return
		EndIf
		If _Sleep(1000) Then Return
		$iDarkStorage = Number($DarkCount)
		If _Sleep(2000) Then Return
		ClickP($TopLeftClient, 2)
	EndIf
EndFunc

Func LocateKing()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate King", "Click OK then click on your King bed.", 0, $frmBot)
		If $MsgBox = 1 Then
			$KingPos[0] = FindPos()[0]
			$KingPos[1] = FindPos()[1]
			SetLog("-King Bed=  " & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateKing

Func LocateQueen()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Queen", "Click OK then click on your Queen bed.", 0, $frmBot)
		If $MsgBox = 1 Then
			$QueenPos[0] = FindPos()[0]
			$QueenPos[1] = FindPos()[1]
			SetLog("-Queen Bed=  " & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateQueen
