;Gets trophy count of village and compares to max trophy input.
;Will drop a troop and return home with no screenshot or gold wait.

Func DropTrophy()
	Local $TrophyCount = getOther(50, 74, "Trophy")
	Local $itxtMaxTrophyNeedCheck
	$itxtMaxTrophyNeedCheck = $itxtMaxTrophy ; $itxtMaxTrophy = 1800

	If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
		If $iChkTrophyAtkDead = 1 Then
			If ($CurCamp >= ($TotalCamp * 70 / 100)) Then

				While Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck)
					$TrophyCount = getOther(50, 74, "Trophy")
					SetLog("Trophy Count : " & $TrophyCount, $COLOR_GREEN)
					If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
						$itxtMaxTrophyNeedCheck = $itxtdropTrophy ; $itxtMinTrophy = 1650
						SetLog("Dropping Trophies to " & $itxtdropTrophy, $COLOR_BLUE)
						If _Sleep(2000) Then ExitLoop

						ZoomOut()
						PrepareSearch()

						If _Sleep(2000) Then ExitLoop
						While getGold(51, 66) = "" ; Loops until gold is readable
							If _Sleep(1000) Then ExitLoop (2)
						WEnd
						SetLog("Identification of your troops:", $COLOR_BLUE)
						PrepareAttack() ; ==== Troops :checks for type, slot, and quantity ===
						$AimGold = $MinGold
						$AimElixir = $MinElixir
						$AimGoldPlusElixir = $MinGoldPlusElixir
						$searchGold = getGold(51, 66)
						$searchElixir = getElixir(51, 66 + 29)
						$searchTrophy = getTrophy(51, 66 + 90)
						Local $G = (Number($searchGold) >= Number($AimGold))
						Local $E = (Number($searchElixir) >= Number($AimElixir))
						Local $GPE = ((Number($searchElixir) + Number($searchGold)) >= Number($AimGoldPlusElixir))
						If $G = True And $E = True And $GPE = True Then
							SetLog("Found [G]:" & StringFormat("%7s", $searchGold) & " [E]:" & StringFormat("%7s", $searchElixir), $COLOR_BLACK, "Lucida Console")
							If checkDeadBase() Then
								; _BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys
								SetLog(_PadStringCenter(" Dead Base Found!! Meet All Conditionals", 50, "~"), $COLOR_GREEN)
								Attack()
								ReturnHome($TakeLootSnapShot)
								ExitLoop (3) ; or ContinueLoop
							EndIf
						EndIf


						If _Sleep(1500) Then Return

						If $iChkTrophyHeroes = 1 Then
							$King = -1
							$Queen = -1
							For $i = 0 To 8
								If $atkTroops[$i][0] = $eKing Then
									$King = $i
								ElseIf $atkTroops[$i][0] = $eQueen Then
									$Queen = $i
								EndIf
							Next


							If $King <> -1 Then
								SetLog("Deploying King", $COLOR_BLUE)
								Click(68 + (72 * $King), 595) ;Select King
								_Sleep(1000)
								Click(34, 310) ;Drop King
								If _Sleep(1000) Then ExitLoop
								ReturnHome(False, False) ;Return home no screenshot
								If _Sleep(1000) Then ExitLoop
								GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - ($TrophyCount - getOther(50, 74, "Trophy")))
							EndIf
							If $King = -1 And $Queen <> -1 Then
								SetLog("Deploying Queen", $COLOR_BLUE)
								Click(68 + (72 * $Queen), 595) ;Select Queen
								_Sleep(1000)
								Click(34, 310) ;Drop Queen
								If _Sleep(1000) Then ExitLoop
								ReturnHome(False, False) ;Return home no screenshot
								If _Sleep(1000) Then ExitLoop
								GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - ($TrophyCount - getOther(50, 74, "Trophy")))
							EndIf
						EndIf
						If ($Queen = -1 And $King = -1) Or $iChkTrophyHeroes = 0 Then
							Select
								Case $atkTroops[0][0] = $eBarb
									Click(34, 310) ;Drop one troop
									$CurBarb += 1
									$ArmyComp -= 1
									SetLog("Deploying 1 Barbarian", $COLOR_BLUE)
								Case $atkTroops[0][0] = $eArch
									Click(34, 310) ;Drop one troop
									$CurArch += 1
									$ArmyComp -= 1
									SetLog("Deploying 1 Archer", $COLOR_BLUE)
								Case $atkTroops[0][0] = $eGiant
									Click(34, 310) ;Drop one troop
									$CurGiant += 1
									$ArmyComp -= 5
									SetLog("Deploying 1 Giant", $COLOR_BLUE)
								Case $atkTroops[0][0] = $eWall
									Click(34, 310) ;Drop one troop
									$CurWall += 1
									$ArmyComp -= 2
									SetLog("Deploying 1 WallBreaker", $COLOR_BLUE)
								Case $atkTroops[0][0] = $eGobl
									Click(34, 310) ;Drop one troop
									$CurGobl += 1
									$ArmyComp -= 2
									SetLog("Deploying 1 Goblins", $COLOR_BLUE)
								Case $atkTroops[0][0] = $eMini
									Click(34, 310) ;Drop one troop
									$CurMini += 1
									$ArmyComp -= 2
									SetLog("Deploying 1 Minion", $COLOR_BLUE)
								Case Else
									$itxtMaxTrophy += 50
									SetLog("You Don´t have Tier 1/2 Troops, exit of dropping Trophies", $COLOR_BLUE) ; preventing of deploying Tier 2/3 expensive troops
							EndSelect
							If _Sleep(1000) Then ExitLoop
							ReturnHome(False, False) ;Return home no screenshot
							If _Sleep(1000) Then ExitLoop
							GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - ($TrophyCount - getOther(50, 74, "Trophy")))
						EndIf

					Else
						SetLog("Trophy Drop Complete", $COLOR_BLUE)

					EndIf
				WEnd
			Else
				Setlog("Drop Thropies: Army is < 70% capacity")
				Setlog("You selected Option Attack DBase if find it")
			EndIf

		Else

			While Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck)
				$TrophyCount = getOther(50, 74, "Trophy")
				SetLog("Trophy Count : " & $TrophyCount, $COLOR_GREEN)
				If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
					$itxtMaxTrophyNeedCheck = $itxtdropTrophy ; $itxtMinTrophy = 1650
					SetLog("Dropping Trophies to " & $itxtdropTrophy, $COLOR_BLUE)
					If _Sleep(2000) Then ExitLoop

				    ZoomOut()
					PrepareSearch()

					If _Sleep(2000) Then ExitLoop
					PrepareAttack()
					If $iChkTrophyHeroes = 1 Then
						$King = -1
						$Queen = -1
						For $i = 0 To 8
							If $atkTroops[$i][0] = $eKing Then
								$King = $i
							ElseIf $atkTroops[$i][0] = $eQueen Then
								$Queen = $i
							EndIf
						Next


						If $King <> -1 Then
							SetLog("Deploying King", $COLOR_BLUE)
							Click(68 + (72 * $King), 595) ;Select King
							_Sleep(1000)
							Click(34, 310) ;Drop King
							If _Sleep(1000) Then ExitLoop
							ReturnHome(False, False) ;Return home no screenshot
							If _Sleep(1000) Then ExitLoop
							GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - ($TrophyCount - getOther(50, 74, "Trophy")))
						EndIf
						If $King = -1 And $Queen <> -1 Then
							SetLog("Deploying Queen", $COLOR_BLUE)
							Click(68 + (72 * $Queen), 595) ;Select Queen
							_Sleep(1000)
							Click(34, 310) ;Drop Queen
							If _Sleep(1000) Then ExitLoop
							ReturnHome(False, False) ;Return home no screenshot
							If _Sleep(1000) Then ExitLoop
							GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - ($TrophyCount - getOther(50, 74, "Trophy")))
						EndIf
					EndIf
					If ($Queen = -1 And $King = -1) Or $iChkTrophyHeroes = 0 Then
						Select
							Case $atkTroops[0][0] = $eBarb
								Click(34, 310) ;Drop one troop
								$CurBarb += 1
								$ArmyComp -= 1
								SetLog("Deploying 1 Barbarian", $COLOR_BLUE)
							Case $atkTroops[0][0] = $eArch
								Click(34, 310) ;Drop one troop
								$CurArch += 1
								$ArmyComp -= 1
								SetLog("Deploying 1 Archer", $COLOR_BLUE)
							Case $atkTroops[0][0] = $eGiant
								Click(34, 310) ;Drop one troop
								$CurGiant += 1
								$ArmyComp -= 5
								SetLog("Deploying 1 Giant", $COLOR_BLUE)
							Case $atkTroops[0][0] = $eWall
								Click(34, 310) ;Drop one troop
								$CurWall += 1
								$ArmyComp -= 2
								SetLog("Deploying 1 WallBreaker", $COLOR_BLUE)
							Case $atkTroops[0][0] = $eGobl
								Click(34, 310) ;Drop one troop
								$CurGobl += 1
								$ArmyComp -= 2
								SetLog("Deploying 1 Goblins", $COLOR_BLUE)
							Case $atkTroops[0][0] = $eMini
								Click(34, 310) ;Drop one troop
								$CurMini += 1
								$ArmyComp -= 2
								SetLog("Deploying 1 Minion", $COLOR_BLUE)
							Case Else
								$itxtMaxTrophy += 50
								SetLog("You Don´t have Tier 1/2 Troops, exit of dropping Trophies", $COLOR_BLUE) ; preventing of deploying Tier 2/3 expensive troops
						EndSelect
						If _Sleep(1000) Then ExitLoop
						ReturnHome(False, False) ;Return home no screenshot
						If _Sleep(1000) Then ExitLoop
						GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - ($TrophyCount - getOther(50, 74, "Trophy")))
					EndIf

				Else
					SetLog("Trophy Drop Complete", $COLOR_BLUE)
				EndIf
			WEnd

		EndIf
	EndIf
EndFunc   ;==>DropTrophy
