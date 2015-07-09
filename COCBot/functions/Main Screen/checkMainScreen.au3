
; #FUNCTION# ====================================================================================================================
; Name ..........: checkMainScreen
; Description ...: Checks whether the pixel, located in the eyes of the builder in mainscreen, is available
;						If it is not available, it calls checkObstacles and also waitMainScreen.
; Syntax ........: checkMainScreen([$Check = True])
; Parameters ....: $Check               - [optional] an unknown value. Default is True.
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......: checkObstacles(), waitMainScreen()
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func checkMainScreen($Check = True) ;Checks if in main screen
	If $Check = True Then
		SetLog("Trying to locate Main Screen")
		_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage
	EndIf

	While _CheckPixel($aIsMain, $bCapturePixel) = False
		$HWnD = WinGetHandle($Title)

		If _Sleep(1000) Then Return
		If checkObstacles() = False Then
			WinActivate($HWnD)  ; ensure bot has window focus
			Click(126, 700, 2, 500,"#0126")  ; click on BS home button twice to clear error and go home.
			Local $RunApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "RunApp")
			Run($RunApp & " Android com.supercell.clashofclans com.supercell.clashofclans.GameApp")
		Else
			$Restart = True
		EndIf
		waitMainScreen()
	WEnd
	ZoomOut()
	If $Check = True Then SetLog("Main Screen Located", $COLOR_GREEN)
EndFunc   ;==>checkMainScreen
