; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Hervidero (2015)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

;~ ------------------------------------------------------
;~ Main GUI
;~ ------------------------------------------------------
$frmBot = GUICreate($sBotTitle, 470, 715)
	GUISetIcon($LibDir & "\CGBBOT.dll", 10)
	TraySetIcon($LibDir & "\CGBBOT.dll", 10)
	GUISetFont(8.5,400,0,"Tahoma")
$tabMain = GUICtrlCreateTab(5, 85, 461, 495, $TCS_TOOLTIPS)
	GUICtrlSetOnEvent(-1, "tabMain")
	GUICtrlCreatePic (@ScriptDir & "\Icons\logo.jpg", 0, 0, 470, 80)

;~ ------------------------------------------------------
;~ Header Menu
;~ ------------------------------------------------------
$configMenu = GUICtrlCreateMenu("Load / Save Config")
$loadConfig = GUICtrlCreateMenuItem("Load", $configMenu)
	GUICtrlSetOnEvent(-1, "btnLoadConfig")
	GUICtrlSetTip(-1, "Load Configuration Setting")
$saveConfig = GUICtrlCreateMenuItem("Save", $configMenu)
	GUICtrlSetOnEvent(-1, "btnSaveConfig")
	GUICtrlSetTip(-1, "Save Configuration Setting")

;~ ------------------------------------------------------
;~ Lower part visible on all Tabs
;~ ------------------------------------------------------
;Local $btnColor = True
Local $btnColor = False

;~ Buttons
$grpButtons = GUICtrlCreateGroup("", 10, 580, 190, 85)
Local $x = 15, $y = 590
	$btnStart = GUICtrlCreateButton("Start Bot", $x, $y + 2, 90, 40)
		GUICtrlSetOnEvent(-1, "btnStart")
		IF $btnColor then GUICtrlSetBkColor(-1, 0x5CAD85)
	$btnStop = GUICtrlCreateButton("Stop Bot", -1, -1, 90, 40)
		GUICtrlSetOnEvent(-1, "btnStop")
		IF $btnColor then GUICtrlSetBkColor(-1, 0xDB4D4D)
		GUICtrlSetState(-1, $GUI_HIDE)
 	$btnPause = GUICtrlCreateButton("Pause", $x + 90, -1, 50, 40)
		$txtTip = "Use this to PAUSE all actions of the bot until you Resume."
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnPause")
 		IF $btnColor then GUICtrlSetBkColor(-1,  0xFFA500)
		GUICtrlSetState(-1, $GUI_HIDE)
	$btnResume = GUICtrlCreateButton("Resume", -1, -1, 50, 40)
 		$txtTip = "Use this to RESUME a paused Bot."
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnResume")
		IF $btnColor then GUICtrlSetBkColor(-1,  0xFFA500)
		GUICtrlSetState(-1, $GUI_HIDE)
	$btnDonate = GUICtrlCreateButton("Donate", $x + 140, -1, 40, 40, $BS_ICON)
		$txtTip = "Click here if you want to DONATE to our project."
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetImage (-1, @ScriptDir & "\Icons\donate.ico",1)
		GUICtrlSetOnEvent(-1, "")
	$chkAutoStart = GUICtrlCreateCheckbox("AS", $x + 2, $y + 48, 30, 20)
 		$txtTip = "Check this to ENABLE the Auto Start of the Bot." & @CRLF & "The bot will Auto Start after 10 seconds"
 		GUICtrlSetFont(-1, 7)
 		GUICtrlSetTip(-1, $txtTip)
 		GUICtrlSetOnEvent(-1, "chkAS")
 		GUICtrlSetState(-1, $GUI_UNCHECKED)
    $btnHide = GUICtrlCreateButton("Hide BS", $x + 40, $y + 45, 50, -1)
		$txtTip = "Use this to move the BlueStacks Window out of sight." & @CRLF & "(Not minimized, but hidden)"
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnHide")
		IF $btnColor Then GUICtrlSetBkColor(-1, 0x22C4F5)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkBackground = GUICtrlCreateCheckbox("Background" & @CRLF & "Mode", $x + 100, $y + 48, 70, 20, BITOR($BS_MULTILINE, $BS_CENTER))
		$txtTip = "Check this to ENABLE the Background Mode of the Bot." & @CRLF & "With this you can also hide the BlueStacks window out of sight."
		GUICtrlSetFont(-1, 7)
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "chkBackground")
		GUICtrlSetState(-1, $GUI_UNCHECKED)
	$btnAttackNow = GUICtrlCreateButton("Attack!", $x + 195, $y + 2, 50, 20, $BS_MULTILINE)
		GUICtrlSetOnEvent(-1, "btnAttackNow")
		GUICtrlSetState(-1, $GUI_HIDE)
	$cmbAtkNowDeploy = GUICtrlCreateCombo("", $x + 195, $y + 22, 50, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "1 side|2 side|3 side|4 side", "4 side")
 		GUICtrlSetState(-1, $GUI_HIDE)
	$chkAtkNowMines = GUICtrlCreateCheckbox("Pumps", $x + 195, $y + 43, 50, 20)
 		GUICtrlSetState(-1, $GUI_HIDE)
	$chkAtkNowLSpell = GUICtrlCreateCheckbox("LSpell", $x + 195, $y + 60, 50, 20)
 		GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlCreateGroup("", -99, -99, 1, 1)

	$pic2arrow = GUICtrlCreatePic(@ScriptDir & "\Icons\2arrow.jpg", $x + 187, $y +10, 50, 45)
	$lblVersion = GUICtrlCreateLabel($sBotVersion, 205, $y + 60, 60, 17, $SS_CENTER)
		GUICtrlSetColor(-1, $COLOR_MEDGRAY)

;~ Village
Local $x = 290, $y = 600
$grpVillage = GUICtrlCreateGroup("Village", $x - 20, $y - 20, 190, 85)
	$lblResultGoldNow = GUICtrlCreateLabel("", $x, $y + 2, 50, 15, $SS_RIGHT)
	$picResultGoldNow = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x + 60, $y, 16, 16)
		GUICtrlSetState(-1, $GUI_HIDE)
	$picResultGoldTemp = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x - 5, $y, 16, 16)
	$lblResultElixirNow = GUICtrlCreateLabel("", $x, $y + 22, 50, 15, $SS_RIGHT)
	$picResultElixirNow = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x + 60, $y + 20, 16, 16)
		GUICtrlSetState(-1, $GUI_HIDE)
	$picResultElixirTemp = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x - 5, $y + 20, 16, 16)
	$lblResultDENow = GUICtrlCreateLabel("", $x, $y + 42, 50, 15, $SS_RIGHT)
	$picResultDENow = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x + 60, $y + 40, 16, 16)
		GUICtrlSetState(-1, $GUI_HIDE)
	$picResultDETemp = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x - 5, $y + 40, 16, 16)
	$x += 80
	$lblResultTrophyNow = GUICtrlCreateLabel("", $x, $y + 2, 50, 15, $SS_RIGHT)
	$picResultTrophyNow = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x + 59, $y , 16, 16)
	$lblResultBuilderNow = GUICtrlCreateLabel("", $x, $y + 22, 50, 15, $SS_RIGHT)
	$picResultBuilderNow = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 8, $x + 59, $y + 20, 16, 16)
	$lblResultGemNow = GUICtrlCreateLabel("", $x, $y + 42, 50, 15, $SS_RIGHT)
	$picResultGemNow = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 18, $x + 60, $y + 40, 16, 16)
	$x = 290
	$lblVillageReportTemp = GUICtrlCreateLabel("Village Report" & @CRLF & "will appear here" & @CRLF & "on first run.", $x + 27, $y + 5, 100, 45, BITOR($SS_CENTER, $BS_MULTILINE))
GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ -------------------------------------------------------------
;~ This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $FirstControlToHide = GUICtrlCreateDummy()
;~ -------------------------------------------------------------

;~ -------------------------------------------------------
;~ General Tab
;~ -------------------------------------------------------

