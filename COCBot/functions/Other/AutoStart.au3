; auto start script by Sm0kE
; edited: 2015-06 sardo - parametrized $ichkAutoStartDelay
If GUICtrlRead($chkAutoStart) = $GUI_CHECKED OR $restarted = 1 Then
	SetLog("Bot Auto Starting in " & $ichkAutoStartDelay & " seconds", $COLOR_RED)
	sleep($ichkAutoStartDelay*1000)
	ControlClick($sBotTitle, "Start Bot", "[CLASS:Button; TEXT:Start Bot]", "left", "1")
EndIf
