#Requires AutoHotkey v2.0

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; COORDINATES CONFIGURATION FILE - 1920x1080 (Fullscreen)
; ----------------------------------------------------------------------------------------
; This file contains pixel coordinates used for various automation tasks. It is NOT
; RECOMMENDED that anyone updates their coordinates but if you must use the AHK
; "Window Spy" option to do it accurately using the "Window" positions.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


global COORDS := Map()

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CONTROLS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Controls"] := Map()
COORDS["Controls"]["HatchSettings"] := [71, 490]
COORDS["Controls"]["FreeGifts"] := [68, 392]
COORDS["Controls"]["Hoverboard"] := [277, 390]
COORDS["Controls"]["AutoFarm"] := [182, 492]
COORDS["Controls"]["Teleport"] := [180, 394]
COORDS["Controls"]["Ultimate"] := [590, 965]
COORDS["Controls"]["Rewards1"] := [1787, 750] ; Standard button position.
COORDS["Controls"]["Rewards2"] := [1787, 664] ; Button position when rank up occurs.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HATCH SETTINGS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["HatchSettings"] := Map()
COORDS["HatchSettings"]["AutoHatchOn"] := [1220, 400]
COORDS["HatchSettings"]["ChargedEggsOn"] := [1220, 546]
COORDS["HatchSettings"]["ChargedEggsOff"] := [1110, 546]
COORDS["HatchSettings"]["GoldenEggsOn"] := [1220, 688]
COORDS["HatchSettings"]["GoldenEggsOff"] := [1110, 688]
COORDS["HatchSettings"]["X"] := [1310, 265]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; BUY EGGS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["BuyEggs"] := Map()
COORDS["BuyEggs"]["BuyMax"] := [1200, 748]
COORDS["BuyEggs"]["X"] := [1324, 265]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; RANK REWARDS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["RankRewards"] := Map()
COORDS["RankRewards"]["X"] := [1500, 265]
COORDS["RankRewards"]["Heading"] := [1148, 300] ; Required to select scrollable area.
COORDS["RankRewards"]["Button1"] := [908, 488]
COORDS["RankRewards"]["Button9"] := [908, 458]
COORDS["RankRewards"]["Button17"] := [908, 443]
COORDS["RankRewards"]["Button25"] := [908, 570]
COORDS["RankRewards"]["Button33"] := [908, 544]
COORDS["RankRewards"]["Button41"] := [908, 518]
COORDS["RankRewards"]["Button49"] := [908, 502]
COORDS["RankRewards"]["ButtonLast"] := [908, 548]
COORDS["RankRewards"]["ClickForMore"] := [971, 790] ; Message that pops up after claiming all rewards.
COORDS["RankRewards"]["Offset"] := [167, 216] ; X and Y offsets for each reward.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CONTROLS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Worlds"] := Map()
COORDS["Worlds"][3] := [384, 588]

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; SUPERCOMPUTER!
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Supercomputer"] := Map()
COORDS["Supercomputer"]["UpgradePotions"] := [528, 620]  
COORDS["Supercomputer"]["UpgradeEnchants"] := [702, 615] 
COORDS["Supercomputer"]["GoldPets"] := [1396, 388]       
COORDS["Supercomputer"]["RainbowPets"] := [1221, 614]    
COORDS["Supercomputer"]["X"] := [1494, 257]
COORDS["Supercomputer"]["Search"] := [1334, 249]
COORDS["Supercomputer"]["Ok"] := [665, 738]
COORDS["Supercomputer"]["SuccessOk"] := [964, 814] ; Ok button on the Success window.
COORDS["Supercomputer"]["Item1"] := [901, 386] ; The 1st item in the window (perfect centre is 899, 386). 
COORDS["Supercomputer"]["Item1Mastery"] := [993, 377] ; The 1st item in the window if the player has mastery 99
COORDS["Supercomputer"]["ItemOffset"] := [134, 0] ; The 2nd item in the window (perfect centre is 1056, 386).

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FREE REWARDS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["FreeRewards"] := Map()
COORDS["FreeRewards"]["X"] := [1292, 265]
COORDS["FreeRewards"]["Reward1"] := [712, 368]
COORDS["FreeRewards"]["Offset"] := [170, 146] ; X and Y offsets for each reward.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; INVENTORY
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Inventory"] := Map()
COORDS["Inventory"]["Items"] := [394, 408]
COORDS["Inventory"]["Potions"] := [394, 469]
COORDS["Inventory"]["Item1"] := [504, 413]
COORDS["Inventory"]["Potion1"] := [514, 365]
COORDS["Inventory"]["Search"] := [1185, 257]
COORDS["Inventory"]["X"] := [1502, 265]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TELEPORT
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Teleport"] := Map()
COORDS["Teleport"]["Search"] := [1200, 260]
COORDS["Teleport"]["Zone"] := [964, 364]
COORDS["Teleport"]["X"] := [1500, 265]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ERRORS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Errors"] := Map()
COORDS["Errors"]["Ok"] := [965, 739]
COORDS["Errors"]["X"] := [1308, 265]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OCR
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["OCR"] := Map()

; Disconnect message.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["DisconnectMessageStart"] := [767, 409]
COORDS["OCR"]["DisconnectMessageSize"] := [398, 248]

; Fruit menu.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["FruitMenuStart"] := [569, 372]
COORDS["OCR"]["FruitMenuSize"] := [159, 462]

; Rank Rewards.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["RankProgressStart"] := [931, 271]
COORDS["OCR"]["RankProgressSize"] := [420, 40]
COORDS["OCR"]["Quest1Start"] := [552, 507]
COORDS["OCR"]["Quest2Start"] := [552, 560]
COORDS["OCR"]["Quest3Start"] := [552, 613]
COORDS["OCR"]["Quest4Start"] := [552, 666]
COORDS["OCR"]["QuestSize"] := [196, 50]

; Rank up message ("MAX RANK" or "CLAIM REWARDS").
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["RankUpStart"] := [1618, 540]
COORDS["OCR"]["RankUpSize"] := [300, 53]

; Supercomputer!
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["SupercomputerAmountStart"] := [855, 365]
COORDS["OCR"]["SupercomputerAmountStartMastery"] := [940, 352]
COORDS["OCR"]["SupercomputerAmountSize"] := [95, 45]
COORDS["OCR"]["PetInfoStart"] := [10, 10] ; This is an offset.
COORDS["OCR"]["PetInfoSize"] := [300, 200]

; Free Rewards.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["FreeRewardsReadyStart"] := [12, 400]
COORDS["OCR"]["FreeRewardsReadySize"] := [120, 40]

; Masteries.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["MasteryLevelStart"] := [444, 585]
COORDS["OCR"]["MasteryLevelSize"] := [157, 41]

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; PIXEL CHECK
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Pixel"] := Map()
COORDS["Pixel"]["SupercomputerPet"] := [572, 458] ; Star/s location  above resultant item.
COORDS["Pixel"]["SupercomputerPetMastery"] := [500, 377] ; Star/s location  above resultant item.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OTHER
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Other"] := Map()
COORDS["Other"]["HatchSpamClick"] := [778, 923]
