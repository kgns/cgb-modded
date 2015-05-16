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

Global $checkwalllogic
Global $Wall[7][3]

$Wall[0][0] = @ScriptDir & "\images\Walls\4_1.bmp"
$Wall[0][1] = @ScriptDir & "\images\Walls\4_2.bmp"
$Wall[0][2] = @ScriptDir & "\images\Walls\4.png"

$Wall[1][0] = @ScriptDir & "\images\Walls\5_1.bmp"
$Wall[1][1] = @ScriptDir & "\images\Walls\5_2.bmp"
$Wall[1][2] = @ScriptDir & "\images\Walls\5.png"

$Wall[2][0] = @ScriptDir & "\images\Walls\6_1.bmp"
$Wall[2][1] = @ScriptDir & "\images\Walls\6_2.bmp"
$Wall[2][2] = @ScriptDir & "\images\Walls\6.png"

$Wall[3][0] = @ScriptDir & "\images\Walls\7_1.bmp"
$Wall[3][1] = @ScriptDir & "\images\Walls\7_2.bmp"
$Wall[3][2] = @ScriptDir & "\images\Walls\7.png"

$Wall[4][0] = @ScriptDir & "\images\Walls\8_1.bmp"
$Wall[4][1] = @ScriptDir & "\images\Walls\8_2.bmp"
$Wall[4][2] = @ScriptDir & "\images\Walls\8.png"

$Wall[5][0] = @ScriptDir & "\images\Walls\9_1.bmp"
$Wall[5][1] = @ScriptDir & "\images\Walls\9_2.bmp"
$Wall[5][2] = @ScriptDir & "\images\Walls\9.png"

$Wall[6][0] = @ScriptDir & "\images\Walls\10_1.bmp"
$Wall[6][1] = @ScriptDir & "\images\Walls\10_2.bmp"
$Wall[6][2] = @ScriptDir & "\images\Walls\10.png"

Global $WallPos[4], $WallxLOC, $WallyLOC
Global $WallX[4], $WallY[4]
Global $HitPoints
Global $HitPointsWall[7]=[900, 1400, 2000, 2500, 3000, 4000, 5500] ; HitPoint of each walls level

