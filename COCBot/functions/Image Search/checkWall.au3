; #FUNCTION# ====================================================================================================================
; Name ..........: CheckWall()
; Description ...: This file Includes the detection of Walls for Upgrade
; Syntax ........:
; Parameters ....: None
; Return values .:
; Author ........: ProMac (2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Global $WallWord = 0
Global $WallLvc = 0

Global $checkwalllogic
Global $Wall[7][3]

;$Wall[0][0] = @ScriptDir & "\images\Walls\3_1.bmp"
;$Wall[0][1] = @ScriptDir & "\images\Walls\3_2.bmp"

$Wall[0][0] = @ScriptDir & "\images\Walls\4_1.bmp"
$Wall[0][1] = @ScriptDir & "\images\Walls\4_2.bmp"

$Wall[1][0] = @ScriptDir & "\images\Walls\5_1.bmp"
$Wall[1][1] = @ScriptDir & "\images\Walls\5_2.bmp"

$Wall[2][0] = @ScriptDir & "\images\Walls\6_1.bmp"
$Wall[2][1] = @ScriptDir & "\images\Walls\6_2.bmp"

$Wall[3][0] = @ScriptDir & "\images\Walls\7_1.bmp"
$Wall[3][1] = @ScriptDir & "\images\Walls\7_2.bmp"

$Wall[4][0] = @ScriptDir & "\images\Walls\8_1.bmp"
$Wall[4][1] = @ScriptDir & "\images\Walls\8_2.bmp"

$Wall[5][0] = @ScriptDir & "\images\Walls\9_1.bmp"
$Wall[5][1] = @ScriptDir & "\images\Walls\9_2.bmp"
$Wall[5][2] = @ScriptDir & "\images\Walls\9_3.bmp"

$Wall[6][0] = @ScriptDir & "\images\Walls\10_1.bmp"
$Wall[6][1] = @ScriptDir & "\images\Walls\10_2.bmp"

Global $WallX = 0, $WallY = 0, $WallLoc = 0


Func CheckWall()
	$WallLoc = 0
	Local $centerPixel[2] = [430, 313]
	If _Sleep(500) Then Return

	If $WallLoc = 0 Then
		_CaptureRegion(78, 200, 790, 360) ; Zona 2
		For $Tolerance2 = 0 To 65
			For $x = 0 To 1
				If $WallLoc = 0 Then
					;_CaptureRegion(78, 200, 790, 360)
					$WallLoc = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
					If $WallLoc = 1 Then
						$WallX += 78
						$WallY += 200
						SetLog("Tolerance is " & $Tolerance2 & " Wall segment in Zone 2: " & "[" & $WallX & "," & $WallY & "]", $COLOR_GREEN)
						SetLog("Found Walls level " & $icmbWalls + 4 & ", Verifying...", $COLOR_GREEN)
						ReportWallUpgrade($Tolerance2)
						$checkwalllogic = True
						Return True
					EndIf
				EndIf
			Next
		Next
	EndIf
	If $WallLoc = 0 Then
		_CaptureRegion(226, 74, 654, 204) ; Zona 1
		For $Tolerance2 = 0 To 65
			For $x = 0 To 1
				If $WallLoc = 0 Then
					;_CaptureRegion(226, 74, 654, 204)
					$WallLoc = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
					If $WallLoc = 1 Then
						$WallX += 226
						$WallY += 74
						SetLog("Tolerance is " & $Tolerance2 & " Wall segment in Zone 1: " & "[" & $WallX & "," & $WallY & "]", $COLOR_GREEN)
						SetLog("Found Walls level " & $icmbWalls + 4 & ", Verifying...", $COLOR_GREEN)
						ReportWallUpgrade($Tolerance2)
						$checkwalllogic = True
						Return True
					EndIf
				EndIf
			Next
		Next
	EndIf
	If $WallLoc = 0 Then
		_CaptureRegion(168, 355, 702, 430) ; Zona 3
		For $Tolerance2 = 0 To 65
			For $x = 0 To 1
				If $WallLoc = 0 Then
					;_CaptureRegion(168, 355, 702, 430)
					$WallLoc = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
					If $WallLoc = 1 Then
						$WallX += 168
						$WallY += 335
						SetLog("Tolerance is " & $Tolerance2 & " Wall segment in Zone 3: " & "[" & $WallX & "," & $WallY & "]", $COLOR_GREEN)
						SetLog("Found Walls level " & $icmbWalls + 4 & ", Verifying...", $COLOR_GREEN)
						ReportWallUpgrade($Tolerance2)
						$checkwalllogic = True
						Return True
					EndIf
				EndIf
			Next
		Next
	EndIf
	If $WallLoc = 0 Then
		_CaptureRegion(294, 425, 654, 520) ; Zona 4
		For $Tolerance2 = 0 To 65
			For $x = 0 To 1
				If $WallLoc = 0 Then
					;_CaptureRegion(294, 425, 654, 520)
					$WallLoc = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX, $WallY, $Tolerance2) ; Getting Wall Location
					If $WallLoc = 1 Then
						$WallX += 294
						$WallY += 425
						SetLog("Tolerance is " & $Tolerance2 & " Wall segment in Zone 4: " & "[" & $WallX & "," & $WallY & "]", $COLOR_GREEN)
						SetLog("Found Walls level " & $icmbWalls + 4 & ", Verifying...", $COLOR_GREEN)
						ReportWallUpgrade($Tolerance2)
						$checkwalllogic = True
						Return True
					EndIf
				EndIf
			Next
		Next
	EndIf

	If $WallLoc = 0 Then ; Verifycation if is a Wall and if is a Correct Level
		$checkwalllogic = False
		SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", Skip upgrade...", $COLOR_RED)
		ReportWallUpgradeFailed()
		Return False
	EndIf

EndFunc   ;==>CheckWall

Global $WallLv[7]
$WallLv[0] = @ScriptDir & "\images\Walls\LV4.bmp"
$WallLv[1] = @ScriptDir & "\images\Walls\LV5.bmp"
$WallLv[2] = @ScriptDir & "\images\Walls\LV6.bmp"
$WallLv[3] = @ScriptDir & "\images\Walls\LV7.bmp"
$WallLv[4] = @ScriptDir & "\images\Walls\LV8.bmp"
$WallLv[5] = @ScriptDir & "\images\Walls\LV9.bmp"
$WallLv[6] = @ScriptDir & "\images\Walls\LV10.bmp"

Func CheckWallLv()
	$WallLvc = 0
	_CaptureRegion(340, 520, 555, 550)
	If _ImageSearch($WallLv[$icmbWalls], 1, $x, $y, 65) Then ; Getting Wall level
		$WallLvc = 1
		SetLog("Found Word: (level " & $icmbWalls + 4 & ")", $COLOR_GREEN)
		Return True
	Else
		$WallLvc = 0
		SetLog("Not Found Word: (level " & $icmbWalls + 4 & ")", $COLOR_GREEN)
		Return False
	EndIf
EndFunc   ;==>CheckWallLv


Func CheckWallWord()
	$WallWord = 0
	_CaptureRegion(340, 520, 515, 550)
	If _ImageSearch(@ScriptDir & "\images\Walls\wallword.bmp", 1, $x, $y, 55) Then ; Getting Wall word
		$WallWord = 1
		SetLog("Found Word: Wall", $COLOR_GREEN)
		Return True
	Else
		$WallWord = 0
		SetLog("Not Found Word: Wall", $COLOR_GREEN)
		Return False
	EndIf

EndFunc   ;==>CheckWallWord