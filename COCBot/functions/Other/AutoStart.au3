;auto start Mod
If GUICtrlRead($chkAutoStart) = $GUI_CHECKED OR $restarted = 1 Then
	SetLog("[MOD AutoStart - Sm0kE]: Starting in 10 seconds", $COLOR_RED)
	sleep(10000)
	ControlClick('[REGEXPTITLE:(?i).*?Clash Game Bot v3.*?]', "Start Bot", "[CLASS:Button; TEXT:Start Bot]", "left", "1")
EndIf