$tabGeneral = GUICtrlCreateTabItem("General")
	$txtLog = _GUICtrlRichEdit_Create($frmBot, "", 10, 115, 450, 405, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912), $WS_EX_STATICEDGE)
		_ArrayConcatenate($G, $A)
	$grpControls = GUICtrlCreateGroup("Halt Attack", 10, 525, 450, 50)
		$chkBotStop = GUICtrlCreateCheckbox("", 25, 545, 16, 16)
			$txtTip = "Use these options to set when the bot will stop attacking."
			GUICtrlSetTip(-1, $txtTip)
		$cmbBotCommand = GUICtrlCreateCombo("", 50, 542, 90, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "Halt Attack|Shutdown PC|Sleep PC", "Halt Attack")
		$lblBotCond = GUICtrlCreateLabel("When...", 155, 545, 45, 17)
		$cmbBotCond = GUICtrlCreateCombo("", 205, 542, 160, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "G and E Full and Max.Trophy|(G and E) Full or Max.Trophy|(G or E) Full and Max.Trophy|G or E Full or Max.Trophy|Gold and Elixir Full|Gold or Elixir Full|Gold Full and Max.Trophy|Elixir Full and Max.Trophy|Gold Full or Max.Trophy|Elixir Full or Max.Trophy|Gold Full|Elixir Full|Reach Max. Trophy|Bot running for...|Now (Train/Donate Only)|Now (Donate Only)|Now (Only stay online)", "Now (Train/Donate Only)")
			GUICtrlSetOnEvent(-1, "cmbBotCond")
		$cmbHoursStop = GUICtrlCreateCombo("", 365, 542, 80, 35, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|1 Hour|2 Hours|3 Hours|4 Hours|5 Hours|6 Hours|7 Hours|8 Hours|9 Hours|10 Hours|11 Hours|12 Hours|13 Hours|14 Hours|15 Hours|16 Hours|17 Hours|18 Hours|19 Hours|20 Hours|21 Hours|22 Hours|23 Hours|24 Hours", "-")
			GUICtrlSetState (-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Search Tab
;~ -------------------------------------------------------------

$tabSearch = GUICtrlCreateTabItem("Search")
	Local $x = 30, $y = 130
	$grpAttackMode = GUICtrlCreateGroup("Search Mode", $x - 20, $y - 20, 450, 130)
		$radDeadBases = GUICtrlCreateRadio("Dead Bases", $x, $y - 5, -1, -1)
			 $txtTip = "Search for a Base with Full Collectors and meets all search conditions."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "radNotWeakBases")
		$y +=22
		$radWeakBases = GUICtrlCreateRadio("Weak Bases -->", $x, $y - 5, -1, -1)
			$txtTip =  "Search for a Base able to get 50% star and meets all search conditions."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "radWeakBases")
		$y +=22
		$radAllBases = GUICtrlCreateRadio("All Bases", $x, $y -5, -1, -1)
			$txtTip = "Search for a Base that meets all search conditions."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "radNotWeakBases")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 150, $y = 130
	$grpWeakBaseSettings = GUICtrlCreateGroup("", $x - 20, $y - 20, 330, 85)
		$txtTip = "Use these options to specify the WeakBase settings."
		$lblWBMortar = GUICtrlCreateLabel("Max. Mortar Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBMortar = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8", "5")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBWizTower = GUICtrlCreateLabel("Max. Wizard Tow. Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBWizTower = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8", "4")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBCannon = GUICtrlCreateLabel("Max. Cannon Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBCannon = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "8")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$x += 160
	$y = 130
	$lblWBArchTow = GUICtrlCreateLabel("Max. Archer Tow. Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBArchTow = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "8")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBXBow = GUICtrlCreateLabel("Max. X-Bow Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBXbow = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4", "0")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBInferno = GUICtrlCreateLabel("Max. Inferno Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBInferno = GUICtrlCreateCombo("", $x + 100, $y -5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3", "0")
		GUICtrlSetState(-1, $GUI_DISABLE)

#cs	Local $x = 30, $y = 210
		$chkBackToAllMode = GUICtrlCreateCheckbox("All Base after:", $x, $y, -1, -1)
			$txtTip = "Release Dead Base or Weak Base search and switch to All Base after No. of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkBackToAllMode")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtBackToAllMode = GUICtrlCreateInput("150", $x + 100, $y, 35, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "No. of searches to wait before activating."
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblBackToAllMode = GUICtrlCreateLabel("search(es).", $x + 137, $y + 5, -1, -1)
#ce			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = 30, $y = 265
	$grpConditions = GUICtrlCreateGroup("Conditions", $x - 20, $y - 20, 220, 200)
		$y -= 5
		$chkMeetGxE = GUICtrlCreateRadio("Meet Gold and Elixir", $x , $y, -1, -1)
			$txtTip = "Search for a base that meets BOTH the values set for Min. Gold, Elixir."
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetGorE = GUICtrlCreateRadio("Meet Gold or Elixir", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets ONE of the values set for Min. Gold, Elixir."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$y += 22
		$chkMeetGpE = GUICtrlCreateRadio("Meet Gold + Elixir", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets sum of values set for Min. Gold + Elixir."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$y += 22
		$chkMeetDE = GUICtrlCreateCheckbox("Meet Dark Elixir", $x , $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Dark Elixir."
			GUICtrlSetOnEvent(-1, "chkMeetDE")
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetTrophy = GUICtrlCreateCheckbox("Meet Trophy Count", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Trophies."
			GUICtrlSetOnEvent(-1, "chkMeetTrophy")
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetTH = GUICtrlCreateCheckbox("Meet Townhall Level", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Max. Townhall Level."
			GUICtrlSetOnEvent(-1, "chkMeetTH")
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetTHO = GUICtrlCreateCheckbox("Meet Townhall Outside", $x, $y, -1, -1)
			$txtTip = "Search for a base that has an exposed Townhall. (Outside of Walls)"
			GUICtrlSetTip(-1, $txtTip)
		$y += 27
		$chkMeetOne = GUICtrlCreateCheckbox("Meet One Then Attack", $x, $y, -1, -1)
			$txtTip = "Just meet only ONE of the above conditions, then Attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = 465
	$grpAlert = GUICtrlCreateGroup("", $x - 20, $y - 20, 100, 40)
		$chkAlertSearch = GUICtrlCreateCheckbox("Alert me", $x, $y - 8, -1, -1, $BS_MULTILINE)
			GUICtrlSetTip(-1, "Check this if you want an Audio alarm & a Balloon Tip when a Base to attack is found.")
			GUICtrlSetState(-1, $GUI_CHECKED)
		$btnSearchMode = GUICtrlCreateButton("Search Mode", $x + 90, $y -10, 100, 25)
			GUICtrlSetOnEvent(-1, "btnSearchMode")
			GUICtrlSetTip(-1, "Does not attack. Searches for a Village that meets conditions.")

Local $x = 255, $y = 265
	$grpResources = GUICtrlCreateGroup("Values", $x - 20, $y - 20, 225, 150)
		$lblMinGold = GUICtrlCreateLabel("Minimum Gold: ", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Gold to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinGold = GUICtrlCreateInput("80000", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$y += 22
		$lblMinElixir = GUICtrlCreateLabel("Minimum Elixir:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinElixir = GUICtrlCreateInput("80000", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$y += 22
		$lblMinGoldPlusElixir = GUICtrlCreateLabel("Minimum Gold + Elixir:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Gold + Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinGoldPlusElixir = GUICtrlCreateInput("160000", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$y += 22
		$lblMinDarkElixir = GUICtrlCreateLabel("Minimum Dark Elixir:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Dark Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinDarkElixir = GUICtrlCreateInput("0", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
			_GUICtrlEdit_SetReadOnly(-1, True)
		$y += 22
		$lblMinTrophy = GUICtrlCreateLabel("Minimum Trophy Count:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Trophies to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinTrophy = GUICtrlCreateInput("0", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetLimit(-1, 2)
		$y += 22
		$lblMinTH = GUICtrlCreateLabel("Maximum Townhall Level:", $x, $y, -1, -1)
			$txtTip = "Set the Max. level of the Townhall to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$cmbTH = GUICtrlCreateCombo("", $x + 130, $y - 5, 61, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = 420
	$grpSearchReduction = GUICtrlCreateGroup("Search Reduction", $x - 20, $y - 20, 225, 110)
		$y -= 5
		$chkSearchReduction = GUICtrlCreateCheckbox("Auto Reduce", $x , $y, -1, -1)
			$txtTip = "Check this if you want the search values to automatically be reduced after a certain amount of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkSearchReduction")
		$y += 22
		$lblSearchReduceGold = GUICtrlCreateLabel("Gold:", $x, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Gold by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceGold = GUICtrlCreateInput("2000", $x + 35, $y, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$lblSearchReduceCount = GUICtrlCreateLabel("Search(es):", $x + 95, $y + 5, -1, 17)
		$txtSearchReduceCount = GUICtrlCreateInput("20", $x + 155, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Enter the No. of searches to wait before each reduction occures."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$y += 22
		$lblSearchReduceElixir = GUICtrlCreateLabel("Elixir:", $x, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Elixir by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceElixir = GUICtrlCreateInput("2000", $x + 35, $y, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$lblSearchReduceDark = GUICtrlCreateLabel("Dark:", $x + 115, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Dark Elixir by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceDark = GUICtrlCreateInput("100", $x + 155, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$y += 22
		$lblSearchReduceGoldPlusElixir = GUICtrlCreateLabel("G+E:", $x, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Sum Value for G+E by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceGoldPlusElixir = GUICtrlCreateInput("4000", $x + 35, $y, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$lblSearchReduceTrophy = GUICtrlCreateLabel("Trophy:", $x + 115, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Trophies by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceTrophy = GUICtrlCreateInput("2", $x + 155, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
; Attack Basics Tab
;~ -------------------------------------------------------------

$tabAttack = GUICtrlCreateTabItem("Attack")
	Local $x = 30, $y = 130
	$grpDeploy = GUICtrlCreateGroup("Deploy", $x - 20, $y - 20, 450, 75)
		$y -= 5
		$lblDeploy = GUICtrlCreateLabel("Attack on:", $x + 20, $y + 5, -1, -1)
		$cmbDeploy = GUICtrlCreateCombo("", $x + 75, $y, 270, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Attack on a single side, penetrates through base" & @CRLF & "Attack on two sides, penetrates through base" & @CRLF & "Attack on three sides, gets outer and some inside of base" & @CRLF & "Attack on all sides equally, gets most of outer base", "Select the No. of sides to attack on.")
			GUICtrlSetData(-1, "one side, penetrates through base|two sides, penetrates through base|three sides, gets outer and some inside of base|all sides equally, gets most of outer base", "all sides equally, gets most of outer base")
		$y += 25
		$lblUnitDelay = GUICtrlCreateLabel("Unit Delay:", $x + 20, $y + 5, -1, -1)
			$txtTip = "This delays the deployment of troops, 1 (fast) = like a Bot, 10 (slow) = Like a Human." & @CRLF & "Random will make bot more varied and closer to a person."
			GUICtrlSetTip(-1, $txtTip)
		$cmbUnitDelay = GUICtrlCreateCombo("", $x + 75, $y, 40, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$lblWaveDelay = GUICtrlCreateLabel("Wave Delay:", $x + 130, $y + 5, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$cmbWaveDelay = GUICtrlCreateCombo("", $x + 195, $y, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$Randomspeedatk = GUICtrlCreateCheckbox("Random", $x + 250, $y, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "Randomspeedatk")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = 210
	$grpSmartAttack = GUICtrlCreateGroup("Smart Attack", $x - 20, $y - 20, 450, 105)
		$y -= 5
		$chkDeployRedArea = GUICtrlCreateCheckbox("Use Smart Attack. Drop your Troops near the Red Line.", $x, $y, -1, -1)
			$txtTip = "Use Smart Attack to detect the outer 'Red Line' of the village to attack. And drop your troops close to it."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkDeployRedArea")
		$y += 25
		$lblSmartDeploy = GUICtrlCreateLabel("Deploy Mode:", $x + 20, $y + 5, -1, -1)
			$txtTip = "Select the Deploy Mode for the waves of Troops." & @CRLF & _
				"Type 1: Drop a single wave of troops on each side then switch troops, OR" & @CRLF & _
				"Type 2: Drop a full wave of all troops (e.g. giants, barbs and archers) on each side then switch sides."
			GUICtrlSetTip(-1, $txtTip)
		$cmbSmartDeploy = GUICtrlCreateCombo("", $x + 90, $y, 250, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Type 1: First switch Sides, then switch Troops|Type 2: First switch Troops, then switch Sides", "Type 1: First switch Sides, then switch Troops")
			GUICtrlSetTip(-1, $txtTip)
		$y += 30
		$x += 20
		$picAttackNearGoldMine = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 59, $x + 80 , $y - 3 , 24, 24)
		$chkAttackNearGoldMine = GUICtrlCreateCheckbox("Attack near", $x, $y, -1, -1)
			$txtTip = "Drop troops near Gold Mines"
			GUICtrlSetTip(-1, $txtTip)
		$x += 130
		$picAttackNearElixirCollector = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 16, $x + 80 , $y - 3 , 24, 24)
		$chkAttackNearElixirCollector = GUICtrlCreateCheckbox("Attack near", $x, $y, -1, -1)
			$txtTip = "Drop troops near Elixir Collectors"
			GUICtrlSetTip(-1, $txtTip)
 		$x += 130
		$picAttackNearDarkElixirDrill = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 14, $x + 80 , $y - 3, 24, 24)
  		$chkAttackNearDarkElixirDrill = GUICtrlCreateCheckbox("Attack near", $x, $y, -1, -1)
			$txtTip = "Drop troops near Dark Elixir Drills"
 			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 320
	$grpKing = GUICtrlCreateGroup("King", $x - 20, $y -20, 150, 90)
		$txtTip = "Use your King in this Attack Mode."
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 7, $x - 10 , $y + 10 , 32, 32)
		$chkKingAttackDeadBases = GUICtrlCreateCheckbox("Atk Dead Bases", $x + 25, $y - 2, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$chkKingAttackWeakBases = GUICtrlCreateCheckbox("Atk Weak Bases", $x + 25, $y + 18, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$chkKingAttackAllBases = GUICtrlCreateCheckbox("Atk All Bases", $x + 25, $y + 38, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpQueen = GUICtrlCreateGroup("Queen", $x + 135, $y - 20, 150, 90)
		$txtTip = "Use your Queen in this Attack Mode."
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 41, $x + 145, $y + 10, 32, 32)
		$chkQueenAttackDeadBases = GUICtrlCreateCheckbox("Atk Dead Bases", $x + 180, $y - 2, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$chkQueenAttackWeakBases = GUICtrlCreateCheckbox("Atk Weak Bases", $x + 180, $y + 18, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$chkQueenAttackAllBases = GUICtrlCreateCheckbox("Atk All Bases", $x + 180, $y + 38, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpClanCastle = GUICtrlCreateGroup("Clan Castle", $x + 290, $y - 20, 140, 90)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 9, $x + 300, $y + 10, 32, 32)
		$chkUseClanCastle = GUICtrlCreateCheckbox("Drop in Battle", $x + 335, $y - 2, -1, -1)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetTip(-1, "Drop your Clan Castle in battle if it contains troops.")
			GUICtrlSetOnEvent(-1, "chkDropInBattle")
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 9, $x + 300, $y + 10, 32, 32)
		$chkUseClanCastleBalanced = GUICtrlCreateCheckbox("Balance D/R", $x + 335, $y + 18, -1, -1)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetTip(-1, "Drop your Clan Castle only if your donated/received ratio is greater than D/R ratio below.")
			GUICtrlSetOnEvent(-1, "chkBalanceDR")
	   $cmbRatioNumeratorDonated = GUICtrlCreateCombo("",  $x + 335, $y + 40, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, "Donated coefficient")
		GUICtrlSetData(-1, "0|1|2|3|4|5", "1")
		GUICtrlSetState(-1, $GUI_DISABLE)
		$lblDRRatio = GUICtrlCreateLabel("/", $x + 375, $y + 45, -1, -1)
			$txtTip = "Wanted donated / received ratio" & @CRLF & "1/1 means donated = received, 1/2 means donated = half the received etc."
			GUICtrlSetTip(-1, $txtTip)
	   $cmbRatioDenominatorReceived = GUICtrlCreateCombo("", $x + 382, $y + 40, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, "Received coefficient")
		GUICtrlSetData(-1, "1|2|3|4|5", "1")
		GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 415
	$grpRoyalAbilities = GUICtrlCreateGroup("Hero Abilities", $x - 20, $y - 20, 450, 90)
		$y += 5
		GUICtrlCreatePic (@ScriptDir & "\Icons\KingAbility.jpg", $x -10, $y - 3, 30, 47)
		GUICtrlCreatePic (@ScriptDir & "\Icons\QueenAbility.jpg", $x + 20, $y - 3, 30, 47)
		$x +=55
		$radManAbilities = GUICtrlCreateRadio("Timed activation of Hero Abilities after:", $x, $y + 3, -1, -1)
			$txtTip = "Activate the Ability on a timer." & @CRLF & "Both Heroes are activated at the same time."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$radAutoAbilities = GUICtrlCreateRadio("Auto activate Hero Abilities when they become weak (red zone).", $x, $y + 25, -1, -1)
		$txtTip = "Activate the Ability when the Hero becomes weak." & @CRLF & "King and Queen are checked and activated individually."
		GUICtrlSetTip(-1, $txtTip)
		$txtManAbilities = GUICtrlCreateInput("9", $x + 200, $y + 2, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the time in seconds for Timed Activation of Hero Abilities."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 2)
		$lblRoyalAbilitiesSec = GUICtrlCreateLabel("sec.", $x + 235, $y + 7, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Attack Advanced Tab
;~ -------------------------------------------------------------
 $tabAttackAdv = GUICtrlCreateTabItem("Adv.")
	Local $x = 30, $y = 130
	$grpAtkOptions = GUICtrlCreateGroup("Attack Options", $x - 20, $y - 20, 450, 155)
		$chkAttackNow = GUICtrlCreateCheckbox("Attack Now! option.", $x, $y, -1, -1)
			$txtTip = "Check this if you want the option to have an 'Attack Now!' button next to" & @CRLF & _
				"the Start and Pause buttons to bypass the dead base or all base search values." & @CRLF & _
				"The Attack Now! button will only appear when searching for villages to Attack."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkAttackNow")
		$y +=22
		$lblAttackNow = GUICtrlCreateLabel("Add:", $x + 20, $y + 4, -1, -1, $SS_RIGHT)
			$txtTip = "Add this amount of reaction time to slow down the search."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$cmbAttackNowDelay = GUICtrlCreateCombo("", $x + 50, $y + 1, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "5|4|3|2|1","3") ; default value 3
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblAttackNowSec = GUICtrlCreateLabel("sec. of reaction time.", $x + 90, $y + 4, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		$chkAttackTH = GUICtrlCreateCheckbox("Attack Townhall Outside", $x, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to Attack an exposed Townhall first. (Townhall outside of Walls)" & @CRLF & "TIP: Also tick 'Meet Townhall Outside' on the Search tab if you only want to search for bases with exposed Townhalls.")
	    $chkSnipeWhileTrain = GUICtrlCreateCheckbox("TH snipe while training army", $x + 200, $y, -1, -1) ; Snipe While Train MOD by ChiefM3
			GUICtrlSetTip(-1, "Bot will try to TH snipe while training army.")
		$y +=22
		$chkLightSpell = GUICtrlCreateCheckbox("Hit Dark Elixir storage with Lightning Spell", $x, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this if you want to use lightning spells to steal Dark Elixir when bot meet Minimum Dark Elixir.")
			GUICtrlSetOnEvent(-1, "GUILightSpell")
	    $txtMinDarkStorage = GUICtrlCreateInput("2000", $x + 275, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 4)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblSpellDarkStorage = GUICtrlCreateLabel("min. Dark Elixir", $x + 315, $y + 4, -1, -1)
			GUICtrlSetTip(-1, "Check this if you want to use Lightning Spells to steal Dark Elixir when bot meet Minimum Dark Elixir.")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
        $lbliLSpellQ = GUICtrlCreateLabel("Have:", $x + 20, $y + 4, -1, -1)
			$txtTip = "Set the minimum amount of spells needed. Never attack with less."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$cmbiLSpellQ = GUICtrlCreateCombo("", $x + 50, $y + 1, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "1|2|3|4|5", "3")
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lbliLSpellQ2 = GUICtrlCreateLabel("Lightning Spells ready before using this type of Attack.", $x + 90, $y + 4, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		 $y += 22
	    $chkZapAndRun = GUICtrlCreateCheckbox("Allow Zap && Run", $x, $y, -1, -1)
		GUICtrlSetTip(-1, "Allow Zap and Run behavior. If a live base has enough Dark Elixir, we will zap the storage and return.")
		GUICtrlSetState(-1, $GUI_DISABLE)

#cs		$y +=27
		$chkWithKing = GUICtrlCreateCheckbox("Attack their King", $x, $y, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		$chkWithQueen = GUICtrlCreateCheckbox("Attack their Queen", $x, $y, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
#ce
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 285
	$grpAtkCombos = GUICtrlCreateGroup("Advanced Attack Combo's", $x - 20, $y - 20, 225, 135)
		$chkBullyMode = GUICtrlCreateCheckbox("TH Bully.  After:", $x, $y, -1, -1)
			$txtTip = "Adds the TH Bully combo to the current search settings. (Example: Deadbase OR TH Bully)" & @CRLF & _
				"TH Bully: Attacks a lower townhall level after the specified No. of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkBullyMode")
		$txtATBullyMode = GUICtrlCreateInput("150", $x + 95, $y, 35, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "TH Bully: No. of searches to wait before activating."
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblATBullyMode = GUICtrlCreateLabel("search(es).", $x + 135, $y + 5, -1, -1)
		$y +=22
		$lblATBullyMode = GUICtrlCreateLabel("Max TH level:", $x + 10, $y + 5, -1, -1, $SS_RIGHT)
		$cmbYourTH = GUICtrlCreateCombo("", $x + 95, $y, 50, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "TH Bully: Max. Townhall level to bully."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y+=27
		$chkTrophyMode = GUICtrlCreateCheckbox("TH Snipe. Add:", $x, $y, -1, -1)
			$txtTip = "Adds the TH Snipe combination to the current search settings. (Example: Deadbase OR TH Snipe)"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkSnipeMode")
		$lblTHaddtiles = GUICtrlCreateLabel( "tile(s).", $x + 135, $y + 5, -1, 17)
		$txtTHaddtiles = GUICtrlCreateInput("1", $x + 95, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y+=22
		$lblAttackTHType = GUICtrlCreateLabel("Attack Type:", $x + 10 , $y + 5, -1, 17, $SS_RIGHT)
		$cmbAttackTHType = GUICtrlCreateCombo("",  $x + 95, $y, 105, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Barch|Attack1:Normal|Attack2:eXtreme|Attack3:Gbarch|Attack4:SmartBarch", "Attack1:Normal")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y+=22
		$chkTHSnipeLightningDE = GUICtrlCreateCheckbox("Use lightning for DE while TH Sniping", $x, $y, -1, -1)
			$txtTip = "Use lightning on DE storage if DE is > than Dark Elixir option above (NOT the one in the Search tab, but this tab) (This will disable lightning for non TH snipe attacks)"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 260, $y = 285
	$grpDefenseFarming = GUICtrlCreateGroup("Defense Farming", $x - 20, $y - 20, 220, 135)
		$chkUnbreakable = GUICtrlCreateCheckbox("Enable Unbreakable Mode", $x, $y, -1, -1)
			$TxtTip = "Enable farming Defense Wins for Unbreakable achievement." ;& @CRLF & "TIP: Set your trophy range on the Misc Tab to '600 - 800' for best results. WARNING: Doing so will DROP you Trophies!"
			GUICtrlSetTip(-1, $TxtTip)
			GUICtrlSetOnEvent(-1, "chkUnbreakable")
		$y += 23
		$lblUnbreakable1 = GUICtrlCreateLabel("Wait Time:", $x + 20 , $y+3, -1, -1)
		$txtUnbreakable = GUICtrlCreateInput("5", $x + 75, $y, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$TxtTip = "Set the amount of time to stop CoC and wait for enemy attacks to gain defense wins. (1-99 minutes)"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblUnbreakable2 = GUICtrlCreateLabel("Minutes", $x + 110, $y+3, -1, -1)
		$y += 26
		$lblUnBreakableFarm = GUICtrlCreateLabel("Farm Min.", $x + 60 , $y, -1, -1)
		$lblUnBreakableSave = GUICtrlCreateLabel("Save Min.", $x + 135 , $y, -1, -1)
		$y += 16
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x+5, $y, 16, 16)
		$lblUnBreakableGold = GUICtrlCreateLabel("Gold:", $x+23 , $y+3, -1, -1)
		$txtUnBrkMinGold = GUICtrlCreateInput("50000", $x + 55, $y, 58, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Amount of Gold that stops Defense farming, switches to normal farming if below." & @CRLF & "Set this value to amount of Gold you need for searching or upgrades.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$x += 130
		$txtUnBrkMaxGold = GUICtrlCreateInput("600000", $x, $y, 58, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Amount of Gold in Storage Required to Enable Defense Farming." & @CRLF & "Input amount of Gold you need to attract enemy or for upgrades.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$x -= 130
		$y +=24
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x+5, $y, 16, 16)
		$lblUnBreakableElixir = GUICtrlCreateLabel("Elixir:", $x+23, $y+3, -1, -1)
		$txtUnBrkMinElixir = GUICtrlCreateInput("50000", $x + 55, $y, 58, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Amount of Elixir that stops Defense farming, switches to normal farming if below." & @CRLF & "Set this value to amount of Elixir you need for making troops or upgrades.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$x += 130
		$txtUnBrkMaxElixir = GUICtrlCreateInput("600000", $x, $y, 58, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Amount of Elixir in Storage Required to Enable Defense Farming." & @CRLF & "Input amount of Elixir you need to attract enemy or for upgrades.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
    GUICtrlCreateGroup("", -99, -99, 1, 1)


	Local $x = 30, $y = 425
	$grpBattleOptions = GUICtrlCreateGroup("Battle Options", $x - 20, $y - 20, 300, 80)
		;$chkTimeStopAtk = GUICtrlCreateCheckbox("End Battle, if no new loot raided within:", $x, $y - 5, -1, -1)
		$lblTimeStopAtk = GUICtrlCreateLabel("End Battle, if no new loot raided within:", $x + 17, $y, -1, -1)
			$txtTip = "End Battle if there is no extra loot raided within this No. of seconds." & @CRLF & "Countdown is started after all Troops and Royals are deployed in battle."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$txtTimeStopAtk = GUICtrlCreateInput("20", $x + 202, $y - 5, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 2)
		$lblTimeStopAtk = GUICtrlCreateLabel("sec.", $x + 237, $y, -1, -1)
#cs
		$chkEndOneStar = GUICtrlCreateCheckbox("End Battle, when One Star is won", $x, $y + 15, -1, -1)
			$txtTip = "Will End the Battle if 1 star is won in battle"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$chkEndTwoStar = GUICtrlCreateCheckbox("End Battle, when Two Stars are won", $x, $y + 35, -1, -1)
			$txtTip = "Will End the Battle if 2 stars are won in battle"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
#ce
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x +=305
	$grpLootSnapshot = GUICtrlCreateGroup("Loot Snapshot", $x - 20, $y - 20, 145, 80)
		$chkTakeLootSS = GUICtrlCreateCheckbox("Take Loot Snapshot", $x - 5, $y - 5, -1, -1)
			GUICtrlSetTip(-1, "Check this if you want to save a Loot snapshot of the Village that was attacked.")
			GUICtrlSetState(-1, $GUI_CHECKED)
		$chkScreenshotLootInfo = GUICtrlCreateCheckbox("Include Loot Info", $x - 5, $y + 15, -1, -1)
			GUICtrlSetTip(-1, "Include loot info into screenshot filename")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Donate Tab
;~ -------------------------------------------------------------
$tabDonate = GUICtrlCreateTabItem("Donate")
	Local $x = 30, $y = 130
	$grpDonation = GUICtrlCreateGroup("Ask for Clan Castle Troops", $x - 20, $y - 20, 450, 65)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 9, $x - 5, $y, 32, 32, $BS_ICON)
		$chkRequest = GUICtrlCreateCheckbox("Request for:", $x + 35, $y + 5, -1, -1)
			GUICtrlSetOnEvent(-1, "chkRequest")
		$txtRequest = GUICtrlCreateInput("Anything please", $x + 115, $y + 5, 305, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetTip(-1, "This text is used on your request for troops in the Clan chat.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

$y += 70
$grpTroopselection = GUICtrlCreateGroup("Donate Troops Selection Menu", $x - 20, $y - 20, 450, 110)
$x -=2
	$lblBtnBarbarians = GUICtrlCreateLabel("", $x - 12, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnBarbarians = GUICtrlCreateButton("Barbarians", $x - 10, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 6, 1)
		GUICtrlSetOnEvent(-1, "btnDonateBarbarians")
	$lblBtnArchers = GUICtrlCreateLabel("", $x + 28, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnArchers = GUICtrlCreateButton("Archers", $x + 30, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 2, 1)
		GUICtrlSetOnEvent(-1, "btnDonateArchers")
	$lblBtnGiants = GUICtrlCreateLabel("", $x + 68, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnGiants = GUICtrlCreateButton("Giants", $x + 70, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 20, 1)
		GUICtrlSetOnEvent(-1, "btnDonateGiants")
	$lblBtnGoblins = GUICtrlCreateLabel("", $x + 108, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnGoblins = GUICtrlCreateButton("Goblins", $x + 110, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 23, 1)
		GUICtrlSetOnEvent(-1, "btnDonateGoblins")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnWallBreakers = GUICtrlCreateLabel("", $x + 148, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnWallBreakers = GUICtrlCreateButton("WallBreakers", $x + 150, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 52, 1)
		GUICtrlSetOnEvent(-1, "btnDonateWallBreakers")
		;GUICtrlSetState (-1, $GUI_DISABLE)

	$btnBlacklist = GUICtrlCreateButton("Blacklist", $x + 191, $y + 24, 32, 32, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 63, 1)
		GUICtrlSetOnEvent(-1, "btnDonateBlacklist")

	$lblBtnMinions = GUICtrlCreateLabel("", $x + 223, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnMinions = GUICtrlCreateButton("Minions", $x + 225, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 38, 1)
		GUICtrlSetOnEvent(-1, "btnDonateMinions")
	$lblBtnHogRiders = GUICtrlCreateLabel("", $x + 263, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnHogRiders = GUICtrlCreateButton("HogRiders", $x + 265, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 30, 1)
		GUICtrlSetOnEvent(-1, "btnDonateHogRiders")
	$lblBtnValkyries = GUICtrlCreateLabel("", $x + 303, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnValkyries = GUICtrlCreateButton("Valkyries", $x+ 305, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 49, 1)
		GUICtrlSetOnEvent(-1, "btnDonateValkyries")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnGolems = GUICtrlCreateLabel("", $x + 343, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnGolems = GUICtrlCreateButton("Golems", $x + 345, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 26, 1)
		GUICtrlSetOnEvent(-1, "btnDonateGolems")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnWitches = GUICtrlCreateLabel("", $x + 383, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnWitches = GUICtrlCreateButton("Witches", $x+ 385, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 54, 1)
		GUICtrlSetOnEvent(-1, "btnDonateWitches")
		;GUICtrlSetState (-1, $GUI_DISABLE)

$y += 40
	$lblBtnBalloons = GUICtrlCreateLabel("", $x - 12, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnBalloons = GUICtrlCreateButton("Balloons", $x - 10, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 4, 1)
		GUICtrlSetOnEvent(-1, "btnDonateBalloons")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnWizards = GUICtrlCreateLabel("", $x + 28, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnWizards = GUICtrlCreateButton("Wizards", $x + 30, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 56, 1)
		GUICtrlSetOnEvent(-1, "btnDonateWizards")
	$lblBtnHealers = GUICtrlCreateLabel("", $x + 68, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnHealers = GUICtrlCreateButton("Healers", $x + 70, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 28, 1)
		GUICtrlSetOnEvent(-1, "btnDonateHealers")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnDragons = GUICtrlCreateLabel("", $x + 108, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnDragons = GUICtrlCreateButton("Dragons", $x + 110, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 13, 1)
		GUICtrlSetOnEvent(-1, "btnDonateDragons")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnPekkas = GUICtrlCreateLabel("", $x + 148, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnPekkas = GUICtrlCreateButton("Pekkas", $x + 150, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 40, 1)
		GUICtrlSetOnEvent(-1, "btnDonatePekkas")
		;GUICtrlSetState (-1, $GUI_DISABLE)

	$lblBtnLavaHounds = GUICtrlCreateLabel("", $x + 223, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLavaHounds = GUICtrlCreateButton("LavaHounds", $x + 225, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 35, 1)
		GUICtrlSetOnEvent(-1, "btnDonateLavaHounds")
		;GUICtrlSetState (-1, $GUI_DISABLE)

	;;; Custom Combination Donate by ChiefM3
	$lblBtnCustom = GUICtrlCreateLabel("", $x + 263, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnCustom = GUICtrlCreateButton("Custom", $x + 265, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 43, 1) ;;; cross swords icon
		GUICtrlSetOnEvent(-1, "btnDonateCustom")

$x += 2
$y += 75
	$grpBarbarians = GUICtrlCreateGroup("Barbarians", $x - 20, $y - 20, 450, 190)
		$picDonateBarbarians = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 6, $x + 215, $y, 64, 64, $BS_ICON)
		$chkDonateBarbarians = GUICtrlCreateCheckbox("Donate Barbarians", $x + 285, $y + 10, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Barbarians if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateBarbarians")
		$chkDonateAllBarbarians = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Barbarians to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllBarbarians")
		$lblDonateBarbarians = 	GUICtrlCreateLabel("Keywords for donating Barbarians:", $x - 5, $y + 5, -1, -1)
		$txtDonateBarbarians = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetData(-1, StringFormat("barbarians\r\nbarb"))
			GUICtrlSetTip(-1, "Keywords for donating Barbarians")
		$lblBlacklistBarbarians = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
		$txtBlacklistBarbarians = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no barbarians\r\nno barb\r\nbarbarians no\r\nbarb no"))
			GUICtrlSetTip(-1, "Blacklist for donating Barbarians")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpArchers = GUICtrlCreateGroup("Archers", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateArchers = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 2, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateArchers = GUICtrlCreateCheckbox("Donate Archers", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Archers if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateArchers")
		$chkDonateAllArchers = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Archers to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllArchers")
		$lblDonateArchers = 	GUICtrlCreateLabel("Keywords for donating Archers:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateArchers = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("archers\r\narch"))
			GUICtrlSetTip(-1, "Keywords for donating Archers")
		$lblBlacklistArchers = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistArchers = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no archers\r\nno arch\r\narchers no\r\narch no"))
			GUICtrlSetTip(-1, "Blacklist for donating Archers")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpGiants = GUICtrlCreateGroup("Giants", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateGiants = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 20, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateGiants = GUICtrlCreateCheckbox("Donate Giants", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Giants if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateGiants")
		$chkDonateAllGiants = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Giants to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllGiants")
		$lblDonateGiants = 	GUICtrlCreateLabel("Keywords for donating Giants:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateGiants = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("giants\r\ngiant\r\nany\r\nreinforcements"))
			GUICtrlSetTip(-1, "Keywords for donating Giants")
		$lblBlacklistGiants = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistGiants = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no giants\r\ngiants no"))
			GUICtrlSetTip(-1, "Blacklist for donating Giants")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpGoblins = GUICtrlCreateGroup("Goblins", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateGoblins = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 23, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateGoblins = GUICtrlCreateCheckbox("Donate Goblins", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Goblins if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateGoblins")
		$chkDonateAllGoblins = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Goblins to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllGoblins")
		$lblDonateGoblins = 	GUICtrlCreateLabel("Keywords for donating Goblins:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateGoblins = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("goblins\r\ngoblin"))
			GUICtrlSetTip(-1, "Keywords for donating Goblins")
		$lblBlacklistGoblins = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistGoblins = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no goblins\r\ngoblins no"))
			GUICtrlSetTip(-1, "Blacklist for donating goblins")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpWallBreakers = GUICtrlCreateGroup("Wall Breakers", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateWallBreakers = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 52, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateWallBreakers = GUICtrlCreateCheckbox("Donate Wall Breakers", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Wall Breakers if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateWallBreakers")
		$chkDonateAllWallBreakers = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Wall Breakers to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllWallBreakers")
		$lblDonateWallBreakers = 	GUICtrlCreateLabel("Keywords for donating Wall Breakers:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateWallBreakers = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("wall breakers\r\nbreaker"))
			GUICtrlSetTip(-1, "Keywords for donating Wall Breakers")
		$lblBlacklistWallBreakers = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistWallBreakers = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no wall breakers\r\nwall breakers no"))
			GUICtrlSetTip(-1, "Blacklist for donating Wall Breakers")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpBalloons = GUICtrlCreateGroup("Balloons", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateBalloons = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 4, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateBalloons = GUICtrlCreateCheckbox("Donate Balloons", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Balloons if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateBalloons")
		$chkDonateAllBalloons = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Balloons to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllBalloons")
		$lblDonateBalloons = 	GUICtrlCreateLabel("Keywords for donating Balloons:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateBalloons = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("balloons\r\nballoon"))
			GUICtrlSetTip(-1, "Keywords for donating Balloons")
		$lblBlacklistBalloons = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistBalloons = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no balloons\r\nballoons no"))
			GUICtrlSetTip(-1, "Blacklist for donating Balloons")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpWizards = GUICtrlCreateGroup("Wizards", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateWizards = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 56, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateWizards = GUICtrlCreateCheckbox("Donate Wizards", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Wizards if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateWizards")
		$chkDonateAllWizards = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Wizards to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllWizards")
		$lblDonateWizards = 	GUICtrlCreateLabel("Keywords for donating Wizards:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateWizards = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("wizards\r\nwizard"))
			GUICtrlSetTip(-1, "Keywords for donating Wizards")
		$lblBlacklistWizards = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistWizards = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no wizards\r\nwizards no"))
			GUICtrlSetTip(-1, "Blacklist for donating Wizards")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpHealers = GUICtrlCreateGroup("Healers", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateHealers = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 28, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateHealers = GUICtrlCreateCheckbox("Donate Healers", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Healers if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateHealers")
		$chkDonateAllHealers = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Healers to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllHealers")
		$lblDonateHealers = 	GUICtrlCreateLabel("Keywords for donating Healers:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateHealers = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("healer"))
			GUICtrlSetTip(-1, "Keywords for donating Healers")
		$lblBlacklistHealers = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistHealers = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no healer\r\nhealer no"))
			GUICtrlSetTip(-1, "Blacklist for donating Healers")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpDragons = GUICtrlCreateGroup("Dragons", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateDragons = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 13, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateDragons = GUICtrlCreateCheckbox("Donate Dragons", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Dragons if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateDragons")
		$chkDonateAllDragons = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Dragons to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllDragons")
		$lblDonateDragons = 	GUICtrlCreateLabel("Keywords for donating Dragons:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateDragons = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("dragon"))
			GUICtrlSetTip(-1, "Keywords for donating Dragons")
		$lblBlacklistDragons = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistDragons = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no dragon\r\ndragon no"))
			GUICtrlSetTip(-1, "Blacklist for donating Dragons")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpPekkas = GUICtrlCreateGroup("P.E.K.K.A.s", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonatePekkas = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 40, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonatePekkas = GUICtrlCreateCheckbox("Donate P.E.K.K.A.s", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate P.E.K.K.A.s if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonatePekkas")
		$chkDonateAllPekkas = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate P.E.K.K.A.s to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllPekkas")
		$lblDonatePekkas = 	GUICtrlCreateLabel("Keywords for donating P.E.K.K.A.s:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonatePekkas = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("PEKKA\r\npekka"))
			GUICtrlSetTip(-1, "Keywords for donating P.E.K.K.A.s")
		$lblBlacklistPekkas = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistPekkas = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no PEKKA\r\npekka no"))
			GUICtrlSetTip(-1, "Blacklist for donating P.E.K.K.A.s")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpMinions = GUICtrlCreateGroup("Minions", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateMinions = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 38, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateMinions = GUICtrlCreateCheckbox("Donate Minions", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Minions if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateMinions")
		$chkDonateAllMinions = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Minions to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllMinions")
		$lblDonateMinions = 	GUICtrlCreateLabel("Keywords for donating Minions:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateMinions = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("minions\r\nminion"))
			GUICtrlSetTip(-1, "Keywords for donating Minions")
		$lblBlacklistMinions = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistMinions = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no minions\r\nminions no"))
			GUICtrlSetTip(-1, "Blacklist for donating Minions")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpHogRiders = GUICtrlCreateGroup("Hog Riders", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateHogRiders = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 30, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateHogRiders = GUICtrlCreateCheckbox("Donate Hog Riders", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Hog Riders if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateHogRiders")
		$chkDonateAllHogRiders = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Hog Riders to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllHogRiders")
		$lblDonateHogRiders = 	GUICtrlCreateLabel("Keywords for donating Hog Riders:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateHogRiders = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("hogriders\r\nhogs\r\nhog"))
			GUICtrlSetTip(-1, "Keywords for donating Hog Riders")
		$lblBlacklistHogRiders = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistHogRiders = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no hogs\r\nhog no"))
			GUICtrlSetTip(-1, "Blacklist for donating Hog Riders")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpValkyries = GUICtrlCreateGroup("Valkyries", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateValkyries = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 49, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateValkyries = GUICtrlCreateCheckbox("Donate Valkyries", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Valkyries if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateValkyries")
		$chkDonateAllValkyries = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Valkyries to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllValkyries")
		$lblDonateValkyries = 	GUICtrlCreateLabel("Keywords for donating Valkyries:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateValkyries = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("valkyries\r\nvalkyrie"))
			GUICtrlSetTip(-1, "Keywords for donating Valkyries")
		$lblBlacklistValkyries = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistValkyries = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no valkyries\r\nvalkyries no"))
			GUICtrlSetTip(-1, "Blacklist for donating Valkyries")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpGolems = GUICtrlCreateGroup("Golems", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateGolems = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 26, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateGolems = GUICtrlCreateCheckbox("Donate Golems", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Golems if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateGolems")
		$chkDonateAllGolems = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Golems to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllGolems")
		$lblDonateGolems = 	GUICtrlCreateLabel("Keywords for donating Golems:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateGolems = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("golem"))
			GUICtrlSetTip(-1, "Keywords for donating Golems")
		$lblBlacklistGolems = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistGolems = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no golem\r\ngolem no"))
			GUICtrlSetTip(-1, "Blacklist for donating Golems")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpWitches = GUICtrlCreateGroup("Witches", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateWitches = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 54, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateWitches = GUICtrlCreateCheckbox("Donate Witches", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Witches if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateWitches")
		$chkDonateAllWitches = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Witches to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllWitches")
		$lblDonateWitches = 	GUICtrlCreateLabel("Keywords for donating Witches:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateWitches = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("witches\r\nwitch"))
			GUICtrlSetTip(-1, "Keywords for donating Witches")
		$lblBlacklistWitches = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistWitches = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no witches\r\nwitch no"))
			GUICtrlSetTip(-1, "Blacklist for donating Witches")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpLavaHounds = GUICtrlCreateGroup("Lava Hounds", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateLavaHounds = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 35, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateLavaHounds = GUICtrlCreateCheckbox("Donate Lava Hounds", $x + 285, $y + 10, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Lava Hounds if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateLavaHounds")
		$chkDonateAllLavaHounds = GUICtrlCreateCheckbox("Donate to All", $x + 285, $y + 30, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Lava Hounds to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllLavaHounds")
		$lblDonateLavaHounds = 	GUICtrlCreateLabel("Keywords for donating Lava Hounds:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateLavaHounds = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("lavahound\r\nhound\r\nlava"))
			GUICtrlSetTip(-1, "Keywords for donating Lava Hounds")
		$lblBlacklistLavaHounds = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 70, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistLavaHounds = GUICtrlCreateEdit("", $x + 215, $y + 85, 200, 70, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no lavahound\r\nhound no"))
			GUICtrlSetTip(-1, "Blacklist for donating Lava Hounds")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	;;; Custom Combination Donate by Chief M3
	$grpCustom = GUICtrlCreateGroup("Custom", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		;$picDonateCustom = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 56, $x + 215, $y, 64, 64, $BS_ICON)
		;    GUICtrlSetState(-1, $GUI_HIDE)
		$chkDonateCustom = GUICtrlCreateCheckbox("Custom Combi", $x + 205, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Custom Combination if keywords match the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateCustom")
		$chkDonateAllCustom = GUICtrlCreateCheckbox("Donate to All", $x + 300, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetTip(-1, "Check this to donate Custom Combination to ALL Chat Requests." & @CRLF & "This will also ignore ALL keywords.")
			GUICtrlSetOnEvent(-1, "chkDonateAllCustom")
		$lblDonateCustom =     GUICtrlCreateLabel("Keywords for donating Custom Combination:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateCustom = GUICtrlCreateEdit("", $x - 5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetData(-1, StringFormat("any\r\nneed"))
			GUICtrlSetTip(-1, "Keywords for donating Custom Troops")

		$lblDonateCustom1 = GUICtrlCreateLabel("Troop1", $x+215, $y+27, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$cmbDonateCustom1 = GUICtrlCreateCombo("", $x+260, $y+23, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Barbarian|Archer|Giant|Goblin|Ballon|W.Breaker|Wizard|Healer|Dragon|Pekka|Minion|HogRider|Valkyrie|Golem|Witch|Lava|Nothing", "Wizard")
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateCustom1 = GUICtrlCreateInput("2", $x+365, $y+23, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetState(-1, $GUI_HIDE)

		$lblDonateCustom2 = GUICtrlCreateLabel("Troop2", $x+215, $y+49, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$cmbDonateCustom2 = GUICtrlCreateCombo("", $x+260, $y+45, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Barbarian|Archer|Giant|Goblin|Ballon|W.Breaker|Wizard|Healer|Dragon|Pekka|Minion|HogRider|Valkyrie|Golem|Witch|Lava|Nothing", "Barbarian")
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateCustom2 = GUICtrlCreateInput("1", $x+365, $y+45, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetState(-1, $GUI_HIDE)

		$lblDonateCustom3 = GUICtrlCreateLabel("Troop3", $x+215, $y+71, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$cmbDonateCustom3 = GUICtrlCreateCombo("", $x+260, $y+67, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Barbarian|Archer|Giant|Goblin|Ballon|W.Breaker|Wizard|Healer|Dragon|Pekka|Minion|HogRider|Valkyrie|Golem|Witch|Lava|Nothing", "Archer")
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtDonateCustom3 = GUICtrlCreateInput("8", $x+365, $y+67, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetState(-1, $GUI_HIDE)

		$lblBlacklistCustom = GUICtrlCreateLabel("Do NOT donate to these keywords:", $x + 215, $y + 90, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklistCustom = GUICtrlCreateEdit("", $x + 215, $y + 105, 200, 50, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("no\r\ncw\r\nwar"))
			GUICtrlSetTip(-1, "Blacklist for donating Custom Troops")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$grpBlacklist = GUICtrlCreateGroup("General Blacklist", $x - 20, $y - 20, 450, 190)
		GUICtrlSetState(-1, $GUI_HIDE)
		$picDonateBlacklist = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 63, $x + 215, $y, 64, 64, $BS_ICON)
			GUICtrlSetState(-1, $GUI_HIDE)
		$lblBlacklist = GUICtrlCreateLabel("Do NOT donate to any of these keywords:", $x - 5, $y + 5, -1, -1)
			GUICtrlSetState(-1, $GUI_HIDE)
		$txtBlacklist = GUICtrlCreateEdit("", $x -5, $y + 20, 205, 135, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetBkColor ( -1, 0x505050)
			GUICtrlSetColor ( -1, $COLOR_WHITE)
			GUICtrlSetData(-1, StringFormat("clan war\r\nwar\r\ncw"))
			GUICtrlSetTip(-1, "General Blacklist for donation requests")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ -------------------------------------------------------------
;~ Troops Tab
;~ -------------------------------------------------------------
$tabTroops = GUICtrlCreateTabItem("Troops")
	Local $x = 30, $y = 130
	$grpTroopComp = GUICtrlCreateGroup("Army Composition", $x - 20, $y - 20, 222, 55)
		$cmbTroopComp = GUICtrlCreateCombo("", $x - 5, $y, 190, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			TrayTip("GameBot.org", "Stay Informed Of New Releases" & @CRLF & "https://gamebot.org/latest", 100)
			GUICtrlSetTip(-1, "Set the type of Army composition." & @CRLF & "'Use Barracks Mode' or 'Custom Army' is for manual compositions.")
			GUICtrlSetOnEvent(-1, "cmbTroopComp")
			GUICtrlSetData(-1, "Preset: Archers|Preset: Barbarians|Preset: Goblins|Preset: B.Arch|Preset: B.A.G.G.|Preset: B.A.Giant|Preset: B.A.Goblin|Preset: B.A.G.G.Wall|Use Barrack Mode|Custom Army", "Custom Army")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 227
	$grpBarrackMode = GUICtrlCreateGroup("Barrack Mode", $x - 20, $y -20, 223, 75)
		$lblBarrack1 = GUICtrlCreateLabel("1:", $x - 5, $y + 5, -1, -1)
		$cmbBarrack1 = GUICtrlCreateCombo("", $x + 10, $y, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 1.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas", "Barbarians") ; "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas"
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y += 2
		$lblBarrack2 = GUICtrlCreateLabel("2:", $x - 5, $y + 26, -1, -1)
		$cmbBarrack2 = GUICtrlCreateCombo("", $x + 10, $y + 21, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 2.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas", "Archers") ; "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas"
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y -= 2
		$lblBarrack3 = GUICtrlCreateLabel("3:", $x + 100, $y + 5, -1, -1)
		$cmbBarrack3 = GUICtrlCreateCombo("", $x + 115, $y, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 3.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas", "Archers") ; "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas"
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y += 2
		$lblBarrack4 = GUICtrlCreateLabel("4:", $x + 100, $y + 26, -1, -1)
		$cmbBarrack4 = GUICtrlCreateCombo("", $x + 115, $y + 21, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 4.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas", "Goblins") ; "Barbarians|Archers|Giants|Goblins|WallBreakers|Balloons|Wizards|Healers|Dragons|Pekkas"
			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y=210
	$grpBoosterOptions = GUICtrlCreateGroup("Boost Options", $x - 20, $y - 20, 223, 95)
	$y -= 5
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 43, $x, $y + 2, 16, 16)
	$lblFullTroop = GUICtrlCreateLabel("Raid when Troops reach:",$x + 25, $y + 5, -1, 17)
	$txtFullTroop = GUICtrlCreateInput("100",  $x + 150, $y, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetTip(-1, "Enter percentage")
		GUICtrlSetLimit(-1, 3)
	$lblFullTroop = GUICtrlCreateLabel("%",$x + 188, $y + 5, -1, 17)
	$y += 25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 58, $x, $y + 2, 16, 16)
	$lblBoostBarracks = GUICtrlCreateLabel("Barracks Boosts left:", $x + 25, $y + 5, -1, -1)
		$txtTip = "Use this to boost your Barracks with GEMS! Use with caution!"
		GUICtrlSetTip(-1, $txtTip)
	$cmbBoostBarracks = GUICtrlCreateCombo("", $x + 150, $y, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0|1|2|3|4|5", "0")
		GUICtrlSetTip(-1, $txtTip)
	$y += 25
	GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 64, $x, $y + 2, 16, 16)
	$lblBoostSpellFactory = GUICtrlCreateLabel("Spell Factory Boosts left:", $x + 25, $y + 5, -1, -1)
		$txtTip = "Use this to boost your Spell Factory with GEMS! Use with caution!"
		GUICtrlSetTip(-1, $txtTip)
	$cmbBoostSpellFactory = GUICtrlCreateCombo("", $x + 150, $y, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0|1|2|3|4|5", "0")
		GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 190
	$grpTroops = GUICtrlCreateGroup("Troops", $x - 20, $y - 20, 222, 115)
		$y +=5
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 5, $x - 5, $y - 5, 24, 24)
		$lblBarbarians = GUICtrlCreateLabel("Barbarians:", $x + 25, $y, -1, -1)
		$txtNumBarb = GUICtrlCreateInput("30", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Set the % of Barbarians to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentBarbarians = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 1, $x - 5, $y - 5, 24, 24)
		$lblArchers = GUICtrlCreateLabel("Archers:", $x + 25, $y, -1, -1)
		$txtNumArch = GUICtrlCreateInput("60", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Set the % of Archers to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentArchers = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 22, $x - 5, $y - 5, 24, 24)
		$lblGoblins = GUICtrlCreateLabel("Goblins:", $x + 25, $y, -1, -1)
		$txtNumGobl = GUICtrlCreateInput("10", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Set the % of Goblins to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentGoblins = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 25
		$lblTotal = GUICtrlCreateLabel("Total:", $x + 95, $y - 5, -1, -1, $SS_RIGHT)
		$lblTotalCount = GUICtrlCreateLabel("100", $x + 130, $y - 5, 55, 15, $SS_CENTER)
			GUICtrlSetBkColor (-1, $COLOR_MONEYGREEN) ;lime, moneygreen
		$lblPercentTotal = GUICtrlCreateLabel("%", $x + 188, $y - 5, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 310
	$grpOtherTroops = GUICtrlCreateGroup("Add. Troops", $x - 20, $y - 20, 222, 195)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 19, $x - 5, $y - 5, 24, 24)
		$lblGiants = GUICtrlCreateLabel("No. of Giants:", $x + 25, $y, -1, -1)
		$txtNumGiant = GUICtrlCreateInput("4", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Giants to make.")
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 51, $x - 5, $y - 5, 24, 24)
		$lblWallBreakers = GUICtrlCreateLabel("No. of Wall Breakers:", $x + 25, $y, -1, -1)
		$txtNumWall = GUICtrlCreateInput("4", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Wall Breakers to make.")
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 4, $x - 5, $y - 5, 24, 24)
		$lblBalloons = GUICtrlCreateLabel("No. of Balloons:", $x + 25, $y, -1, -1)
		$txtNumBall = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Balloons to make.")
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 55, $x - 5, $y - 5, 24, 24)
		$lblWizards = GUICtrlCreateLabel("No. of Wizards:", $x + 25, $y, -1, -1)
		$txtNumWiza = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Wizards to make.")
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 27, $x - 5, $y - 5, 24, 24)
		$lblHealers = GUICtrlCreateLabel("No. of Healers:", $x + 25, $y, -1, -1)
		$txtNumHeal = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Healers to make.")
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 12, $x - 5, $y - 5, 24, 24)
		$lblDragons = GUICtrlCreateLabel("No. of Dragons:", $x + 25, $y, -1, -1)
		$txtNumDrag = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Dragons to make.")
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 39, $x - 5, $y - 5, 24, 24)
		$lblPekka = GUICtrlCreateLabel("No. of P.E.K.K.A.:", $x + 25, $y, -1, -1)
		$txtNumPekk = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of P.E.K.K.A. to make.")
			GUICtrlSetLimit(-1, 3)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x +=  227
	$y = 310
	$grpDarkTroops = GUICtrlCreateGroup("Add. Dark Troops", $x - 20, $y - 20, 223, 195)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 37, $x - 5, $y - 5, 24, 24)
		$lblMinion = GUICtrlCreateLabel("No. of Minions:", $x + 25, $y, -1, -1)
		$txtNumMini = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Minions to make.")
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 29, $x - 5, $y - 5, 24, 24)
		$lblHogRiders = GUICtrlCreateLabel("No. of Hog Riders:", $x + 25, $y, -1, -1)
		$txtNumHogs = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Hog Riders to make.")
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 48, $x - 5, $y - 5, 24, 24)
		$lblValkyries = GUICtrlCreateLabel("No. of Valkyries:", $x + 25, $y, -1, -1)
		$txtNumValk = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Valkyries to make.")
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 25, $x - 5, $y - 5, 24, 24)
		$lblGolems = GUICtrlCreateLabel("No. of Golems:", $x + 25, $y, -1, -1)
		$txtNumGole = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Golems to make.")
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 53, $x - 5, $y - 5, 24, 24)
		$lblWitches = GUICtrlCreateLabel("No. of Witches:", $x + 25, $y, -1, -1)
		$txtNumWitc = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Witches to make.")
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 34, $x - 5, $y - 5, 24, 24)
		$lblLavaHounds = GUICtrlCreateLabel("No. of Lava Hounds:", $x + 25, $y, -1, -1)
		$txtNumLava = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Lava Hounds to make.")
			GUICtrlSetLimit(-1, 2)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
; Misc Tab
;~ -------------------------------------------------------------
$tabMisc = GUICtrlCreateTabItem("Misc")
	Local $x = 30, $y = 130
	$grpTraps = GUICtrlCreateGroup("Traps, X-bows && Infernos", $x -20, $y - 20 , 225, 60)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 21, $x - 11, $y, 24, 24)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 57, $x + 12, $y, 24, 24)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 32, $x + 35, $y, 24, 24)
		$chkTrap = GUICtrlCreateCheckbox("Auto Rearm && Reload", $x + 65, $y + 2, -1, -1)
			GUICtrlSetTip(-1, "Check this to automatically Rearm Traps, Reload Xbows and Infernos (if any) in your Village.")
			GUICtrlSetOnEvent(-1, "chkTrap")
			_ArrayConcatenate($G, $D)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 200
	$grpCollect = GUICtrlCreateGroup("Collecting Resources", $x - 20, $y - 20 , 225, 60)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 59, $x - 11, $y, 24, 24)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 16, $x + 12, $y, 24, 24)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 14, $x + 35, $y, 24, 24)
		$chkCollect = GUICtrlCreateCheckbox("Auto Collect Resources", $x + 65, $y + 2, -1, -1)
			$txtTip = "Check this to automatically collect the Village's Resources" & @CRLF & " from Gold Mines, Elixir Collectors and Dark Elixir Drills."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	;Mow the Lawn
	Local $x = 260, $y = 200
	$grpOther = GUICtrlCreateGroup("Other", $x -20, $y - 20 , 220, 70)
		GUICtrlCreateIcon(@ScriptDir & "\Icons\trees.ico", -1, $x - 10, $y - 4, 18, 23)
		$chkTrees = GUICtrlCreateCheckbox("Remove Trees", $x + 20, $y - 2, -1, -1)
			GUICtrlSetTip(-1, "Check this to remove shrubbery. Ni! ... and gem boxes.")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkTrees")
		GUICtrlCreateIcon(@ScriptDir & "\Icons\tombs.ico", -1, $x - 10, $y + 18, 18, 23)
		$chkTombs = GUICtrlCreateCheckbox("Remove Tombstones", $x + 20, $y + 20, -1, -1)
			GUICtrlSetTip(-1, "Check this to remove enemy tombstones. They may obstruct shrubbery.")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkTombs")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	;End Mow the Lawn

	Local $x = 30, $y = 260
	$grpTimeWakeUp = GUICtrlCreateGroup("Remote Device", $x - 20, $y - 20 , 225, 60)
		$lblTimeWakeUp = GUICtrlCreateLabel("When 'Another Device' wait:", $x, $y + 7, -1, -1)
		$txtTip = "Enter the time to wait (in seconds) before the Bot reconnects when another device took control."
			GUICtrlSetTip(-1, $txtTip)
		$txtTimeWakeUp = GUICtrlCreateInput("120", $x + 138, $y + 4, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$lblTimeWakeUpSec = GUICtrlCreateLabel("sec.", $x + 175, $y + 7, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 325
	$grpVSDelay = GUICtrlCreateGroup("Village Search Delay ", $x - 20, $y - 20, 225, 55)
		$txtTip = "Use this slider to change the time to wait between Next clicks when searching for a Village to Attack." & @CRLF & "This might compensate for Out of Sync errors on some PC's." & @CRLF & "NO GUARANTEES! This will not always have the same results!"
		$lblVSDelay = GUICtrlCreateLabel("0", $x, $y, 12, 15, $SS_RIGHT)
			GUICtrlSetTip(-1, $txtTip)
		$lbltxtVSDelay = GUICtrlCreateLabel("seconds", $x + 15, $y, 45, -1)
		$sldVSDelay = GUICtrlCreateSlider($x + 55, $y - 2, 130, 25, BITOR($TBS_TOOLTIPS, $TBS_AUTOTICKS)) ;,
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-1, 1)
			GUICtrlSetLimit(-1, 10, 0) ; change max/min value
			GUICtrlSetData(-1, 0) ; default value
			GUICtrlSetOnEvent(-1, "sldVSDelay")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Local $x = 260, $y = 130
	$grpTrophy = GUICtrlCreateGroup("Trophy Settings", $x - 20, $y - 20, 220, 65)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x - 10, $y + 5, 24, 24)
		$lblTrophyRange = GUICtrlCreateLabel("Trophy range:", $x + 20, $y, -1, -1)
		$txtdropTrophy = GUICtrlCreateInput("3000", $x + 110, $y - 5, 35, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "MIN: The Bot will drop trophies until below this value."
			GUICtrlSetLimit(-1, 4)
			GUICtrlSetTip(-1, $txtTip)
		$lblDash = GUICtrlCreateLabel(" - ", $x + 148, $y, -1, -1)
		$txtMaxTrophy = GUICtrlCreateInput("3000", $x + 160, $y - 5, 35, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "MAX: The Bot will drop trophies if your trophy count is greater than this value."
			GUICtrlSetLimit(-1, 4)
			GUICtrlSetTip(-1, $txtTip)
		$chkTrophyHeroes = GUICtrlCreateCheckbox("Use Heroes", $x + 20, $y + 20, -1, -1)
			$txtTip = "Use Heroes to drop Trophies if Heroes are available."
			GUICtrlSetTip(-1, $txtTip)
		$chkTrophyAtkDead = GUICtrlCreateCheckbox("Atk Dead Bases", $x + 100, $y + 20, -1, -1)
			$txtTip = "Attack a Deadbase found on the first search while dropping Trophies."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 260, $y = 275
	$grpLocateBuildings = GUICtrlCreateGroup("Locate Manually", $x - 20, $y - 20, 220, 65)
		$btnLocateTownHall = GUICtrlCreateButton("Townhall", $x - 10, $y, 40, 40, $BS_ICON)
			GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 46, 1)
			$txtTip = "Relocate your Townhall."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetOnEvent(-1, "btnLocateTownHall")
		$btnLocateClanCastle = GUICtrlCreateButton("Clan Castle", $x + 30, $y, 40, 40, $BS_ICON)
			GUICtrlSetOnEvent(-1, "btnLocateClanCastle")
			GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 9, 1)
			$txtTip = "Relocate your Clan Castle."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_HIDE)
		;$y += 27
		$btnLocateArmyCamp = GUICtrlCreateButton("A.C.", $x + 70, $y, 40, 40, $BS_ICON)
			GUICtrlSetOnEvent(-1, "btnLocateArmyCamp")
			GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 60, 1)
			$txtTip = "Relocate your Army Camp."
			GUICtrlSetTip(-1, $txtTip)
		$btnLocateBarracks = GUICtrlCreateButton("Bar.", $x + 110, $y, 40, 40, $BS_ICON)
			GUICtrlSetOnEvent(-1, "btnLocateBarracks")
			GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 61, 1)
			$txtTip = "Relocate your Barrack."
			GUICtrlSetTip(-1, $txtTip)
		;$y += 27
	    $btnLocateSpellFactory = GUICtrlCreateButton("S.F.", $x + 150, $y, 40, 40, $BS_ICON)
			GUICtrlSetOnEvent(-1, "btnLocateSpellfactory")
			GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 62, 1)
			$txtTip = "Relocate your Spell Factory."
			GUICtrlSetTip(-1, $txtTip)
			_ArrayConcatenate($G, $T)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Upgrades Tab
;~\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
$tabUpgrade = GUICtrlCreateTabItem("Upgrades")
Local $x = 30, $y = 125
	$grpWalls = GUICtrlCreateGroup("Walls", $x - 20, $y - 15, 450, 110)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 50, $x - 10, $y - 4, 24, 24)
		$chkWalls = GUICtrlCreateCheckbox("Auto Wall Upgrade", $x + 20, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to upgrade Walls if there are enough resources.")
			GUICtrlSetState(-1, $GUI_ENABLE)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkWalls")
			_ArrayConcatenate($G, $B)
		$UseGold = GUICtrlCreateRadio("Use Gold", $x + 35, $y + 25, -1, -1)
			GUICtrlSetTip(-1, "Use only Gold for Walls." & @CRLF & "Available at all Wall levels.")
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$UseElixir = GUICtrlCreateRadio("Use Elixir", $x + 35, $y + 45, -1, -1)
			GUICtrlSetTip(-1, "Use only Elixir for Walls." & @CRLF & "Available only at Wall levels upgradeable with Elixir.")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$UseElixirGold = GUICtrlCreateRadio("Try Elixir first, Gold second", $x + 35, $y + 65, -1, -1)
			GUICtrlSetTip(-1, "Try to use Elixir first. If not enough Elixir try to use Gold second for Walls." & @CRLF & "Available only at Wall levels upgradeable with Elixir.")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblWalls = GUICtrlCreateLabel("Search for Walls level:", $x + 220, $y +5, -1, -1)
		$cmbWalls = GUICtrlCreateCombo("", $x + 330, $y, 61, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL), $WS_EX_RIGHT)
			GUICtrlSetTip(-1, "Search for Walls of this level and try to upgrade them one by one.")
			GUICtrlSetData(-1, "4   |5   |6   |7   |8   |9   |10   ", "4   ")
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbWalls")
			_ArrayConcatenate($G, $C)
		$lblTxtWallCost = GUICtrlCreateLabel("Next Wall level costs:", $x + 220,  $y + 25, -1, -1)
			GUICtrlSetTip(-1, "Use this value as an indicator." &@CRLF & "The value will update if you select an other wall level.")
		$lblWallCost = GUICtrlCreateLabel("30 000", $x + 330, $y + 25, 50, -1, $SS_RIGHT)
			GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x + 220, $y + 47, 16, 16)
		$WallMinGold = GUICtrlCreateLabel("Min. Gold to save:", $x + 240, $y + 50, -1, -1)
		$txtWallMinGold = GUICtrlCreateInput("250000", $x + 330, $y + 45, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Gold in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x + 220, $y + 69, 16, 16)
		$WallMinElixir = GUICtrlCreateLabel("Min. Elixir to save:", $x + 240, $y + 72, -1, -1)
		$txtWallMinElixir = GUICtrlCreateInput("250000", $x + 330, $y + 67, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Elixir in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 115
	$grpUpgrades = GUICtrlCreateGroup("Upgrades Queue", $x - 20, $y - 20, 220, 110)
	$chkUpgrade1 = GUICtrlCreateCheckbox("Upgrade 1", $x-10, $y - 3, -1, 20)
	$txtUpgradeX1 = GUICtrlCreateInput("", $x+62, $y-3, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$txtUpgradeY1 = GUICtrlCreateInput("", $x+90, $y-3, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$btnLocateUp1 = GUICtrlCreateButton("Locate Upg 1", $x + 118, $y-3, -1, 20)
	GUICtrlSetOnEvent(-1, "btnLocateUp1")
	$y +=5
	$chkUpgrade2 = GUICtrlCreateCheckbox("Upgrade 2", $x-10, $y + 15, -1, 20)
	$txtUpgradeX2 = GUICtrlCreateInput("", $x+62, $y+15, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$txtUpgradeY2 = GUICtrlCreateInput("", $x+90, $y+15, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$btnLocateUp2 = GUICtrlCreateButton("Locate Upg 2", $x + 118, $y+15, -1, 20)
	GUICtrlSetOnEvent(-1, "btnLocateUp2")
	$y +=5
	$chkUpgrade3 = GUICtrlCreateCheckbox("Upgrade 3", $x-10, $y + 33, -1, 20)
	$txtUpgradeX3 = GUICtrlCreateInput("", $x+62, $y+33, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$txtUpgradeY3 = GUICtrlCreateInput("", $x+90, $y+33, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$btnLocateUp3 = GUICtrlCreateButton("Locate Upg 3", $x + 118, $y+33, -1, 20)
	GUICtrlSetOnEvent(-1, "btnLocateUp3")
	$y +=5
	$chkUpgrade4 = GUICtrlCreateCheckbox("Upgrade 4", $x-10, $y+51, -1, 20)
	$txtUpgradeX4 = GUICtrlCreateInput("", $x+62, $y+51, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$txtUpgradeY4 = GUICtrlCreateInput("", $x+90, $y+51, 25, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
	$btnLocateUp4 = GUICtrlCreateButton("Locate Upg 4", $x + 118, $y+51, -1, 20)
	GUICtrlSetOnEvent(-1, "btnLocateUp4")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y -= 15
	$x += 230
	$grpLocateBuildings = GUICtrlCreateGroup("Resources for Upgrade Buildings", $x - 20, $y - 20, 220, 110)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x - 10, $y - 1, 16, 16)
		$BuildMinGold = GUICtrlCreateLabel("Min. Gold to save:", $x + 10, $y + 2, -1, -1)
		$txtBuildMinGold = GUICtrlCreateInput("200000", $x + 100, $y - 3, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Gold in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			;GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=2
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x - 10, $y + 18, 16, 16)
		$BuildMinElixir = GUICtrlCreateLabel("Min. Elixir to save:", $x + 10, $y + 22, -1, -1)
		$txtBuildMinElixir = GUICtrlCreateInput("200000", $x + 100, $y + 17, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Elixir in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			;GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=2
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x - 10, $y + 39, 16, 16)
		$BuildMinDark = GUICtrlCreateLabel("Min. D. E. to save:", $x + 10, $y + 42, -1, -1)
		$txtBuildMinDark = GUICtrlCreateInput("1000", $x + 100, $y + 37, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Dark Elixir in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			;GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=2
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 8, $x - 10, $y + 60, 16, 16)
		$BuilderKeepFree = GUICtrlCreateLabel("Builders Free:", $x + 10, $y + 62, -1, -1)
		$txtBuilderKeepFree = GUICtrlCreateInput("0", $x + 100, $y + 57, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Keep free builders to build walls or otherwise.")
			GUICtrlSetLimit(-1, 1)

		$x -= 230
		$y += 105
		$Laboratory = GUICtrlCreateGroup("Laboratory", $x - 20, $y - 20, 500, 70)
		$chkLab = GUICtrlCreateCheckbox("Enable", $x - 15, $y - 5, 80, 17)
		$cmbLaboratory = GUICtrlCreateCombo("", $x, $y+15, 95, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblin|Ballon|W.Breaker|Wizard|Healer|Dragon|Pekka|Lightning|Healing|Rage|Jump Spell|Freeze|Minion|HogRider|Valkrye|Golem|Witch|Lava|Nothing", "Archers")
		;GUICtrlSetState(-1, $GUI_ENABLE)

		$btnLab = GUICtrlCreateButton("Locate Laboratory", $x+220, $y-10, 50, 45, $BS_BITMAP)
		GUICtrlSetImage($btnLab, @ScriptDir & "\Icons\Laboratory8.bmp", 0)
		$txtTip = "Relocate your Laboratory."
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnLab")
		$lblLabPos = GUICtrlCreateLabel("LabPos:", $x+280, $y-5, 40, 18)
		$txtLabX = GUICtrlCreateInput("", $x+280, $y+8, 31, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))
		$txtLabY = GUICtrlCreateInput("", $x+320, $y+8, 31, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER, $ES_READONLY))

		$y += 70
		$grpTroopselection = GUICtrlCreateGroup("Upgrade Troops Selection Menu", $x - 20, $y - 20, 450, 110)
		$x -=2
	$lblBtnlabBarbarians = GUICtrlCreateLabel("", $x - 12, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabBarbarians = GUICtrlCreateButton("Barbarians", $x - 10, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 6, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsBarbarians")
	$lblBtnlabArchers = GUICtrlCreateLabel("", $x + 28, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabArchers = GUICtrlCreateButton("Archers", $x + 30, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 2, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsArchers")
	$lblBtnlabGiants = GUICtrlCreateLabel("", $x + 68, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabGiants = GUICtrlCreateButton("Giants", $x + 70, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 20, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsGiants")
	$lblBtnlabGoblins = GUICtrlCreateLabel("", $x + 108, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabGoblins = GUICtrlCreateButton("Goblins", $x + 110, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 23, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsGoblins")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnlabWallBreakers = GUICtrlCreateLabel("", $x + 148, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabWallBreakers = GUICtrlCreateButton("WallBreakers", $x + 150, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 52, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsWallBreakers")
		;GUICtrlSetState (-1, $GUI_DISABLE)

	$lblBtnlabMinions = GUICtrlCreateLabel("", $x + 223, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabMinions = GUICtrlCreateButton("Minions", $x + 225, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 38, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsMinions")
	$lblBtnlabHogRiders = GUICtrlCreateLabel("", $x + 263, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabHogRiders = GUICtrlCreateButton("HogRiders", $x + 265, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 30, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsHogRiders")
	$lblBtnlabValkyries = GUICtrlCreateLabel("", $x + 303, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabValkyries = GUICtrlCreateButton("Valkyries", $x+ 305, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 49, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsValkyries")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnlabGolems = GUICtrlCreateLabel("", $x + 343, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabGolems = GUICtrlCreateButton("Golems", $x + 345, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 26, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsGolems")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnlabWitches = GUICtrlCreateLabel("", $x + 383, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabWitches = GUICtrlCreateButton("Witches", $x+ 385, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 54, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsWitches")
		;GUICtrlSetState (-1, $GUI_DISABLE)

	$y += 40
	$lblBtnlabBalloons = GUICtrlCreateLabel("", $x - 12, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabBalloons = GUICtrlCreateButton("Balloons", $x - 10, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 4, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsBalloons")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnlabWizards = GUICtrlCreateLabel("", $x + 28, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabWizards = GUICtrlCreateButton("Wizards", $x + 30, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 56, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsWizards")
	$lblBtnlabHealers = GUICtrlCreateLabel("", $x + 68, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabHealers = GUICtrlCreateButton("Healers", $x + 70, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 28, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsHealers")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnlabDragons = GUICtrlCreateLabel("", $x + 108, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabDragons = GUICtrlCreateButton("Dragons", $x + 110, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 13, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsDragons")
		;GUICtrlSetState (-1, $GUI_DISABLE)
	$lblBtnlabPekkas = GUICtrlCreateLabel("", $x + 148, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabPekkas = GUICtrlCreateButton("Pekkas", $x + 150, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 40, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsPekkas")
		;GUICtrlSetState (-1, $GUI_DISABLE)

	$lblBtnlabLavaHounds = GUICtrlCreateLabel("", $x + 223, $y - 2, 42, 42)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnLabLavaHounds = GUICtrlCreateButton("LavaHounds", $x + 225, $y, 38, 38, $BS_ICON)
		GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 35, 1)
		GUICtrlSetOnEvent(-1, "btnTroopsLavaHounds")
		;GUICtrlSetState (-1, $GUI_DISABLE)

		$x += 2
		$y += 70
        $grpLocateBuildings = GUICtrlCreateGroup("Locate Heroes", $x - 20, $y - 20, 220, 65)
        $btnLocateKing = GUICtrlCreateButton("King", $x - 10, $y, 40, 40, $BS_ICON)
            GUICtrlSetOnEvent(-1, "btnLocateKing")
            GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 7, 1)
            $txtTip = "Locate Your King."
            GUICtrlSetTip(-1, $txtTip)
        $btnLocateQueen = GUICtrlCreateButton("Queen", $x + 30, $y, 40, 40, $BS_ICON)
            GUICtrlSetOnEvent(-1, "btnLocateQueen")
            GUICtrlSetImage (-1, $LibDir & "\CGBBOT.dll", 41, 1)
            $txtTip = "Locate Your Queen."
            GUICtrlSetTip(-1, $txtTip)
        $chkUpgradeKing = GUICtrlCreateCheckbox("Upgrade King", $x + 90, $y , 80, 17)
            GUICtrlSetTip(-1, "Heroes will upgrade if you have at least 2 free builders.")
        $chkUpgradeQueen = GUICtrlCreateCheckbox("Upgrade Queen", $x + 90, $y + 21, 95, 17)
            GUICtrlSetTip(-1, "Heroes will upgrade if you have at least 2 free builders.")
    GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ -------------------------------------------------------------
;~ PushBullet Tab
;~ -------------------------------------------------------------
$tabNotify = GUICtrlCreateTabItem("Notify")
	Local $x = 30, $y = 130
	  $grpPushBullet = GUICtrlCreateGroup("PushBullet Alert ", $x - 20, $y - 20, 450, 375)
	  $chkPBenabled = GUICtrlCreateCheckbox("Enable", $x, $y - 5 , -1, -1)
		 GUICtrlSetOnEvent(-1, "chkPBenabled")
		 ;GUICtrlSetState(-1, $GUI_CHECKED)
		 GUICtrlSetTip(-1, "Enable pushbullet notification")
	  $chkPBRemote = GUICtrlCreateCheckbox("Remote Control", $x , $y + 20 , -1, -1)
		 GUICtrlSetTip(-1, "Enables pushbullet remote function")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkDeleteAllPushes = GUICtrlCreateCheckbox("Delete Msg on Start", $x + 140, $y - 5 , -1, -1)
		 GUICtrlSetTip(-1, "It will delete all previous push notification when you start bot")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $btnDeletePBmessages = GUICtrlCreateButton("Delete all msg now", $x +269, $y -8 , 102,25)
		 GUICtrlSetTip(-1, "Click here to delete all Pushbullet messages.")
		 GUICtrlSetOnEvent(-1, "btnDeletePBMessages")
		 IF $btnColor then GUICtrlSetBkColor(-1, 0x5CAD85)
		 GUICtrlSetState(-1, $GUI_DISABLE)


	  $chkDeleteOldPushes = GUICtrlCreateCheckbox("Delete Msg older than", $x + 140, $y + 20 , -1, -1)
		 GUICtrlSetTip(-1, "It will delete all previous push notification older than specified hour")
		 GUICtrlSetState(-1, $GUI_DISABLE)
		 GUICtrlSetOnEvent(-1, "chkDeleteOldPushes")
  	  $cmbHoursPushBullet = GUICtrlCreateCombo("", $x + 270, $y + 20, 100, 35, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		 GUICtrlSetTip(-1, "Set the interval for messages to be deleted.")
		 GUICtrlSetData(-1, "1 Hour|2 Hours|3 Hours|4 Hours|5 Hours|6 Hours|7 Hours|8 Hours|9 Hours|10 Hours|11 Hours|12 Hours|13 Hours|14 Hours|15 Hours|16 Hours|17 Hours|18 Hours|19 Hours|20 Hours|21 Hours|22 Hours|23 Hours|24 Hours", "-")
		 GUICtrlSetState (-1, $GUI_DISABLE)
	  $lblPushBTokenValue = GUICtrlCreateLabel("Access Token:", $x, $y + 45, 80, 17, $SS_RIGHT)
      $PushBTokenValue = GUICtrlCreateInput("", $x + 90, $y + 45, 280, 19)
		 GUICtrlSetTip(-1, "Token from PushBullet.com")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $lblOrigPush = GUICtrlCreateLabel("Village Name:", $x, $y + 70, 80, 17, $SS_RIGHT)
	  $OrigPushB = GUICtrlCreateInput("", $x + 90, $y + 70, 280, 19)
	  	 GUICtrlSetTip(-1, "Your village's name")
	    GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBVMFound = GUICtrlCreateCheckbox("Match Found", $x + 25, $y + 95, -1, -1)
		 GUICtrlSetTip(-1, "It will send you the amount of available loot when bot found dead base")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBLastRaid = GUICtrlCreateCheckbox("Last raid as image", $x + 125, $y + 95, -1, -1)
		 GUICtrlSetTip(-1, "Last raid screenshot will be sent")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBWallUpgrade = GUICtrlCreateCheckbox("Wall upgrade", $x + 25, $y + 120, -1, -1)
		 GUICtrlSetTip(-1, "It will altert you about wall upgrade whether fail or successful")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBLastRaidTxt = GUICtrlCreateCheckbox("Last raid as Text", $x + 250, $y + 95, -1, -1)
		 GUICtrlSetState(-1, $GUI_DISABLE)
		 GUICtrlSetTip(-1, "Last raid result will be sent as text")
	  $chkAlertPBOOS = GUICtrlCreateCheckbox("Error: Out Of Sync", $x + 125, $y + 120, -1, -1)
		 GUICtrlSetTip(-1, "It will alert you when Error: Server out of sync")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBVBreak = GUICtrlCreateCheckbox("Take a break", $x + 250, $y + 120, -1, -1)
		 GUICtrlSetTip(-1, "It will notify you when you have been playing for too long and your villagers need to rest")
		 GUICtrlSetState(-1, $GUI_DISABLE)

	  $chkAlertPBVillage = GUICtrlCreateCheckbox("Alert My Village", $x + 25, $y + 145, -1, -1)
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBOtherDevice = GUICtrlCreateCheckbox("Another device has connected", $x + 250, $y + 145, -1, -1)
		 GUICtrlSetTip(-1, "It will notify you when your village is connected from another device")
		 GUICtrlSetState(-1, $GUI_DISABLE)
	  $chkAlertPBLab = GUICtrlCreateCheckbox("Laboratory Upgrades", $x + 125, $y + 145, -1, -1)
		 GUICtrlSetTip(-1, "It will alert you when the unit you selected starts upgrading, or you do not have enough resources to upgrade")
		 GUICtrlSetState(-1, $GUI_DISABLE)

	  $lblgrppushbullet = GUICtrlCreateGroup("PushBullet Remote Control", $x-10, $y + 170, 430, 180)
	  $lblPBdesc = GUICtrlCreateLabel("You can remotely control your bot sending commands following this syntax:" & @CRLF & "BOT HELP - send this help message" & @CRLF & "BOT DELETE  - delete all your previous Push message" & @CRLF & "BOT <Village Name> PAUSE - pause the bot named <Village Name>" & @CRLF & "BOT <Village Name> RESUME   - resume the bot named <Village Name>" & @CRLF & "BOT <Village Name> STATS - send Village Statistics of <Village Name>" & @CRLF & "BOT <Village Name> LOG - send the current log file of <Village Name>" & @CRLF & "BOT <Village Name> LASTRAID -  send the last raid loot screenshot of <Village Name>" & @CRLF & "BOT <Village Name> LASTRAIDTXT - send the last raid loot values of <Village Name>" & @CRLF & "BOT <Village Name> SCREENSHOT - send a screenshot of <Village Name>"  & @CRLF &  @CRLF &   "Examples:   Bot MyVillage Pause    -    Bot Delete    -    Bot MyVillage Screenshot", $x, $y + 190, -1, -1, $SS_LEFT)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $LastControlToHide = GUICtrlCreateDummy()
Global $iPrevState[$LastControlToHide + 1]
;~ -------------------------------------------------------------

;~ -------------------------------------------------------------
;~ Stats Tab
;~ -------------------------------------------------------------
$tabStatsCredits = GUICtrlCreateTabItem("Stats")
Local $x = 30, $y = 130
	$grpResourceOnStart = GUICtrlCreateGroup("Stats: Started with", $x - 20, $y - 20, 108, 105)
		$lblResultStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will appear" & @CRLF & "here on" & @CRLF & "first run.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x + 65, $y, 16, 16)
		$lblResultGoldStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x + 65, $y, 16, 16)
		$lblResultElixirStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picResultDEStart = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x + 65, $y, 16, 16)
		$lblResultDEStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x + 65, $y, 16, 16)
		$lblResultTrophyStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 113
	$y = 130
	$grpLastAttack = GUICtrlCreateGroup("Stats: Last Attack", $x - 20, $y - 20, 108, 105)
		$lblLastAttackTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x + 65, $y, 16, 16)
		$lblGoldLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x + 65, $y, 16, 16)
		$lblElixirLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picDarkLastAttack = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x + 65, $y, 16, 16)
		$lblDarkLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x + 65, $y, 16, 16)
		$lblTrophyLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost on the last attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 113
	$y = 130
    $grpTotalLoot = GUICtrlCreateGroup("Stats: Total Loot", $x - 20, $y - 20, 108, 105)
		$lblTotalLootTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x + 65, $y, 16, 16)
		$lblGoldLoot =  GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The total amount of Gold you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x + 65, $y, 16, 16)
		$lblElixirLoot =  GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The total amount of Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picDarkLoot = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x + 65, $y, 16, 16)
        $lblDarkLoot =  GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The total amount of Dark Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x + 65, $y, 16, 16)
		$lblTrophyLoot = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost while the Bot is running."
			GUICtrlSetTip(-1, $txtTip)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 113
	$y = 130
	$grpHourlyStats = GUICtrlCreateGroup("Stats: Hourly", $x - 20, $y - 20, 108, 105)
	$lblHourlyStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 24, $x + 65, $y, 16, 16)
		$lblHourlyStatsGold = GUICtrlCreateLabel("", $x - 10, $y + 2, 65, 17, $SS_RIGHT)
			$txtTip = "Net Gold gain per hour"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 15, $x + 65, $y, 16, 16)
		$lblHourlyStatsElixir = GUICtrlCreateLabel("", $x - 10, $y + 2, 65, 17, $SS_RIGHT)
			$txtTip = "Net Elixir gain per hour"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picHourlyStatsDark = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x + 65, $y, 16, 16)
		$lblHourlyStatsDark = GUICtrlCreateLabel("", $x - 10, $y + 2, 65, 17, $SS_RIGHT)
			$txtTip = "Net Dark Elixir gain per hour"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x + 65, $y, 16, 16)
		$lblHourlyStatsTrophy = GUICtrlCreateLabel("", $x - 10, $y + 2, 65, 17, $SS_RIGHT)
			$txtTip = "Net Trophy gain per hour"
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 265
	$y = 300
	$btnResetStats = GUICtrlCreateButton ("Reset Stats", $x-5, $y, 65,21)
		GUICtrlSetOnEvent(-1, "btnResetStats")
		GUICtrlSetTip(-1, "Reset statistics without closing the bot")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$x +=65
	$btnMoreStats = GUICtrlCreateButton ("More Stats", $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$x +=65
	$btnExportCSV = GUICtrlCreateButton ("Export CSV", $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
#cs    $y +=25
    $btnLoots = GUICtrlCreateButton ("Loots", $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLoots")
    $y +=25
    $btnLogs = GUICtrlCreateButton ("Logs", $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLogs")
#ce

	$x = 30
	$y = 235
	$grpStatsMisc = GUICtrlCreateGroup("Stats: Misc", $x - 20, $y - 20, 450, 85)
		$y -=2
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 45, $x - 10, $y + 7, 24, 24)
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 46, $x + 16, $y + 7, 24, 24)
        $lblvillagesattacked = GUICtrlCreateLabel("Attacked:", $x + 45, $y + 2, -1, 17)
        $lblresultvillagesattacked = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were attacked by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
        $lblvillagesskipped = GUICtrlCreateLabel("Skipped:", $x + 45, $y + 2, -1, 17)
        $lblresultvillagesskipped = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were skipped during search by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
        GUICtrlCreateLabel("Zap&&Run Villages:", $x - 10, $y + 2, -1, 17)
        $lblZapAndRunHitCount = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were zapped for DE and ran by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
        GUICtrlCreateLabel("Zap&&Run Nbr. LSpell:", $x - 10, $y + 2, -1, 17)
        $lblZapAndRunUsedLSpell = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Lightning Spells used for Zap&Run villages by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$x += 155
		$y -= 51
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 47, $x, $y, 16, 16)
        $lbltrophiesdropped = GUICtrlCreateLabel("Dropped:", $x + 20, $y + 2, -1, 17)
        $lblresulttrophiesdropped = GUICtrlCreateLabel("0", $x + 100, $y + 2, 30, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies dropped by the Bot due to Trophy Settings (on Misc Tab)."
			GUICtrlSetTip(-1, $txtTip)
        $y += 17
        GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 44, $x, $y, 16, 16)
        $lblruntime = GUICtrlCreateLabel("Runtime:", $x + 20, $y + 2, -1, 17)
        $lblresultruntime = GUICtrlCreateLabel("00:00:00", $x + 70, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The total Running Time of the Bot."
			GUICtrlSetTip(-1, $txtTip)
        $y += 17
        GUICtrlCreateLabel("Zap&&Run DE gain:", $x, $y + 2, -1, 17)
        $lblZapAndRunTotalDE = GUICtrlCreateLabel("0", $x + 60, $y + 2, 70, 17, $SS_RIGHT)
			$txtTip = "The total amount of DE gained from only Zap&Run attacks."
			GUICtrlSetTip(-1, $txtTip)
		$x += 145
		$y -= 34
		GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 50, $x - 7, $y + 7, 24, 24)
        $lblwallbygold = GUICtrlCreateLabel("Upg. by Gold:", $x + 20, $y + 2, -1, 17)
		$lblWallgoldmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Walls upgraded by Gold."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
		$lblwallbyelixir = GUICtrlCreateLabel("Upg. by Elixir:", $x + 20, $y + 2, -1, 17)
		$lblWallelixirmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Walls upgraded by Elixir."
			GUICtrlSetTip(-1, $txtTip)
	   $y += 17
	   $lbloutofsync = GUICtrlCreateLabel("Out Of Sync :", $x + 20, $y + 2, -1, 17)
	   $lblresultoutofsync = GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "Restarted after Out of Sync Error:"
			GUICtrlSetTip(-1, $txtTip)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 30
	$y = 340
	$grpCredits = GUICtrlCreateGroup("Credits", $x - 20, $y - 20, 450, 170)
		$labelGameBotURL = GUICtrlCreateLabel("https://GameBot.org", $x - 5, $y + 5, 430, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
		$labelClashGameBotURL = GUICtrlCreateLabel("https://ClashGameBot.com", $x + 150, $y + 5, 430, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
		$lblCredits = GUICtrlCreateLabel("Credits go to the following coders:", $x - 5, $y + 25, 400, 20)
			GUICtrlSetFont(-1, 8.5, $FW_BOLD)
		$txtCredits =	"Antidote, AtoZ, Didipe, Dinobot, DixonHill, DkEd, Envyus, GkevinOD, Hervidero,"  & @CRLF & _
                        "HungLe, knowjack, ProMac, Safar46, Sardo, Saviart and others"  & @CRLF & _
						"" & @CRLF & _
						"And to all forum members contributing to this software!" & @CRLF & _
						"" & @CRLF & _
						"The latest release of the 'Clash Game Bot' can be found at:"
		$lbltxtCredits = GUICtrlCreateEdit($txtCredits, $x - 5, $y + 40, 400, 85, BITOR($WS_VISIBLE, $ES_AUTOVSCROLL, $ES_READONLY, $SS_LEFT),0)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
		$labelForumURL = GUICtrlCreateLabel("https://GameBot.org/latest", $x - 5, $y + 125, 450, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 30
	$y = 510
	$grpModCredits = GUICtrlCreateGroup("Mod Credits", $x - 20, $y - 20, 450, 85)
		$lblModCredits = GUICtrlCreateLabel("Credits go to the following modders:", $x - 5, $y - 5, 400, 20)
			GUICtrlSetFont(-1, 8.5, $FW_BOLD)
		$txtModCredits =	"ChiefM3, Sm0kE, lekter, kgns, barracoda, janikz211, bunana123, Jame, papaismurf, indy, sabrewulf86, Jgrt123, summoner, Boju, Shark, Cocmady, coldfire2k, cmestres, rcorts"
		$lbltxtModCredits = GUICtrlCreateEdit($txtModCredits, $x - 5, $y + 10, 434, 39, BITOR($WS_VISIBLE, $ES_AUTOVSCROLL, $ES_READONLY, $SS_LEFT),0)
			GUICtrlSetBkColor(-1, $COLOR_WHITE)
		$labelModForumURL = GUICtrlCreateLabel("https://GameBot.org/forums/thread-2682.html", $x - 5, $y + 50, 450, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Bottom status bar
;~ -------------------------------------------------------------
GUISetState(@SW_SHOW)

$statLog = _GUICtrlStatusBar_Create($frmBot)
	_ArrayConcatenate($G, $Y)
	_GUICtrlStatusBar_SetSimple($statLog)
	_GUICtrlStatusBar_SetText($statLog, "Status : Idle")
$tiAbout = TrayCreateItem("About")
	TrayCreateItem("")
$tiExit = TrayCreateItem("Exit")

;~ -------------------------------------------------------------

CheckPrerequisites()