Func CheckWall()

	$WallLoc = 0
	If _Sleep(500) Then Return
	Local $y1, $y2, $y3

	$y = 0
	SetLog("Initial Position of $y :" & $y)
	_CaptureRegion(0, $y, 860, 720) ; Detection for Position 1
	For $Tolerance2 = 0 To 90
		For $x = 0 To 2
			$WallPos[0] = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[0], $WallY[0], $Tolerance2) ; Getting Wall Location
			If $WallPos[0] = 1 Then
				Sleep(500)
				PureClick($WallX[0], $WallY[0])
				Sleep(500)
				If  HitPoints()= true Then ; CheckWallLv() = 1 And CheckWallWord() = 1
					SetLog("Wall segment Position 1 Correct •[" & $WallX[0] & "," & $WallY[0] & "]")
					$checkwalllogic = True
					$WallLoc = 1
					Return True
					ExitLoop (2)
				Else
					$WallLoc = 0
					Sleep(500)
					 Click(1, 1, 2)
					;ContinueLoop
				EndIf
			EndIf
		Next
	Next
	$WallY[0] += $y
	;SetLog("Wall segment Position 1 •[" & $WallX[0] & "," & $WallY[0] & "]", $COLOR_GREEN)


	$y1 = Ceiling($WallY[0] + 5)
	SetLog("Initial Position of $y :" & $y1)
	_CaptureRegion(0, $y1, 860, 720) ; Detection for Position 2
	For $Tolerance2 = 0 To 90
		For $x = 0 To 2
			$WallPos[1] = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[1], $WallY[1], $Tolerance2) ; Getting Wall Location
			If $WallPos[1] = 1 Then
				Sleep(500)
				PureClick($WallX[1], $WallY[1])
				Sleep(500)
				If  HitPoints()= true Then ; CheckWallLv() = 1 And CheckWallWord() = 1
					SetLog("Wall segment Position 2 Correct •[" & $WallX[1] & "," & $WallY[1] & "]")
					$checkwalllogic = True
					$WallLoc = 1
					Return True
					ExitLoop (2)
				Else
					$WallLoc = 0
					Sleep(500)
					 Click(1, 1, 2)
					;ContinueLoop
				EndIf
			EndIf
		Next
	Next
	$WallY[1] += $y1
	;SetLog("Wall segment Position 2 •[" & $WallX[1] & "," & $WallY[1] & "]", $COLOR_GREEN)


	$y2 = Ceiling($WallY[1] + 5)
	SetLog("Initial Position of $y :" & $y2)
	_CaptureRegion(0, $y2, 860, 720) ; Detection for Position 3
	For $Tolerance2 = 0 To 90
		For $x = 0 To 2
			$WallPos[2] = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[2], $WallY[2], $Tolerance2) ; Getting Wall Location
			If $WallPos[2] = 1 Then
				Sleep(500)
				PureClick($WallX[2], $WallY[2])
				Sleep(500)
				If  HitPoints()= true Then ; CheckWallLv() = 1 And CheckWallWord() = 1
					SetLog("Wall segment Position 3 Correct •[" & $WallX[2] & "," & $WallY[2] & "]")
					$checkwalllogic = True
					$WallLoc = 1
					Return True
					ExitLoop (2)
				Else
					$WallLoc = 0
					Sleep(500)
					 Click(1, 1, 2)
					;ContinueLoop
				EndIf
			EndIf
		Next
	Next
	$WallY[2] += $y2
	;SetLog("Wall segment Position 3 •[" & $WallX[2] & "," & $WallY[2] & "]", $COLOR_GREEN)


	$y3 = Ceiling($WallY[2] + 5)
	SetLog("Initial Position of $y :" & $y3)
	_CaptureRegion(0, $y3, 860, 720) ; Detection for Position 4
	For $Tolerance2 = 0 To 90
		For $x = 0 To 2
			$WallPos[3] = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[3], $WallY[3], $Tolerance2) ; Getting Wall Location
			If $WallPos[3] = 1 Then
				Sleep(500)
				PureClick($WallX[3], $WallY[3])
				Sleep(500)
				If  HitPoints()= true Then ; CheckWallLv() = 1 And CheckWallWord() = 1
					SetLog("Wall segment Position 4 Correct •[" & $WallX[4] & "," & $WallY[4] & "]")
					$checkwalllogic = True
					$WallLoc = 1
					ReportWallUpgrade()
					Return True
					ExitLoop (2)
				Else
					$WallLoc = 0
					Sleep(500)
					 Click(1, 1, 2)
					;ContinueLoop
				EndIf
			EndIf
		Next
	Next
	$WallY[3] += $y3

	If $WallLoc = 0 Then
		$checkwalllogic = False
		SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", Skip upgrade...", $COLOR_RED)
		ReportWallUpgradeFailed()
		Return False
	EndIf

EndFunc   ;==>CheckWall


Func HitPoints()

	Local $offColors[3][3] = [[0xD6714B, 47, 37], [0xF0E850, 70, 0], [0xF4F8F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF3F3F1, 6), $offColors, 30) ; first gray/white pixel of button

	If IsArray($ButtonPixel) Then
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20) ; Click Upgrade Gold Button
		If _Sleep(1000) Then Return
		_CaptureRegion()
		$HitPoints = Number(getOther(504, 193, "Hitpoints"))
		SetLog("~ Get HitPoints :" &  _NumberFormat($HitPoints) )

		If $HitPointsWall[$icmbWalls] = $HitPoints then
			SetLog("~ Wall HitPoints is correct.",$COLOR_GREEN)
			Click(1, 1, 2)
			Sleep(500)
			Return True
		Else
		    SetLog ("~ Wall HitPoint not match...", $COLOR_RED)
			Click(1, 1, 2)
			Sleep(500)
			Return False
		EndIf
	Else
		Setlog("No Upgrade Gold Button to check HitPoints, is not a Wall...", $COLOR_RED)
		Click(1, 1, 2)
		Sleep(500)
		Return False
	EndIf

EndFunc   ;==>HitPoints
