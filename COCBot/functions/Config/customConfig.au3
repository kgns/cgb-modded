Global $config

Func btnLoadConfig()
	Local $sFileOpenDialog = FileOpenDialog("Open config", @ScriptDir & "\", "Config (*.ini;)", $FD_FILEMUSTEXIST)

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error opening file!")
		FileChangeDir(@ScriptDir)
	Else
		FileChangeDir(@ScriptDir)
		$sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)
		$config = $sFileOpenDialog
		readConfig()
		applyConfig()
		MsgBox($MB_SYSTEMMODAL, "", "Config loaded successfully!" & @CRLF & $sFileOpenDialog)
	EndIf
EndFunc   ;==>btnLoadConfig

Func btnSaveConfig()
	Local $sFileSaveDialog = FileSaveDialog("Save current config as..", @ScriptDir & "\", "Config (*.ini)", $FD_PATHMUSTEXIST)

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Config save failed!")
	Else
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSE, -1))
		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSE)

		If $iExtension Then
			If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".ini") Then $sFileSaveDialog &= ".ini"
		Else
			$sFileSaveDialog &= ".ini"
		EndIf

		$config = $sFileSaveDialog
		saveConfig()
		MsgBox($MB_SYSTEMMODAL, "", "Successfully saved the current configuration!" & @CRLF & $sFileSaveDialog)
	EndIf
EndFunc   ;==>btnSaveConfig


Func getfilename($psFilename)
	Local $szDrive, $szDir, $szFName, $szExt
	_PathSplit($psFilename, $szDrive, $szDir, $szFName, $szExt)
	Return $szFName & $szExt
EndFunc   ;==>getfilename
