; #FUNCTION# ====================================================================================================================
; Name ..........: Click, PureClick, ClickP
; Description ...: Clicks the BS screen on desired location
; Syntax ........: Click($x, $y, $times, $speed)
; Parameters ....: $x, $y are mandatory, $times and $speed are optional
; Return values .: None
; Author ........: (2014)
; Modified ......: HungLe (may-2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......: checkMainscreen, isProblemAffect
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func Click($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			If isProblemAffect(True) Then checkMainScreen(False)
			ControlClick($Title, "", "", "left", "1", $x, $y)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		If isProblemAffect(True) Then checkMainScreen(False)
		ControlClick($Title, "", "", "left", "1", $x, $y)
	EndIf
EndFunc   ;==>Click

Func PureClick($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "left", "1", $x, $y)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		ControlClick($Title, "", "", "left", "1", $x, $y)
	EndIf
EndFunc   ;==>PureClick

; ClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func ClickP($point, $howMuch = 1, $speed = 0)
	Click($point[0], $point[1], $howMuch, $speed)
EndFunc   ;==>ClickP
