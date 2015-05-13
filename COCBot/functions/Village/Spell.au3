
	Func CreateSpell()
If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
SetLog("Creating Spells...")
		 If $SFPos[0] = -1 Then
			LocateSpellFactory()
			SaveConfig()
			  Else
               Click($SFPos[0], $SFPos[1])
					 If _Sleep(600) Then Return
					  _CaptureRegion()
					  If _Sleep(600) Then Return
			     If _ColorCheck(_GetPixelColor(555, 616), Hex(0xFFFFFF, 6), 20) Or _
					_ColorCheck(_GetPixelColor(555, 616), Hex(0x838669, 6), 20)  Then
						SetLog("Create Lighning Spell", $COLOR_BLUE)
						Click(566,599) ;click create spell
						 If _Sleep(1000) Then Return
							     _CaptureRegion()
								 If _Sleep(600) Then Return
						   If  _ColorCheck(_GetPixelColor(237, 354), Hex(0xFFFFFF, 6), 20) = False Then
							  setlog("Not enoug Elixir to create Spell", $COLOR_RED)
						       Elseif  _ColorCheck(_GetPixelColor(200, 346), Hex(0x1A1A1A, 6), 20) Then
							   setlog("Spell Factory Full", $COLOR_RED)
						     Else
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
						   EndIf
					     Else
						   setlog("Spell Factory is not available, Skip Create", $COLOR_RED)

			    EndIf
	   EndIf
        If _Sleep(250) Then Return
		Click(1, 1)
		If _Sleep(250) Then Return
 EndIf
EndFunc

 ;CreateSpell

;~ Func BoostFactSpell()
;~
;~  	If GUICtrlRead($chkBoostFactSpell) = $GUI_CHECKED Then
;~          SetLog("Boost Spell Factory...")
;~  		 If $SFPos[0] = -1 Then
;~  			LocateSpellFactory()
;~  			SaveConfig()
;~  		 Else
;~  			Click($SFPos[0], $SFPos[1])
;~  			   If _Sleep(600) Then Return
;~  			   _CaptureRegion()
;~  			   $Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
;~  			   If IsArray($Boost) Then
;~  					Click($Boost[0], $Boost[1])
;~  					 If _Sleep(1000) Then Return
;~  			       _CaptureRegion()
;~  			     If _ColorCheck(_GetPixelColor(420, 375), Hex(0xD0E978, 6), 20) Then
;~  			       Click(420, 375)
;~  					 If _Sleep(2000) Then Return
;~  			       _CaptureRegion()
;~  			        If _ColorCheck(_GetPixelColor(586, 267), Hex(0xd80405, 6), 20) Then
;~  				      _GUICtrlComboBox_SetCurSel($cmbBoostFactSpell, 0)
;~  				      SetLog("Not enough gems", $COLOR_RED)
;~  			        Else
;~  			        _GUICtrlComboBox_SetCurSel($cmbBoostFactSpell, (GUICtrlRead($cmbBoostFactSpell)-1))
;~  				    SetLog('Boost completed. Remaining :' & (GUICtrlRead($cmbBoostFactSpell)), $COLOR_GREEN)
;~  			        EndIf
;~  			     Else
;~  					 SetLog("Factory is already Boosted", $COLOR_RED)
;~  			     EndIf
;~  					 If _Sleep(500) Then ExitLoop
;~  					 Click(1, 1)
;~  			   Else
;~  					 SetLog("Factory is already Boosted", $COLOR_RED)
;~  					 If _Sleep(1000) Then Return
;~  			   EndIf
;~          EndIf
;~     EndIf
;~EndFunc