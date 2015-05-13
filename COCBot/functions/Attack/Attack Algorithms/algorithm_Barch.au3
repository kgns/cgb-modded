; #FUNCTION# ====================================================================================================================
; Name ..........: algorithm_Barch
; Description ...: This file contens the attack algorithm using Barbarians and Archers
; Syntax ........: Barch()
; Parameters ....: None
; Return values .: None
; Author ........:  (2014-Dec)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================


Func Barch() ;Attack Algorithm for Barch
	While 1
		Local $Barb = -1, $Arch = -1, $CC = -1
		Global $King = -1, $Queen = -1
		For $i = 0 To 6
			If $atkTroops[$i][0] = "Barbarian" Then
				$Barb = $i
			ElseIf $atkTroops[$i][0] = "Archer" Then
				$Arch = $i
			ElseIf $atkTroops[$i][0] = "Clan Castle" Then
				$CC = $i
			ElseIf $atkTroops[$i][0] = "King" Then
				$King = $i
			ElseIf $atkTroops[$i][0] = "Queen" Then
				$Queen = $i
			EndIf
		Next

		If _Sleep(500) Then ExitLoop
		Switch $deploySettings
			Case 0 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking from two sides...")
				If _Sleep(1000) Then ExitLoop
				Local $numBarbPerSpot = Ceiling((($atkTroops[$Barb][1] / 2) / 5) / 2)
				Local $numArchPerSpot = Ceiling((($atkTroops[$Arch][1] / 2) / 5) / 2)

				SetLog("Dropping first wave of Barbarians", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop first round of Barbarians
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numBarbPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numBarbPerSpot, 1)
				Next

				If _Sleep(1000) Then ExitLoop

				SetLog("Dropping first wave of Archers", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop first round of Archers
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numArchPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numArchPerSpot, 1)
				Next

				If _Sleep(2000) Then ExitLoop ;-------------------------------------------

				SetLog("Dropping second wave of Barbarians", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop second round of Barbarians
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numBarbPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numBarbPerSpot, 1)
				Next

				If _Sleep(1000) Then ExitLoop

				SetLog("Dropping second wave of Archers", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop second round of Archers
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numArchPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numArchPerSpot, 1)
				Next

				dropHeroes($TopLeft[3][0], $TopLeft[3][1], $King, $Queen)
				If _Sleep(1000) Then ExitLoop
				dropCC($TopLeft[3][0], $TopLeft[3][1], $CC)
			Case 1 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking from three sides...")
				If _Sleep(1000) Then ExitLoop
				Local $numBarbPerSpot = Ceiling((($atkTroops[$Barb][1] / 3) / 5) / 2)
				Local $numArchPerSpot = Ceiling((($atkTroops[$Arch][1] / 3) / 5) / 2)

				SetLog("Dropping first wave of Barbarians", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop first round of Barbarians
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numBarbPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numBarbPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numBarbPerSpot, 1)
				Next

				If _Sleep(1000) Then ExitLoop

				SetLog("Dropping first wave of Archers", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop first round of Archers
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numArchPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numArchPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numArchPerSpot, 1)
				Next

				If _Sleep(2000) Then ExitLoop ;-------------------------------------------

				SetLog("Dropping second wave of Barbarians", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop second round of Barbarians
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numBarbPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numBarbPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numBarbPerSpot, 1)
				Next

				If _Sleep(1000) Then ExitLoop

				SetLog("Dropping second wave of Archers", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop second round of Archers
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numArchPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numArchPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numArchPerSpot, 1)
				Next

				dropHeroes($TopRight[3][0], $TopRight[3][1], $King, $Queen)
				If _Sleep(1000) Then ExitLoop
				dropCC($TopRight[3][0], $TopRight[3][1], $CC)
			Case 2 ;Four sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking from all sides...")
				If _Sleep(1000) Then ExitLoop
				Local $numBarbPerSpot = Ceiling((($atkTroops[$Barb][1] / 4) / 5) / 2)
				Local $numArchPerSpot = Ceiling((($atkTroops[$Arch][1] / 4) / 5) / 2)

				SetLog("Dropping first wave of Barbarians", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop first round of Barbarians
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numBarbPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numBarbPerSpot, 1)
					Click($BottomLeft[$i][0], $BottomLeft[$i][1], $numBarbPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numBarbPerSpot, 1)
				Next

				If _Sleep(1000) Then ExitLoop

				SetLog("Dropping first wave of Archers", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop first round of Archers
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numArchPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numArchPerSpot, 1)
					Click($BottomLeft[$i][0], $BottomLeft[$i][1], $numArchPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numArchPerSpot, 1)
				Next

				If _Sleep(2000) Then ExitLoop ;-------------------------------------------

				SetLog("Dropping second wave of Barbarians", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop second round of Barbarians
					Click(68 + (72 * $Barb), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numBarbPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numBarbPerSpot, 1)
					Click($BottomLeft[$i][0], $BottomLeft[$i][1], $numBarbPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numBarbPerSpot, 1)
				Next

				If _Sleep(1000) Then ExitLoop

				SetLog("Dropping second wave of Archers", $COLOR_BLUE)
				For $i = 0 To 4 ;Drop second round of Archers
					Click(68 + (72 * $Arch), 595) ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					Click($TopLeft[$i][0], $TopLeft[$i][1], $numArchPerSpot, 1)
					Click($TopRight[$i][0], $TopRight[$i][1], $numArchPerSpot, 1)
					Click($BottomLeft[$i][0], $BottomLeft[$i][1], $numArchPerSpot, 1)
					Click($BottomRight[$i][0], $BottomRight[$i][1], $numArchPerSpot, 1)
				Next

				dropHeroes($BottomLeft[3][0], $BottomLeft[3][1], $King, $Queen)
				If _Sleep(1000) Then ExitLoop
				dropCC($BottomLeft[3][0], $BottomLeft[3][1], $CC)
		EndSwitch

		If _Sleep(100) Then ExitLoop
		SetLog("Dropping left over troops", $COLOR_BLUE)
		$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
		$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))

		While $atkTroops[$Barb][1] <> 0
			Click(68 + (72 * $Barb), 595)
			Click($TopLeft[3][0], $TopLeft[3][1], $atkTroops[$Barb][1], 1)

			$atkTroops[$Barb][1] = Number(getNormal(40 + (72 * $Barb), 565))
		WEnd

		If _Sleep(1000) Then ExitLoop

		While $atkTroops[$Arch][1] <> 0
			Click(68 + (72 * $Arch), 595)
			Click($TopLeft[3][0], $TopLeft[3][1], $atkTroops[$Arch][1], 1)

			$atkTroops[$Arch][1] = Number(getNormal(40 + (72 * $Arch), 565))
		WEnd

		If _Sleep(100) Then ExitLoop

		;Activate KQ's power
		If $checkKPower = True Or $checkQPower = True Then
			SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating Hero abilities", $COLOR_GREEN)
			_Sleep($delayActivateKQ)
			If $checkKPower = True Then
				SetLog("Activate King's power", $COLOR_BLUE)
				Click(68 + (72 * $King), 595)
			EndIf
			If $checkQPower = True Then
				SetLog("Activate Queen's power", $COLOR_BLUE)
				Click(68 + (72 * $Queen), 595)
			EndIf
		EndIf

		SetLog("~Finished Attacking, waiting to finish")
		ExitLoop
	WEnd
EndFunc   ;==>Barch