
; Read the quantity for a given troop
Func ReadTroopQuantity($Troop)
	Local $iAmount
	$iAmount = getTroopCountSmall(40 + (72 * $Troop), 582)
	If $iAmount = "" Then
		$iAmount = getTroopCountBig(40 + (72 * $Troop), 577)
	EndIf
	Return Number($iAmount)
EndFunc   ;==>ReadTroopQuantity
