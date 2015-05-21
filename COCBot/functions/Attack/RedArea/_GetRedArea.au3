; Strategy :
; 			Search red area
;			Split the result in 4 sides (global var) : Top Left / Bottom Left / Top Right / Bottom Right
;			Remove bad pixel (Suppose that pixel to deploy are in the green area)
;			Get pixel next the "out zone" , indeed the red color is very different and more uncertain
;			Sort each sides
;			Add each sides in one array (not use, but it can help to get closer pixel of all the red area)
Func _GetRedArea()
	$nameFunc = "[_GetRedArea] "
	debugRedArea($nameFunc & " IN")


	Local $colorVariation = 40
	Local $xSkip = 1
	Local $ySkip = 5

	Local $result = DllCall($LibDir & "\CGBfunctions.dll", "str", "getRedArea", "ptr", $hBitmapFirst, "int", $xSkip, "int", $ySkip, "int", $colorVariation)
	Local $listPixelBySide = StringSplit($result[0], "#")
	$PixelTopLeft = GetPixelSide($listPixelBySide, 1)
	$PixelBottomLeft = GetPixelSide($listPixelBySide, 2)
	$PixelBottomRight = GetPixelSide($listPixelBySide, 3)
	$PixelTopRight = GetPixelSide($listPixelBySide, 4)

	Local $offsetArcher = 15
	Global $PixelTopLeftFurther[UBound($PixelTopLeft)]
	Global $PixelRedArea[UBound($PixelTopLeft) + UBound($PixelBottomLeft) + UBound($PixelTopRight) + UBound($PixelBottomRight)]
	Global $PixelRedAreaFuther[UBound($PixelTopLeft) + UBound($PixelBottomLeft) + UBound($PixelTopRight) + UBound($PixelBottomRight)]
	$count = 0
	For $i = 0 To UBound($PixelTopLeft) - 1
		$PixelTopLeftFurther[$i] = _GetOffsetTroopFurther($PixelTopLeft[$i], $eVectorLeftTop, $offsetArcher)
		$PixelRedArea[$count] = $PixelTopLeft[$i]
		$PixelRedAreaFuther[$count] = $PixelTopLeftFurther[$i]
		$count += 1
	Next
	Global $PixelBottomLeftFurther[UBound($PixelBottomLeft)]
	For $i = 0 To UBound($PixelBottomLeft) - 1
		$PixelBottomLeftFurther[$i] = _GetOffsetTroopFurther($PixelBottomLeft[$i], $eVectorLeftBottom, $offsetArcher)
		$PixelRedArea[$count] = $PixelBottomLeft[$i]
		$PixelRedAreaFuther[$count] = $PixelBottomLeftFurther[$i]
		$count += 1
	Next
	Global $PixelTopRightFurther[UBound($PixelTopRight)]
	For $i = 0 To UBound($PixelTopRight) - 1
		$PixelTopRightFurther[$i] = _GetOffsetTroopFurther($PixelTopRight[$i], $eVectorRightTop, $offsetArcher)
		$PixelRedArea[$count] = $PixelTopRight[$i]
		$PixelRedAreaFuther[$count] = $PixelTopRightFurther[$i]
		$count += 1
	Next
	Global $PixelBottomRightFurther[UBound($PixelBottomRight)]
	For $i = 0 To UBound($PixelBottomRight) - 1
		$PixelBottomRightFurther[$i] = _GetOffsetTroopFurther($PixelBottomRight[$i], $eVectorRightBottom, $offsetArcher)
		$PixelRedArea[$count] = $PixelBottomRight[$i]
		$PixelRedAreaFuther[$count] = $PixelBottomRightFurther[$i]
		$count += 1
	Next
	debugRedArea("PixelTopLeftFurther " + UBound($PixelTopLeftFurther))


	If UBound($PixelTopLeft) < 10 Then
		$PixelTopLeft = _GetVectorOutZone($eVectorLeftTop)
		$PixelTopLeftFurther = $PixelTopLeft
	EndIf
	If UBound($PixelBottomLeft) < 10 Then
		$PixelBottomLeft = _GetVectorOutZone($eVectorLeftBottom)
		$PixelBottomLeftFurther = $PixelBottomLeft
	EndIf
	If UBound($PixelTopRight) < 10 Then
		$PixelTopRight = _GetVectorOutZone($eVectorRightTop)
		$PixelTopRightFurther = $PixelTopRight
	EndIf
	If UBound($PixelBottomRight) < 10 Then
		$PixelBottomRight = _GetVectorOutZone($eVectorRightBottom)
		$PixelBottomRightFurther = $PixelBottomRight
	EndIf

	debugRedArea($nameFunc & "  Size of arr pixel for TopLeft [" & UBound($PixelTopLeft) & "] /  BottomLeft [" & UBound($PixelBottomLeft) & "] /  TopRight [" & UBound($PixelTopRight) & "] /  BottomRight [" & UBound($PixelBottomRight) & "] ")

	debugRedArea($nameFunc & " OUT ")
EndFunc   ;==>_GetRedArea


