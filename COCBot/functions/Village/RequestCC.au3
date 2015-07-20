; #FUNCTION# ====================================================================================================================
; Name ..........: RequestCC
; Description ...:
; Syntax ........: RequestCC()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #73
; Modified ......: (2015-06) Sardo
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func RequestCC()

	If $ichkRequest <> 1 Or $bDonationEnabled = False Then
		Return
	EndIf

	If $iPlannedRequestCCHoursEnable = 1 Then
		Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)
		If $iPlannedRequestCCHours[$hour[0]] = 0 Then
			SetLog("Request CC not Planned, Skipped..", $COLOR_GREEN)
			Return ; exit func if no planned donate checkmarks
		EndIf
	EndIf

	SetLog("Requesting Clan Castle Troops", $COLOR_BLUE)

	;open army overview
	Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#9999")

	;wait to see army overview
	Local $icount = 0
	While Not ( _ColorCheck(_GetPixelColor($aArmyOverviewTest[0], $aArmyOverviewTest[1], True), Hex($aArmyOverviewTest[2], 6), $aArmyOverviewTest[3]))
		If _Sleep(100) Then ContinueLoop
		$icount = $icount + 1
		If $icount = 5 Then ExitLoop
	WEnd
	If $icount = 5 And $debugSetlog = 1 Then Setlog("RequestCC warning 1")

	$color = _GetPixelColor($aRequestTroopsAO[0], $aRequestTroopsAO[1], True)
	If _ColorCheck($color, Hex($aRequestTroopsAO[2], 6), $aRequestTroopsAO[5]) Then
		;can make a request
		Local $x = _makerequest()
	ElseIf _ColorCheck($color, Hex($aRequestTroopsAO[3], 6), $aRequestTroopsAO[5]) Then
		;request has allready been made
		SetLog("Request has already been made")
	ElseIf _ColorCheck($color, Hex($aRequestTroopsAO[4], 6), $aRequestTroopsAO[5]) Then
		;clan full or not in clan
		SetLog("Your Clan Castle is already full or you are not in a clan.")
	Else
		;no button request found
		SetLog("Cannot detect button request troops.")
	EndIf

	;exit from army overview
	Click(1, 1, 2, 0, "#9999")

EndFunc   ;==>RequestCC


Func _makerequest()
	;click button request troops
	Click($aRequestTroopsAO[0], $aRequestTroopsAO[1], 1, 0, "#9999") ;Select text for request

	;wait window
	Local $icount = 0
	While Not ( _ColorCheck(_GetPixelColor($aCancRequestCCBtn[0], $aCancRequestCCBtn[1], True), Hex($aCancRequestCCBtn[2], 6), $aCancRequestCCBtn[3]))
		_Sleep(100)
		$icount = $icount + 1
		If $icount = 5 Then ExitLoop
	WEnd
	If $icount = 5 Then
		SetLog("Unable to request, or request has already been made", $COLOR_RED)
		Click(1, 1, 2, 0, "#0257")
	Else
		If $sTxtRequest <> "" Then
			Click($atxtRequestCCBtn[0], $atxtRequestCCBtn[1], 1, 0, "#0254") ;Select text for request
			_Sleep(250)
			ControlSend($Title, "", "", $sTxtRequest, 0)
		EndIf
		$icount = 0
		While Not _ColorCheck(_GetPixelColor($aSendRequestCCBtn[0], $aSendRequestCCBtn[1], True), Hex(0x5fac10, 6), 20)
			_Sleep(50)
			$icount += 1
			If $icount = 100 Then ExitLoop
		WEnd
		If $icount = 100 Then
			If $debugSetlog = 1 Then SetLog("send request button not found")
			;emergency exit
		    checkMainScreen(False)
		EndIf
		Click($aSendRequestCCBtn[0], $aSendRequestCCBtn[1], 1, 100, "#0256") ; click send button
	EndIf

EndFunc   ;==>_makerequest
