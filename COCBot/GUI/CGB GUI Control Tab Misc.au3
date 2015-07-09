; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GkevinOD (2014)
; Modified ......: Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func cmbProfile()
	saveConfig()
	FileClose($hLogFileHandle)
	FileClose($hAttackLogFileHandle)
	Switch _GUICtrlComboBox_GetCurSel($cmbProfile)
		Case 0
			$sCurrProfile = "01"
		Case 1
			$sCurrProfile = "02"
		Case 2
			$sCurrProfile = "03"
		Case 3
			$sCurrProfile = "04"
		Case 4
			$sCurrProfile = "05"
		Case 5
			$sCurrProfile = "06"
	EndSwitch
;~ 	MsgBox($MB_SYSTEMMODAL, "", "Profile " & $sCurrProfile & " loaded successfully!")
	DirCreate($sProfilePath & "\" & $sCurrProfile)
	$sProfilePath = @ScriptDir & "\Profiles"
	If FileExists($sProfilePath & "\profile.ini") = 0 Then
		Local $hFile = FileOpen($sProfilePath & "\profile.ini",BitOR($FO_APPEND,$FO_CREATEPATH))
		FileWriteLine($hfile, "[general]")
		FileClose($hFile)
	EndIf
	IniWrite($sProfilePath & "\profile.ini", "general", "defaultprofile", $sCurrProfile)
	$config = $sProfilePath & "\" & $sCurrProfile & "\config.ini"
	$building = $sProfilePath & "\" & $sCurrProfile & "\building.ini"
	$dirLogs = $sProfilePath & "\" & $sCurrProfile & "\Logs\"
	$dirLoots = $sProfilePath & "\" & $sCurrProfile & "\Loots\"
	$dirTemp = $sProfilePath & "\" & $sCurrProfile & "\Temp\"
	DirCreate($dirLogs)
	DirCreate($dirLoots)
	DirCreate($dirTemp)
	readConfig()
	applyConfig()
	saveConfig()
	SetLog(_PadStringCenter("Profile " & $sCurrProfile & " loaded from " & $config, 50, "="), $COLOR_GREEN)
EndFunc   ;==>cmbProfile

Func txtVillageName()
	$iVillageName = GUICtrlRead($txtVillageName)
	If $iVillageName = "" Then $iVillageName = "MyVillage"
	GUICtrlSetData($grpVillage, "Village: " & $iVillageName)
	GUICtrlSetData($OrigPushB, $iVillageName)
	GUICtrlSetData($txtVillageName, $iVillageName)

EndFunc   ;==>txtVillageName

Func btnLocateBarracks()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateBarracks

Func btnLocateArmyCamp()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack(True)
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateArmyCamp

Func btnLocateClanCastle()
	$RunState = True
	While 1
		ZoomOut()
		LocateClanCastle()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateClanCastle

Func btnLocateSpellfactory()
	$RunState = True
	While 1
		ZoomOut()
		LocateSpellFactory()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateSpellfactory

Func btnLocateTownHall()
	$RunState = True
	While 1
		ZoomOut()
		LocateTownHall()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateTownHall

Func cmbBotCond()
	If _GUICtrlComboBox_GetCurSel($cmbBotCond) = 13 Then
		If _GUICtrlComboBox_GetCurSel($cmbHoursStop) = 0 Then _GUICtrlComboBox_SetCurSel($cmbHoursStop, 1)
		GUICtrlSetState($cmbHoursStop, $GUI_ENABLE)
	Else
		_GUICtrlComboBox_SetCurSel($cmbHoursStop, 0)
		GUICtrlSetState($cmbHoursStop, $GUI_DISABLE)
	EndIf
EndFunc   ;==>cmbBotCond

Func chkTrap()
	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		$ichkTrap = 1
		GUICtrlSetState($btnLocateTownHall, $GUI_SHOW)
	Else
		$ichkTrap = 0
		GUICtrlSetState($btnLocateTownHall, $GUI_HIDE)
	EndIf
EndFunc   ;==>chkTrap

Func sldVSDelay()
	$iVSDelay = GUICtrlRead($sldVSDelay)
	GUICtrlSetData($lblVSDelay, $iVSDelay)

	If $iVSDelay = 1 Then
		GUICtrlSetData($lbltxtVSDelay, "second")
	Else
		GUICtrlSetData($lbltxtVSDelay, "seconds")
	EndIf
EndFunc   ;==>sldVSDelay

Func btnLab()
	$RunState = True
	While 1
		ZoomOut()
		LocateLab()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLab
