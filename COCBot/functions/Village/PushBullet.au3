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

Func _PushBullet($pTitle = "", $pMessage = "")
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushToken
    ;$device_iden = ""

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

Func _PushImageLoot()
   $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
   $access_token = $PushToken

   $oHTTP.Open("Post", "https://api.pushbullet.com/v2/upload-request", False)
   $oHTTP.SetCredentials($access_token, "", 0)
   $oHTTP.SetRequestHeader("Content-Type", "application/json")
   Local $pPush = '{"file_name": "' & $iImageLoot & '", "file_type": "image/jpeg"}'
   $oHTTP.Send($pPush)
   $Result = $oHTTP.ResponseText
   Local $upload_url = _StringBetween($Result, 'upload_url":"', '"')
   Local $awsaccesskeyid = _StringBetween($Result, 'awsaccesskeyid":"', '"')
   Local $acl = _StringBetween($Result, 'acl":"', '"')
   Local $key = _StringBetween($Result, 'key":"', '"')
   Local $signature = _StringBetween($Result, 'signature":"', '"')
   Local $policy = _StringBetween($Result, 'policy":"', '"')
   Local $file_url = _StringBetween($Result, 'file_url":"', '"')
   $result=run(@ScriptDir & "\curl\curl.exe -i -X POST " & $upload_url[0] & " -F awsaccesskeyid=" & $awsaccesskeyid[0] & " -F acl=" & $acl[0] & " -F key=" & $key[0] & " -F signature=" & $signature[0] & " -F policy=" & $policy[0] & " -F content-type=image/jpeg" & " -F ""file=@" & $dirLoots & $iImageLoot & """","",@SW_HIDE)
   $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
   $oHTTP.SetCredentials($access_token, "", 0)
   $oHTTP.SetRequestHeader("Content-Type", "application/json")
   Local $pPush = '{"type": "file", "file_name": "' & $iImageLoot & '", "file_type": "image/jpeg", "file_url": "' & $file_url[0] & '", "body": "' & $iOrigPushB & ': Last Attack Image"}'
   $oHTTP.Send($pPush)
   $Result = $oHTTP.ResponseText
EndFunc   ;==>PushImageLoot

Func _Push($pTitle, $pMessage)
    $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
    $access_token = $PushToken
    ;$device_iden = ""

    $oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
    $oHTTP.SetCredentials($access_token, "", 0)
    $oHTTP.SetRequestHeader("Content-Type", "application/json")
    Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
    ;Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '","device_iden": "' & $device_iden[$pDevice - 1] & '"}'
    $oHTTP.Send($pPush)
 EndFunc   ;==>Push

Func ReportPushBullet()

	If $iLastAttack = 1 Then
		If $GoldLast <> "" Or $ElixirLast <> "" Then
			_PushBullet($iOrigPushB & ": Last Gain", " [G]: " &  _NumberFormat($GoldLast) & " [E]: " &  _NumberFormat($ElixirLast) & " [D]: " &  _NumberFormat($DarkLast) & "  [T]: " & _NumberFormat($TrophyLast))
		EndIf
	EndIf

	If $iAlertPBVillage = 1 Then
		_PushBullet($iOrigPushB & ": My Village", " [G]: " &  _NumberFormat($GoldCount) & " [E]: " &  _NumberFormat($ElixirCount) & " [D]: " &  _NumberFormat($DarkCount) & "  [T]: " &  _NumberFormat($TrophyCount) & " [FB]: " &  _NumberFormat($FreeBuilder))
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
   If $iAlertPBMatchFound = 1 Then
	  _PushBullet($iOrigPushB & ": Match Found After " & $SearchCount & " Searches", " [G]: " & _NumberFormat($searchGold) & " [E]: " & _NumberFormat($searchElixir) & " [D]: " & _NumberFormat($searchDark) & " [T]: " & _NumberFormat($searchTrophy) & " [M]: " & $iradAttackModeString)
   Endif
EndFunc   ;==>ReportMatchFound