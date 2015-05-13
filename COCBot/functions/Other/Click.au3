;HungLe from gamebot.org
Func Click($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			if isProblemAffect(true) then checkMainScreen(false)
			ControlClick($Title, "", "", "left", "1", $x, $y)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		if isProblemAffect(true) then checkMainScreen(false)
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
 EndFunc   ;==>Click
 ; ClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func ClickP($point, $howMuch=1, $speed = 0)
   Click($point[0], $point[1], $howMuch, $speed)
EndFunc