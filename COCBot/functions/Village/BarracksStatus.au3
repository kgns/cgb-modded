Func BarracksStatus($showlog = false)

	Local $COLOR_AVAIABLE = "0x888070"
	Local $COLOR_UPGRADING = "0x6b6964"
	Local $COLOR_EMPTYSLOT = "0x58514D"

	$numBarracks = 0
	$numBarracksAvaiables = 0
	$numDarkBarracks = 0
	$numDarkBarracksAvaiables = 0
	$numFactorySpell = 0
	$numFactorySpellAvaiables = 0
	$numFactoryDarkSpell = 0
	$numFactoryDarkSpellAvaiables = 0


	if $debugSetlog= 1 Then Setlog("start barrackstatus")
	; VERIFY HOW MUCH BARRACK ARE READY
	Local $i = 0
	While Not _ColorCheck(_GetPixelColor($btnpos[0][0], $btnpos[0][1], True), Hex(0xE8E8E0, 6), 20)
		if $debugSetlog= 1 Then Setlog("search color pos0 army overview... "  & $i)
		_Sleep(50)
		$i += 1
		If $i > 10 Then ExitLoop
	WEnd
	If $debugSetlog= 1 then
		If $i > 10 And $debugSetlog = 1 Then
			Setlog("BarrackStatus Warning #1")
		Else
			Setlog("OK, I'm in army overview")
		EndIf
	EndIf
	_sleep(100)

	For $i = 1 To 4
		If _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_AVAIABLE, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("barrack " & $i & " found! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numBarracks += 1
			$numBarracksAvaiables += 1
			$Trainvaiable[$i] = 1
		ElseIf _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_UPGRADING, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("barrack " & $i & " found upgrading! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numBarracks += 1
			$numBarracksAvaiables += 0
			$Trainvaiable[$i] = 0
		Else
			if $debugSetlog= 1 Then Setlog("barrack " & $i & " NO found, color = " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numBarracks += 0
			$numBarracksAvaiables += 0
			$Trainvaiable[$i] = 0
		EndIf
	Next

	For $i = 5 To 6
		If _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_AVAIABLE, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("dark barrack " & $i -4 & " found! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numDarkBarracks += 1
			$numDarkBarracksAvaiables += 1
			$Trainvaiable[$i] = 1
		ElseIf _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_UPGRADING, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("dark barrack " & $i -1 & " found upgrading! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numDarkBarracks += 1
			$numDarkBarracksAvaiables += 0
			$Trainvaiable[$i] = 0
		Else
			if $debugSetlog= 1 Then Setlog("dark barrack " & $i -2 & " NO found, color = " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numDarkBarracks += 0
			$numDarkBarracksAvaiables += 0
			$Trainvaiable[$i] = 0
		EndIf
	Next

	$i=7
		If _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_AVAIABLE, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("Factory Spell found! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numFactorySpell += 1
			$numFactorySpellAvaiables += 1
			$Trainvaiable[$i] = 1
		ElseIf _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_UPGRADING, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("Factory spell found upgrading! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numFactorySpell += 1
			$numFactorySpellAvaiables += 0
			$Trainvaiable[$i] = 0
		Else
			if $debugSetlog= 1 Then Setlog("Factory spell NO found, color = " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numFactorySpell += 0
			$numFactorySpellAvaiables += 0
			$Trainvaiable[$i] = 0
		EndIf

	$i=8
		If _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_AVAIABLE, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("Dark Factory Spell found! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numFactoryDarkSpell += 1
			$numFactoryDarkSpellAvaiables += 1
			$Trainvaiable[$i] = 1
		ElseIf _ColorCheck(_GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True), Hex($COLOR_UPGRADING, 6), 20) Then
			if $debugSetlog= 1 Then Setlog("Dark Factory spell found upgrading! color " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numFactoryDarkSpell += 1
			$numFactoryDarkSpellAvaiables += 0
			$Trainvaiable[$i] = 0
		Else
			if $debugSetlog= 1 Then Setlog("Dark Factory spell NO found, color = " & _GetPixelColor($btnpos[$i][0], $btnpos[$i][1], True))
			$numFactorySpell += 0
			$numFactorySpellAvaiables += 0
			$Trainvaiable[$i] = 0
		EndIf

	If $showlog = true or $debugSetlog = 1 Then
		SetLog("Barracks and Spell factory status: ", $COLOR_GREEN)
		SetLog("- Barracks detected: " & $numBarracks & " available: " & $numBarracksAvaiables & " upgrading: " & $numBarracks -  $numBarracksAvaiables,$COLOR_GREEN)
		SetLog("- Dark Barracks detected: " & $numDarkBarracks & " available: " & $numDarkBarracksAvaiables & " upgrading: " & $numDarkBarracks -  $numDarkBarracksAvaiables,$COLOR_GREEN)
		Setlog("- Spell factory detected: " & $numFactorySpell & " available: " & $numFactorySpellAvaiables & " upgrading: " & $numFactorySpell -  $numFactorySpellAvaiables,$COLOR_GREEN)
		Setlog("- Dark Spell factory detected: " & $numFactoryDarkSpell & " available: " & $numFactoryDarkSpellAvaiables & " upgrading: " & $numFactoryDarkSpell -  $numFactoryDarkSpellAvaiables,$COLOR_GREEN)
	EndIf

	If $debugSetlog = 1 Then
		For $i = 0 to Ubound($Trainvaiable) -1
			SetLog ("Trainavaiable[" & $i & "] = " & $Trainvaiable[$i] )
		Next
	EndIf
EndFunc   ;==>BarracksStatus