; #FUNCTION# ====================================================================================================================
; Name ..........: CGB Global Variables
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
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

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <GuiSlider.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
;#include <WindowsConstants.au3> ; included on CGB Bot.au3
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Array.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <INet.au3>
#include <GuiTab.au3>
#include <String.au3>
#include <IE.au3>

GLOBAL CONST $COLOR_ORANGE = 0xFFA500

Global $Compiled
If @Compiled Then
	$Compiled = "Executable"
Else
	$Compiled = "Au3 Script"
EndIf

Global $hBitmap; Image for pixel functions
Global $hHBitmap; Handle Image for pixel functions
;Global $sFile = @ScriptDir & "\Icons\logo.gif"

Global $Title = "BlueStacks App Player" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window

Global $config = @ScriptDir & "\config.ini"
Global $building = @ScriptDir & "\building.ini"
Global $dirLogs = @ScriptDir & "\logs\"
Global $dirLoots = @ScriptDir & "\Loots\"
Global $sLogPath ; `Will create a new log file every time the start button is pressed
Global $hLogFileHandle
Global $Restart = False
Global $RunState = False
Global $TakeLootSnapShot = True
Global $ScreenshotLootInfo = False
Global $AlertSearch = True
Global $iChkAttackNow, $iAttackNowDelay, $bBtnAttackNowPressed = False
Global $icmbAtkNowDeploy, $ichkAtkNowLSpell, $ichkAtkNowMines = False
Global $PushToken = ""

Global $DontTouchMe=False
Global $IAmSelfish=False

;PushBullet---------------------------------------------------------------
Global $PBRemoteControlInterval = 30000
GLOBAL $iOrigPushB
Global $iAlertPBVillage
GLOBAL $pEnabled
GLOBAL $pRemote
GLOBAL $pMatchFound
GLOBAL $pLastRaidImg
GLOBAL $iAlertPBLastRaidTxt
GLOBAL $pWallUpgrade
GLOBAL $pOOS
GLOBAL $pTakeAbreak
GLOBAL $pAnotherDevice
GLOBAL $sLogFName
;GLOBAL $AttackFile
GLOBAL $RequestScreenshot = 0
Global $iDeleteAllPushes = 0
Global $iDeleteAllPushesNow = False
Global $ichkDeleteOldPushes
Global $icmbHoursPushBullet
Global $chkDeleteAllPushes
Global $pLabUpgrade

Global $cmbTroopComp ;For Event change on ComboBox Troop Compositions
Global $iCollectCounter = 0 ; Collect counter, when reaches $COLLECTATCOUNT, it will collect
Global $COLLECTATCOUNT = 8 ; Run Collect() after this amount of times before actually collect

;---------------------------------------------------------------------------------------------------
Global $BSpos[2] ; Inside BlueStacks positions relative to the screen
;---------------------------------------------------------------------------------------------------
;Stats
;Global $iGoldLoot, $iElixirLoot, $iDarkLoot, $iTrophyLoot
Global $GoldCount, $ElixirCount, $DarkCount, $TrophyCount
Global $FreeBuilder, $TotalBuilders, $GemCount
Global $GoldStart, $ElixirStart, $DarkStart, $TrophyStart
Global $GoldVillage, $ElixirVillage, $DarkVillage, $TrophyVillage
;Global $GoldLast, $ElixirLast, $DarkLast, $TrophyLast
Global $totalLootGold, $totalLootElixir, $totalLootDarkElixir, $totalLootTrophies, $totalLootZapAndRun
;Global $CostGoldWall, $CostElixirWall

;Global $costspell

;Search Settings
Global $Is_ClientSyncError = False ;If true means while searching Client Out Of Sync error occurred.
Global $searchGold, $searchElixir, $searchDark, $searchTrophy, $searchTH ;Resources of bases when searching
Global $SearchGold2=0, $SearchElixir2=0, $iStuck=0, $iNext=0
Global $MinGold, $MinElixir, $MinGoldPlusElixir, $MinDark, $MinTrophy, $MaxTH ; Minimum Resources conditions
Global $AimGold, $AimElixir, $AimGoldPlusElixir, $AimDark, $AimTrophy, $AimTHtext ; Aiming Resource values
Global $iChkSearchReduction
Global $ReduceCount, $ReduceGold, $ReduceElixir, $ReduceGoldPlusElixir, $ReduceDark, $ReduceTrophy ; Reducing values
Global $chkConditions[7], $ichkMeetOne ;Conditions (meet gold...)
Global $icmbTH
Global $THLocation
Global $THx = 0, $THy = 0
Global $LabPos[2]
Global $DESLoc
Global $DESLocx = 0
Global $DESLocy = 0
Global $THText[5] ; Text of each Townhall level
$THText[0] = "4-6"
$THText[1] = "7"
$THText[2] = "8"
$THText[3] = "9"
$THText[4] = "10"
Global $SearchCount = 0 ;Number of searches
Global $THaddtiles, $THside, $THi
Global $SearchTHLResult=0
Global $BullySearchCount=0
Global $OptBullyMode=0
Global $OptTrophyMode
Global $OptTrophyModeDE
Global $ATBullyMode
Global $YourTH
Global $AttackTHType
Global $chklightspell
Global $chkZapAndRun
Global $OptZapAndRun
Global $zapandrunAvoidAttack = 0
Global $SpellMinDarkStorage = 500
Global $iLSpellQ

Global $TrainSpecial=1 ;0=Only trains after atk. Setting is automatic
Global $cBarbarian=0,$cArcher=0,$cGoblin=0,$cGiant=0,$cWallbreaker=0,$cWizard=0,$cBalloon=0,$cDragon=0,$cPekka=0,$cMinion=0,$cHogs=0,$cValkyrie=0,$cGolem=0,$cWitch=0,$cLavaHound=0
;Troop types
Global Enum $eBarb, $eArch, $eGiant, $eGobl, $eWall, $eBall, $eWiza, $eHeal, $eDrag, $ePekk, $eMini, $eHogs, $eValk, $eGole, $eWitc, $eLava, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell
;wall
Global $wallcost
Global $wallbuild
Global $walllowlevel
Global $iwallcost
Global $iwallcostelix
Global $Wallgoldmake = 0
Global $Wallelixirmake = 0
Global $WallX = 0, $WallY = 0, $WallLoc = 0
Global $Wallv[8]
Global $wallh[8]
Global $Wall[8]

;Attack Settings
Global $TopLeft[5][2] = [[79, 281], [170, 205], [234, 162], [296, 115], [368, 66]]
Global $TopRight[5][2] = [[480, 63], [540, 104], [589, 146], [655, 190], [779, 278]]
Global $BottomLeft[5][2] = [[79, 342], [142, 389], [210, 446], [276, 492], [339, 539]]
Global $BottomRight[5][2] = [[523, 537], [595, 484], [654, 440], [715, 393], [779, 344]]
Global $eThing[1] = [101]
Global $Edges[4] = [$BottomRight, $TopLeft, $BottomLeft, $TopRight]

Global $atkTroops[9][2] ;9 Slots of troops -  Name, Amount

Global $fullArmy ;Check for full army or not
Global $deploySettings ;Method of deploy found in attack settings
Global $chkRedArea, $iCmbSmartDeploy, $chkSmartAttack[3]

Global $KingAttack[3] ;King attack settings
Global $QueenAttack[3] ;Queen attack settings
Global $A[4] = [112, 111, 116, 97]

Global $checkKPower = False ; Check for King activate power
Global $checkQPower = False ; Check for Queen activate power
Global $iActivateKQCondition
Global $delayActivateKQ ; = 9000 ;Delay before activating KQ
Global $checkUseClanCastle ; Use Clan Castle settings
Global $checkUseClanCastleBalanced ; Use Clan Castle Balanced settings
Global $ratioNumeratorDonated ; Use Clan Castle Balanced ratio settings
Global $ratioDenominatorReceived ; Use Clan Castle Balanced ratio settings
Global $iradAttackMode ;Attack mode, 0 1 2
Global $iradAttackModeString
Global $THLoc
Global $chkATH, $iChkLightSpell
Global $iChkSnipeWhileTrain, $isSnipeWhileTrain, $tempSnipeWhileTrain[14], $haltSearch ; Snipe While Train MOD by ChiefM3

Global $King, $Queen, $CC, $Barb, $Arch, $LSpell , $LSpellQ
Global $LeftTHx, $RightTHx, $BottomTHy, $TopTHy
Global $AtkTroopTH
Global $GetTHLoc
Global $iUnbreakableMode = 0
Global $iUnbreakableWait, $iUnBrkMinGold, $iUnBrkMinElixir, $iUnBrkMaxGold, $iUnBrkMaxElixir

;Boosts Settings
Global $remainingBoosts = 0 ;  remaining boost to active during session
Global $boostsEnabled = 1 ; is this function enabled

; TownHall Settings
Global $TownHallPos[2] = [-1, -1] ;Position of TownHall
Global $Y[4] = [46, 116, 120, 116]
;Mics Setting
Global $SFPos[2]=[-1, -1] ;Position of Spell Factory

;Donate Settings
Global $aCCPos[2] = [-1, -1] ;Position of clan castle
Global $LastDonateBtn1 = -1, $LastDonateBtn2 = -1

Global $iChkRequest = 0, $sTxtRequest = ""

Global $ichkDonateAllBarbarians = 0, $ichkDonateBarbarians = 0, $sTxtDonateBarbarians = "", $sTxtBlacklistBarbarians = "", $aDonBarbarians, $aBlkBarbarians
Global $ichkDonateAllArchers = 0, $ichkDonateArchers = 0, $sTxtDonateArchers = "", $sTxtBlacklistArchers = "", $aDonArchers, $aBlkArchers
Global $ichkDonateAllGiants = 0, $ichkDonateGiants = 0, $sTxtDonateGiants = "", $sTxtBlacklistGiants = "", $aDonGiants, $aBlkGiants
Global $ichkDonateAllGoblins = 0, $ichkDonateGoblins = 0, $sTxtDonateGoblins = "", $sTxtBlacklistGoblins = "", $aDonGoblins, $aBlkGoblins
Global $ichkDonateAllWallBreakers = 0, $ichkDonateWallBreakers = 0, $sTxtDonateWallBreakers = "", $sTxtBlacklistWallBreakers = "", $aDonWallBreakers, $aBlkWallBreakers
Global $ichkDonateAllBalloons = 0, $ichkDonateBalloons = 0, $sTxtDonateBalloons = "", $sTxtBlacklistBalloons = "", $aDonBalloons, $aBlkBalloons
Global $ichkDonateAllWizards = 0, $ichkDonateWizards = 0, $sTxtDonateWizards = "", $sTxtBlacklistWizards = "", $aDonWizards, $aBlkWizards
Global $ichkDonateAllHealers = 0, $ichkDonateHealers = 0, $sTxtDonateHealers = "", $sTxtBlacklistHealers = "", $aDonHealers, $aBlkHealers
Global $ichkDonateAllDragons = 0, $ichkDonateDragons = 0, $sTxtDonateDragons = "", $sTxtBlacklistDragons = "", $aDonDragons, $aBlkDragons
Global $ichkDonateAllPekkas = 0, $ichkDonatePekkas = 0, $sTxtDonatePekkas = "", $sTxtBlacklistPekkas = "", $aDonPekkas, $aBlkPekkas
Global $ichkDonateAllMinions = 0, $ichkDonateMinions = 0, $sTxtDonateMinions = "", $sTxtBlacklistMinions = "", $aDonMinions, $aBlkMinions
Global $ichkDonateAllHogRiders = 0, $ichkDonateHogRiders = 0, $sTxtDonateHogRiders = "", $sTxtBlacklistHogRiders = "", $aDonHogRiders, $aBlkHogRiders
Global $ichkDonateAllValkyries = 0, $ichkDonateValkyries = 0, $sTxtDonateValkyries = "", $sTxtBlacklistValkyries = "", $aDonValkyries, $aBlkValkyries
Global $ichkDonateAllGolems = 0, $ichkDonateGolems = 0, $sTxtDonateGolems = "", $sTxtBlacklistGolems = "", $aDonGolems, $aBlkGolems
Global $ichkDonateAllWitches = 0, $ichkDonateWitches = 0, $sTxtDonateWitches = "", $sTxtBlacklistWitches = "", $aDonWitches, $aBlkWitches
Global $ichkDonateAllLavaHounds = 0, $ichkDonateLavaHounds = 0, $sTxtDonateLavaHounds = "", $sTxtBlacklistLavaHounds = "", $aDonLavaHounds, $aBlkLavaHounds
Global $ichkDonateAllCustom = 0, $ichkDonateCustom = 0, $sTxtDonateCustom = "", $sTxtBlacklistCustom = "", $aDonCustom, $aBlkCustom, $varDonateCustom[3][2] ;;; Custom Combination Donate by ChiefM3
Global $sTxtBlacklist = "", $aBlacklist
Global $B[6] = [116, 111, 98, 111, 116, 46]
Global $F[8] = [112, 58, 47, 47, 119, 119, 119, 46]

;Troop Settings
Global $icmbTroopComp ;Troop Composition
Global $icmbTroopCap ;Troop Capacity
Global $BarbComp = 30, $ArchComp = 60, $GoblComp = 10, $GiantComp = 4, $WallComp = 4, $WizaComp = 0, $MiniComp = 0, $HogsComp = 0
Global $DragComp = 0, $BallComp = 0, $PekkComp = 0, $HealComp = 0, $ValkComp = 0, $GoleComp = 0, $WitcComp = 0, $LavaComp = 0
Global $CurBarb = 0, $CurArch = 0, $CurGiant = 0, $CurGobl = 0, $CurWall = 0, $CurBall = 0, $CurWiza = 0, $CurHeal = 0
Global $CurMini = 0, $CurHogs = 0, $CurValk = 0, $CurGole = 0, $CurWitc = 0, $CurLava = 0, $CurDrag = 0, $CurPekk = 0
Global $T[1] = [97]
Global $ArmyComp

;Global $barrackPos[4][2] ;Positions of each barracks
Global $barrackPos[2] ;Positions of each barracks
Global $barrackTroop[10] ;Barrack troop set
Global $ArmyPos[2]
Global $barrackNum = 0
Global $barrackDarkNum = 0
Global $ichkUpgradeKing, $ichkUpgradeQueen ;==> upgrade heroes
Global $KingPos[2]
Global $QueenPos[2]
;Other Settings
Global $ichkWalls
Global $icmbWalls
Global $iUseStorage
Global $itxtWallMinGold
Global $itxtWallMinElixir
Global $itxtBuildMinGold
Global $itxtBuildMinElixir
Global $itxtBuildMinDark
Global $itxtBuilderKeepFree
Global $ichkTrees
Global $ichkTombs
Global $iVSDelay
Global $ichkTrap, $iChkCollect
Global $icmbUnitDelay, $icmbWaveDelay, $iRandomspeedatk
Global $iTimeTroops = 0
Global $iTimeGiant = 120
Global $iTimeWall = 120
Global $iTimeArch = 25
Global $iTimeGoblin = 30
Global $iTimeBarba = 20
Global $iTimeWizard = 480
Global $iChkTrophyHeroes, $iChkTrophyAtkDead
Global $ichkUpgrade1, $ichkUpgrade2, $ichkUpgrade3, $ichkUpgrade4
Global $itxtUpgradeX1, $itxtUpgradeY1, $itxtUpgradeX2, $itxtUpgradeY2, $itxtUpgradeX3, $itxtUpgradeY3, $itxtUpgradeX4, $itxtUpgradeY4
Global $BuildPos1[2]
Global $BuildPos2[2]
Global $BuildPos3[2]
Global $BuildPos4[2]

;General Settings
Global $botPos[2] ; Position of bot used for Hide function
Global $frmBotPosX ; Position X of the GUI
Global $frmBotPosY ; Position Y of the GUI
Global $Hide = False ; If hidden or not

Global $ichkBotStop, $icmbBotCommand, $icmbBotCond, $icmbHoursStop
Global $C[6] = [98, 117, 103, 115, 51, 46]
Global $CommandStop = -1
Global $MeetCondStop = False
Global $UseTimeStop = -1
Global $TimeToStop = -1

Global $itxtMaxTrophy ; Max trophy before drop trophy
Global $itxtdropTrophy ; trophy floor to drop to
Global $ichkAutoStart ; AutoStart mode enabled disabled
Global $restarted
Global $ichkBackground ; Background mode enabled disabled
Global $collectorPos[17][2] ;Positions of each collectors
Global $D[4] = [99, 111, 109, 47]

Global $break = @ScriptDir & "\images\break.bmp"
Global $device = @ScriptDir & "\images\device.bmp"
Global $CocStopped = @ScriptDir & "\images\CocStopped.bmp"
Global $G[3] = [104, 116, 116]
Global $resArmy = 0
Global $FirstAttack = 0
Global $FirstRun = 1
Global $CurTrophy = 0
Global $brrNum
Global $sTimer, $iTimePassed, $hour, $min, $sec , $sTimeWakeUp = 120,$sTimeStopAtk
Global $fulltroop = 100
Global $CurCamp, $TotalCamp = 0
Global $NoLeague
Global $FirstStart = true
Global $TPaused, $BlockInputPause=0

Global $iWBMortar
Global $iWBWizTower
Global $iWBXbow
Global $TroopGroup[10][4] = [["Pekk",9,25,-1],["Drag",8,20,-1],["Heal",7,14,-1],["Wiza",6,4,-1],["Ball",5,5,-1],["Wall",4,2,-1],["Giant",2,5,-1],["Gobl",3,1,-1],["Arch",1,1,9],["Barb",0,1,8]]
Global $THSnipeTroopGroup[10][4] = [["Arch",1,1,2],["Giant",2,5,-1],["Barb",0,1,0],["Heal",7,14,-1],["Wiza",6,4,-1],["Drag",8,20,-1],["Pekk",9,25,-1],["Gobl",3,1,-1],["Wall",4,2,-1],["Ball",5,5,-1]]
Global $TroopName[Ubound($TroopGroup,1)]
Global $TroopNamePosition[Ubound($TroopGroup,1)]
Global $TroopHeight[Ubound($TroopGroup,1)]
Global $TroopRotateIndex[Ubound($TroopGroup,1)]
Global $TroopGroupDark[6][3] = [["Lava",5,30],["Gole",3,30],["Witc",4,12],["Valk",2,8],["Hogs",1,5],["Mini",0,2]]
Global $TroopDarkName[Ubound($TroopGroupDark,1)]
Global $TroopDarkNamePosition[Ubound($TroopGroupDark,1)]
Global $TroopDarkHeight[Ubound($TroopGroupDark,1)]
Global $BarrackStatus[4] = [false,false,false,false]
Global $BarrackDarkStatus[2] = [false,false]
Global $listResourceLocation = ""
Global $isNormalBuild = ""
Global $isDarkBuild = ""
Global $TrainPos = ""

for $i=0 to Ubound($TroopGroup,1) - 1
	$TroopName[$i]         							= $TroopGroup[$i][0]
	$TroopNamePosition[$i] 							= $TroopGroup[$i][1]
	$TroopHeight[$i]       							= $TroopGroup[$i][2]
	$TroopRotateIndex[$i]   						= $TroopGroup[$i][3]
next
for $i=0 to Ubound($TroopGroupDark,1) - 1
	$TroopDarkName[$i]         = $TroopGroupDark[$i][0]
	$TroopDarkNamePosition[$i] = $TroopGroupDark[$i][1]
	$TroopDarkHeight[$i]       = $TroopGroupDark[$i][2]
next

Global $LibDir=@ScriptDir&"\lib" ;lib directory contains dll
;New var to search red area
Global $PixelTopLeft[0]
Global $PixelBottomLeft[0]
Global $PixelTopRight[0]
Global $PixelBottomRight[0]

Global $PixelTopLeftFurther[0]
Global $PixelBottomLeftFurther[0]
Global $PixelTopRightFurther[0]
Global $PixelBottomRightFurther[0]

Global $PixelMine[0]
Global $PixelElixir[0]
Global $PixelDarkElixir[0]
Global $PixelNearCollector[0]

Global $PixelRedArea[0]
Global $hBitmapFirst
Global Enum $eVectorLeftTop, $eVectorRightTop, $eVectorLeftBottom, $eVectorRightBottom
Global $debugRedArea = 0, $debugSetlog = 0

Global $DESTOLoc = ""

Global $dropAllOnSide=1

; Info Profile
Global $AttacksWon = 0
Global $DefensesWon = 0
Global $TroopsDonated = 0
Global $TroopsReceived = 0

Global $LootFileName = ""

Global $lootGold
Global $lootElixir
Global $lootDarkElixir
Global $lootTrophies

Global $debug_getdigitlarge

;UpTroops
Global $ichkLab
Global $icmbLaboratory
Global $itxtLabX
Global $itxtLabY
Global $UpBar2X = 175
Global $UpBar2Y = 370
Global $UpArchX = 175
Global $UpArchY = 470
Global $GiantsX = 275
Global $GiantsY = 370
Global $GoblinsX = 275
Global $GoblinsY = 470
Global $WBreakerX = 375
Global $WBreakerY = 370
Global $BalloonX = 375
Global $BalloonY = 470
Global $WizardX = 475
Global $WizardY = 370
Global $UpHealX = 475
Global $UpHealY = 470
Global $UpDragonX = 575
Global $UpDragonY = 370
Global $UpPekkaX = 575
Global $UpPekkaY = 470
Global $SpellHealX = 675
Global $SpellHealY = 470
Global $SpellLightningX = 675
Global $SpellLightningY = 370
