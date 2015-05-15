Func CreateLogFile()
	$sLogPath = $dirLogs & "Logs_" & @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & ".log"
	$sLogFName = "Logs_" & @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & ".log"
	$hLogFileHandle = FileOpen($sLogPath, $FO_APPEND)
EndFunc   ;==>CreateLogFile