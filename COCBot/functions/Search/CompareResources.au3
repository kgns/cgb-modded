;Compares the searched values to the minimum values, returns false if doesn't meet.
;Every 20 searches, it will decrease minimum by certain amounts.

Func CompareResources() ;Compares resources and returns true if conditions meet, otherwise returns false

	If $iChkSearchReduction = 1 Then
		If $SearchCount <> 0 And Mod($SearchCount, $ReduceCount) = 0 Then
			If $AimGold - $ReduceGold >= 0 Then $AimGold -= $ReduceGold
			If $AimElixir - $ReduceElixir >= 0 Then $AimElixir -= $ReduceElixir
			If $AimDark - $ReduceDark >= 0 Then $AimDark -= $ReduceDark
			If $AimTrophy - $ReduceTrophy >= 0 Then $AimTrophy -= $ReduceTrophy
			If $AimGoldPlusElixir - $ReduceGoldPlusElixir >= 0 Then $AimGoldPlusElixir -= $ReduceGoldPlusElixir

			SetLog("Aim: [G+E]:" & StringFormat("%7s", $AimGoldPlusElixir) & " [G]:" & StringFormat("%7s", $AimGold) & " [E]:" & StringFormat("%7s", $AimElixir) & " [D]:" & StringFormat("%5s", $AimDark) & " [T]:" & StringFormat("%2s", $AimTrophy) & $AimTHtext, $COLOR_GREEN, "Lucida Console", 7.5)
		EndIf
	EndIf

	Local $G = (Number($searchGold) >= Number($AimGold)), $E = (Number($searchElixir) >= Number($AimElixir)), $D = (Number($searchDark) >= Number($AimDark)), $T = (Number($searchTrophy) >= Number($AimTrophy)), $GPE = ((Number($searchGold) + Number($searchElixir)) >= Number($AimGoldPlusElixir))
	Local $THL = -1, $THLO = -1

	For $i = 0 To 4
		If $searchTH = $THText[$i] Then $THL = $i
	Next

	Switch $THLoc
	Case "In"
		$THLO = 0
	Case "Out"
		$THLO = 1
	EndSwitch


   $SearchTHLResult=0
;   Local $YourTHNumHere
;   For $i = 0 To 4
;		If $YourTH = $THText[$i] Then $YourTHNumHere = $i
;	Next
;	if $YourTH < 7 then
;		$YourTHNumHere = 0
;	endif
   If $THL > -1 And $THL <= $YourTH And $searchTH <> "-" Then $SearchTHLResult=1

    If $ichkMeetOne = 1 Then
	   If $chkConditions[0]=1  Then
		   If $G = True And $E = True Then Return True
	   EndIf

	   If $chkConditions[1]=1 Then
		   If $D = True Then Return True
	   EndIf

	   If $chkConditions[2]=1  Then
		   If $T = True Then Return True
		EndIf

	   If $chkConditions[3]=1 Then
		   If $G = True Or $E = True Then Return True
		EndIf

	   If $chkConditions[4]=1  Then
		   If $THL <> -1 And $THL <= $icmbTH Then Return True
	   EndIf

	   If $chkConditions[5]=1 Then
		   If $THLO = 1 Then Return True
	   EndIf

	   If $chkConditions[6]=1 Then
		   If $GPE = True Then Return True
	   EndIf
	   Return False
    Else
	   If $chkConditions[0]=1 Then
		   If $G = False Or $E = False Then Return False
	   EndIf

	   If $chkConditions[1]=1 Then
		   If $D = False Then Return False
	   EndIf

	   If $chkConditions[2]=1 Then
		   If $T = False Then Return False
		EndIf

	   If $chkConditions[3]=1 Then
		   If $G = False And $E = False Then Return False
		EndIf

	   If $chkConditions[4]=1 Then
		   If $THL = -1 Or $THL > $icmbTH Then Return False
	   EndIf

	   If $chkConditions[5]=1 Then
		   If $THLO <> 1 Then Return False
	   EndIf

	   If $chkConditions[6]=1 Then
		   If $GPE = False Then Return False
	   EndIf
    EndIf
	Return True
EndFunc   ;==>CompareResources