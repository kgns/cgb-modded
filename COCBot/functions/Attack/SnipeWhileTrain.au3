; #FUNCTION# ====================================================================================================================
; Name ..........: SnipeWhileTrain
; Description ...: During the idle loop, if $chkSnipeWhileTrain is checked, the bot will to for pure TH snipe
;                  and return after 20 searches to profit from idle time.
;                  VillageSearch() was modified to break search after 20 loops.
;                  2 variables are used for this function.
;                  Global $chkSnipeWhileTrain, $isSnipeWhileTrain
;                  Local $tempSnipeWHileTrain[12]
; Syntax ........:
; Parameters ....: None
; Return values .: False if not enough troops (30%) True if 20 searches was successfully done.
; Author ........: ChiefM3
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func SnipeWhileTrain()
   ; Attempt only when 30% army full to prevent failure of TH snipe
   If $TotalCamp * $fulltroop < 0.3 Then
	  Return False
   EndIf

   ; Swap variables to pure TH snipe mode
   Local $tempSnipeWhileTrain[14] = [2, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0]
   $tempSnipeWhileTrain[0] = $iradAttackMode ; attack mode
   $tempSnipeWhileTrain[1] = $chkConditions[0]
   $tempSnipeWhileTrain[2] = $chkConditions[1]
   $tempSnipeWhileTrain[3] = $chkConditions[2]
   $tempSnipeWhileTrain[4] = $chkConditions[3]
   $tempSnipeWhileTrain[5] = $chkConditions[4]
   $tempSnipeWhileTrain[6] = $chkConditions[5]
   $tempSnipeWhileTrain[7] = $chkConditions[6]
   $tempSnipeWhileTrain[8] = $MinGold
   $tempSnipeWHileTrain[9] = $MinElixir
   $tempSnipeWhileTrain[10] = $ichkMeetOne ; search meet one
   $tempSnipeWhileTrain[11] = $chkATH ; Attack Town Hall
   $tempSnipeWhileTrain[12] = $OptTrophyMode ; TH snipe
   $tempSnipeWhileTrain[13] = $THaddtiles ; Th snipe tiles
   $iradAttackMode = 2
   $chkConditions[0] = 0
   $chkConditions[1] = 0
   $chkConditions[2] = 0
   $chkConditions[3] = 1
   $chkConditions[4] = 0
   $chkConditions[5] = 1
   $chkConditions[6] = 0
   $MinGold = 1
   $MinElixir = 1
   $ichkMeetOne = 0
   $chkATH = 1
   $OptTrophyMode = 1
   If $TotalCamp * $fulltroop < 0.7 Then
	  $THaddtiles = 0 ;; Safe TH snipe if army under 70%
   Else
	  $THaddtiles = 1 ;; Take a bit of risk if army over 70%
   EndIf

   ; go to search for 20 times
   SetLog("Trying TH snipe while training army", $COLOR_RED)
   $isSnipeWhileTrain = True
   $Is_ClientSyncError = False
   AttackMain()
   $Restart = False ; Sets $Restart as True to end search after 10 attempts
   $Is_ClientSyncError = False
   $isSnipeWhileTrain = False
   SetLog("End trying TH snipe while training army", $COLOR_RED)

   ; revert settings back to normal
   $iradAttackMode = $tempSnipeWhileTrain[0]
   $chkConditions[0] = $tempSnipeWhileTrain[1]
   $chkConditions[1] = $tempSnipeWhileTrain[2]
   $chkConditions[2] = $tempSnipeWhileTrain[3]
   $chkConditions[3] = $tempSnipeWhileTrain[4]
   $chkConditions[4] = $tempSnipeWhileTrain[5]
   $chkConditions[5] = $tempSnipeWhileTrain[6]
   $chkConditions[6] = $tempSnipeWhileTrain[7]
   $MinGold = $tempSnipeWhileTrain[8]
   $MinElixir = $tempSnipeWhileTrain[9]
   $ichkMeetOne = $tempSnipeWhileTrain[10]
   $chkATH = $tempSnipeWhileTrain[11]
   $OptTrophyMode = $tempSnipeWhileTrain[12]
   $THaddtiles = $tempSnipeWhileTrain[13]

   Return True

EndFunc