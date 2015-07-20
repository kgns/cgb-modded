; #FUNCTION# ====================================================================================================================
; Name ..........: GetTownHallLevel
; Description ...:
; Syntax ........: GetTownHallLevel($bFirstTime)
; Parameters ....: $bFirstTime          - a boolean value True = first time the bot has run
; Return values .: None
; Author ........: KNowJack (July 2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func GetTownHallLevel($bFirstTime = False)

	Local $aTHInfo[3] = ["", "", ""]

	If $debugSetlog = 1 Then SetLog("Town Hall Position: " & $TownHallPos[0]& ", "& $TownHallPos[1], $COLOR_PURPLE)
	If isInsideDiamond($TownHallPos) = False Then  ; If TH pos is not known or is outside village then get new position
		LocateTownHall(True)  ; Set flag = true for location only, or repeated loop happens
		If isInsideDiamond($TownHallPos) Then SaveConfig()  ; save new location
		If _Sleep(1000) Then Return
	EndIf

	If $bFirstTime = True Then
		Click($TownHallPos[0], $TownHallPos[1] + 5)
		If _Sleep(1500) Then Return
	EndIf

	If $debugSetlog = 1 Then DebugImageSave("GetTHLevelView")

	$iTownHallLevel = 0 ; Reset Townhall level
	$aTHInfo = BuildingInfo(250, 520)
	If $debugSetlog = 1 Then Setlog("$aTHInfo[0]="&$aTHInfo[0]&", $aTHInfo[1]="&$aTHInfo[1]&", $aTHInfo[2]="&$aTHInfo[2], $COLOR_PURPLE)
	If $aTHInfo[0] > 1 Then
		If  StringInStr($aTHInfo[1], "Town") = 0 Then
			SetLog ("Hmm, That is not a TownHall?, It was a " &$aTHInfo[1] & ", Try again!", $COLOR_Fuchsia)
			Return $aTHInfo
		EndIf
		If $aTHInfo[2] <> "" Then
			$iTownHallLevel = $aTHInfo[2]  ; grab building level from building info array
			SetLog ("Your Town Hall Level read as: " & $iTownHallLevel, $COLOR_GREEN)
		Else
			SetLog ("Your Town Hall Village Level was not found! Please Manually Locate " & $iTownHallLevel, $COLOR_BLUE)
			ClickP($aTopLeftClient)  ; Unselect TH
			Return False
		EndIf
	Else
	  SetLog ("Your Town Hall Village Level was not found! Please Manually Locate " & $iTownHallLevel, $COLOR_BLUE)
	  ClickP($aTopLeftClient)  ; Unselect TH
	  Return False
	EndIf

	ClickP($aTopLeftClient, 2, 200)  ; Unselect TH
	Return True

	EndFunc
