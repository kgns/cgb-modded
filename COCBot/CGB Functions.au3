; #FUNCTION# ====================================================================================================================
; Name ..........: CGB Functions
; Description ...: This file Includes several files in the current script.
; Syntax ........: #include
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

#include "functions\Attack\AttackReport.au3"
#include "functions\Attack\dropCC.au3"
#include "functions\Attack\dropHeroes.au3"
#include "functions\Attack\GoldElixirChange.au3"
#include "functions\Attack\PrepareAttack.au3"
#include "functions\Attack\ReturnHome.au3"
#include "functions\Attack\TroopDeploy.au3"
#include "functions\Attack\Attack Algorithms\algorithmTH.au3"
#include "functions\Attack\Attack Algorithms\algorithm_AllTroops.au3"
#include "functions\Attack\Attack Algorithms\algorithm_Barch.au3"

#include "functions\Config\applyConfig.au3"
#include "functions\Config\readConfig.au3"
#include "functions\Config\saveConfig.au3"
#include "functions\Config\ScreenCoordinates.au3"

#include "functions\Image Search\ImageSearch.au3"
#include "functions\Image Search\checkDeadBase.au3"
#include "functions\Image Search\checkTownhall.au3"
#include "functions\Image Search\checkWall.au3"
#include "functions\Image Search\checkDElixS.au3"

#include "functions\Main Screen\checkMainScreen.au3"
#include "functions\Main Screen\checkObstacles.au3"
#include "functions\Main Screen\waitMainScreen.au3"
#include "functions\Main Screen\ZoomOut.au3"
#include "functions\Main Screen\isProblemAffect.au3"

#include "functions\Other\_NumberFormat.au3"
#include "functions\Other\_PadStringCenter.au3"
#include "functions\Other\_Sleep.au3"
#include "functions\Other\Click.au3"
#include "functions\Other\ClickDrag.au3"
#include "functions\Other\CreateLogFile.au3"
#include "functions\Other\FindPos.au3"
#include "functions\Other\getBSPos.au3"
;#include "functions\Other\GUICtrlGetBkColor.au3" ; included in CGB GUI Control
#include "functions\Other\SetLog.au3"
#include "functions\Other\Tab.au3"
#include "functions\Other\Time.au3"
#include "functions\Other\BlockInputEx.au3"
#include "functions\Other\TogglePause.au3"
#include "functions\Other\CheckPrerequisites.au3"

#include "functions\Pixels\_CaptureRegion.au3"
#include "functions\Pixels\_ColorCheck.au3"
#include "functions\Pixels\GetListPixel.au3"
#include "functions\Pixels\_GetPixelColor.au3"
#include "functions\Pixels\_PixelSearch.au3"
#include "functions\Pixels\_MultiPixelSearch.au3"
#include "functions\Pixels\boolPixelSearch.au3"

#include "functions\Read Text\getChar.au3"
#include "functions\Read Text\getDarkElixir.au3"
#include "functions\Read Text\getDigit.au3"
#include "functions\Read Text\getDigitLarge.au3"
#include "functions\Read Text\getDigitSmall.au3"
#include "functions\Read Text\getElixir.au3"
#include "functions\Read Text\getGold.au3"
#include "functions\Read Text\getNormal.au3"
#include "functions\Read Text\getOther.au3"
#include "functions\Read Text\getReturnHome.au3"
#include "functions\Read Text\getTrophy.au3"
#include "functions\Read Text\getString.au3"

;#include "functions\Search\checkNextButton.au3"
#include "functions\Search\CompareResources.au3"
#include "functions\Search\GetResources.au3"
#include "functions\Search\PrepareSearch.au3"
#include "functions\Search\VillageSearch.au3"
#include "functions\Search\CheckZoomOut.au3"
#include "functions\Search\SearchTownHallloc.au3"

#include "functions\Village\BoostBarracks.au3"
#include "functions\Village\BotDetectFirstTime.au3"
#include "functions\Village\BotCommand.au3"
#include "functions\Village\CheckFullArmy.au3"
#include "functions\Village\Collect.au3"
#include "functions\Village\DonateCC.au3"
#include "functions\Village\DropTrophy.au3"
#include "functions\Village\isGoldFull.au3"
#include "functions\Village\isElixirFull.au3"
#include "functions\Village\LocateBarrack.au3"
#include "functions\Village\LocateBuildings.au3"
#include "functions\Village\LocateClanCastle.au3"
#include "functions\Village\LocateTownHall.au3"
#include "functions\Village\ReArm.au3"
#include "functions\Village\RequestCC.au3"
#include "functions\Village\Train.au3"
#include "functions\Village\VillageReport.au3"
#include "functions\Village\isBarrack.au3"
#include "functions\Village\UpgradeBuilding.au3"
#include "functions\Village\UpgradeWall.au3"
#include "functions\Village\PushBullet.au3"
#include "functions\Village\UpTroops.au3"

#include "functions\Village\LocateSpell.au3"
#include "functions\Village\Spell.au3"

#include "functions\Read Text\getDigitProfile.au3"
#include "functions\Village\ProfileReport.au3"