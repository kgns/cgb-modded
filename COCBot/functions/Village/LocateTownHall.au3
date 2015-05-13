; Locates TownHall for Rearm Function

Func LocateTownHall()
   If $ichkTrap = 1 Then
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Townhall", "Click OK then click on your Townhall", 0, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$TownHallPos[0] = FindPos()[0]
			$TownHallPos[1] = FindPos()[1]
			SetLog("-Townhall =  " & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
	Click(1, 1)
	EndIf
EndFunc   ;==>LocateTownHall