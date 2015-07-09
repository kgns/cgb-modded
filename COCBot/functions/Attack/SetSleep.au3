Func SetSleep($type)
	Switch $type
		Case 0
			If $iRandomspeedatk = 1 Then
				Return Round(Random(1, 5)) * 10
			Else
				Return ($icmbUnitDelay + 1) * 10
			EndIf
		Case 1
			If $iRandomspeedatk = 1 Then
				Return Round(Random(1, 5)) * 100
			Else
				Return ($icmbWaveDelay + 1) * 100
			EndIf
	EndSwitch
EndFunc   ;==>SetSleep
