; #FUNCTION# ====================================================================================================================
; Name ..........: PrepareAttack
; Description ...: Checks the troops when in battle, checks for type, slot, and quantity.  Saved in $atkTroops[SLOT][TYPE/QUANTITY] variable
; Syntax ........: PrepareAttack($pMatchMode[, $Remaining = False])
; Parameters ....: $pMatchMode          - a pointer value.
;                  $Remaining           - [optional] Flag for when checking remaining troops. Default is False.
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func PrepareAttack($pMatchMode, $Remaining = False) ;Assigns troops
	If $Remaining Then
		SetLog("Checking remaining unused troops for: " & $sModeText[$pMatchMode], $COLOR_BLUE)
	Else
		SetLog("Initiating attack for: " & $sModeText[$pMatchMode], $COLOR_RED)
	EndIf

	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2(0, 571, 859, 671)
	Sleep(250)
	Local $result = DllCall($pFuncLib, "str", "searchIdentifyTroop", "ptr", $hBitmapFirst)
	Local $aTroopDataList = StringSplit($result[0], "#", $STR_NOCOUNT)
	Local $aTemp[0][3]
	For $i = 0 To UBound($aTroopDataList) - 1
		ReDim $aTemp[$i + 1][3]
		Local $troopData = StringSplit($aTroopDataList[$i], "|", $STR_NOCOUNT)
		Switch $troopData[0]
			Case "Barbarian"
				$aTemp[$i][0] = $eBarb
			Case "Archer"
				$aTemp[$i][0] = $eArch
			Case "Giant"
				$aTemp[$i][0] = $eGiant
			Case "Goblin"
				$aTemp[$i][0] = $eGobl
			Case "WallBreaker"
				$aTemp[$i][0] = $eWall
			Case "Balloon"
				$aTemp[$i][0] = $eBall
			Case "Wizard"
				$aTemp[$i][0] = $eWiza
			Case "Healer"
				$aTemp[$i][0] = $eHeal
			Case "Dragon"
				$aTemp[$i][0] = $eDrag
			Case "Pekka"
				$aTemp[$i][0] = $ePekk
			Case "Minion"
				$aTemp[$i][0] = $eMini
			Case "HogRider"
				$aTemp[$i][0] = $eHogs
			Case "Valkyrie"
				$aTemp[$i][0] = $eValk
			Case "Golem"
				$aTemp[$i][0] = $eGole
			Case "Witch"
				$aTemp[$i][0] = $eWitc
			Case "LavaHound"
				$aTemp[$i][0] = $eLava
			Case "King"
				$aTemp[$i][0] = $eKing
			Case "Queen"
				$aTemp[$i][0] = $eQueen
			Case "LightSpell"
				$aTemp[$i][0] = $eLSpell
			Case "HealSpell"
				$aTemp[$i][0] = $eHSpell
			Case "RageSpell"
				$aTemp[$i][0] = $eRSpell
			Case "JumpSpell"
				$aTemp[$i][0] = $eJSpell
			Case "FreezeSpell"
				$aTemp[$i][0] = $eFSpell
			Case "Castle"
				$aTemp[$i][0] = $eCastle
		EndSwitch
		$aTemp[$i][2] = Number(StringSplit($troopData[1], "-", $STR_NOCOUNT)[0])
		$aTemp[$i][1] = Number($troopData[2])
	Next
	_ArraySort($aTemp, 0, 0, 0, 2)
	For $i = 0 To UBound($aTemp) - 1
		$troopKind = $aTemp[$i][0]
		If Not IsTroopToBeUsed($pMatchMode, $troopKind) Then
			$atkTroops[$i][0] = -1
			$troopKind = -1
		Else
			$atkTroops[$i][0] = $troopKind
		EndIf
		If ($troopKind == -1) Then
			$atkTroops[$i][1] = 0
		ElseIf ($troopKind = $eKing) Or ($troopKind = $eQueen) Or ($troopKind = $eCastle) Then
			$atkTroops[$i][1] = ""
		Else
			$atkTroops[$i][1] = $aTemp[$i][1]
		EndIf
		If $troopKind <> -1 Then SetLog("-" & NameOfTroop($atkTroops[$i][0]) & " " & $atkTroops[$i][1], $COLOR_GREEN)
	Next
	For $i = UBound($aTemp) To 10
		$atkTroops[$i][0] = -1
		$atkTroops[$i][1] = 0
	Next
EndFunc   ;==>PrepareAttack

Func IsTroopToBeUsed($pMatchMode, $pTroopType)
	If $pMatchMode = $DT Or $pMatchMode = $TB Or $pMatchMode = $TS Then Return True
	Local $tempArr = $troopsToBeUsed[$iCmbSelectTroop[$pMatchMode]]
	For $x = 0 To UBound($tempArr) - 1
		If $tempArr[$x] = $pTroopType Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>IsTroopToBeUsed
