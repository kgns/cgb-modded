Func LocateUpgrade1()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 1", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos1[0] = FindPos()[0]
			$BuildPos1[1] = FindPos()[1]
			SetLog("-Building 1 =  " & "(" & $BuildPos1[0] & "," & $BuildPos1[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX1, $BuildPos1[0])
			GUICtrlSetData($txtUpgradeY1, $BuildPos1[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade1

Func LocateUpgrade2()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 2", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos2[0] = FindPos()[0]
			$BuildPos2[1] = FindPos()[1]
			SetLog("-Building 2 =  " & "(" & $BuildPos2[0] & "," & $BuildPos2[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX2, $BuildPos2[0])
			GUICtrlSetData($txtUpgradeY2, $BuildPos2[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade2

Func LocateUpgrade3()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 3", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos3[0] = FindPos()[0]
			$BuildPos3[1] = FindPos()[1]
			SetLog("-Building 3 =  " & "(" & $BuildPos3[0] & "," & $BuildPos3[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX3, $BuildPos3[0])
			GUICtrlSetData($txtUpgradeY3, $BuildPos3[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade3

Func LocateUpgrade4()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Upgrade Building 4", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$BuildPos4[0] = FindPos()[0]
			$BuildPos4[1] = FindPos()[1]
			SetLog("-Building 4 =  " & "(" & $BuildPos4[0] & "," & $BuildPos4[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtUpgradeX4, $BuildPos4[0])
			GUICtrlSetData($txtUpgradeY4, $BuildPos4[1])
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateUpgrade4

Func LocateLab()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Laboratory", "Click OK then click on your Building", 0, $frmBot)
		If $MsgBox = 1 Then
			$LabPos[0] = FindPos()[0]
			$LabPos[1] = FindPos()[1]
			SetLog("-Locate Laboratory =  " & "(" & $LabPos[0] & "," & $LabPos[1] & ")", $COLOR_GREEN)
			GUICtrlSetData($txtLabX, $LabPos[0])
			GUICtrlSetData($txtLabY, $LabPos[1])
		EndIf
		ExitLoop
	WEnd
EndFunc