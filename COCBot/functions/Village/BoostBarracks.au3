;==>BoostBarracks
Func BoostBarracks()
   If (GUICtrlRead($cmbBoostBarracks) > 0) And ($boostsEnabled = 1)  Then
	  If $barrackPos[0] = "" Then
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	  EndIf
	  While 1
		 SetLog("Boosting Barracks", $COLOR_BLUE)


			   Click(1, 1)
				 If _Sleep(1000) Then ExitLoop
				 Click($barrackPos[0], $barrackPos[1])
				 If _Sleep(1000) Then ExitLoop
				 _CaptureRegion()
				 $Boost = _PixelSearch(410, 603, 493, 621, Hex(0xfffd70, 6), 10)
				 If IsArray($Boost) Then
					Click($Boost[0], $Boost[1])
					 If _Sleep(1000) Then Return
					 _CaptureRegion()
					 If _ColorCheck(_GetPixelColor(420, 375), Hex(0xd2ec78, 6), 20) Then
						 Click(420, 375)
						 If _Sleep(2000) Then Return
							_CaptureRegion()
						   If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
							  _GUICtrlComboBox_SetCurSel($cmbBoostBarracks, 0)
							  SetLog("Not enough gems", $COLOR_RED)
						   Else
							  _GUICtrlComboBox_SetCurSel($cmbBoostBarracks, (GUICtrlRead($cmbBoostBarracks)-1))
							  SetLog('Boost completed. Remaining :' & (GUICtrlRead($cmbBoostBarracks)), $COLOR_GREEN)
						   EndIf
					 Else
						 SetLog("Barracks are already Boosted", $COLOR_RED)
					 EndIf
					 If _Sleep(500) Then ExitLoop
					 Click(1, 1)
				 Else
					 SetLog("Barracks are already Boosted", $COLOR_RED)
					 If _Sleep(1000) Then Return
				 EndIf

		ExitLoop
	  WEnd
   EndIf


EndFunc ;==>BoostBarracks


Func BoostSpellFactory()

If (GUICtrlRead($cmbBoostSpellFactory ) > 0) And ($boostsEnabled = 1)  Then
	  If $barrackPos[0] = "" Then
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
      EndIf
          SetLog("Boost Spell Factory...", $COLOR_BLUE)
  		 If $SFPos[0] = -1 Then
  			LocateSpellFactory()
  			SaveConfig()
  		 Else
  			Click($SFPos[0], $SFPos[1])
  			   If _Sleep(600) Then Return
  			   _CaptureRegion()
  			   $Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
		   If IsArray($Boost) Then
				  Click($Boost[0], $Boost[1])
				  If _Sleep(1000) Then Return
				  _CaptureRegion()
			  If _ColorCheck(_GetPixelColor(420, 375), Hex(0xD0E978, 6), 20) Then
				  Click(420, 375)
				  If _Sleep(2000) Then Return
				  _CaptureRegion()
			     If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
				    _GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory , 0)
				    SetLog("Not enough gems", $COLOR_RED)
			     Else
				    _GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory , (GUICtrlRead($cmbBoostSpellFactory )-1))
				    SetLog('Boost completed. Remaining :' & (GUICtrlRead($cmbBoostSpellFactory )), $COLOR_GREEN)
			     EndIf
			  Else
			     SetLog("Factory is already Boosted", $COLOR_RED)
			  EndIf
			     If _Sleep(500) Then Return
			    Click(1, 1)
		   Else
			 SetLog("Factory is already Boosted", $COLOR_RED)
			 If _Sleep(1000) Then Return
		   EndIf
		EndIf
EndIf
EndFunc

Func BoostHeros()
	  If $ichkBoostKing = 1 Then;
			If $KingPos[0] = "" Then
				LocateKing()
				SaveConfig()
				If _Sleep(2000) Then Return
				Click(1, 1) ;Click Away
			EndIf
			SetLog("Boosting King...", $COLOR_BLUE)
			Click($KingPos[0], $KingPos[1]) ;Click King
			If _Sleep(500) Then Return
			_CaptureRegion()
			$Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
		   If IsArray($Boost) Then
				  Click($Boost[0], $Boost[1])
				  If _Sleep(1000) Then Return
				  _CaptureRegion()
			  If _ColorCheck(_GetPixelColor(420, 375), Hex(0xD0E978, 6), 20) Then
				  Click(420, 375)
				  If _Sleep(2000) Then Return
				  _CaptureRegion()
			     If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
				    SetLog("Not enough gems", $COLOR_RED)
			     Else
				    SetLog('Boost completed.', $COLOR_GREEN)
			     EndIf
			  Else
			     SetLog("King is already Boosted", $COLOR_RED)
			  EndIf
			     If _Sleep(500) Then Return
			    Click(1, 1)
		   Else
			 SetLog("King is already Boosted", $COLOR_RED)
			 If _Sleep(1000) Then Return
		   EndIf
	  EndIf

	  If $ichkBoostQueen = 1 Then
			If $QueenPos[0] = "" Then
				LocateQueen()
				SaveConfig()
				If _Sleep(2000) Then Return
				Click(1, 1) ;Click Away
			EndIf
			SetLog("Boosting Queen...", $COLOR_BLUE)
			Click($QueenPos[0], $QueenPos[1]) ;Click Queen
			If _Sleep(500) Then Return
			_CaptureRegion()
			$Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
		   If IsArray($Boost) Then
				  Click($Boost[0], $Boost[1])
				  If _Sleep(1000) Then Return
				  _CaptureRegion()
			  If _ColorCheck(_GetPixelColor(420, 375), Hex(0xD0E978, 6), 20) Then
				  Click(420, 375)
				  If _Sleep(2000) Then Return
				  _CaptureRegion()
			     If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
				    SetLog("Not enough gems", $COLOR_RED)
			     Else
				    SetLog('Boost completed.', $COLOR_GREEN)
			     EndIf
			  Else
			     SetLog("Queen is already Boosted", $COLOR_RED)
			  EndIf
			     If _Sleep(500) Then Return
			    Click(1, 1)
		   Else
			 SetLog("Queen is already Boosted", $COLOR_RED)
			 If _Sleep(1000) Then Return
		   EndIf
	  EndIf
EndFunc