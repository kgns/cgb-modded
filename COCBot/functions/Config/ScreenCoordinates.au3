;                                 x    y     color  tolerance
Global $aIsMain[4]           = [284,  28, 0x41B1CD, 20] ; Main Screen, Builder Left Eye
Global $aIsMainGrayed[4]     = [284,  28, 0x215B69, 20] ; Main Screen Grayed, Builder Left Eye
Global $aTopLeftClient[4]    = [  1,   1, 0x000000,  0] ; TopLeftClient: Tolerance not needed
Global $aTopRightClient[4]   = [850,   1, 0x000000,  0] ; TopRightClient: Tolerance not needed
Global $aIsInactive[4]       = [457, 300, 0x33B5E5, 10] ; COC message : 'Anyone there?'
Global $aReloadButton[2]     = [416, 399]               ; Reload Coc Button after Out of Sync
Global $aAttackButton[2]     = [ 60, 614]               ; Attack Button, Main Screen
Global $aFindMatchButton[2]  = [217, 510]               ; Find Multiplayer Match Button, Attack Screen
;Global $aBreakShield[4]     = [513, 416, 0x5DAC10, 50] ; Break Shield Button, Attack Screen ;the 0x5DAC10 color value matches open grass use with caution
Global $aSurrenderButton[2]  = [ 62, 519]               ; Surrender Button, Attack Screen
Global $aConfirmSurrender[2] = [512, 394]               ; Confirm Surrender Button, Attack Screen
Global $aCancelFight[4]      = [822,  48, 0xD80408, 20] ; Cancel Fight Scene
Global $aCancelFight2[4]     = [830,  59, 0xD80408, 20] ; Cancel Fight Scene 2nd pixel
Global $aEndFightScene[4]    = [429, 519, 0xB8E35F, 20] ; Victory or defeat scene
Global $aReturnHomeButton[2] = [428, 544]               ; Return Home Button, End Battle Screen
Global $aChatTab[4]          = [331, 330, 0xF0A03B, 20] ; Chat Window Open, Main Screen
Global $aOpenChat[2]         = [ 19, 349]               ; Open Chat Windows, Main Screen
Global $aClanTab[2]          = [189,  24]               ; Clan Tab, Chat Window, Main Screen
Global $aArmyCampSize[2]     = [586, 193]               ; Army Camp Info Window, Current Size/Total Size
Global $aBuildersDigits[2]   = [324,  21]               ; Main Screen, Free/Total Builders
Global $aLanguageCheck1[4]   = [326,   8, 0xF9FAF9, 20] ; Main Screen Test Language for word 'Builders'
Global $aLanguageCheck2[4]   = [329,   9, 0x060706, 20] ; Main Screen Test Language for word 'Builders'
Global $aLanguageCheck3[4]   = [348,  12, 0x040403, 20] ; Main Screen Test Language for word 'Builders'
Global $aLanguageCheck4[4]   = [354,  11, 0x090908, 20] ; Main Screen Test Language for word 'Builders'
Global $aTrophies[2]         = [ 65,  74]               ; Main Screen, Trophies
Global $aNoCloudsAttack[4]   = [774,    1,0x000000, 20] ; Attack Screen: No More Clouds
Global $aMessageButton[2]    = [ 38, 143]               ; Main Screen, Message Button
Global $aArmyTrainButton[2]  = [ 40, 525]               ; Main Screen, Army Train Button
Global $aWonOneStar[4] 		 = [714, 538, 0xC0C8C0, 20] ; Center of 1st Star for winning attack on enemy
Global $aWonTwoStar[4] 		 = [739, 538, 0xC0C8C0, 20] ; Center of 2nd Star for winning attack on enemy
Global $aWonThreeStar[4] 	 = [763, 538, 0xC0C8C0, 20] ; Center of 3rd Star for winning attack on enemy
Global $aArmyOverviewTest[4] = [150, 554, 0xBC2BD1, 20] ; Color purple of army overview  bottom left
Global $aCancRequestCCBtn[4] = [340, 245,0xCC4010, 20]  ; Red button Cancel in window request CC
Global $aSendRequestCCBtn[4] = [524, 245]               ; Green button Send in window request CC
Global $atxtRequestCCBtn[4]  = [430, 140]               ; textbox in window request CC


;attack report... stars won
Global $aWonOneStarAtkRprt[4] 		  = [325, 180, 0xC8CaC4, 30] ; Center of 1st Star reached attacked village
Global $aWonTwoStarAtkRprt[4] 		  = [398, 180, 0xD0D6D0, 30] ; Center of 2nd Star reached attacked village
Global $aWonThreeStarAtkRprt[4] 	  = [534, 180, 0xC8CAC7, 30] ; Center of 3rd Star reached attacked village


Global $SomeXCancelBtn[4] = [819,  55, 0xD80400,     20]
Global $EndBattleBtn[4]   = [71, 530,  0xC00000,     20]
Global $Attacked[4]       = [235, 209, 0x9E3826,     20] ;
Global $AttackedBtn[2]    = [429, 493]					 ;
Global $HasClanMessage[4] = [ 31, 313, 0xF80B09,     20] ;
Global $OpenChatBtn[2]    = [ 10, 334] 					 ;
Global $IsClanTabSelected[4]=[204, 20, 0x6F6C4F,     20] ;
Global $IsClanMessage[4]  = [ 26, 320, 0xE70400,     20] ;

Global $ClanRequestTextArea[2]=[430, 140]
Global $ConfirmClanTroopsRequest[2]=[524,228]
Global $CampFull[4]  	  = [328, 535, 0xD03840,     20] ;

