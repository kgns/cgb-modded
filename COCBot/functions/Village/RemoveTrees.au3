Func RemoveTrees()
	If GUICtrlRead($chkTrees) = $GUI_CHECKED Then
		If $FreeBuilder > 0 Then
			SetLog("Checking for Trees", $COLOR_GREEN)
			Click(1, 1) ; click away
			CheckTrees()
			If $TreeLoc = 1 Then
				Click($TreeX, $TreeY)
				If _Sleep(600) Then Return
				Click(430,600); Click Remove
				Click(1, 1) ; click away
			EndIf
		Else
			SetLog("No free builder, Remove Trees skipped..", $COLOR_RED)
		EndIf
	EndIf
EndFunc   ;==>RemoveTrees