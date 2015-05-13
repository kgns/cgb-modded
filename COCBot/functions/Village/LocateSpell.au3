;Locates Spell Factory manually
;saviart

Func LocateSpellFactory()
	While 1
		$MsgBox = MsgBox(1 + 262144, "Locate Spell Factory", "Click OK then click on your Spell Factory", 0, $frmBot)
		If $MsgBox = 1 Then
			$SFPos[0] = FindPos()[0]
			$SFPos[1] = FindPos()[1]
			SetLog("-Spell Factory =  " & "(" & $SFPos[0] & "," & $SFPos[1] & ")", $COLOR_GREEN)
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>LocateSpellFactory