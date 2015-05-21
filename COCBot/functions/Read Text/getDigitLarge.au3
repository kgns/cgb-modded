;==============================================================================================================
;=== Get Digit Large ==========================================================================================
;--------------------------------------------------------------------------------------------------------------
;Finds pixel color pattern of specific X and Y values, returns digit if pixel color pattern found.
;--------------------------------------------------------------------------------------------------------------
;13/5/15 01.46
Func getDigitLarge(ByRef $x, $y, $type)
    Local $width = 0
    Local $i = 0


	;Search for digit 0 reverse
    $width = 16;*
    Select
        Case $type = "ReturnHome"
            Local $c1 = Hex(0x8F8F8F, 6), $c2 = Hex(0x424242, 6), $c3 = Hex(0xAFAFAF, 6)
    EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 6 + $i, $y + 6, $c1], $pixel2[3] = [$x - 6 +$i, $y + 9, $c2], $pixel3[3] = [$x - 1 +$i, $y + 16, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 0 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 6 + $i, $y + 6 ) , $COLOR_BLACK)
		 SetLog("digit 0 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 6 + $i, $y + 9 ) , $COLOR_BLACK)
		 SetLog("digit 0 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 1 + $i, $y + 16) , $COLOR_BLACK)
		 SetLog("check 0 return " & boolPixelSearch($pixel1, $pixel2, $pixel3) )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "0"
	 Else
		$i += 1
     EndIf
    WEnd


    ;Search for digit 1 reverse
    $width = 7
    Select
        Case $type = "ReturnHome"
            Local $c1 = Hex(0xe0e0e0, 6), $c2 = Hex(0xbfbfbf, 6), $c3 = Hex(0x7b7b7b, 6)
    EndSelect
	$i = -3
	while $i <= 3
	  Local $pixel1[3] = [$x - 6 + $i, $y + 2, $c1], $pixel2[3] = [$x - 1 + $i, $y + 17, $c2], $pixel3[3] = [$x - 5 + $i, $y + 17, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 1 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 6 + $i, $y + 2 ) , $COLOR_BLACK)
		 SetLog("digit 1 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 1 + $i, $y + 17) , $COLOR_BLACK)
		 SetLog("digit 1 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 5 + $i, $y + 17) , $COLOR_BLACK)
		 SetLog("check 1 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "1"
	 Else
		$i += 1
     EndIf
    WEnd


    ;Search for digit 2
    $width = 13
    Select
        Case $type = "ReturnHome"
            Local $c1 = Hex(0x707070, 6), $c2 = Hex(0x898989, 6), $c3 = Hex(0xBFBFBF, 6)
		EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 12 + $i, $y + 10, $c1], $pixel2[3] = [$x - 7 + $i, $y + 7, $c2], $pixel3[3] = [$x - 5 + $i, $y + 11, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 2 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 12 + $i, $y + 10) , $COLOR_BLACK)
		 SetLog("digit 2 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 7  + $i, $y + 7 ) , $COLOR_BLACK)
		 SetLog("digit 2 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 5  + $i, $y + 11) , $COLOR_BLACK)
		 SetLog("check 2 return " & boolPixelSearch($pixel1, $pixel2, $pixel3) , $COLOR_GREEN)
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "2"
	 Else
		$i += 1
     EndIf
    WEnd

    ;Search for digit 3 reverse
    $width = 13
    Select
        Case $type = "ReturnHome"
            Local $c1 = Hex(0xdfdfdf, 6), $c2 = Hex(0x868686, 6), $c3 = Hex(0xB7B7B7, 6)
    EndSelect
	$i = -3
	while $i <= 3
	  Local $pixel1[3] = [$x - 9 + $i, $y + 4, $c1], $pixel2[3] = [$x - 6 + $i, $y + 11, $c2], $pixel3[3] = [$x - 3 + $i, $y + 17, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 3 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 9 + $i, $y + 4 ) , $COLOR_BLACK)
		 SetLog("digit 3 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 6 + $i, $y + 11) , $COLOR_BLACK)
		 SetLog("digit 3 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 3 + $i, $y + 17) , $COLOR_BLACK)
		 SetLog("check 3 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "3"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for digit 4 reverse
	$width = 15 ; correzione per valore 74
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0xa0a0a0, 6), $c2 = Hex(0xD9D9D9, 6), $c3 = Hex(0x707070, 6)
	EndSelect
	$i = -3
	while $i <= 3
	  Local $pixel1[3] = [$x - 11 + $i, $y + 2, $c1], $pixel2[3] = [$x - 12 + $i, $y + 4, $c2], $pixel3[3] = [$x - 2 + $i, $y + 14, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 4 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 11+ $i, $y + 2 ) , $COLOR_BLACK)
		 SetLog("digit 4 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 12+ $i, $y + 4 ) , $COLOR_BLACK)
		 SetLog("digit 4 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 2 + $i, $y + 14) , $COLOR_BLACK)
		 SetLog("check 4 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "4"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for digit 5 reverse
	$width = 13
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x9f9f9f, 6), $c2 = Hex(0xB6B6B6, 6), $c3 = Hex(0xBFBFBF, 6)
	EndSelect
	$i = -3
	while $i <= 3
	  Local $pixel1[3] = [$x - 7 + $i, $y + 5, $c1], $pixel2[3] = [$x - 6 + $i, $y + 12, $c2], $pixel3[3] = [$x - 5 + $i, $y + 17, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 5 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 7 + $i, $y + 5 ) , $COLOR_BLACK)
		 SetLog("digit 5 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 6 + $i, $y + 12) , $COLOR_BLACK)
		 SetLog("digit 5 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 5 + $i, $y + 17) , $COLOR_BLACK)
		 SetLog("check 5 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "5"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for digit 6 reverse
	$width = 15
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x575757, 6), $c2 = Hex(0xB7B7B7, 6), $c3 = Hex(0xB9B9B9, 6)
	EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 8 + $i, $y + 5, $c1], $pixel2[3] = [$x - 8 + $i, $y + 11, $c2], $pixel3[3] = [$x - 3 + $i, $y + 8, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 6 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 8 + $i, $y + 5 ) , $COLOR_BLACK)
		 SetLog("digit 6 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 5 + $i, $y + 11) , $COLOR_BLACK)
		 SetLog("digit 6 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 3 + $i, $y + 8 ) , $COLOR_BLACK)
		 SetLog("check 6 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "6"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for digit 7 reverse
	$width = 13
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0xA7A7A7, 6), $c2 = Hex(0x757575, 6), $c3 = Hex(0xA7A7A7, 6)
	EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 6 + $i, $y + 15, $c1], $pixel2[3] = [$x - 7 + $i, $y + 5, $c2], $pixel3[3] = [$x - 3 + $i, $y + 9, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 7 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 6 + $i, $y + 15) , $COLOR_BLACK)
		 SetLog("digit 7 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 7 + $i, $y + 5 ) , $COLOR_BLACK)
		 SetLog("digit 7 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 3 + $i, $y + 9 ) , $COLOR_BLACK)
		 SetLog("check 7 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "7"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for digit 8 reverse
	$width = 16
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x575757, 6), $c2 = Hex(0xb5b5b5, 6), $c3 = Hex(0x4a4a4a, 6)
	EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 8 + $i, $y + 4, $c1], $pixel2[3] = [$x - 13 + $i, $y + 8, $c2], $pixel3[3] = [$x - 9 + $i, $y + 14, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 8 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 8 + $i, $y + 4 ) , $COLOR_BLACK)
		 SetLog("digit 8 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 13+ $i, $y + 8 ) , $COLOR_BLACK)
		 SetLog("digit 8 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 9 + $i, $y + 14) , $COLOR_BLACK)
		 SetLog("check 8 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "8"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for digit 9 revers
	$width = 15
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x6e6e6e, 6), $c2 = Hex(0x262626, 6), $c3 = Hex(0x151515, 6)
	EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 7 + $i, $y + 5, $c1], $pixel2[3] = [$x - 7 + $i, $y + 12, $c2], $pixel3[3] = [$x - 2 + $i, $y + 16, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("digit 9 pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 7 + $i, $y + 5 ) , $COLOR_BLACK)
		 SetLog("digit 9 pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 7 + $i, $y + 12) , $COLOR_BLACK)
		 SetLog("digit 9 pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 2 + $i, $y + 16) , $COLOR_BLACK)
		 SetLog("check 9 return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "9"
	 Else
		$i += 1
     EndIf
    WEnd

	;Search for sign - revers
	$width = 7
	Select
		Case $type = "ReturnHome"
			Local $c1 = Hex(0x989898, 6), $c2 = Hex(0x7E7E7E, 6), $c3 = Hex(0x565656, 6)
	EndSelect
	$i = -3
	while $i <= 3
      Local $pixel1[3] = [$x - 5 + $i, $y + 9, $c1], $pixel2[3] = [$x - 4 + $i, $y + 13, $c2], $pixel3[3] = [$x - 2 + $i, $y + 13, $c3]
	  if $debug_getdigitlarge=1 then
		 SetLog("sign - pixel1 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 5 + $i, $y + 9 ) , $COLOR_BLACK)
		 SetLog("sign - pixel2 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 4 + $i, $y + 13) , $COLOR_BLACK)
		 SetLog("sign - pixel3 at " & $x + $i & "," & $y & " return " & _GetPixelColor($x - 2 + $i, $y + 13) , $COLOR_BLACK)
		 SetLog("sign - return " & boolPixelSearch($pixel1, $pixel2, $pixel3), $COLOR_GREEN )
	  EndIf
	  If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
        $x -= $width -$i  ;Adds to x coordinate to get the next digit
        Return "-"
	 Else
		$i += 1
     EndIf
    WEnd

	Return ""
EndFunc   ;==>getDigitLarge