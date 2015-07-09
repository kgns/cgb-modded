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

	ClickP($aTopLeftClient, 2, 200)  ; Close any windows that may be open in case user is doing manual location

	If $debugSetlog = 1 Then SetLog("Town Hall Position: " & $TownHallPos[0]& ", "& $TownHallPos[1], $COLOR_Purple)
	If isInsideDiamond($TownHallPos) = False Then  ; If TH pos is not known or is outside village then get new position
		LocateTownHall(True)  ; Set flag = true for location only, or repeated loop happens
		SaveConfig()  ; save new location
		If _Sleep(1000) Then Return
	EndIf

	Click($TownHallPos[0], $TownHallPos[1] + 5)
	If _Sleep(1500) Then Return

	If $debugSetlog = 1 Then DebugImageSave("GetTHLevelView")

	$aTHInfo = BuildingInfo(250, 520)
	If $aTHInfo[0] > 1 Then
		$iTownHallLevel = $aTHInfo[2]  ; grab building level from building info array
		SetLog ("Your Town Hall is Level: " & $iTownHallLevel, $COLOR_GREEN)
	Else
	  SetLog ("Your Town Hall Level was not found, please restart the bot" & $iTownHallLevel, $COLOR_BLUE)
	EndIf

	ClickP($aTopLeftClient, 2, 200)  ; Unselect TH

	EndFunc
