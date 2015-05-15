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

Global $WallPos[4] , $WallxLOC , $WallyLOC
Global $Tolerance2 = 70
Global $WallX[4] , $WallY[4]

Func CheckWall()

	$WallLoc = 0
	If _Sleep(500) Then Return
	Local $y1 ,$y2 , $y3

        $y = 0
		SetLog ("Initial Position of $y :" & $y )
	    _CaptureRegion(0, $y, 860, 720) ; Detection for Position 1
		For $Tolerance2 = 0 To 90
		   For $x = 0 To 2
			$WallPos[0]= _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[0], $WallY[0], $Tolerance2) ; Getting Wall Location
			If $WallPos[0] = 1 Then
				ExitLoop(2)
			EndIf
		   Next
		Next
		$WallY[0] += $y
		SetLog("Wall segment Position 1 •[" & $WallX[0] & "," & $WallY[0] & "]", $COLOR_GREEN)


		$y1 = Ceiling ($WallY[0] + 10)
		SetLog ("Initial Position of $y :" & $y1 )
	    _CaptureRegion(0,$y1, 860, 720) ; Detection for Position 2
        For $Tolerance2 = 0 To 90
		   For $x = 0 To 2
			$WallPos[1]= _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[1], $WallY[1], $Tolerance2) ; Getting Wall Location
			If $WallPos[1] = 1 Then
				ExitLoop(2)
			EndIf
		   Next
		Next
		$WallY[1] += $y1
		SetLog("Wall segment Position 2 •[" & $WallX[1] & "," & $WallY[1] & "]", $COLOR_GREEN)


	    $y2 = Ceiling ($WallY[1] + 10)
		SetLog ("Initial Position of $y :" & $y2 )
	    _CaptureRegion(0, $y2, 860, 720) ; Detection for Position 3
        For $Tolerance2 = 0 To 90
		   For $x = 0 To 2
			$WallPos[2]= _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[2], $WallY[2], $Tolerance2) ; Getting Wall Location
			If $WallPos[2] = 1 Then
				ExitLoop(2)
			EndIf
		   Next
		Next
		$WallY[2] += $y2
		SetLog("Wall segment Position 3 •[" & $WallX[2] & "," & $WallY[2] & "]", $COLOR_GREEN)


		$y3 = Ceiling ($WallY[2] + 10)
		SetLog ("Initial Position of $y :" & $y3 )
	    _CaptureRegion(0, $y3, 860, 720) ; Detection for Position 4
        For $Tolerance2 = 0 To 90
		   For $x = 0 To 2
			$WallPos[3]= _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX[3], $WallY[3], $Tolerance2) ; Getting Wall Location
			If $WallPos[3] = 1 Then
				ExitLoop(2)
			EndIf
		   Next
		Next
		$WallY[3] += $y3
        SetLog("Wall segment Position 4 •[" & $WallX[3] & "," & $WallY[3] & "]", $COLOR_GREEN)


		 If IsArray($WallPos)> 0 Then
			SetLog("Found Walls level " & $icmbWalls + 4 & ", Verifying...", $COLOR_GREEN)
			For $i = 0 To 3
				Sleep (1000)
				PureClick($WallX[$i], $WallY[$i])
				Sleep(1000)
				If CheckWallLv() = 1 And CheckWallWord() = 1 Then
					$checkwalllogic = True
					$WallLoc = 1
					$WallxLOC = $WallX[$i]
					$WallyLOC = $WallY[$i]
					ReportWallUpgrade()
					click(1, 1)
					Return True
					ExitLoop
				Else
					$WallLoc = 0
					ContinueLoop
					click(1, 1)
				EndIf
			Next
		 EndIf


	If $WallLoc = 0 Then
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
	If _ImageSearch($WallLv[$icmbWalls], 1, $x, $y, 100) Then ; Getting Wall level
		$WallLvc = 1
		SetLog("Found Word: (level " & $icmbWalls + 4 & ")", $COLOR_GREEN)
		Return True
	Else
		$WallLvc = 0
		SetLog("Not Found Word: (level " & $icmbWalls + 4 & ")", $COLOR_GREEN)
		Return False
	EndIf
	Click(1, 1)
EndFunc   ;==>CheckWallLv


Func CheckWallWord()
	$WallWord = 0
	_CaptureRegion(340, 520, 515, 550)
	If _ImageSearch(@ScriptDir & "\images\Walls\wallword.bmp", 1, $x, $y, 100) Or _
	   _ImageSearch(@ScriptDir & "\images\Walls\wallword1.bmp", 1, $x, $y, 100) Then ; Getting Wall word
		$WallWord = 1
		SetLog("Found Word: Wall", $COLOR_GREEN)
		Return True
	Else
		$WallWord = 0
		SetLog("Not Found Word: Wall", $COLOR_GREEN)
		Return False
	EndIf

EndFunc   ;==>CheckWallWord




