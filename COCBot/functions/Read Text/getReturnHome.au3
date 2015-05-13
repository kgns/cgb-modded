;Returns complete value of other

Func getReturnHome($x_start, $y_start, $type)
    _CaptureRegion(0, 0, $x_start + 120, $y_start + 25)
    ;-----------------------------------------------------------------------------
    Local $x = $x_start, $y = $y_start
    Local $Number, $i = 0

    Switch $type
        Case "ReturnTrophy"
            $Number = getDigitLarge($x, $y, "ReturnHome")

            While $Number = ""
                If $i >= 50 Then ExitLoop
                $i += 1
                $x += 1
                $Number = getDigitLarge($x, $y, "ReturnHome")
            WEnd

            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")

        Case "ReturnResource"
            $Number = getDigitLarge($x, $y, "ReturnHome")

            While $Number = ""
                If $i >= 120 Then ExitLoop
                $i += 1
                $x += 1
                $Number = getDigitLarge($x, $y, "ReturnHome")
            WEnd

            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $x += 9
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $x += 9
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")
            $Number &= getDigitLarge($x, $y, "ReturnHome")

    EndSwitch

    Return $Number
EndFunc   ;==>getOther