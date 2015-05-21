
; Read the quantity for a given troop
Func ReadTroopQuantity($Troop)
	Return Number(getNormal(40 + (72 * $Troop), 565))
EndFunc   ;==>ReadTroopQuantity
