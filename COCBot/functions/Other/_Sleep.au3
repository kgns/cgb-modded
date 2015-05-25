Func _Sleep($iDelay, $iSleep = True)
	If $iDeleteAllPushesNow = True Then PushMsg("DeleteAllPBMessages") ; only when button is pushed, and only when on a sleep cyle
	Local $iBegin = TimerInit()
	While TimerDiff($iBegin) < $iDelay
		If $RunState = False Then Return True
		tabMain()
		If $iSleep = True Then Sleep(50)
	WEnd
	Return False
EndFunc   ;==>_Sleep

Func _SleepStatus($iDelay, $iSleep = True, $bDirection = True)
	;
	; $bDirection: True equals count down display, False equals count up display
	;
	Local $iCurTime, $iMinCalc, $iSecCalc, $iTime, $iBegin, $sString
	Local $iDelayMinCalc, $iDelaySecCalc, $iDelaySecCalc
	Local Const $Font = "Verdana"
	Local Const $FontSize = 7.5
	$iBegin = TimerInit()
	$iDelayMinCalc = Int($iDelay / (60 * 1000))
	$iDelaySecCalc = $iDelay - ($iDelayMinCalc * 60 * 1000)
	$iDelaySecCalc = Int($iDelaySecCalc / 1000)
	While TimerDiff($iBegin) < $iDelay
		If $RunState = False Then Return True
		$iCurTime = TimerDiff($iBegin)
		$iTime = $iCurTime ; display count up timer
		If $bDirection = True Then $iTime = $iDelay - $iCurTime ; display countdown timer
		$iMinCalc = Int($iTime / (60 * 1000))
		$iSecCalc = $iTime - ($iMinCalc * 60 * 1000)
		$iSecCalc = Int($iSecCalc / 1000)
		$sString = "Waiting Time= " & StringFormat("%02u" & ":" & "%02u", $iDelayMinCalc, $iDelaySecCalc) & ",  Time Left= " & StringFormat("%02u" & ":" & "%02u", $iMinCalc, $iSecCalc)
		_GUICtrlStatusBar_SetText($statLog, " Status: " & $sString)
		tabMain()
		If $iSleep = True Then Sleep(500)
	WEnd
	Return False
EndFunc   ;==>_SleepStatus
