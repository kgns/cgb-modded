; #FUNCTION# ====================================================================================================================
; Name ..........: PushBulle
; Description ...: This function will report to your mobile phone your values and last attack
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Antidote (2015-03)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================


#include <Array.au3>
#include <String.au3>

Func _RemoteControl()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText

	Local $findstr = StringRegExp($Result, '"title":"BOT')
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"bot')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"Bot')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"bOt')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"boT')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"BOt')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"bOT')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"BoT')
	EndIf
	If $findstr = 1 Then
		Local $title = _StringBetween($Result, '"title":"', '"', "", False)
		Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)

		For $x = 0 To UBound($title) - 1
			If $title <> "" Or $iden <> "" Then
				$title[$x] = StringUpper(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
				$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

			   If $title[$x] = "BOT HELP" Then
				   _DeleteMessage($iden[$x])
				   SetLog("Your request has been received. " & $title[$x])
					_Push($iPBVillageName & ": Request for Help", "You can remotely control your bot using the following command format\nEnter Bot <command> in the Title message\n\n<command> is:\nRestart or Stop - to restart the bot and Bluestacks\nStop - to stop bot\nPause - to pause bot\nResume - to resume bot\nStats - to send village report and current troop capacity\nLogs - to send the current log file\nDelete - to delete all previous Push messages\nLastRaid - to send last raid screenshot\nHelp - to send this help message")
			    ElseIf $title[$x] = "BOT PAUSE" Then
				  _DeleteMessage($iden[$x])
				  SetLog("Your request has been received. " & $title[$x])
				  TogglePauseImpl("Push")
			   ElseIf $title[$x] = "BOT RESUME" Then
				  _DeleteMessage($iden[$x])
				  SetLog("Your request has been received. " & $title[$x])
				  TogglePauseImpl("Push")
			    ElseIf $title[$x] = "BOT RESTART" Or $title[$x] = "BOT START" Then
				  _DeleteMessage($iden[$x])
				  SetLog("Your request has been received. " & $title[$x])
				  _Push($iPBVillageName & ": Request to Restart...", "Your bot and BS are now restarting...")
				  SaveConfig()
				  _Restart()
			    ElseIf $title[$x] = "BOT STOP" Then
				  _DeleteMessage($iden[$x])
				  SetLog("Your request has been received. " & $title[$x])
				  If $Runstate = True Then
					 _Push($iPBVillageName & ": Request to Stop...", "Your bot is now stopping...")
					 btnStop()
				  Else
					 _Push($iPBVillageName & ": Request to Stop...", "Your bot is currently stopped, no action was taken")
				  EndIf
				ElseIf $title[$x] = "BOT DELETE" Then
					_DeletePush()
					SetLog("Your request has been received. " & $title[$x])
					_Push($iPBVillageName & ": Request to Delete Push messages...", "All your previous Push messages are deleted...")
				 ElseIf $title[$x] = "BOT STATS" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. " & $title[$x])
					_Push($iPBVillageName & ": Village Report, My Lord...", "Total Army Camp capacity: " & $CurCamp & "/" & $TotalCamp & "\n\nHere are your Resources at Start\n-[G]: " & _NumberFormat($GoldStart) & "\n-[E]: " & _NumberFormat($ElixirStart) & "\n-[D]: " & _NumberFormat($DarkStart) & " \n-[T]: " & $TrophyStart & "\n\nNow (Current Resources)\n-[G]: " & _NumberFormat($GoldVillage) & "\n-[E]: " & _NumberFormat($ElixirVillage) & "\n-[D]: " & _NumberFormat($DarkVillage) & "\n-[T]: " & $TrophyVillage & "\n\n-[GEM]: " & $GemCount & "\n [No. of Free Builders]: " & $FreeBuilder & "\n [No. of Wall Up]: G: " & $wallgoldmake & "/ E: " & $wallelixirmake & "\n\nAttacked: " & GUICtrlRead($lblresultvillagesattacked) & "\nSkipped: " & GUICtrlRead($lblresultvillagesskipped))
				 ElseIf $title[$x] = "BOT LOGS" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. " & $title[$x])
					_PushFile($sLogFName, "logs", "text/plain; charset=utf-8", $iPBVillageName & ": Current Logs", $sLogFName)
				 ElseIf $title[$x] = "BOT LASTRAID" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. " & $title[$x])
					If $iImageLoot <> "" Then
					   _PushFile($iImageLoot, "Loots", "image/jpeg", $iPBVillageName & ": Last Raid", $iImageLoot)
				    Else
						_Push($iPBVillageName & ": There is no last raid screenshot", "...")
					 EndIf
				EndIf
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
	  SetLog("Unable to send file " & $File, $COLOR_RED)
   EndIf
EndFunc   ;==>_PushFile

Func ReportPushBullet()

	If $iLastAttack = 1 Then
		If $GoldLast <> "" Or $ElixirLast <> "" Then
			_Push($iPBVillageName & ": Last Gain", " [G]: " &  _NumberFormat($GoldLast) & " [E]: " &  _NumberFormat($ElixirLast) & " [D]: " &  _NumberFormat($DarkLast) & "  [T]: " & _NumberFormat($TrophyLast))
		EndIf
	EndIf

	If $iAlertPBVillage = 1 Then
		_Push($iPBVillageName & ": My Village", " [G]: " &  _NumberFormat($GoldCount) & " [E]: " &  _NumberFormat($ElixirCount) & " [D]: " &  _NumberFormat($DarkCount) & "  [T]: " &  _NumberFormat($TrophyCount) & " [FB]: " &  _NumberFormat($FreeBuilder))
	EndIf

EndFunc   ;==>ReportPushBullet


Func _DeletePush()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>DeletePush

Func ReportMatchFound()
   If $pEnabled = 1 AND $pMatchFound = 1 Then
	  _Push($iPBVillageName & ": Match Found After " & StringFormat("%3s", $SearchCount) & " skip(s)", " [G]: " & _NumberFormat($searchGold) & " [E]: " & _NumberFormat($searchElixir) & " [D]: " & _NumberFormat($searchDark) & " [T]: " & _NumberFormat($searchTrophy) & " [M]: " & $iradAttackModeString)
   Endif
EndFunc   ;==>ReportMatchFound

Func ReportWallUpgrade()
   If $pEnabled = 1 AND $pWallUpgrade = 1 Then 
      _Push($iPBVillageName & ": Found Wall level " & $icmbWalls+4 , "Wall segment has been located...\nUpgrading ...")
   EndIf
EndFunc   ;==>ReportWallUpgrade

Func ReportWallUpgradeFailed()
   If $pEnabled = 1 AND $pWallUpgrade = 1 Then 
      _Push($iPBVillageName & ": Cannot find Wall level " & $icmbWalls+4 , "Skip upgrade ...")
   EndIf
EndFunc   ;==>ReportWallUpgradeFailed

Func ReportBreak()
   If $pEnabled = 1 AND $pTakeAbreak = 1 Then 
      _Push($iPBVillageName & ": Village must take a break", "")
   EndIf
EndFunc   ;==>ReportBreak

Func ReportCoCStopped()
   If $pEnabled = 1 AND $pOOS = 1 Then 
      _Push($iPBVillageName & ": CoC Has Stopped Error", "")
   EndIf
EndFunc   ;==>ReportCoCStopped

Func _DeleteMessage($iden)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushToken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden, False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeleteMessage