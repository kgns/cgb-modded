;Checks the troops when in battle, checks for type, slot, and quantity.
;Saved in $atkTroops[SLOT][TYPE/QUANTITY] variable

Func PrepareAttack($Remaining = False) ;Assigns troops
  If $Remaining Then
	  SetLog("Checking remaining unused troops", $COLOR_BLUE)
   Else
	  SetLog("Initiating attack", $COLOR_RED)
   EndIf
  _CaptureRegion()
  For $i = 0 To 8
	  Local $troopKind = IdentifyTroopKind($i)
			For $x = 0 To 3
			 $troopKind = IdentifyTroopKind($i)
			 If $troopKind = $eBarb Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eArch Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eGiant Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eGobl Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eWall Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eBall Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eWiza Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eHeal Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eDrag Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $ePekk Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eMini Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eHogs Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eValk Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eWitc Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eGole Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			  ElseIf $troopKind = $eLava Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eLSpell Then ; And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eHSpell Then ; And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eRSpell Then ; And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eJSpell Then ;And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind = $eFSpell Then ;And $barrackTroop[$x] = 6 Then
				$atkTroops[$i][0] = $troopKind
				ExitLoop
			 ElseIf $troopKind <> $eKing And $troopKind <> $eQueen And $troopKind <> $eCastle Then
				$troopKind = -1
			 EndIf
			Next

	  If ($troopKind == -1) Then
		 $atkTroops[$i][1] = 0
	  ElseIf ($troopKind = $eKing) Or ($troopKind = $eQueen) Or ($troopKind = $eCastle) Then
		 $atkTroops[$i][1] = ""
	  Else
		 $atkTroops[$i][1] = ReadTroopQuantity($i)
	  EndIf
	  $atkTroops[$i][0] = $troopKind
	  If $troopKind <> -1 Then SetLog("-" & NameOfTroop($atkTroops[$i][0]) & " " & $atkTroops[$i][1], $COLOR_GREEN)
  Next
EndFunc   ;==>PrepareAttack
