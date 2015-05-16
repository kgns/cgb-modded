;auto start Mod
If GUICtrlRead($chkAutoStart) = $GUI_CHECKED Then
SetLog("[MOD AutoStart - Sm0kE]: Starting in 10 seconds", $COLOR_RED)
sleep(10000)
ControlClick('[REGEXPTITLE:(?i).*?Clash Game Bot v3.0.*?]', "Start Bot", "[CLASS:Button; TEXT:Start Bot]", "left", "1")
EndIf