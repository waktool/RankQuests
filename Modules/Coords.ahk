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
COORDS["Controls"]["FreeGifts"] := [40, 189]
COORDS["Controls"]["Teleport"] := [104, 189]
COORDS["Controls"]["HatchSettings"] := [104, 247]
COORDS["Controls"]["AutoFarm"] := [40, 311]
COORDS["Controls"]["AutoTap"] := [104, 311]
COORDS["Controls"]["Ultimate"] := [242, 514]
COORDS["Controls"]["Rewards1"] := [706, 425] ; Standard button position.
COORDS["Controls"]["Rewards2"] := [706, 364] ; Button position when rank up occurs.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HATCH SETTINGS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["HatchSettings"] := Map()
COORDS["HatchSettings"]["ChargedEggsOff"] := [492, 294]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; BUY EGGS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["BuyEggs"] := Map()
COORDS["BuyEggs"]["BuyMax"] := [552, 429]
COORDS["BuyEggs"]["X"] := [632, 109]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; RANK REWARDS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["RankRewards"] := Map()
COORDS["RankRewards"]["X"] := [748, 109]
COORDS["RankRewards"]["Heading"] := [522, 159] ; Required to select scrollable area.
COORDS["RankRewards"]["ClickForMore"] := [400, 440] ; Message that pops up after claiming all rewards.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CONTROLS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Worlds"] := Map()
COORDS["Worlds"][1] := [22, 239]
COORDS["Worlds"][2] := [22, 284]
COORDS["Worlds"][3] := [22, 329]

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; SUPERCOMPUTER!
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Supercomputer"] := Map()
COORDS["Supercomputer"]["X"] := [748, 109]
COORDS["Supercomputer"]["Search"] := [530, 107]
COORDS["Supercomputer"]["Ok"] := [164, 424]
COORDS["Supercomputer"]["SuccessOk"] := [396, 419] ; Ok button on the Success window.

; The boundaries of the hover effect for item 1 (no mastery) are:
; The perfect center coordinates are therefore (370.5, 238.5).
; However, for practical purposes, we adjust these coordinates slightly to (372, 239).
; This adjustment is made to ensure accurate interaction with the item.
COORDS["Supercomputer"]["Item1"] := [364, 208]

; The boundaries of the hover effect for item 1 (with mastery) are:
; The perfect center coordinates are therefore (422, 196.5).
; However, for practical purposes, we adjust these coordinates slightly to (424, 197).
; This adjustment is made to ensure accurate interaction with the item.
COORDS["Supercomputer"]["Item1Mastery"] := [424, 197]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FREE REWARDS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["FreeRewards"] := Map()
COORDS["FreeRewards"]["X"] := [623, 109]
COORDS["FreeRewards"]["Reward1"] := [231, 175]
COORDS["FreeRewards"]["Offset"] := [112, 100] ; X and Y offsets for each reward.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; INVENTORY
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Inventory"] := Map()

; Icon buttons.
COORDS["Inventory"]["Items"] := [25, 203]
COORDS["Inventory"]["Potions"] := [25, 249]

; Locations for first icon in each window.
COORDS["Inventory"]["Item1"] := [114, 238]
COORDS["Inventory"]["Potion1"] := [114, 198]

COORDS["Inventory"]["Search"] := [558, 108]
COORDS["Inventory"]["X"] := [747, 109]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TELEPORT
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Teleport"] := Map()
COORDS["Teleport"]["Search"] := [558, 108]
COORDS["Teleport"]["Zone"] := [437, 243]
COORDS["Teleport"]["X"] := [747, 109]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ERRORS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Errors"] := Map()
COORDS["Errors"]["Ok"] := [402, 419]
COORDS["Errors"]["X"] := [622, 109]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OCR
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["OCR"] := Map()

; Disconnect message.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["DisconnectMessageStart"] := [201, 175]
COORDS["OCR"]["DisconnectMessageSize"] := [398, 248]

; Fruit menu.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["FruitMenuStart"] := [163, 196]
COORDS["OCR"]["FruitMenuSize"] := [165, 400]

; Rank Rewards.
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["RankProgressStart"] := [418, 124]
COORDS["OCR"]["RankProgressSize"] := [216, 34]
COORDS["OCR"]["Quest1Start"] := [128, 277]
COORDS["OCR"]["Quest2Start"] := [128, 313]
COORDS["OCR"]["Quest3Start"] := [128, 347]
COORDS["OCR"]["Quest4Start"] := [128, 381]
COORDS["OCR"]["QuestSize"] := [134, 34]

; Rank up message ("MAX RANK" or "CLAIM REWARDS").
; ----------------------------------------------------------------------------------------
COORDS["OCR"]["RankUpStart"] := [599, 278]
COORDS["OCR"]["RankUpSize"] := [200, 50]

; Supercomputer!
; ----------------------------------------------------------------------------------------
; These coordinates define the top-left corner of a rectangle that is used by OCR. Here,
; OCR reads the selected amount of items in the "Supercomputer" when the player does not
; have mastery level 99.
COORDS["OCR"]["SupercomputerAmountStart"] := [322, 189]

; These coordinates define the top-left corner of a rectangle that is used by OCR. Here,
; OCR reads the selected amount of items in the "Supercomputer" when the player has
; mastery level 99.
COORDS["OCR"]["SupercomputerAmountStartMastery"] := [382, 176]

; This is the size of the OCR rectangle used for reading the amount of items.
COORDS["OCR"]["SupercomputerAmountSize"] := [82, 37]

; These coordinates define the top-left corner of the information tooltip that appears 
; when you hover over an item. This is an offset from where the mouse cursor is.
COORDS["OCR"]["PetInfoStart"] := [10, 10] ; This is an offset.

; This is the size of the OCR rectangle used for reading the information tooltip.
; * Width = 150 pixels, Height = 100 pixels
COORDS["OCR"]["PetInfoSize"] := [155, 100]


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OTHER
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

COORDS["Other"] := Map()
COORDS["Other"]["HatchSpamClick"] := [241, 580]