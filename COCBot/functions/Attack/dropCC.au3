;Drops Clan Castle troops, given the slot and x, y coordinates.
Func dropCC($x, $y, $slot) ;Drop clan castle
 If $slot <> -1 And $checkUseClanCastle = 1  Then
    If $checkUseClanCastleBalanced = 1 Then
    IF  Number($TroopsDonated) >= Number($TroopsReceived) Then
       SetLog("Dropping Clan Castle, donated (" & $TroopsDonated & ") >= received (" & $TroopsReceived & ")", $COLOR_BLUE)
   Click(68 + (72 * $slot), 595, 1, 500)
   If _Sleep(500) Then Return
   Click($x, $y)
    Else
      SetLog("No Dropping Clan Castle, donated  (" & $TroopsDonated & ") < received  (" & $TroopsReceived & ")", $COLOR_BLUE)
   EndIf
   Else
  SetLog("Dropping Clan Castle", $COLOR_BLUE)
  Click(68 + (72 * $slot), 595, 1, 500)
  If _Sleep(500) Then Return
  Click($x, $y)
   EndIf
 EndIf
EndFunc   ;==>dropCC