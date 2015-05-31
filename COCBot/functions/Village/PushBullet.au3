; #FUNCTION# ====================================================================================================================
; Name ..........: PushBullet
; Description ...: This function will report to your mobile phone your values and last attack
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Antidote (2015-03)
; Modified ......: Sardo and Didipe (2015-05)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

#include <Array.au3>
#include <String.au3>

Global $pushLastModified = 0

Func _RemoteControl()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	Local $pushbulletApiUrl
	If $pushLastModified = 0 Then
		$pushbulletApiUrl = "https://api.pushbullet.com/v2/pushes?active=true&limit=1" ; if this is the first time looking for pushes, get the last one
	Else
		$pushbulletApiUrl = "https://api.pushbullet.com/v2/pushes?active=true&modified_after=" & $pushLastModified ; get the one pushed after the last one received
	EndIf
	$oHTTP.Open("Get", $pushbulletApiUrl, False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText

	Local $modified = _StringBetween($Result, '"modified":', ',' , "", False)
	If UBound($modified) > 0 Then
		$pushLastModified = Number($modified[0]) ; modified date of the newest push that we received
		$pushLastModified += 0.00001
	EndIf
	
	Local $findstr = StringRegExp(StringUpper($Result), '"TITLE":"BOT')
	If $findstr = 1 Then
		Local $title   = _StringBetween($Result, '"title":"' , '"' , "", False)
		Local $iden    = _StringBetween($Result, '"iden":"'  , '"' , "", False)
		For $x = UBound($title) - 1 To 0 Step -1
			If $title <> "" Or $iden <> "" Then
				$title[$x] = StringUpper(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
				$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

			Switch $title[$x]
			Case "BOT HELP"
					 Local $txtHelp = "You can remotely control your bot sending commands following this syntax:"
					 $txtHelp &= '\n' & "BOT HELP - send this help message"
					 $txtHelp &= '\n' & "BOT DELETE  - delete all your previous Push message"
					 $txtHelp &= '\n' & "BOT <Village Name> RESTART - restart the bot named <Village Name> and bluestacks"
					 $txtHelp &= '\n' & "BOT <Village Name> STOP - stop the bot named <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> PAUSE - pause the bot named <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> RESUME   - resume the bot named <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> STATS - send Village Statistics of <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> LOG - send the current log file of <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> LASTRAID - send the last raid loot screenshot of <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> LASTRAIDTXT - send the last raid loot values of <Village Name>"
					 $txtHelp &= '\n' & "BOT <Village Name> SCREENSHOT - send a screenshot of <Village Name>"
 					 $txtHelp &= '\n'
					 $txtHelp &= '\n' & "Examples:"
					 $txtHelp &= '\n' & "Bot MyVillage Pause"
					 $txtHelp &= '\n' & "Bot Delete "
					 $txtHelp &= '\n' & "Bot MyVillage ScreenShot"
					_Push($iOrigPushB & " | Request for Help", $txtHelp )
					SetLog("Pushbullet: Your request has been received from ' " & $iOrigPushB  & ". Help has been sent", $COLOR_GREEN)
					_DeleteMessage($iden[$x])
			Case "BOT " & StringUpper($iOrigPushB)  & " PAUSE"
				    If $TPaused = false  and $Runstate = True Then
						TogglePauseImpl("Push")
					Else
						SetLog("Pushbullet: Your bot is currently paused, no action was taken", $COLOR_GREEN)
						_Push($iOrigPushB & " | Request to Pause", "Your bot is currently paused, no action was taken")
					EndIf
					_DeleteMessage($iden[$x])
			Case "BOT " & StringUpper($iOrigPushB)  & " RESUME"
				    If $TPaused = true  and $Runstate = True Then
						TogglePauseImpl("Push")
					Else
						SetLog("Pushbullet: Your bot is currently resumed, no action was taken", $COLOR_GREEN)
						_Push($iOrigPushB & " | Request to Resume", "Your bot is currently resumed, no action was taken")
					EndIf
					_DeleteMessage($iden[$x])
			Case "BOT DELETE"
					_DeletePush($PushToken)
					SetLog("Pushbullet: Your request has been received.", $COLOR_GREEN)
			Case "BOT " & StringUpper($iOrigPushB)  & " LOG"
					SetLog("Pushbullet: Your request has been received from " & $iOrigPushB & ". Log is now sent", $COLOR_GREEN)
					_PushFile(  $sLogFName, "logs", "text/plain; charset=utf-8", $iOrigPushB & " | Current Log", "Cannot open log with app, open from browser.")
				   _DeleteMessage($iden[$x])
;			Case "BOT " & StringUpper($iOrigPushB)  & " LOG1"
;					SetLog("Your request has been received from " & $iOrigPushB & ". Log is now sent", $COLOR_GREEN)
;				    Local $file = $DirLogs & $sLogFName
;					Local $i = 0
;					Local $line = ""
;					SetLog( $file )
;					SetLog( _FileCountLines($file) )
;					FileOpen( $file, 0)
;					For $i = 1 to _FileCountLines($file)
;						$line = $line & FileReadLine($file, $i)
;						Next
;				    FileClose($file)
;				    _Push ($iOrigPushB & " | Current Log1 " & $sLogFName , $line)
;					_DeleteMessage($iden[$x])
			Case "BOT " & StringUpper($iOrigPushB)  & " LASTRAID"
				    If $LootFileName <> "" Then
						_PushFile($LootFileName, "Loots", "image/jpeg",  $iOrigPushB & " | Last Raid", $LootFileName)
 				    Else
 						_Push($iOrigPushB &" | There is no last raid screenshot." , "")
					EndIf
				    SetLog("Pushbullet: Push Last Raid Snapshot...", $COLOR_GREEN)
					_DeleteMessage($iden[$x])
			Case "BOT " & StringUpper($iOrigPushB)  & " LASTRAIDTXT"
					SetLog("Pusbullet: Your request has been received. Last Raid txt sent", $COLOR_GREEN)
					_Push($iOrigPushB & " | Last Raid txt", "[G]: " & _NumberFormat($lootGold) & " [E]: " & _NumberFormat($lootElixir) & " [D]: " & _NumberFormat($lootDarkElixir) & " [T]: " & $lootTrophies )
					_DeleteMessage($iden[$x])
			Case "BOT " & StringUpper($iOrigPushB)  & " STATS"
					SetLog("Pushbullet: Your request has been received. Statistics sent", $COLOR_GREEN)
					Local $txtVillageReport = "Total Army Camp capacity: " & $CurCamp & "/" & $TotalCamp
					$txtVillageReport &= "\n\n" & "At Start"
					$txtVillageReport &= "\n" & "-[G]: " & _NumberFormat($GoldStart)
					$txtVillageReport &= "\n" & "-[E]: " & _NumberFormat($ElixirStart)
					$txtVillageReport &= "\n" & "-[D]: " & _NumberFormat($DarkStart)
					$txtVillageReport &= "\n" & "-[T]: " & $TrophyStart
					$txtVillageReport &= "\n\n" & "Now (Current Resources)"
					$txtVillageReport &= "\n" & "-[G]: " & _NumberFormat($GoldVillage)
					$txtVillageReport &= "\n" & "-[E]: " & _NumberFormat($ElixirVillage)
					$txtVillageReport &= "\n" & "-[D]: " & _NumberFormat($DarkVillage)
					$txtVillageReport &= "\n" & "-[T]: " & $TrophyVillage
					$txtVillageReport &= "\n\n" & "-[GEM]: " & $GemCount
					$txtVillageReport &= "\n" & "-[No. of Free Builders]: " & $FreeBuilder
					$txtVillageReport &= "\n" & "-[No. of Wall Up]: G: " & $wallgoldmake & "/ E: " & $wallelixirmake
					$txtVillageReport &= "\n" & "-[No. of Free Builders]: " & $FreeBuilder
					$txtVillageReport &= "\n\n" & "Attacked: " & GUICtrlRead($lblresultvillagesattacked)
					$txtVillageReport &= "\n" & "Skipped: " & GUICtrlRead($lblresultvillagesskipped)
					$txtVillageReport &= "\n" & "Nbr of OOS: " & GUICtrlRead($lblresultoutofsync)
					_Push($iOrigPushB & " | Stats Village Report", $txtVillageReport)
					_DeleteMessage($iden[$x])
			Case "BOT " & StringUpper($iOrigPushB)  & " SCREENSHOT"
				    SetLog("Pushbullet: ScreenShot request received", $COLOR_GREEN)
					$RequestScreenshot=1
					_DeleteMessage($iden[$x])
			;Case "BOT " & StringUpper($iOrigPushB)  & " RESTART"
			;		SetLog("Restart Bluestacks!", $COLOR_GREEN)
			;		Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
			;		Run($RestartApp & " Android")
			;		If _Sleep(10000) Then Return
			;		Do
			;		If _Sleep(5000) Then Return
			;		Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
			Case "BOT " & StringUpper($iOrigPushB)  & " RESTART"
				  _DeleteMessage($iden[$x])
				  SetLog("Your request has been received. " & $title[$x])
				  _Push($iOrigPushB & " | Request to Restart...", "Your bot and BS are now restarting...")
				  SaveConfig()
				  _Restart()
			Case "BOT " & StringUpper($iOrigPushB)  & " STOP"
				  _DeleteMessage($iden[$x])
				  SetLog("Your request has been received. " & $title[$x])
				  If $Runstate = True Then
					 _Push($iOrigPushB & " | Request to Stop...", "Your bot is now stopping...")
					 btnStop()
				  Else
					 _Push($iOrigPushB & " | Request to Stop...", "Your bot is currently stopped, no action was taken")
				  EndIf
		 Case Else
		    Local $lenstr = stringlen("BOT " & StringUpper($iOrigPushB) & " "  )
		    local $teststr = StringLeft ($title[$x] , $lenstr )
			if $teststr = ( "BOT " & StringUpper($iOrigPushB) & " " ) then
					SetLog("Pushbullet: received command syntax wrong, command ignored.", $COLOR_RED)
					_Push($iOrigPushB & " | Command not recognized", "please push BOT HELP to obtain a complete command list.")
					_DeleteMessage($iden[$x])
					endif
			EndSwitch

				$title[$x] = ""
				$iden[$x] = ""
			EndIf
		Next
	EndIf
EndFunc   ;==>_RemoteControl

Func _PushBullet($pTitle = "", $pMessage = "")
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushToken
    $oHTTP.Open("Get", "https://api.pushbullet.com/v2/devices", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.Send()
    $Result = $oHTTP.ResponseText
    Local $device_iden = _StringBetween($Result, 'iden":"', '"')
    Local $device_name = _StringBetween($Result, 'nickname":"', '"')
    Local $device = ""
    Local $pDevice = 1
    $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
    $oHTTP.Send($pPush)
EndFunc   ;==>PushBullet

Func _Push($pTitle, $pMessage)
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushToken
    $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
    $oHTTP.Send($pPush)
EndFunc   ;==>_Push

Func _PushFile($File, $Folder, $FileType, $title, $body)
   if FileExists(@ScriptDir & '\' & $Folder & '\' & $File ) then
	  $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	  $access_token = $PushToken
	  $oHTTP.Open("Post", "https://api.pushbullet.com/v2/upload-request", False)
	  $oHTTP.SetCredentials($access_token, "", 0)
	  $oHTTP.SetRequestHeader("Content-Type", "application/json")

	  Local $pPush = '{"file_name": "' & $File & '", "file_type": "' & $FileType & '"}'
	  $oHTTP.Send($pPush)
	  $Result = $oHTTP.ResponseText

	  Local $upload_url = _StringBetween($Result, 'upload_url":"', '"')
	  Local $awsaccesskeyid = _StringBetween($Result, 'awsaccesskeyid":"', '"')
	  Local $acl = _StringBetween($Result, 'acl":"', '"')
	  Local $key = _StringBetween($Result, 'key":"', '"')
	  Local $signature = _StringBetween($Result, 'signature":"', '"')
	  Local $policy = _StringBetween($Result, 'policy":"', '"')
	  Local $file_url = _StringBetween($Result, 'file_url":"', '"')

	  If IsArray($upload_url) And IsArray($awsaccesskeyid) And IsArray($acl) And IsArray($key) And IsArray($signature) and IsArray($policy) Then
		 $Result = RunWait(@ScriptDir & "\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '"', "", @SW_HIDE)

		 $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
		 $oHTTP.SetCredentials($access_token, "", 0)
		 $oHTTP.SetRequestHeader("Content-Type", "application/json")
		 Local $pPush = '{"type": "file", "file_name": "' & $File & '", "file_type": "' & $FileType & '", "file_url": "' & $file_url[0] & '", "title": "' & $title & '", "body": "' & $body & '"}'
		 $oHTTP.Send($pPush)
	  Else
		 SetLog("Pusbullet: Unable to send file " & $File, $COLOR_RED)
		 _Push($iOrigPushB & "| Unable to Upload File" , "Occured an error type 1 uploading file to PushBullet server...")
	  EndIf
   Else
		 SetLog("Pushbullet: Unable to send file " & $File, $COLOR_RED)
		 _Push($iOrigPushB & "| Unable to Upload File" , "Occured an error type 2 uploading file to PushBullet server...")
   EndIF
EndFunc   ;==>_PushFile

Func ReportPushBullet()
	PushMsg("MyVillage")
EndFunc   ;==>ReportPushBullet


Func _DeletePush($token)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $token
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>DeletePush

Func _DeleteMessage($iden)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden, False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeleteMessage

Func PushMsg($Message, $Source = "")
	Local $hBitmap_Scaled
	Switch $Message
	Case "OutOfSync"
		If $pEnabled = 1 AND $pOOS = 1 Then _Push($iOrigPushB  & " | Restarted after Out of Sync Error", "Attacking now...")
	Case "LastRaid"
		If $pEnabled = 1 And $pLastRaidImg = 1 Then
;		   			_CaptureRegion(0, 0, 860, 675)
;					;create a temporary file to send with pushbullet...
;				    Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
;				    Local $Time = @HOUR & "." & @MIN
;
;				    If $ScreenshotLootInfo = 1 Then
;						$AttackFile = $Date & "__" & $Time & " G" & $lootGold & " E" & $lootElixir & " DE" & $lootDarkElixir & " T" & $lootTrophies & " S" & StringFormat("%s", $SearchCount) & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
;				    Else
;						$AttackFile = $Date & "__" & $Time & ".jpg" ; separator __ is need  to not have conflict with saving other files if $TakeSS = 1 and $chkScreenshotLootInfo = 0
;				    EndIf
;				    $hBitmap_Scaled = _GDIPlus_ImageResize($hBitmap, _GDIPlus_ImageGetWidth($hBitmap) / 2, _GDIPlus_ImageGetHeight($hBitmap) / 2) ;resize image
;					_GDIPlus_ImageSaveToFile($hBitmap_Scaled, $dirLoots & $AttackFile  )
;					_GDIPlus_ImageDispose($hBitmap_Scaled)
					;push the file
					SetLog("Pushbullet: Last Raid screenshot has been sent!", $COLOR_GREEN)
				    _PushFile($LootFileName, "Loots", "image/jpeg", $iOrigPushB  & " | Last Raid", $LootFileName)
					;wait a second and then delete the file
;					If _Sleep(500) Then Return
;				    Local $iDelete = FileDelete($dirLoots & $AttackFile)
;				    If not($iDelete) Then SetLog("Pushbullet: An error occurred deleting temporary screenshot file." , $COLOR_RED)
	  EndIf
	Case "LastRaidTxt"
		If $pEnabled = 1 And $iAlertPBLastRaidTxt = 1 Then _Push($iOrigPushB & " | Last Raid", " [G]: " &  _NumberFormat($lootGold) & " [E]: " &  _NumberFormat($lootElixir) & " [D]: " &  _NumberFormat($lootDarkElixir) & "  [T]: " & _NumberFormat($lootTrophies))
	Case "MyVillage"
		If $pEnabled = 1 AND $iAlertPBVillage = 1 Then _Push($iOrigPushB & " | My Village", " [G]: " &  _NumberFormat($GoldCount) & " [E]: " &  _NumberFormat($ElixirCount) & " [D]: " &  _NumberFormat($DarkCount) & "  [T]: " &  _NumberFormat($TrophyCount) & " [FB]: " &  _NumberFormat($FreeBuilder))
	Case "FoundWalls"
		If $pEnabled = 1 AND $pWallUpgrade = 1 Then _Push($iOrigPushB & " | Found Wall level " & $icmbWalls+4 , " Wall segment has been located...\nUpgrading ...")
	Case "SkypWalls"
		If $pEnabled = 1 AND $pWallUpgrade = 1 Then _Push($iOrigPushB & " | Cannot find Wall level " & $icmbWalls+4 , "Skip upgrade ...")
	Case "AnotherDevice3600"
		If $pEnabled = 1 AND $pAnotherDevice = 1 Then _Push($iOrigPushB & " | Another Device has connected", "Another Device has connected, waiting " & Floor(Floor($sTimeWakeUp / 60) / 60) & " hours " & Floor(Mod(Floor($sTimeWakeUp / 60), 60)) & " minutes " & Floor(Mod($sTimeWakeUp, 60)) & " seconds")
	Case "AnotherDevice60"
		If $pEnabled = 1 AND $pAnotherDevice = 1 Then _Push($iOrigPushB & " | Another Device has connected", "Another Device has connected, waiting " & Floor(Mod(Floor($sTimeWakeUp / 60), 60)) & " minutes " & Floor(Mod($sTimeWakeUp, 60)) & " seconds")
	Case "AnotherDevice"
		If $pEnabled = 1 AND $pAnotherDevice = 1 Then _Push($iOrigPushB & " | Another Device has connected", "Another Device has connected, waiting " & Floor(Mod($sTimeWakeUp, 60)) & " seconds")
	Case "TakeBreak"
		If $pEnabled = 1 AND $pTakeAbreak = 1 Then _Push($iOrigPushB & " | Chief, we need some rest!", "Village must take a break..")
	Case "CocError"
	   If $pEnabled = 1 AND $pOOS = 1 Then _Push($iOrigPushB & " | CoC Has Stopped Error .....", ".....")
	Case "Pause"
		If $pEnabled = 1 AND $pRemote = 1 AND $Source = "Push" Then _Push($iOrigPushB & " | Request to Pause...", "Your request has been received. Bot is now paused")
	Case "Resume"
		If $pEnabled = 1 AND $pRemote = 1 AND $Source = "Push" Then _Push($iOrigPushB & " | Request to Resume...", "Your request has been received. Bot is now resumed")
	Case "OsSResources"
		If $pEnabled = 1 AND $pOOS = 1 Then _Push($iOrigPushB & " | Disconnected after " & StringFormat("%3s", $SearchCount) & " skip(s)", "Cannot locate Next button, Restarting Bot...")
	Case "MatchFound"
		If $pEnabled = 1 AND $pMatchFound = 1 Then _Push($iOrigPushB & " | Match Found! after " & StringFormat("%3s", $SearchCount) & " skip(s)" , "[G]: " & _NumberFormat($searchGold) & "; [E]: " & _NumberFormat($searchElixir) & "; [D]: " & _NumberFormat($searchDark) & "; [T]: " & $searchTrophy)
	Case "UpgradeWithWallGold"
		If $pEnabled = 1 AND $pWallUpgrade = 1 Then _Push($iOrigPushB & " | Upgrade completed by using GOLD" , "Complete by using GOLD ...")
	Case "UpgradeWithWallElixir"
		If $pEnabled = 1 AND $pWallUpgrade = 1 Then _Push($iOrigPushB & " | Upgrade completed by using ELIXIR" , "Complete by using ELIXIR ...")
	Case "NoUpgradeWallButton"
		If $pEnabled = 1 AND $pWallUpgrade = 1 Then _Push($iOrigPushB & " | No Upgrade Gold Button" , "Cannot find gold upgrade button ...")
	Case "NoUpgradeElixirButton"
		If $pEnabled = 1 AND $pWallUpgrade = 1 Then _Push($iOrigPushB & " | No Upgrade Elixir Button" , "Cannot find elixir upgrade button ...")
	Case "LabFailedElixir"
		If $pEnabled = 1 AND $pLabUpgrade = 1 Then _Push($iOrigPushB & " | " & GUICtrlRead($cmbLaboratory) & " upgrade failed to start", "Not enough Elixir to upgrade troops "&GUICtrlRead($cmbLaboratory))
	Case "LabFailedDElixir"
		If $pEnabled = 1 AND $pLabUpgrade = 1 Then _Push($iOrigPushB & " | " & GUICtrlRead($cmbLaboratory) & " upgrade failed to start", "Not enough Dark Elixir to upgrade troops "&GUICtrlRead($cmbLaboratory))
	Case "LabSuccess"
		If $pEnabled = 1 AND $pLabUpgrade = 1 Then _Push($iOrigPushB & " | " & GUICtrlRead($cmbLaboratory) & " upgrade has started", "")
    Case "RequestScreenshot"
		Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
		Local $Time = @HOUR & "." & @MIN
		_CaptureRegion(0, 0, 860, 720)
		$hBitmap_Scaled = _GDIPlus_ImageResize($hBitmap, _GDIPlus_ImageGetWidth($hBitmap) / 2, _GDIPlus_ImageGetHeight($hBitmap) / 2) ;resize image
		Local $Screnshotfilename = "Screenshot_" & $Date & "_" & $Time & ".jpg"
		_GDIPlus_ImageSaveToFile($hBitmap_Scaled, $dirLoots & $Screnshotfilename)
		_GDIPlus_ImageDispose($hBitmap_Scaled)
		_PushFile($Screnshotfilename, "Loots" , "image/jpeg", $iOrigPushB & " | Screenshot of your village", $Screnshotfilename)
		SetLog("Pushbullet: Screenshot sent!", $COLOR_GREEN)
		$RequestScreenshot = 0
		;wait a second and then delete the file
		If _Sleep(1000) Then Return
	    Local $iDelete = FileDelete($dirLoots &  $Screnshotfilename)
	    If not($iDelete) Then SetLog("Pushbullet: An error occurred deleting the temporary screenshot file." , $COLOR_RED)
    Case "DeleteAllPBMessages"
		_DeletePush( GUICtrlRead($PushBTokenValue))
		SetLog("PushBullet: All messages deleted.", $COLOR_GREEN)
		$iDeleteAllPushesNow = False ; reset value
    EndSwitch
 EndFunc   ; ==>PushMsg


Func _DeleteOldPushes()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText
    Local $findstr = StringRegExp($Result, ',"created":')
	Local $msgdeleted = 0
	If $findstr = 1 Then
		Local $title   = _StringBetween($Result, '"title":"' , '"' , "", False)
		Local $iden    = _StringBetween($Result, '"iden":"'  , '"' , "", False)
		Local $created = _StringBetween($Result, '"created":', ',' , "", False)
		if isarray($title) and isarray($iden) and isarray($created) then
			For $x = 0 To UBound($created) - 1
				If $iden <> ""  and  $created <>"" Then
					local $tLocal = _Date_Time_GetLocalTime()
					local $tSystem = _Date_Time_TzSpecificLocalTimeToSystemTime(DllStructGetPtr($tLocal))
					local $timeUTC = _Date_Time_SystemTimeToDateTimeStr($tSystem,1)
					Local $hdif = _DateDiff('h', _GetDateFromUnix ($created[$x]),$timeUTC )
					if $hdif >= $icmbHoursPushBullet  then
					;	setlog("Pushbullet, deleted message: (+" & $hdif & "h)" & $title[$x] )
						$msgdeleted += 1
						_DeleteMessage($iden[$x])
					;else
					;	setlog("Pushbullet, skypped message: (+" & $hdif & "h)" & $title[$x] )
					endif
				endif
				$title[$x] = ""
				$iden[$x] = ""
			Next
		endif
	EndIf
	if $msgdeleted >0 then
		setlog("Pushbullet: removed " & $msgdeleted & " messages older than " & $icmbHoursPushBullet & " h ", $COLOR_GREEN)
		_Push($iOrigPushB & "| removed " & $msgdeleted & " messages older than " & $icmbHoursPushBullet & " h ","")
	endif
EndFunc   ; ==>_DeleteOldPushes


Func _GetDateFromUnix ($nPosix)
   Local $nYear = 1970, $nMon = 1, $nDay = 1, $nHour = 00, $nMin = 00, $nSec = 00, $aNumDays = StringSplit ("31,28,31,30,31,30,31,31,30,31,30,31", ",")
   While 1
	  If (Mod ($nYear + 1, 400) = 0) Or (Mod ($nYear + 1, 4) = 0 And Mod ($nYear + 1, 100) <> 0) Then; is leap year
		 If $nPosix < 31536000 + 86400 Then ExitLoop
		 $nPosix -= 31536000 + 86400
		 $nYear += 1
	  Else
		 If $nPosix < 31536000 Then ExitLoop
		 $nPosix -= 31536000
		 $nYear += 1
	  EndIf
   WEnd
   While $nPosix > 86400
	  $nPosix -= 86400
	  $nDay += 1
   WEnd
   While $nPosix > 3600
	  $nPosix -= 3600
	  $nHour += 1
   WEnd
   While $nPosix > 60
	  $nPosix -= 60
	  $nMin += 1
   WEnd
   $nSec = $nPosix
   For $i = 1 to 12
	  If $nDay < $aNumDays[$i] Then ExitLoop
	  $nDay -= $aNumDays[$i]
	  $nMon += 1
   Next
;   Return $nDay & "/" & $nMon & "/" & $nYear & " " & $nHour & ":" & $nMin & ":" & $nSec
   Return  $nYear & "-" &  $nMon & "-" &  $nDay & " " & $nHour & ":" & $nMin & ":" & StringFormat("%02i",$nSec)
EndFunc; ==> _GetDateFromUnix
