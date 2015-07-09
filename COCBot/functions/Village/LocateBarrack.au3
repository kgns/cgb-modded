; #FUNCTION# ====================================================================================================================
; Name ..........: LocateBarrack
; Description ...:
; Syntax ........: LocateBarrack([$ArmyCamp = False])
; Parameters ....: $ArmyCamp            - [optional] Flag to set if locating army camp and not barrack Default is False.
; Return values .: None
; Author ........: Code Monkey #19
; Modified ......: KnowJack (June 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateBarrack($ArmyCamp = False)
	Local $choice = "Barrack"
	Local $stext, $MsgBox, $iCount
	Local $aGetArmySize[3] = ["", "", ""]
	Local $sArmyInfo = ""

	If $ArmyCamp Then $choice = "Army Camp"
	SetLog("Locating " & $choice & "...", $COLOR_BLUE)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = "Click OK then click on one of your " & $choice & "'s." & @CRLF & "Do not move mouse quickly after clicking location"
		$MsgBox = _ExtMsgBox(32, "OK", "Locate " & $choice, $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			If $ArmyCamp Then
				$ArmyPos[0] = FindPos()[0]
				$ArmyPos[1] = FindPos()[1]
				If isInsideDiamond($ArmyPos) = False Then
					SetLog("Location not valid", $COLOR_RED)
					ContinueLoop
				EndIf
				SetLog($choice & ": " & "(" & $ArmyPos[0] & "," & $ArmyPos[1] & ")", $COLOR_GREEN)
			Else
				$barrackPos[0] = FindPos()[0]
				$barrackPos[1] = FindPos()[1]
				If isInsideDiamond($barrackPos) = False Then
					SetLog("Location not valid, try again", $COLOR_RED)
					ContinueLoop
				EndIf
				SetLog($choice & ": " & "(" & $barrackPos[0] & "," & $barrackPos[1] & ")", $COLOR_GREEN)
			EndIf
		EndIf
		ExitLoop
	WEnd
	If $ArmyCamp Then
		$TotalCamp = 0 ; reset total camp number to get it updated
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 500)
		$stext = "Keep Mouse OUT of BlueStacks Window While I Update Army Camp Number, Thanks!!"
		$MsgBox = _ExtMsgBox(48, "OK", "Notice!", $stext, 15, $frmBot)
		If _Sleep(1000) Then Return

		ClickP($aTopLeftClient) ;Click Away
		If _Sleep(100) Then Return

		Click($aArmyTrainButton[0], $aArmyTrainButton[1]) ;Click Army Camp
		If _Sleep(1000) Then Return

		$iCount = 0  ; reset loop counter
		$sArmyInfo = getArmyCampCap(212, 144) ; OCR read army trained and total
		If $debugSetlog = 1 Then Setlog("$sArmyInfo = " & $sArmyInfo, $COLOR_PURPLE)
		While $sArmyInfo = ""  ; In case the CC donations recieved msg are blocking, need to keep checking numbers for 10 seconds
			If _Sleep(2000) Then Return
			$sArmyInfo = getArmyCampCap(212, 144) ; OCR read army trained and total
			If $debugSetlog = 1 Then Setlog(" $sArmyInfo = " & $sArmyInfo, $COLOR_PURPLE)
			$iCount += 1
			If $iCount > 4 Then ExitLoop
		WEnd

		$aGetArmySize = StringSplit($sArmyInfo, "#") ; split the trained troop number from the total troop number
		If $debugSetlog = 1 Then Setlog("$aGetArmySize[0]= " & $aGetArmySize[0] & "$aGetArmySize[1]= " & $aGetArmySize[1] & "$aGetArmySize[2]= " & $aGetArmySize[2], $COLOR_PURPLE)
		If $aGetArmySize[0] > 1 Then ; check if the OCR was valid and returned both values
			$TotalCamp = Number($aGetArmySize[2])
			Setlog("$TotalCamp = " & $TotalCamp, $COLOR_GREEN)
		Else
			Setlog("Army size read error", $COLOR_RED) ; log if there is read error
		EndIf

		If $TotalCamp = 0 Then ; if Total camp size is still not set
			If $ichkTotalCampForced = 0 Then ; check if forced camp size set in expert tab
				$sInputbox = InputBox("Question", "Enter your total Army Camp capacity", "200", "", Default, Default, Default, Default, 0, $frmbot)
				$TotalCamp = Number($sInputbox)
				Setlog("Army Camp User input = " & $TotalCamp, $COLOR_RED) ; log if there is read error AND we ask the user to tell us.
			Else
				$TotalCamp = Number($iValueTotalCampForced)
			EndIf
		EndIf
	EndIf
	ClickP($aTopLeftClient, 1, 0, "#0206")

EndFunc   ;==>LocateBarrack