Global $DropTrophiesStartPoint=[34, 310]

Global $TrainBarb[4]  = [ 220, 310, 0xFFC721,     40] ;  Done
Global $TrainArch[4]  = [ 301, 310, 0x902C55,     40] ;  Done
Global $TrainGiant[4] = [ 442, 310, 0xFFCB8A,     40] ;  Done
Global $TrainGobl[4]  = [ 546, 310, 0xA8F468,     40] ;  Done
Global $TrainWall[4]  = [ 646, 310, 0x78D4F0,     40] ;  Done

Global $TrainBall[4]  = [ 220, 459, 0x383831,     20] ;  Done
Global $TrainWiza[4]  = [ 301, 459, 0x2F3030,     20] ;  Done ;
Global $TrainHeal[4]  = [ 442, 459, 0xD77E57,     20] ;  Done
Global $TrainDrag[4]  = [ 546, 459, 0xBA1618,     20] ;  Done
Global $TrainPekk[4]  = [ 646, 459, 0x406281,     20] ;  Done

Global $TrainMini[4]  = [ 220, 310, 0x182340,     20] ;  Done
Global $TrainHogs[4]  = [ 301, 310, 0x72D0E8,     20] ;  Done
Global $TrainValk[4]  = [ 442, 310, 0xA64002,     20] ;  Done
Global $TrainGole[4]  = [ 546, 310, 0xDEC3A8,     20] ;  Done
Global $TrainWitc[4]  = [ 646, 324, 0x685EA5,     20] ;  Done

Global $TrainLava[4]  = [ 220, 459, 0x4F4F40,     20] ;  Done

Global $NextBtn[2]        = [ 750, 500]
; Someone asking troops : Color 0xD0E978 in x = 121

Global $aRequestTroopsAO[6]	 = [705, 290, 0xD2EC80, 0x407D06, 0xD8D8D8, 20] ; Button Request Troops in Army Overview  (x,y,can request, request allready made, army full/no clan, toll)

Global Const $FullBarb[4]  = [ 253, 375, 0x8F8F8F, 45]  ; Location of Elixir check pixel with normal color and Barrack Full color
Global Const $FullArch[4]  = [ 360, 375, 0x8D8D8D, 45]
Global Const $FullGiant[4] = [ 468, 375, 0x8D8D8D, 45]
Global Const $FullGobl[4]  = [ 574, 375, 0x8F8F8F, 45]
Global Const $FullWall[4]  = [ 680, 375, 0x8F8F8F, 45]

Global Const $FullBall[4]  = [ 253, 482, 0xB5B5B5, 45]
Global Const $FullWiza[4]  = [ 360, 482, 0xB5B5B5, 45]
Global Const $FullHeal[4]  = [ 468, 482, 0xB5B5B5, 45]
Global Const $FullDrag[4]  = [ 574, 482, 0xB5B5B5, 45]
Global Const $FullPekk[4]  = [ 680, 482, 0xB5B5B5, 45]

Global Const $FullMini[4]  = [ 253, 375, 0x8D8D8D, 45] ; Need New pixel location, difference between normal and full is too close with Dark Elxir icon
Global Const $FullHogs[4]  = [ 360, 375, 0x8D8D8D, 45] ; Need New pixel location, difference between normal and full is too close with Dark Elxir icon
Global Const $FullValk[4]  = [ 468, 375, 0x8D8D8D, 45] ; Need New pixel location, difference between normal and full is too close with Dark Elxir icon
Global Const $FullGole[4]  = [ 574, 375, 0x8D8D8D, 45] ; Need New pixel location, difference between normal and full is too close with Dark Elxir icon
Global Const $FullWitc[4]  = [ 680, 375, 0x8D8D8D, 45] ; Need New pixel location, difference between normal and full is too close with Dark Elxir icon

Global Const $FullLava[4]  = [ 680, 375, 0xDE58D0, 0x8D8D8D ] ; Need New pixel location, difference between normal and full is too close with Dark Elxir icon

Global Const $GemBarb[4]   = [ 239, 372, 0xE70A12, 30] ; Pixel location of middle of right side of zero text for troop training, and color when out of Elixir
Global Const $GemArch[4]   = [ 346, 372, 0xE70A12, 30]
Global Const $GemGiant[4]  = [ 453, 372, 0xE70A12, 30]
Global Const $GemGobl[4]   = [ 559, 372, 0xE70A12, 30]
Global Const $GemWall[4]   = [ 666, 372, 0xE70A12, 30]

Global Const $GemBall[4]   = [ 239, 372, 0xE70A12, 30]
Global Const $GemWiza[4]   = [ 346, 372, 0xE70A12, 30]
Global Const $GemHeal[4]   = [ 453, 372, 0xE70A12, 30]
Global Const $GemDrag[4]   = [ 559, 372, 0xE70A12, 30]
Global Const $GemPekk[4]   = [ 666, 372, 0xE70A12, 30]

Global Const $GemMini[4]   = [ 239, 378, 0xE70A12, 30]
Global Const $GemHogs[4]   = [ 346, 379, 0xE70A12, 30]
Global Const $GemValk[4]   = [ 453, 372, 0xE70A12, 30]
Global Const $GemGole[4]   = [ 559, 378, 0xE70A12, 30]
Global Const $GemWitc[4]   = [ 666, 372, 0xE70A12, 30]

Global Const $GemLava[4]   = [ 239, 372, 0xE70A12, 30]
