Func _Sleep($iDelay, $iSleep = True)
	Local $iBegin = TimerInit()
	While TimerDiff($iBegin) < $iDelay
		If $RunState = False Then Return True
		tabMain()
		If $iSleep = True Then Sleep(50)
	WEnd
	Return False
EndFunc   ;==>_Sleep