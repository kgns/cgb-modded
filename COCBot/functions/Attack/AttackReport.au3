Func AttackReport()

Local $lootGold
Local $lootElixir
Local $lootDarkElixir
Local $lootTrophies

   SetLog("Attack Report", $COLOR_GREEN)

   If _ColorCheck(_GetPixelColor(459, 372), Hex(0x433350, 6), 20) Then  ; if the color of the DE drop detected
    $lootGold   	= GetReturnHome(320,289, "ReturnResource")
    $lootElixir		= GetReturnHome(320,328, "ReturnResource")
    $lootDarkElixir	= GetReturnHome(320,366, "ReturnResource")
    $lootTrophies	= GetReturnHome(400,402, "ReturnTrophies")
    SetLog("Loot: [G]: " & $lootGold & " [E]: " & $lootElixir & " [DE]: " & $lootDarkElixir & " [T]: " & $lootTrophies, $COLOR_GREEN)
   Else
    $lootGold		= GetReturnHome(320,289, "ReturnResource")
    $lootElixir		= GetReturnHome(320,328, "ReturnResource")
    $lootTrophies	= GetReturnHome(400,365, "ReturnTrophies") ; 1 pixel higher
    SetLog("Loot: [G]: " & $lootGold & " [E]: " & $lootElixir & " [DE]: " & "" & " [T]: " & $lootTrophies, $COLOR_GREEN)
   EndIf

EndFunc
