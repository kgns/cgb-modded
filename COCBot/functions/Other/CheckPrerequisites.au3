Func isNetFramework4Installed()
	Local $z = 0, $sKeyName, $success = False
	Do
		$z += 1
		$sKeyName = RegEnumKey("HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP", $z)
		If StringRegExp($sKeyName, "v4|v4.\d+") Then
			$success = True
		EndIf
	Until $sKeyName = '' Or $success
	Return $success
EndFunc   ;==>isNetFramework4Installed

Func isVC2010Installed()
	Local $listRegistry[4]=[	"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x86", _
							"HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\10.0\VC\VCRedist\x86", _
							"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\12.0\VC\Runtimes\x86", _
							"HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\VC\Runtimes\x86" _
						   ]

	Local $success = False
	For $reg In $listRegistry
		$sKeyName = RegRead($reg, "Version")
		If $sKeyName <> "" Then
			$success = True
			ExitLoop
		EndIf
	Next

	Return $success
EndFunc   ;==>isVC2010Installed


Func CheckPrerequisites()
	Local $isNetFramework4Installed = isNetFramework4Installed()
	Local $isVC2010Installed = isVC2010Installed()
	If ($isNetFramework4Installed = False Or $isVC2010Installed = False) Then
		If ($isNetFramework4Installed = False) Then
			SetLog("The .Net Framework 4 is not installed", $COLOR_RED)
			SetLog("Please download here : https://www.microsoft.com/en-US/download/details.aspx?id=17851", $COLOR_RED)
		EndIf
		If ($isVC2010Installed = False) Then
			SetLog("The VC 2010 x86 is not installed", $COLOR_RED)
			SetLog("Please download here : https://www.microsoft.com/en-US/download/details.aspx?id=5555", $COLOR_RED)
		EndIf

		GUICtrlSetState($btnStart, $GUI_DISABLE)
	EndIf
EndFunc   ;==>CheckPrerequisites