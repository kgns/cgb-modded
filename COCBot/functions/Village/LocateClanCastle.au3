;Locates Clan Castle manually (Temporary)

Func LocateClanCastle()
	$MsgBox = MsgBox(1 + 262144, "Locate Clan Castle", "Click OK then click on your Clan Castle", 0, $frmBot)
	If $MsgBox = 1 Then
		$aCCPos[0] = FindPos()[0]
		$aCCPos[1] = FindPos()[1]
		SetLog("Clan Castle: " & "(" & $aCCPos[0] & "," & $aCCPos[1] & ")")
	EndIf
EndFunc   ;==>LocateClanCastle
