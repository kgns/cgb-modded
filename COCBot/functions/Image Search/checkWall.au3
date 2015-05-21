; #FUNCTION# ====================================================================================================================
; Name ..........: CheckWall()
; Description ...: This file Includes the detection of Walls for Upgrade
; Syntax ........:
; Parameters ....: None
; Return values .:
; Author ........: ProMac (2015), HungLe (2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Global $Wall[7][3]
Global $NoMoreWalls = 0

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

Local $WallPos
Local $WallX, $WallY
Local $HitPoints
Local $HitPointsWall[7] = [900, 1400, 2000, 2500, 3000, 4000, 5500] ; HitPoint of each walls level

Func CheckWall()

	If _Sleep(500) Then Return

	Local $listArrayPoint = ""
	$ToleranceHere = 20
	While $ToleranceHere < 91
		$ToleranceHere = $ToleranceHere + 10
		For $icount = 0 To 9
			_CaptureRegion(86 * $icount, 0 , 86 * ($icount + 1), 720)
			For $x = 0 To 2
				$WallPos = _ImageSearch($Wall[$icmbWalls][$x], 1, $WallX, $WallY, $ToleranceHere) ; Getting Wall Location
				If $WallPos = 1 Then
					If Not checkPointDouble($listArrayPoint, $WallX, $WallY) Then
						$listArrayPoint = $listArrayPoint & $WallX & ";" & $WallY & "|"
					EndIf
					$WallX += 86 * $icount
					$icount += 1

					If $WallX < 112 Or $WallX > 748 Or $WallY < 95 Or $WallY > 558 Then ContinueLoop ; exclude area

					If $debugSetlog = 1 Then
						SetLog("Wall level: " & $icmbWalls + 4 & " • Region: " & $icount - 1 & " • Position: [" & $WallX & "," & $WallY & "], Verifying..")
					Else
						SetLog("Wall level: " & $icmbWalls + 4 & ", Verifying..", $COLOR_GREEN)
					EndIf
					Click($WallX, $WallY)
					If _Sleep(500) Then Return
					If HitPoints() Then Return True; CheckWallLv() = 1 And CheckWallWord() = 1
				EndIf
			Next
		Next
	WEnd

	SetLog("Cannot find Walls level " & $icmbWalls + 4 & ", function disabled ...", $COLOR_RED)
	$NoMoreWalls = 1
	Return False

EndFunc   ;==>CheckWall

Func checkPointDouble($listArrayPoint, $xPoint, $yPoint)
	Local $ArrayPoints = StringSplit($listArrayPoint, "|")
	For $i = 1 To $ArrayPoints[0]
		If $ArrayPoints[$i] <> "" Then
			$pixel = StringSplit($ArrayPoints[$i], ";")
			If (Abs($xPoint - $pixel[1]) < 5 Or Abs($yPoint - $pixel[2]) < 5) Then Return True
		EndIf
	Next
	Return False
EndFunc   ;==>checkPointDouble

Func HitPoints()

	Local $offColors[3][3] = [[0xD6714B, 47, 37], [0xF0E850, 70, 0], [0xF4F8F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF3F3F1, 6), $offColors, 30) ; first gray/white pixel of button

	If IsArray($ButtonPixel) Then
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20) ; Click Upgrade Gold Button
		If _Sleep(1000) Then Return
		_CaptureRegion()
		$HitPoints = Number(getOther(504, 193, "Hitpoints"))
		SetLog("~ Verify HitPoints:" & _NumberFormat($HitPoints))

		If $HitPointsWall[$icmbWalls] = $HitPoints Then
			SetLog("~ Wall HitPoints Correct.", $COLOR_GREEN)
			Click(1, 1)
			If _Sleep(500) Then Return
			Return True
		Else
			SetLog("~ Wall HitPoints Incorrect! Not a Wall or wrong level.", $COLOR_RED)
			Click(1, 1, 2)
			If _Sleep(500) Then Return
			Return False
		EndIf
	Else
		Setlog("No Upgrade Gold Button to check HitPoints, is not a Wall...", $COLOR_RED)
		Click(1, 1, 2)
		If _Sleep(500) Then Return
		Return False
	EndIf

EndFunc   ;==>HitPoints
