; check for trees, bushes, etc
Global $mush, $bush, $bark, $trunk, $tree1, $tree2, $tree3
$mush = @ScriptDir & "\images\Trees\mush1c.png"
$bush = @ScriptDir & "\images\Trees\bush1b.png"
$bark = @ScriptDir & "\images\Trees\bark4.png"
$trunk = @ScriptDir & "\images\Trees\trunk1c.png"
$tree1 = @ScriptDir & "\images\Trees\tree1b.png"
$tree2 = @ScriptDir & "\images\Trees\tree2b.png"
$tree3 = @ScriptDir & "\images\Trees\tree3.png"
$gembox = @ScriptDir & "\images\Trees\gembox.png"

Global $TreeX = 0, $TreeY = 0, $TreeLoc = 0

Func CheckTrees()
If FileExists($mush) Then ;mushroom
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 27
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($mush, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Mushroom at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($bush) Then ;bush
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 15
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($bush, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Bush at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($bark) Then ;bark
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 21
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($bark, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Bark at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($trunk) Then ;trunk
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 11
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($trunk, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Trunk at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($tree1) Then ;tree1
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 20
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($tree1, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Tree1 at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($tree2) Then ;tree2
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 18
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($tree2, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Tree2 at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($tree3) Then ;tree3
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 18
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($tree3, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found Tree3 at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
EndIf
If FileExists($gembox) Then ;gembox
	$TreeLoc = 0
	If _Sleep(500) Then Return
	For $TreeTol = 0 To 30
		If $TreeLoc = 0 Then
			_CaptureRegion()
			$TreeLoc = _ImageSearch($gembox, 1, $TreeX, $TreeY, $TreeTol) ; Getting Tree Location
			If $TreeLoc = 1 and $TreeX > 35 and $TreeY < 610 Then
				SetLog("Found gembox at "&$TreeX&","&$TreeY&" with "&$TreeTol&" tolerance, Removing...", $COLOR_GREEN)
				Return True
			EndIf
		EndIf

	Next
	SetLog("Cannot find trees, moving on...", $COLOR_RED)
	Return False
EndIf
EndFunc   ;==>CheckTrees
