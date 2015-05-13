Func LocateBarrack($ArmyCamp = False)
    Local $choice = "Barrack"
    If $ArmyCamp Then $choice = "Army Camp"
	SetLog("Locating " & $choice & "...", $COLOR_BLUE)
	Local $MsgBox
	$MsgBox = MsgBox(1 + 262144, "Locate your " & $choice, "Click OK then click on one of your " & $choice & "s.", 0, $frmBot)
	If $MsgBox = 1 Then
	    If $ArmyCamp Then
		   $ArmyPos[0] = FindPos()[0]
		   $ArmyPos[1] = FindPos()[1]
		Else
		   $barrackPos[0] = FindPos()[0]
		   $barrackPos[1] = FindPos()[1]
		EndIf
	endif
	#cs
	While 1
	  $MsgBox = MsgBox(6 + 262144, "Locate first barrack", "Click Continue then click on your first barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[0][0] = FindPos()[0]
		  $barrackPos[0][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  For $i=0 To 3
			 $barrackPos[$i][0] = ""
			 $barrackPos[$i][1] = ""
		  Next
		  ExitLoop
	  EndIf
	  If _Sleep(500) Then ExitLoop
	  $MsgBox = MsgBox(6 + 262144, "Locate second barrack", "Click Continue then click on your second barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[1][0] = FindPos()[0]
		  $barrackPos[1][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  For $i=1 To 3
			 $barrackPos[$i][0] = ""
			 $barrackPos[$i][1] = ""
		  Next
		  ExitLoop
	  EndIf
	  If _Sleep(500) Then ExitLoop
	  $MsgBox = MsgBox(6 + 262144, "Locate third barrack", "Click Continue then click on your third barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[2][0] = FindPos()[0]
		  $barrackPos[2][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  For $i=2 To 3
			 $barrackPos[$i][0] = ""
			 $barrackPos[$i][1] = ""
		  Next
		  ExitLoop
	  EndIf
	  If _Sleep(500) Then ExitLoop
	  $MsgBox = MsgBox(6 + 262144, "Locate fourth barrack", "Click Continue then click on your fourth barrack. Cancel if not available. Try again to start over.", 0, $frmBot)
	  If $MsgBox = 11 Then
		  $barrackPos[3][0] = FindPos()[0]
		  $barrackPos[3][1] = FindPos()[1]
	  ElseIf $MsgBox = 10 Then
		  ContinueLoop
	  Else
		  $barrackPos[3][0] = ""
		  $barrackPos[3][1] = ""
	  EndIf
	  If GUICtrlRead($chkRequest) = $GUI_CHECKED And $CCPos[0] = -1 Then LocateClanCastle()
	  ExitLoop
   WEnd
   #ce
;	SaveConfig()
;	SetLog("-Locating Complete-", $COLOR_BLUE)
	If $ArmyCamp Then
	   SetLog($choice & ": " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")")
    Else
	   SetLog($choice & ": " & "(" & $barrackPos[0] & "," & $barrackPos[1] & ")")
    EndIf
EndFunc   ;==>LocateBarrack