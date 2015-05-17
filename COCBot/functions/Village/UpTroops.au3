#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         summoner

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

Func GetUpLaboratoryPos()
	Switch _GUICtrlComboBox_GetCurSel($cmbLaboratory)
	Case 0
		Click($UpBar2X, $UpBar2Y)
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(132, 362), Hex(0x303030, 6), 20) Then
			SetLog("Level troops "&GUICtrlRead($cmbLaboratory)&" is already max in your laboratory, skip upgrading...", $COLOR_RED)
			If _Sleep(1000) Then Return
			ClickP($TopLeftClient, 2)
			GUICtrlSetState($chkLab, $GUI_UNCHECKED)
		EndIf
	Case 1
		Click($UpArchX, $UpArchY)
	Case 2
		Click($GiantsX, $GiantsY)
	Case 3
		Click($GoblinsX, $GoblinsY)
	Case 4
		Click($BalloonX, $BalloonY)
	Case 5
		Click($WBreakerX, $WBreakerY)
	Case 6
		Click($WizardX, $WizardY)
	Case 7
		Click($UpHealX, $UpHealY)
	Case 8
		Click($UpDragonX, $UpDragonY)
	Case 9
		Click($UpPekkaX, $UpPekkaY)
	Case 10
		Click($SpellLightningX, $SpellLightningY)
	Case 11
		Click($SpellHealX, $SpellHealY)
	Case 12
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(270, 370) ; rage
	Case 13
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(270, 470) ; jump
	Case 14
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(370, 370) ; freeze
	Case 15
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(370, 470) ; minion
	Case 16
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(470, 370) ; hog
	Case 17
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(470, 470) ; valkrye
	Case 18
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(570, 370); golem
	Case 19
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(570, 470) ; witch
	Case 20
		_PostMessage_ClickDrag(552, 464, 3, 492, "left", 2000)
		Sleep(1000)
		Click(670, 370) ; lava
	Case 21
		GUICtrlSetState($chkLab, $GUI_UNCHECKED)
	
	EndSwitch
EndFunc   ;==>GetUpTroopsPos

Func Laboratory()
	If GUICtrlRead($chkLab) <> $GUI_CHECKED Then
		SetLog("Upgrade Laboratory option disabled, skipping upgrading", $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf
	If GUICtrlRead($txtLabX) = "" And GUICtrlRead($txtLabY) = "" Then
		SetLog("Building location not set, skipping upgrade...", $COLOR_RED)
		ClickP($TopLeftClient) ; Click Away
		Return
	EndIf
	Click(GUICtrlRead($txtLabX), GUICtrlRead($txtLabY));Click Laboratory
	If _Sleep(1000) Then Return
	SetLog("Searching for Troops "&GUICtrlRead($cmbLaboratory)&"...", $COLOR_BLUE)
	Click(527, 597) ; Click Button Research
	If _Sleep(1000) Then Return
	GetUpLaboratoryPos() ; Click Troops
	SetLog("Troops "&GUICtrlRead($cmbLaboratory)&" found...", $COLOR_GREEN)
	If _Sleep(1000) Then Return
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(535, 506), Hex(0x868686, 6), 20) or  _ColorCheck(_GetPixelColor(580, 511), Hex(0x848484, 6), 20)  Then
		SetLog("Upgrade in progress, wait for upgrading troops "&GUICtrlRead($cmbLaboratory)&" after completion other troops upgraded", $COLOR_RED)
		If _Sleep(1000) Then Return
		ClickP($TopLeftClient, 2)
	Else
		If _ColorCheck(_GetPixelColor(558, 489), Hex(0xE70A12, 6), 20) or  _ColorCheck(_GetPixelColor(558, 489), Hex(0xE70A12, 6), 20)  Then
			SetLog("Not enough Elixir to upgrade troops "&GUICtrlRead($cmbLaboratory)&"...", $COLOR_RED)
			If $pEnabled = 1 AND $pLabUpgrade = 1 Then _Push($iPBVillageName & " :" & GUICtrlRead($cmbLaboratory) & " upgrade failed to start", "Not enough Elixir to upgrade troops "&GUICtrlRead($cmbLaboratory))
			If _Sleep(1000) Then Return
			ClickP($TopLeftClient, 2)
		Else
			If _ColorCheck(_GetPixelColor(558, 489), Hex(0xE70A12, 6), 20) And  _ColorCheck(_GetPixelColor(577, 498), Hex(0x2A2A2A, 6), 20)  Then
				SetLog("Not enough Dark Elixir to upgrade troops "&GUICtrlRead($cmbLaboratory)&"...", $COLOR_RED)
				If $pEnabled = 1 AND $pLabUpgrade = 1 Then _Push($iPBVillageName & " :" & GUICtrlRead($cmbLaboratory) & " upgrade failed to start", "Not enough Dark Elixir to upgrade troops "&GUICtrlRead($cmbLaboratory))
				If _Sleep(1000) Then Return
				ClickP($TopLeftClient, 2)
			Else
				If _ColorCheck(_GetPixelColor(558, 489), Hex(0xFFFFFF, 6), 20) = True Then
					Click(558, 489) ; Click Upgrade troops
					SetLog("Upgrade troops" &  GUICtrlRead($cmbLaboratory) &" in your laboratory has been done...", $COLOR_GREEN)
					If $pEnabled = 1 AND $pLabUpgrade = 1 Then _Push($iPBVillageName & " :" & GUICtrlRead($cmbLaboratory) & " upgrade has started", "")
					If _Sleep(1000) Then Return
					GUICtrlSetState($chkLab, $GUI_UNCHECKED)
				EndIf
				ClickP($TopLeftClient, 2)
			EndIf
		EndIf
	EndIf
EndFunc

