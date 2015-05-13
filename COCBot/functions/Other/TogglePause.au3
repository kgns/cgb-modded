; TogglePause

HotKeySet("{PAUSE}", "TogglePause")

Func TogglePause()
   Local $BlockInputPausePrev
	$TPaused = NOT $TPaused
	If $TPaused and $Runstate = True Then
		TrayTip($sBotTitle, "", 1)
		TrayTip($sBotTitle, "was Paused!", 1, $TIP_ICONEXCLAMATION)
		Setlog("ClashGameBot was Paused!",$COLOR_RED)
		 If $BlockInputPause>0 Then	 $BlockInputPausePrev=$BlockInputPause
		 If $BlockInputPause>0 Then  _BlockInputEx(0,"","",$HWnD)
		GUICtrlSetState($btnPause, $GUI_HIDE)
		GUICtrlSetState($btnResume, $GUI_SHOW)
	ElseIf $TPaused = False And $Runstate = True Then
		TrayTip($sBotTitle, "", 1)
		TrayTip($sBotTitle, "was Resumed.", 1, $TIP_ICONASTERISK)
		Setlog("ClashGameBot was Resumed.",$COLOR_GREEN)
		 If $BlockInputPausePrev>0 Then  _BlockInputEx($BlockInputPausePrev,"","",$HWnD)
		 If $BlockInputPausePrev>0 Then $BlockInputPausePrev=0
		GUICtrlSetState($btnPause, $GUI_SHOW)
		GUICtrlSetState($btnResume, $GUI_HIDE)
	EndIf

	While $TPaused ; Actual Pause loop
		If _Sleep(100) Then ExitLoop
	WEnd
	; everything below this WEnd is executed when unpaused!
	ZoomOut()
	If _Sleep(250) Then Return
EndFunc