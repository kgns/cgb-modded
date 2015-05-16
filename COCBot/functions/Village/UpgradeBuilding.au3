Func UpgradeBuilding()

  If $ichkUpgrade1 = 0 And $ichkUpgrade2 = 0 And $ichkUpgrade3 = 0 And $ichkUpgrade4 = 0 Then Return

  If GUICtrlRead($txtUpgradeX1) = "" And GUICtrlRead($txtUpgradeX2) = "" And GUICtrlRead($txtUpgradeX3) = "" And GUICtrlRead($txtUpgradeX4) = "" Then
        SetLog("Building location not set, skipping upgrade...", $COLOR_RED)
        ClickP($TopLeftClient) ; Click Away
        Return
  EndIf

  VillageReport()
  If $FreeBuilder = 0 Then
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
  Local $iMinDark = Number(GUICtrlRead($txtBuildMinDElixir))
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
                  $Type_Resource = 1
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
                        If _Sleep(1000) Then Return
                        ClickP($TopLeftClient, 2)
                        GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                     EndIf
                  EndIf
               EndIf

               If _ColorCheck(_GetPixelColor(491, 479), Hex(0xE050D8, 6), 30) Then ; ELIXIR ON BUTTON
                  $Type_Resource = 1
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
                        If _Sleep(1000) Then Return
                        ClickP($TopLeftClient, 2)
                        GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                     EndIf
                  EndIf
               EndIf

               If _ColorCheck(_GetPixelColor(579, 482), Hex(0x261A2C, 6), 30) Then ; DARK ELIXIR ON BUTTON
                  $Type_Resource = 1
                  SetLog("Upgrade using Dark Elixir(HEROES)...")
                  SetLog("Dark Storage: "&$iDarkStorage&" Dark Min: "&$iMinDark)
                  If $iDarkStorage < $iMinDElixir Then
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
                        If _Sleep(1000) Then Return
                        ClickP($TopLeftClient, 2)
                        GUICtrlSetState($chkUpgrade1, $GUI_UNCHECKED)
                     EndIf
                  EndIf
               EndIf

               If $Type_Resource = 0 Then
                  SetLog("Not found Gold/Elixir/Dark Elixir on button...", $COLOR_RED)
                  ClickP($TopLeftClient, 2)
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
            If $FreeBuilder = 0 Then
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
