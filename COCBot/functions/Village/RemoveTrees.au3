Func RemoveTrees()
	If GUICtrlRead($chkTrees) = $GUI_CHECKED Then
		If $FreeBuilder > 0 Then
			VillageReport() ; Get current gold and elixir amount
			Local $ElixirCountOld = 11000000 ; Will be used to avoid infinite loop
			Local $GoldCountOld = 11000000 ; Will be used to avoid infinite loop
			; If gold or elixir did not decrease after trying to remove,
			; either we could not locate correct objects, or some other error occurred.
			; end loop and exit
			While (Number($ElixirCount) < Number($ElixirCountOld) OR Number($GoldCount) < Number($GoldCountOld))
				$ElixirCountOld = $ElixirCount
				$GoldCountOld = $GoldCount
				SetLog("Checking for Trees", $COLOR_GREEN)
				Click(1, 1) ; click away
				CheckTrees()
				If $TreeLoc = 1 Then
					Click($TreeX, $TreeY)
					If _Sleep(600) Then Return
					Click(430,600); Click Remove
					Click(1, 1) ; click away
					VillageReport() ; Check to see if a builder is free AND also get the current Gold/Elixir amount
					If $FreeBuilder = 0 Then
						If _Sleep(10000) Then Return
						VillageReport() ; Check to see if a builder is free (if not its a gembox)
						If $FreeBuilder = 0 Then
							If _Sleep(20000) Then Return
							;VillageReport() ; This is to avoid FreeBuilder to stay 0 after removing gembox the last
						EndIf
					EndIf
				Else
					ExitLoop
				EndIf
			WEnd
		Else
			SetLog("No free builder, Remove Trees skipped..", $COLOR_RED)
		EndIf
		CheckTombs()
	EndIf
EndFunc   ;==>RemoveTrees