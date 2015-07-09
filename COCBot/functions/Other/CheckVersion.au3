; #FUNCTION# ====================================================================================================================
; Name ..........: CheckVersion
; Description ...: Check if we have last version of program
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Sardo (2015-06)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================




Func CheckVersionTXT()
	;download page from site contains last bot version
	$hLastVersion = InetGet("https://gamebot.org/lastversion.txt", @ScriptDir & "\LastVersion.txt")
	InetClose($hLastVersion)

	;search version into downloaded page
	Local $f, $line, $Casesense = 0
	$lastversion =""

	If FileExists(@ScriptDir & "\LastVersion.txt") Then
		$f = FileOpen(@ScriptDir & "\LastVersion.txt", 0)
		; Read in lines of text until the EOF is reached
		While 1
			$line = FileReadLine($f)
			If  @error = -1 Then ExitLoop
			If StringInStr($line, "version=", $Casesense) Then
				$lastversion = StringMid($line,9,-1)
			EndIf
			If StringInStr($line, "message=", $Casesense) Then
				$lastmessage = StringMid($line,9,-1)
			EndIf
		WEnd
		FileClose($f)
		FileDelete (@ScriptDir & "\LastVersion.txt")
	EndIf
EndFunc

Func CheckVersionHTML()
	;download page from site contains last bot version
	$hLastVersion = InetGet("https://raw.githubusercontent.com/ClashGameBot/CGB/master/LastVersion.txt" , @ScriptDir & "\LastVersion.txt")
	InetClose($hLastVersion)
	;search version into downloaded page
	Local $f, $line, $Casesense = 0
	$lastversion =""

	If FileExists(@ScriptDir & "\LastVersion.txt") Then
		$f = FileOpen(@ScriptDir & "\LastVersion.txt", 0)
		; Read in lines of text until the EOF is reached
		While 1
			$line = FileReadLine($f)
			If  @error = -1 Then ExitLoop
			If StringInStr(StringUpper($line), "version #", $Casesense) Then
				$line = StringMid($line,StringInStr(StringUpper($line), "version #", $Casesense),-1) ;select line from string found to end of string
				Local $first_double_quote  = StringInStr($line,"#",0,1)
				Local $second_double_quote = StringInStr($line,"#",0,2)
				$lastversion = StringMid( $line, $first_double_quote+1,$second_double_quote - $first_double_quote -1)
				ExitLoop
			EndIf
		WEnd
		FileClose($f)
		FileDelete (@ScriptDir & "\LastVersion.txt")
	EndIf
EndFunc

