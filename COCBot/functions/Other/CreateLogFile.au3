Func CreateLogFile()
    $sLogFName = @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & ".log"
	$sLogPath = $dirLogs & $sLogFName
	$hLogFileHandle = FileOpen($sLogPath, $FO_APPEND)
EndFunc   ;==>CreateLogFile