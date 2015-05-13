;HungLe from gamebot.org
func isProblemAffect($isCaptureRegion = false)
	if $isCaptureRegion = false then
		If not _ColorCheck(_GetPixelColor(253, 395), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(263, 395), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(283, 395), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(300, 395), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(594, 395), Hex(0x282828, 6), 20) then
			return false
		elseif _ColorCheck(_GetPixelColor(823, 32), Hex(0xF8FCFF, 6), 20) then
			return false
		else
			return true
		endif
	else
		If not _ColorCheck(_GetPixelColor(253, 395,true), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(263, 395,true), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(283, 395,true), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(300, 395,true), Hex(0x282828, 6), 20) then
			return false
		elseif not _ColorCheck(_GetPixelColor(594, 395,true), Hex(0x282828, 6), 20) then
			return false
		elseif _ColorCheck(_GetPixelColor(823, 32,true), Hex(0xF8FCFF, 6), 20) then
			return false
		else
			return true
		endif
	endif
	return false
endfunc