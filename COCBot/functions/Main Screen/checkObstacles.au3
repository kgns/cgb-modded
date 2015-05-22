;Checks whether something is blocking the pixel for mainscreen and tries to unblock
;Returns True when there is something blocking

Func checkObstacles() ;Checks if something is in the way for mainscreen
    Local $x, $y
	_CaptureRegion()
	;coded by hungle from gamebot.org
    If _ImageSearchArea($device, 0, 237, 321, 293, 346, $x, $y, 80) Then
		if $sTimeWakeUp > 3600 then
			SetLog("Another Device has connected, waiting " & Floor(Floor($sTimeWakeUp / 60) / 60) & " hours " & Floor(Mod(Floor($sTimeWakeUp / 60), 60)) & " minutes " & Floor(Mod($sTimeWakeUp, 60)) & " seconds", $COLOR_RED)
			PushMsg("AnotherDevice3600")
		Elseif $sTimeWakeUp > 60 then
			SetLog("Another Device has connected, waiting " & Floor(Mod(Floor($sTimeWakeUp / 60), 60)) & " minutes " & Floor(Mod($sTimeWakeUp, 60)) & " seconds", $COLOR_RED)
			PushMsg("AnotherDevice60")
		else
			SetLog("Another Device has connected, waiting " & Floor(Mod($sTimeWakeUp, 60)) & " seconds", $COLOR_RED)
			PushMsg("AnotherDevice")
		endif
		If _Sleep($sTimeWakeUp * 1000) Then Return ; 2 Minutes
		$iTimeTroops = 0
		PureClick(416, 399);Check for "Another device" message
		If _Sleep(2000) Then Return
        Return True
	Endif
    If _ImageSearch($break, 0, $x, $y, 80) Then
        SetLog("Village must take a break, wait ...", $COLOR_RED)
	    PushMsg("TakeBreak")
        If _Sleep(120000) Then Return ; 2 Minutes
        PureClick(416, 399);Check for "Take a break" message
        Return True
	 EndIf
	  If _ImageSearchArea($CocStopped, 0, 250, 328, 618, 402, $x, $y, 70) Then
	 SetLog("CoC Has Stopped Error .....", $COLOR_RED)
	 PushMsg("CoCError")
        If _Sleep(1000) Then Return
        PureClick(250+$x, 328+$y, 2, 100);Check for "CoC has stopped error, looking for OK message" on screen
If _Sleep(2000) Then Return
  PureClick(126, 700, 1, 500)
   Local $RunApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "RunApp")
   Run($RunApp & " Android com.supercell.clashofclans com.supercell.clashofclans.GameApp")
  Return True
  EndIf
  $Message = _PixelSearch(457, 300, 458, 330, Hex(0x33B5E5, 6), 10)
	If IsArray($Message) Then
		PureClick(416, 399);Check for out of sync or inactivity
		If _Sleep(5000) Then Return
		Return True
	EndIf
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(235, 209), Hex(0x9E3826, 6), 20) Then
		PureClick(429, 493);See if village was attacked, clicks Okay
		Return True
	EndIf
	If _ColorCheck(_GetPixelColor(284, 28), Hex(0x215B69, 6), 20) Then
		PureClick(1, 1) ;Click away If things are open
		Return True
	EndIf
	If _ColorCheck(_GetPixelColor(819, 55), Hex(0xD80400, 6), 20) Then
		PureClick(819, 55) ;Clicks X
		Return True
	EndIf
	If _ColorCheck(_GetPixelColor(822, 48), Hex(0xD80408, 6), 20) Or _ColorCheck(_GetPixelColor(830, 59), Hex(0xD80408, 6), 20) Then
		PureClick(822, 48) ;Clicks X
		Return True
	EndIf
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		PureClick(331, 330) ;Clicks chat thing
		If _Sleep(1000) Then Return
		Return True
	EndIf
	If _ColorCheck(_GetPixelColor(429, 519), Hex(0xB8E35F, 6), 20) Then
		PureClick(429, 519) ;If in that victory or defeat scene
		Return True
	EndIf
	If _ColorCheck(_GetPixelColor(71, 530), Hex(0xC00000, 6), 20) Then
		ReturnHome(False, False) ;If End battle is available
		Return True
	EndIf
    $Message = _PixelSearch(19, 565, 104, 580, Hex(0xD9DDCF, 6), 10)
	If IsArray($Message) Then
		PureClick(67, 602);Check if Return Home button available
		If _Sleep(2000) Then Return
		Return True
	EndIf

	Return False
EndFunc   ;==>checkObstacles
