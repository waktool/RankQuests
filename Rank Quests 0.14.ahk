#Requires AutoHotkey v2.0  ; Ensures the script runs only on AutoHotkey version 2.0, which supports the syntax and functions used in this script.

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; RANK QUEST - AutoHotKey 2.0 Macro for Pet Simulator 99
; ----------------------------------------------------------------------------------------
; Copyright © waktool
; Version: 0.14
; Date: 2024-06-02
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

/*

This program is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this
program. If not, see <https://www.gnu.org/licenses/>.

*/


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; DIRECTIVES & CONFIGURATIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

#SingleInstance Force  ; Forces the script to run only in a single instance. If this script is executed again, the new instance will replace the old one.
CoordMode "Mouse", "Window"  ; Sets the coordinate mode for mouse functions (like Click, MouseMove) to be relative to the active window's client area, ensuring consistent mouse positioning across different window states.
CoordMode "Pixel", "Window"  ; Sets the coordinate mode for pixel functions (like PixelSearch, PixelGetColor) to be relative to the active window's client area, improving accuracy in color detection and manipulation.
SetMouseDelay 10  ; Sets the delay between mouse events to 10 milliseconds, balancing speed and reliability of automated mouse actions.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Titles and versioning for GUI elements.
global MACRO_TITLE := "Rank Quests"  ; The title displayed in main GUI elements.
global MACRO_VERSION := "0.14"  ; Script version, helpful for user support and debugging.
global READ_ME := A_ScriptDir "\README.txt"  ; Path to the README file, provides additional information to users.
global LOG_FOLDER := A_ScriptDir "\Logs\"  ; Path to the README file, provides additional information to users.
global DATE_TODAY := FormatTime(A_Now, "yyyyMMdd")

; Mathematics and constants.
global RADIUS := 150  ; Standard radius used for calculations in positioning or graphics.
global PI := 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679  ; Mathematical constant Pi, crucial for circular calculations.
global ONE_SECOND := 1000  ; Number of milliseconds in one second, used for timing operations.

; Zone settings defining game areas.
global BEST_ZONE := 209  ; Identifier for the best zone, typically where optimal actions occur.
global SECOND_BEST_ZONE := 208  ; Identifier for the second-best ZONE

; Font settings for GUI and other text displays.
global TIMES_NEW_ROMAN := A_ScriptDir "\Assets\TimesNewRoman.ttf"  ; Path to Times New Roman font.
global TIMES_NEW_ROMAN_INVERTED := A_ScriptDir "\Assets\TimesNewRoman-Inverted.ttf"  ; Path to Times New Roman font (inverted).
global FREDOKA_ONE_REGULAR := A_ScriptDir "\Assets\FredokaOne-Regular.ttf"  ; Path to Fredoka One Regular font.
global SOURCE_SANS_PRO_BOLD := A_ScriptDir "\Assets\SourceSansPro-Bold.ttf"  ; Path to Source Sans Pro Bold font.

; User settings loaded from an INI file.
global SETTINGS_INI := A_ScriptDir "\Settings\Settings.ini"  ; Path to settings INI file.
global DARK_MODE := getSetting("DarkMode")  ; User preference for dark mode, loaded from settings.
global SHOW_OCR_OUTLINE := getSetting("ShowOcrOutline")  ; User preference for displaying OCR outlines.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; LIBRARIES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Third-party Libraries:
#Include <OCR>        ; Includes an Optical Character Recognition library for extracting text from images.
#Include <Pin>        ; Includes a library for creating pinned overlays or highlights on the screen, enhancing visual interfaces.
#Include <JXON>       ; Includes a library for handling JSON data, useful for configuration and data management tasks.
#Include <DarkMode>   ; Includes a library to support dark mode functionality, improving UI aesthetics and reducing eye strain.

; Macro Related Libraries:
#Include "%A_ScriptDir%\Modules"    ; Includes all scripts located in the 'Modules' directory relative to the script's directory.
#Include "Coords.ahk"               ; Includes a script defining coordinates for GUI elements, useful for automation tasks.
#Include "Delays.ahk"               ; Includes a script that defines various delay times for operations, ensuring timing accuracy.
#Include "Movement.ahk"             ; Includes a script managing movement or navigation automation within the application.
#Include "Quests.ahk"               ; Includes a script that handles quest-related data and operations.
#Include "Zones.ahk"                ; Includes a script that defines different game zones or areas, used in navigation and contextual actions.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

runMacro()

; ----------------------------------------------------------------------------------------
; runMacro Function
; Description: Initiates the macro by running a series of initialization and maintenance tasks.
; Operation:
;   - Executes a sequence of functions designed to prepare and manage the macro's operational environment.
;   - Handles initial setups, checks, and displays crucial information via a GUI.
; Dependencies:
;   - completeInitialisationTasks, DownloadAvatar, displayQuestsGui, activateRoblox, 
;     checkForDisconnection, checkForMaxRank, priortiseAndCompleteQuests: Functions that initialize the environment, manage connectivity, display UI, and handle game-specific tasks.
; Parameters:
;   - None
; Return: None; triggers a sequence of operations that ensure the macro is ready and operational.
; ----------------------------------------------------------------------------------------
runMacro() {
    writeToLogFile("*** MACRO START ***")
    completeInitialisationTasks()  ; Perform all initial tasks necessary for the macro's setup, such as setting variables or preparing the environment.
    displayQuestsGui()  ; Creates and displays a graphical user interface that lists quests and other activities, enhancing user interaction and control.
    activateRoblox()  ; Ensures that the Roblox window is active and ready for input, critical for reliably sending commands to the game.
    checkForDisconnection()  ; Continuously monitors the connection status to handle any disconnections promptly, maintaining the macro's functionality.
    checkForMaxRank()  ; Verifies if the player has reached the maximum rank available, which might change the behavior of the macro or disable certain functions.    
    priortiseAndCompleteQuests()  ; Analyzes available quests to determine priorities and executes them accordingly, managing the macro's main objectives effectively.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI INITIALISATION
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; displayQuestsGui Function
; Description: Sets up and displays a GUI for quest management and macro control.
; Operation:
;   - Creates a GUI with always-on-top property for constant visibility.
;   - Configures the GUI with title, font, and interactive elements such as list views and buttons.
;   - Positions the GUI and assigns functions to buttons for operational control.
; Dependencies:
;   - Gui, guiMain.Show, guiMain.GetPos, guiMain.Move: Functions for GUI creation and manipulation.
; Parameters:
;   - None
; Return: None; creates a GUI for interacting with the macro.
; ----------------------------------------------------------------------------------------
displayQuestsGui() {
    ; Initialize the main GUI with "AlwaysOnTop" property.
    global guiMain := Gui("+AlwaysOnTop")
    guiMain.Title := MACRO_TITLE " v" MACRO_VERSION  ; Set the title incorporating global variables for title and version.
    guiMain.SetFont(, "Segoe UI")  ; Use "Segoe UI" font for a modern look.

    ; Create a list view for quests with various columns.
    global lvQuests := guiMain.AddListView("r4 w650 NoSortHdr", ["★", "Type", "Quest", "Amount", "Priority", "Status", "Zone", "OCR"])
    lvQuests.ModifyCol(1, 25)  ; Modify column widths for better data presentation.
    lvQuests.ModifyCol(2, 0)
    lvQuests.ModifyCol(3, 200)
    lvQuests.ModifyCol(4, 55)
    lvQuests.ModifyCol(5, 50)
    lvQuests.ModifyCol(6, 60)
    lvQuests.ModifyCol(7, 40)
    lvQuests.ModifyCol(8, 200)  ; Set the last column width to 0 as it may contain OCR data not needed for display.

    ; Create another list view for displaying current activities.
    global lvCurrent := guiMain.AddListView("xs r1 w650 NoSortHdr", ["Loop", "Zone", "Area", "Quest", "Action", "Time"])
    lvCurrent.Add(, "-", "-", "-", "-", "-")  ; Initialize with a default row.
    lvCurrent.ModifyCol(1, 50)
    lvCurrent.ModifyCol(2, 40)
    lvCurrent.ModifyCol(3, 100)
    lvCurrent.ModifyCol(4, 200)
    lvCurrent.ModifyCol(5, 200)
    lvCurrent.ModifyCol(6, 40)

    ; Add control buttons to the GUI for various functions.
    btnPause := guiMain.AddButton("xs", "⏸ &Pause")
    btnHelp := guiMain.AddButton("yp", "❓&Help")
    btnRefresh := guiMain.AddButton("yp", "🔄 &Refresh")
    btnReconnect := guiMain.AddButton("yp", "🔁 &Reconnect")
    btnFont := guiMain.AddButton("yp", "𝔄 &Default Font")

    ; Display the GUI window.
    guiMain.Show()

    ; Retrieve and adjust the GUI window position to the top right of the screen.
    guiMain.GetPos(,, &Width,)
    guiMain.Move(A_ScreenWidth - Width + 8, 0)

    ; Assign events to buttons for respective functionalities.
    btnPause.OnEvent("Click", pauseMacro)
    btnHelp.OnEvent("Click", openHelpText)
    btnRefresh.OnEvent("Click", refreshQuests)
    btnReconnect.OnEvent("Click", reconnectClient)
    btnFont.OnEvent("Click", changeToDefaultFont)

    ; Apply a dark mode theme if enabled.
    if (DARK_MODE == "true") {
        SetWindowAttribute(guiMain)
        SetWindowTheme(guiMain)
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; openHelpText Function
; Description: Opens a help text file in Notepad for user assistance.
; Operation:
;   - Executes Notepad with a specified file path to display help documentation.
; Dependencies:
;   - Run: Function to execute external applications.
; Parameters:
;   - None; uses a global variable for the file path.
; Return: None; opens a text file for user reference.
; ----------------------------------------------------------------------------------------
openHelpText(*) {
    Run "C:\Windows\Notepad.exe " READ_ME  ; Run Notepad with the path to the help file stored in READ_ME.
}

; ----------------------------------------------------------------------------------------
; pauseMacro Function
; Description: Toggles the pause state of the macro.
; Operation:
;   - Sends a keystroke to simulate a pause/unpause command.
;   - Toggles the pause state of the script.
; Dependencies:
;   - Send: Function to simulate keystrokes.
; Parameters:
;   - None
; Return: None; toggles the paused state of the macro.
; ----------------------------------------------------------------------------------------
pauseMacro(*) {
    writeToLogFile("*** PAUSED ***")
    Send "{F11}"  ; Send the F11 key, which is often used to pause/resume scripts.
    Pause -1  ; Toggle the pause status of the macro.
}

; ----------------------------------------------------------------------------------------
; exitMacro Function
; Description: Exits the macro application completely.
; Operation:
;   - Terminates the application.
; Dependencies:
;   - ExitApp: Command to exit the application.
; Parameters:
;   - None
; Return: None; closes the application.
; ----------------------------------------------------------------------------------------
exitMacro(*) {
    ExitApp  ; Exit the macro application.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST PRIORITISATION & COMPLETION
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; priortiseAndCompleteQuests Function
; Description: Coordinates multiple tasks in a macro for Pet Simluator 99, managing looped actions based on game settings and quest priorities.
; Operation:
;   - Adjusts the camera view and applies game-specific settings.
;   - Loops through a set number of iterations, performing tasks such as checking for rewards, refreshing quests, and executing the highest priority quest.
;   - Manages disconnections and utilizes special abilities based on game conditions.
;   - Continuously updates loop count and handles quest failure conditions.
; Dependencies:
;   - Various game-specific functions like changeCameraView, applyAutoHatchSettings, checkForClaimRewards, refreshQuests, setCurrentLoop, doQuest, useUltimate, checkForDisconnection, EatfruitArray, claimFreeGifts.
; Parameters:
;   - None; utilizes game settings and state to determine actions.
; Return: None; loops indefinitely, managing game actions continuously.
; ----------------------------------------------------------------------------------------
priortiseAndCompleteQuests(*) {
    changeCameraView()  ; Adjusts the camera view for optimal automation interaction.
    applyAutoHatchSettings()  ; Applies settings relevant to auto-hatching features.

    ; Main loop to handle all macro actions repeatedly.
    Loop {
        DATE_TODAY := FormatTime(A_Now, "yyyyMMdd")
        
        loopTimes := getSetting("NumberOfLoops")  ; Retrieve the number of times the loop should run.

        ; Perform defined tasks for each iteration of the loop.
        Loop loopTimes {
            checkForClaimRewards()  ; Check and claim any available game rewards.
            refreshQuests()  ; Update the list of quests from the game interface.
            currentLoop := A_Index "/" loopTimes  ; Update the current loop count.
            setCurrentLoop(currentLoop)  ; Display the current loop count in the UI.

            ; Find the quest with the highest priority to execute.
            highestPriority := 0
            priorityIndex := 0
            failedQuests := 0
            Loop lvQuests.GetCount() {  ; Iterate through all listed quests.
                currentPriority := lvQuests.GetText(A_Index, 5)
                currentPriority := (currentPriority == "") ? 0 : Integer(currentPriority)
                if (currentPriority > 0 && currentPriority >= highestPriority) {  ; Identify the highest priority quest.
                    priorityIndex := A_Index
                    highestPriority := currentPriority
                }
                if (lvQuests.GetText(A_Index, 3) == "?") {
                    failedQuests++  ; Count quests that failed to read correctly.
                }
            }

            ; Execute the quest with the highest priority or default to a waiting quest.
            if (priorityIndex > 0) {
                currentType := lvQuests.GetText(priorityIndex, 2)
                currentQuest := lvQuests.GetText(priorityIndex, 3)
                currentAmount := lvQuests.GetText(priorityIndex, 4)
                doQuest(currentType, currentQuest, currentAmount)
            } else if (failedQuests != lvQuests.GetCount()) {
                doQuest(100, "Waiting For A Quest")  ; Perform a default action if no specific quests are available.
            }
            
            if (getCurrentZone() == BEST_ZONE) {
                useUltimate()  ; Use the ultimate ability if in the best ZONE
            }

            checkForDisconnection()  ; Monitor and handle any disconnections.

        }

        eatFruit()  ; Consume fruit as part of the game actions.
        claimFreeGifts()  ; Claim any free gifts available in the game.

        if (getSetting("ReconnectAfterLoopsCompleted") == "true") {
            reconnectClient()
        }

        Reload  ; Reload the script to refresh all settings and start fresh.
    }
}

; ----------------------------------------------------------------------------------------
; refreshQuests Function
; Description: Updates quest data by reading from the game's interface, processes each quest, and updates the UI accordingly.
; Operation:
;   - Activates the game window and manages the rewards menu for accessing quest information.
;   - Reads quest details using OCR and updates the quest list view.
;   - Calculates additional data such as stars earned based on gamepasses and updates the main GUI.
; Dependencies:
;   - activateRoblox, setCurrentAction, closeRewardsMenu, clickRewardsButton, getOcrResult, getquestId, RegExReplace, fixAmount, FormatTime: Functions for UI interaction, OCR processing, and data formatting.
; Parameters:
;   - None explicitly passed; uses global settings and game state.
; Return: None; updates internal data structures and UI components to reflect the latest quest information.
; ----------------------------------------------------------------------------------------
refreshQuests(*) {
    setCurrentAction("Reading Quests")  ; Signal beginning of quest processing.
    activateRoblox()  ; Focus the game window for interaction.

    lvQuests.Delete()  ; Clear existing quest data from the list view.
    closeRewardsMenu()  ; Ensure the rewards menu is closed before opening.
    clickRewardsButton()  ; Open the rewards menu to access quest data.

    writeToLogFile("*** REFRESH QUESTS ***")

    ; Process each of the four quests.
    Loop 4 {
        if (getSetting("Do" A_Index "StarQuests") == "true") {  ; Check settings if the quest level should be processed.
            ocrTextResult := getOcrResult(COORDS["OCR"]["Quest" A_Index "Start"], COORDS["OCR"]["QuestSize"], 20)  ; Perform OCR to get quest text.
            questId := getquestId(ocrTextResult)  ; Identify the quest type from OCR results.
            questName := QUEST_DATA[questId]["Name"]  ; Retrieve the name of the quest from a map based on questId.
            questStatus := QUEST_DATA[questId]["Status"]  ; Get the status of the quest.
            questPriority := QUEST_PRIORITY[questId] ; Determine the priority of the quest.
            questZone := QUEST_DATA[questId]["Zone"]  ; Get the associated quest ZONE
            questAmount := fixAmount(ocrTextResult, questId)  ; Correct the OCR-extracted amount if necessary.
            starsMultiplier := (getSetting("HasGamepassDoubleStars") == "true") ? 2 : 1  ; Determine star multiplier based on gamepass.
            questStars := starsMultiplier * A_Index  ; Calculate the total stars earned for this quest.
            lvQuests.Add(, questStars, questId, questName, questAmount, questPriority, questStatus, questZone, ocrTextResult)  ; Add quest data to the list view.
            writeToLogFile("  OCR Result: " ocrTextResult "   Id: " questId "   Quest: " questName "   Amount: " Round(questAmount, 0) "   Priority: " questPriority)
            waitTime("QuestAfterOcrCompleted")  ; Pause until OCR processing is confirmed complete.
        }
    }

    activateRoblox()  ; Re-focus the game window if it lost focus.
    ocrTextResult := getOcrResult(COORDS["OCR"]["RankProgressStart"], COORDS["OCR"]["RankProgressSize"], 20)  ; Read the rank progress using OCR.
    writeToLogFile("  Rank Details: " ocrTextResult)

    ; Update the main GUI title with the rank, reward progress, and current time.
    guiMain.Title := MACRO_TITLE " v" MACRO_VERSION "  (" ocrTextResult ")  (" FormatTime(A_Now, "h:mm tt") ")"

    closeRewardsMenu()  ; Close the rewards menu after completing the quest updates.
    setCurrentAction("-")  ; Reset the current action status.
}

; ----------------------------------------------------------------------------------------
; getquestId Function
; Description: Determines the quest ID based on OCR text by matching it against known regex patterns.
; Operation:
;   - Iterates through each quest entry in a global quest map.
;   - Uses regex matching to identify if the OCR text corresponds to a specific quest pattern.
;   - Returns the quest key if a match is found or a default value if no match is found.
; Dependencies:
;   - Quest: A globally defined map containing quest details such as regex patterns.
;   - regexMatch: Function used to match strings against regular expression patterns.
; Parameters:
;   - OcrText: The text obtained from OCR that needs to be checked against quest patterns.
; Return:
;   - String: Returns the quest key if a match is found; otherwise returns a default "-" indicating no match.
; ----------------------------------------------------------------------------------------
getquestId(ocrTextResult) {
    ; Iterate through each quest in the globally defined Quest.
    for questKey, questItem in QUEST_DATA {
        ; Check if the OCR text matches the regex pattern defined for the current quest.
        if (regexMatch(ocrTextResult, questItem["Regex"])) {
            return questKey  ; If a match is found, return the key associated with this quest.
        }
    }
    return "-"  ; If no matches are found after checking all quests, return a default value.
}

; ----------------------------------------------------------------------------------------
; doQuest Function
; Description: Handles different quests based on the provided questId and Name. Adjusts game state accordingly.
; Operation:
;   - Activates the Roblox window to ensure it's the active application.
;   - Checks if the current quest has changed and stops certain actions if necessary.
;   - Updates the current quest for tracking.
;   - Executes different quest actions based on the questId.
; Dependencies:
;   - activateRoblox, getCurrentQuest, stopHatching, setCurrentQuest, and various quest-related functions.
; Parameters:
;   - questId: Identifier for the quest.
;   - Name: Name of the quest.
;   - Amount: Optional parameter for the amount needed in certain quests (default is 1).
; Return: None; modifies game actions based on the quest requirements.
; ----------------------------------------------------------------------------------------
doQuest(questId, questName, questAmount := 1) {
    activateRoblox()  ; Focus on the Roblox window to ensure actions are sent to the right place.
    writeToLogFile("*** ACTIVE QUEST***   Id: " questId "   Quest: " questName "   Amount: " Round(questAmount, 0) "   Loop: " getCurrentLoop())

    ; Check if the current quest is still active, and stop hatching if in an egg area.
    if (questName != getCurrentQuest()) {
        if getCurrentArea() == "Best Egg"
            stopHatching()  ; Stop hatching actions if the area is for hatching eggs.
        else if getCurrentArea() == "Rare Egg" {
            stopHatching() 
            applyAutoHatchSettings()
        }
    }

    setCurrentQuest(questName)  ; Update the system with the new or current quest.

    ; Perform actions based on the quest ID provided.
    Switch questId {
        Case "7":  ; Quest for earning diamonds.
            earnDiamonds()
        Case "9":  ; Quest for breaking diamond breakables.
            breakDiamondBreakables()
        Case "14":  ; Quest for collecting potions.
            upgradePotions(questAmount)
        Case "15":  ; Quest for collecting enchants.
            upgradeEnchants(questAmount)
        Case "20":  ; Quest for hatching the best egg.
            hatchBestEgg(questAmount)
        Case "21":  ; Quest for breaking breakables in the best area.
            breakBreakables()
        Case "33":  ; Quest for using flags.
            useFlags(questAmount)
        Case "34-1", "34-2", "34-3":  ; Quest for using specific tier potions.
            usePotions(questId, questAmount)
        Case "35":  ; Quest for eating fruitArray.
            useFruit(questAmount)
        Case "37":  ; Quest for breaking coin jars.
            breakBasicCoinJars(questId, questAmount)
        Case "38":  ; Quest for breaking comets.
            breakComets(questId, questAmount)
        Case "39":  ; Quest for breaking mini-chests.
            breakMiniChests()
        Case "40":  ; Quest for making golden pets from the best egg.
            makeGoldenPets(questAmount)
        Case "41":  ; Quest for making rainbow pets from the best egg.
            makeRainbowPets(questAmount)
        Case "42":  ; Quest for hatching rare pets.
            hatchRarePetEgg()
        Case "43":  ; Quest for breaking pinatas.
            breakPinatas(questId, questAmount)
        Case "44":  ; Quest for breaking lucky blocks.
            breakLuckyBlocks(questId, questAmount)
        Case "66":  ; "Break Superior Mini-Chests in Best Area"
            breakSuperiorMiniChests()
        Case "100":  ; Default action when there are no specific quests.
            waitForQuest()
        Default:
            ; No action for undefined questId.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; breakComets Function
; Description: Breaks a specified number of Comets in the last zone based on game settings.
; Operation:
;   - Navigates to the optimal zone for breaking Comets.
;   - Loops through the specified number of Comets to break.
;   - Updates UI to reflect the current action.
;   - Attempts to use the 'Comet' item to break a comet, and quits if the item isn't found.
;   - Pauses between actions to allow for the game's processing time.
; Dependencies:
;   - farmBestZone, setCurrentAction, useItem, getSetting: Functions to navigate, update UI, use items, and retrieve settings.
; Parameters:
;   - questId: Identifier for the quest.
;   - Amount: Number of Comets to break.
; Return: None; modifies the game state by breaking Comets.
; ----------------------------------------------------------------------------------------
breakComets(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal ZONE
    Loop questAmount {
        currentAction := "Breaking Comets (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Display breaking status.
        writeToLogFile(currentAction)
        itemFound := useItem("Comet", 2,,, true)  ; Attempt to use Comet item.
        if (itemFound == false) {
            QUEST_PRIORITY[questId] := 0  ; Downgrade quest priority if item not found.
            return
        }
        loopAmountOfSeconds(getSetting("TimeToBreakComet"))
    }
}

; ----------------------------------------------------------------------------------------
; breakPinatas Function
; Description: Breaks a specified number of Pinatas or Party Boxes based on settings.
; Operation:
;   - Navigates to the last zone optimal for breaking.
;   - Decides whether to break Pinatas or use Party Boxes based on a setting.
;   - Updates the UI to reflect the current breaking action.
;   - Attempts to use the specified item, and exits if unavailable.
;   - Pauses to allow time for the breaking process to complete.
; Dependencies:
;   - farmBestZone, getSetting, setCurrentAction, useItem: Functions for navigation, retrieving settings, updating UI, and using items.
; Parameters:
;   - questId: Identifier for the quest.
;   - Amount: Initial number of Pinatas to break, adjusted if using Party Boxes.
; Return: None; modifies game state based on the breaking of items.
; ----------------------------------------------------------------------------------------
breakPinatas(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking.
    if (getSetting("UsePartyBoxInsteadOfPinata") == "true") {  ; Check if party boxes should be used instead.
        itemToUse := "Party Box"
        currentItem := "Breaking Party Boxes"
        questAmount := questAmount * getSetting("PartyBoxAmountMultiplier")  ; Adjust the amount based on the multiplier.
    } else {
        itemToUse := "Piñata"
        currentItem := "Breaking Pinatas"
    }

    Loop questAmount {  ; Loop through the number of items to break.
        currentAction := currentItem " (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Display the current action in UI.
        writeToLogFile(currentAction)
        itemFound := useItem(itemToUse, 2,,, true)  ; Attempt to use the item.
        if (itemFound == false) {  ; Check if the item was successfully used.
            QUEST_PRIORITY[questId] := 0  ; Downgrade quest priority if item not found.
            return
        }
        loopAmountOfSeconds(getSetting("TimeToBreakPinata"))
    }
}

; ----------------------------------------------------------------------------------------
; breakLuckyBlocks Function
; Description: Breaks Lucky Blocks and optionally uses TNT crates based on settings.
; Operation:
;   - Navigates to the optimal zone for breaking Lucky Blocks.
;   - Retrieves time settings for breaking and possibly using TNT crates.
;   - Continuously updates UI and manages item use based on successful item availability.
; Dependencies:
;   - farmBestZone, getSetting, setCurrentAction, useItem: Functions for navigation, retrieving settings, updating UI, and using items.
; Parameters:
;   - questId: Identifier for the quest.
;   - Amount: Number of Lucky Blocks to break.
; Return: None; engages in breaking Lucky Blocks and using additional items if specified.
; ----------------------------------------------------------------------------------------
breakLuckyBlocks(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking.
    timeToBreakLuckyBlock := getSetting("TimeToBreakLuckyBlock") ; Get the set time to break a Lucky Block.
    Loop questAmount {  ; Loop through the number of Lucky Blocks to break.
        currentAction := "Breaking Lucky Blocks (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Display the current action in UI.
        writeToLogFile(currentAction)        
        itemFound := useItem("Lucky Block", 2,,, true)  ; Attempt to use the Lucky Block item.
        if (itemFound == false) {  ; Check if the item was successfully used.
            QUEST_PRIORITY[questId] := 0  ; Downgrade quest priority if item not found.
            return
        }

        if (getSetting("UseTntCratesAfterLuckyBlock") == "true") {  ; Check if TNT crates should be used after breaking.
            numberOfTnt := getSetting("NumberOfTntCratesToUseAfterLuckyBlock")  ; Get the number of TNT crates to use.
            Loop numberOfTnt {  ; Loop through the number of TNT crates.
                useItem("TNT Crate", 2)  ; Use a TNT crate.
                loopAmountOfSeconds(Min(3, Ceil(timeToBreakLuckyBlock / numberOfTnt)))
            }
        } else {
            loopAmountOfSeconds(timeToBreakLuckyBlock)
        }
    }
}

; ----------------------------------------------------------------------------------------
; breakBasicCoinJars Function
; Description: Breaks a specified number of Basic Coin Jars in the last ZONE
; Operation:
;   - Navigates to the best zone for breaking Basic Coin Jars.
;   - Updates UI to reflect the current action of breaking Coin Jars.
;   - Attempts to use the Coin Jar item and exits if not available.
;   - Pauses for a set duration to allow the breaking process to complete.
; Dependencies:
;   - farmBestZone, setCurrentAction, useItem, getSetting: Functions for navigation, UI updates, using items, and retrieving settings.
; Parameters:
;   - questId: Identifier for the quest.
;   - Amount: Number of Basic Coin Jars to break.
; Return: None; modifies game state by breaking Coin Jars.
; ----------------------------------------------------------------------------------------
breakBasicCoinJars(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking.
    Loop questAmount {  ; Loop through the number of Coin Jars to break.
        currentAction := "Breaking Coin Jars (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Display the current action in UI.
        writeToLogFile(currentAction)        
        itemFound := useItem("Basic Coin Jar", 2,,, true)  ; Attempt to use the Coin Jar item.
        if (itemFound == false) {  ; Check if the item was successfully used.
            QUEST_PRIORITY[questId] := 0  ; Downgrade quest priority if item not found.
            return
        }
        loopAmountOfSeconds(getSetting("TimeToBreakBasicCoinJar"))
    }
}

; ----------------------------------------------------------------------------------------
; breakMiniChests Function
; Description: Simulates the action of breaking Mini-Chests for a specified duration.
; Operation:
;   - Navigates to the best zone and updates the current action.
;   - Calculates the total time to break Mini-Chests and updates the UI to reflect time left.
;   - Continuously updates UI and waits between actions.
; Dependencies:
;   - farmBestZone, setCurrentAction, setCurrentTime, getSetting: Functions for navigation and UI updates.
; Return: None; simulates the action of breaking Mini-Chests over time.
; ----------------------------------------------------------------------------------------
breakMiniChests() {
    farmBestZone()  ; Navigate to the optimal ZONE
    currentAction := "Breaking Mini-Chests"
    setCurrentAction(currentAction)  ; Display the current action in UI.
    writeToLogFile(currentAction)          
    loopAmountOfSeconds(getSetting("TimeToBreakMiniChests"))
    setCurrentAction("-")  ; Reset action status.
}

; ---------------------------------------------------------------------------------
; breakSuperiorMiniChests Function
; Description: Navigates to the optimal zone and breaks superior mini-chests for a specified duration.
; Operation:
;   - Navigates to the best zone for breaking superior mini-chests.
;   - Updates the current action status and logs the action.
;   - Retrieves the breaking duration from settings and calculates the total seconds.
;   - Updates the countdown timer and waits for the specified duration.
;   - Resets the action status after the duration has elapsed.
; Dependencies: 
;   - farmBestZone, setCurrentAction, writeToLogFile, getSetting, setCurrentTime: Various functions handling specific operations.
; Return: None; performs the action of breaking superior mini-chests.
; ---------------------------------------------------------------------------------
breakSuperiorMiniChests() {
    farmBestZone()  ; Navigate to the optimal ZONE
    
    currentAction := "Breaking Superior Mini-Chests"
    setCurrentAction(currentAction)  ; Display the current action in the UI.
    writeToLogFile(currentAction)  ; Log the current action.
    loopAmountOfSeconds(getSetting("TimeToBreakSuperiorMiniChests"))    
    setCurrentAction("-")  ; Reset action status.
}

; ----------------------------------------------------------------------------------------
; useFruit Function
; Description: Distributes a specified total amount of actions equally across different fruit types.
; Operation:
;   - Calculates the amount of each fruit type to be used based on the total amount divided by the number of fruit types.
;   - Iterates over a list of fruit types and applies the same amount of action to each fruit.
; Dependencies:
;   - useItem: Function to consume items in the game.
; Parameters:
;   - Amount: Total amount of actions to be distributed among the fruitArray.
; Return: None; modifies game state by consuming fruitArray.
; ----------------------------------------------------------------------------------------
useFruit(amountToUse) {
    amountPerFruit := Ceil(amountToUse / 6)  ; Calculate how many times each fruit type should be used by dividing the total amount by 6.
    fruitArray := ["Apple", "Banana", "Orange", "Pineapple", "Rainbow Fruit", "Watermelon"] ; List of fruitArray to be used.
    ; Loop through each fruit in the list and apply the action.
    for fruit in fruitArray {
        useItem(fruit, 2, amountPerFruit)  ; Use the calculated amount of each fruit.
    }
}

; ----------------------------------------------------------------------------------------
; useFlags Function
; Description: Distributes a specified amount of flags equally among five designated zones.
; Operation:
;   - Calculates the number of flags needed per area.
;   - Teleports to each zone and uses the calculated number of flags.
; Dependencies:
;   - teleportToZone, moveToZoneCentre, useItem, getSetting: Functions for zone navigation, item use, and settings retrieval.
; Parameters:
;   - Amount: Total amount of flags to be used.
; Return: None; modifies game state by using flags in specified zones.
; ----------------------------------------------------------------------------------------
useFlags(amountToUse) {
    flagsPerArea := Ceil(amountToUse / 5)  ; Divide the total amount by 5 areas.
    questFlag := getSetting("QuestFlag")  ; Retrieve the type of flag to use from settings.

    zoneArray := [200, 201, 202, 203, 204]  ; Define the zones where flags will be used.
    for zoneItem in zoneArray {  ; Iterate through each ZONE
        teleportToZone(zoneItem)  ; Teleport to the current ZONE
        moveToZoneCentre(zoneItem)  ; Move to the center of the ZONE
        useItem(questFlag, 2, flagsPerArea)  ; Use the calculated number of flags.
    }
}

; ----------------------------------------------------------------------------------------
; usePotions Function
; Description: Uses a specific amount of a particular potion based on the quest ID.
; Operation:
;   - Selects the appropriate potion to use based on the quest ID.
;   - Uses the selected potion item in the specified amount.
; Dependencies:
;   - useItem, getSetting: Functions for item use and settings retrieval.
; Parameters:
;   - questId: Identifier for the quest determining the potion type.
;   - Amount: Number of potions to use.
; Return: None; modifies game state by consuming potions.
; ----------------------------------------------------------------------------------------
usePotions(questId, amountToUse) {
    Switch questId {  ; Determine the potion type based on the quest ID.
        Case "34-1":
            useItem(getSetting("Tier3Potion"), 3, amountToUse)  ; Use the Tier 3 potion.
        Case "34-2":
            useItem(getSetting("Tier4Potion"), 3, amountToUse)  ; Use the Tier 4 potion.
        Case "34-3":
            useItem(getSetting("Tier5Potion"), 3, amountToUse)  ; Use the Tier 5 potion.
        Default:
            ; No action for undefined questId.
    }
}

; ----------------------------------------------------------------------------------------
; breakBreakables Function
; Description: Handles the process of breaking Breakables over a set duration.
; Operation:
;   - Moves to the best zone and updates the current action.
;   - Calculates the time needed to break Breakables and updates the UI accordingly.
;   - Maintains a countdown and waits appropriately between updates.
; Dependencies:
;   - farmBestZone, setCurrentAction, setCurrentTime, getSetting: Functions for navigation and UI management.
; Return: None; engages in breaking Breakables for the set duration.
; ----------------------------------------------------------------------------------------
breakBreakables() {
    farmBestZone()  ; Navigate to the optimal ZONE
    currentAction := "Breaking Breakables"
    setCurrentAction(currentAction)  ; Display the current action in UI.
    writeToLogFile(currentAction)
    loopAmountOfSeconds(getSetting("TimeToBreakBreakables"))        
    setCurrentAction("-")  ; Reset action status upon completion.
}

; ----------------------------------------------------------------------------------------
; breakDiamondBreakables Function
; Description: Breaks diamond breakables either in the VIP area or the last zone based on VIP gamepass status.
; Operation:
;   - Checks for VIP gamepass and navigates to the appropriate area.
;   - Updates the current action displayed to the user.
;   - Calculates and manages the duration for breaking activities.
;   - Periodically updates UI with the time remaining and pauses to simulate the breaking process.
; Dependencies:
;   - getSetting, goToVipArea, farmBestZone, setCurrentAction, setCurrentTime: Functions to retrieve settings, navigate zones, and update UI.
; Parameters:
;   - None
; Return: None; modifies game state by performing breakable actions.
; ----------------------------------------------------------------------------------------
breakDiamondBreakables() {
    if (getSetting("HasGamepassVip") == "true") {  ; Check for VIP gamepass availability.
        goToVipArea()  ; Navigate to VIP area for exclusive activities.
    } else {
        farmBestZone()  ; Navigate to the last zone for general activities.
    }
    currentAction := "Breaking Diamond Breakables"
    setCurrentAction(currentAction)  ; Display the current action in UI.
    writeToLogFile(currentAction)
    loopAmountOfSeconds(getSetting("TimeTobreakDiamondBreakables"))
    setCurrentAction("-")  ; Reset the action indicator upon completion.
}

; ----------------------------------------------------------------------------------------
; earnDiamonds Function
; Description: Earns diamonds through activities performed in the last ZONE
; Operation:
;   - Navigates to the last zone for diamond earning activities.
;   - Updates the current action displayed to the user.
;   - Calculates and manages the duration for earning activities.
;   - Periodically updates UI with the time remaining and pauses to simulate the earning process.
; Dependencies:
;   - getSetting, farmBestZone, setCurrentAction, setCurrentTime: Functions to retrieve settings, navigate zones, and update UI.
; Parameters:
;   - None
; Return: None; modifies game state by performing diamond earning actions.
; ----------------------------------------------------------------------------------------
earnDiamonds() {
    farmBestZone()  ; Navigate to the last zone, which is optimal for earning diamonds.
    currentAction := "Earning Diamonds"
    setCurrentAction(currentAction)  ; Display the current action in UI.
    writeToLogFile(currentAction)
    loopAmountOfSeconds(getSetting("TimeToEarnDiamonds"))
    setCurrentAction("-")  ; Reset the action indicator upon completion.
}

; ----------------------------------------------------------------------------------------
; upgradePotions Function
; Description: Upgrades potions using the supercomputer based on game settings.
; Operation:
;   - Determines if Potion Mastery is active.
;   - Calls a general function to handle the upgrading process within the supercomputer interface.
; Dependencies:
;   - doSupercomputerStuff: A generalized function to handle actions within the supercomputer.
; Return: None; modifies game elements via the supercomputer interface.
; ----------------------------------------------------------------------------------------
upgradePotions(amountToMake) {
    potionsMastery := (getSetting("PotionMasteryLevel99") == "true") ? true : false
    doSupercomputerStuff(COORDS["Supercomputer"]["UpgradePotions"], amountToMake, getSetting("PotionsRequiredForUpgrade"), potionsMastery, getSetting("PotionToUpgrade"))
}

; ----------------------------------------------------------------------------------------
; upgradeEnchants Function
; Description: Upgrades enchants using the supercomputer based on game settings.
; Operation:
;   - Determines if Enchant Mastery is active.
;   - Calls a general function to handle the upgrading process within the supercomputer interface.
; Dependencies:
;   - doSupercomputerStuff: A generalized function to handle actions within the supercomputer.
; Return: None; modifies game elements via the supercomputer interface.
; ----------------------------------------------------------------------------------------
upgradeEnchants(amountToMake) {
    enchantsMastery := (getSetting("EnchantMasteryLevel99") == "true") ? true : false
    doSupercomputerStuff(COORDS["Supercomputer"]["UpgradeEnchants"], amountToMake, getSetting("EnchantsRequiredForUpgrade"), enchantsMastery, getSetting("EnchantToUpgrade"))
}

; ----------------------------------------------------------------------------------------
; makeRainbowPets Function
; Description: Converts pets to rainbow versions using the supercomputer based on game settings.
; Operation:
;   - Calls a general function to handle the conversion process within the supercomputer interface.
; Dependencies:
;   - doSupercomputerStuff: A generalized function to handle actions within the supercomputer.
; Return: None; modifies game elements via the supercomputer interface.
; ----------------------------------------------------------------------------------------
makeRainbowPets(amountToMake) {
    doSupercomputerStuff(COORDS["Supercomputer"]["RainbowPets"], amountToMake, getSetting("GoldenPetsRequiredForUpgrade"),, getSetting("PetToConvertToRainbow"), "i)shiny")
}

; ----------------------------------------------------------------------------------------
; makeGoldenPets Function
; Description: Converts pets to golden versions using the supercomputer based on game settings.
; Operation:
;   - Calls a general function to handle the conversion process within the supercomputer interface.
; Dependencies:
;   - doSupercomputerStuff: A generalized function to handle actions within the supercomputer.
; Return: None; modifies game elements via the supercomputer interface.
; ----------------------------------------------------------------------------------------
makeGoldenPets(amountToMake) {
    doSupercomputerStuff(COORDS["Supercomputer"]["GoldPets"], amountToMake, getSetting("StandardPetsRequiredForUpgrade"),, getSetting("PetToConvertToGolden"), "i)shiny")
}

; ----------------------------------------------------------------------------------------
; waitForQuest Function
; Description: Engages in a default activity of breaking breakables when there are no specific tasks assigned.
; Operation:
;   - Navigates to the last zone, optimized for breakable activities.
;   - Updates the UI to display the current activity to the user.
;   - Calculates the duration for the activity based on game settings.
;   - Enters a loop to manage the countdown and simulate the activity duration.
;   - Periodically updates the UI with the time remaining.
;   - Resets the UI once the activity is complete.
; Dependencies:
;   - farmBestZone, setCurrentAction, getSetting, setCurrentTime: Functions for navigation, UI updates, and settings retrieval.
; Parameters:
;   - None
; Return: None; simulates an activity to keep the game engaging during idle times.
; ----------------------------------------------------------------------------------------
waitForQuest() {
    farmBestZone()  ; Navigate to the optimal zone for breaking activities.
    setCurrentAction("Breaking Breakables")  ; Indicate the current default activity to the user.
    loopAmountOfSeconds(getSetting("TimeToBreakBreakables"))    
    setCurrentAction("-")  ; Reset the UI display to indicate the completion of the default activity.
}

loopAmountOfSeconds(amountOfSeconds) {
    totalSeconds := Floor(amountOfSeconds)  ; Convert milliseconds to seconds for duration.
    setCurrentTime(totalSeconds)  ; Set and display the countdown timer.
    Loop totalSeconds {  ; Loop through the total duration in seconds.
        setCurrentTime(totalSeconds - A_Index)  ; Update countdown timer each second.
        Sleep ONE_SECOND  ; Wait for one second, simulating the time it takes to break each breakable.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; SUPERCOMPUTER! FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; doSupercomputerStuff Function
; Description: Handles various operations within the supercomputer interface, facilitating different types of upgrades and actions based on the game's needs.
; Operation:
;   - Activates the Roblox window to ensure it's the active window.
;   - Navigates to the supercomputer area to start the operation.
;   - Clicks on a specific machine button determined by the function's parameters.
;   - If a search text is provided, it selects the search box, inputs the text, and waits briefly.
;   - Calculates the necessary angle for the operation, adjusting for the amount, multiplier, and mastery settings.
;   - Confirms the operation by clicking the OK button.
;   - Moves away from the supercomputer to conclude the operation sequence.
;   - Clicks the success button to finalize the process and then closes the supercomputer menu.
; Dependencies:
;   - activateRoblox, goToSupercomputer, clickMachineButton, selectSupercomputerSearchBox, SendText, findAngle, clickMachineOkButton, moveAwayFromTheSupercomputer, clickMachineSuccessButton, closeSuperComputerMenu: Functions for UI interaction and navigation.
; Parameters:
;   - Button: Coordinates of the button to interact with on the supercomputer.
;   - Amount: Number of units involved in the operation.
;   - Multiplier: Factor that affects the operation's scale or extent.
;   - Mastery: Boolean indicating if mastery level adjustments are required.
;   - searchText: Optional text for searching within the interface.
; Return: None; carries out a sequence of actions in the supercomputer.
; ----------------------------------------------------------------------------------------
doSupercomputerStuff(buttonToClick, amountToMake, amountMultiplier, hasMastery := false, searchText := "", itemToIgnore := "") {
    activateRoblox()  ; Ensure Roblox is the active application.
    goToSupercomputer()  ; Navigate to the supercomputer location.
    clickMachineButton(buttonToClick)  ; Interact with the specific button on the machine.

    if (searchText != "") {
        selectSupercomputerSearchBox()  ; Focus on the search box within the supercomputer.
        SendText searchText  ; Enter the required search terms.
        Sleep 500  ; Allow time for the text entry to be processed.
    }

    findAngle(amountToMake, amountMultiplier, hasMastery, itemToIgnore)  ; Calculate necessary adjustments for the operation.
    clickMachineOkButton()  ; Confirm the operation by clicking the OK button.
    moveAwayFromTheSupercomputer()  ; Step back from the supercomputer post-operation.
    clickMachineSuccessButton()  ; Acknowledge the successful operation.
    closeSuperComputerMenu()  ; Close the supercomputer interface to complete the action.
}

; ----------------------------------------------------------------------------------------
; selectSupercomputerSearchBox Function
; Description: Selects the search box within the Supercomputer interface by clicking on it.
; Operation:
;   - Performs a left mouse click at the coordinates specified for the search box.
; Dependencies:
;   - leftClickMouseAndWait: Function to handle mouse click and wait for a predefined action to complete.
; Return: None; initiates UI interaction by selecting the search box.
; ----------------------------------------------------------------------------------------
selectSupercomputerSearchBox() {
    leftClickMouseAndWait(COORDS["Supercomputer"]["Search"], "SupercomputerAfterSearchClicked")
}

; ----------------------------------------------------------------------------------------
; clickMachineButton Function
; Description: Handles the action of clicking a designated button within a GUI, specifically within a game or application's supercomputer interface.
; Operation:
;   - Moves the mouse to the center of the screen to ensure it starts from a consistent position.
;   - Scrolls the mouse wheel upwards twice to possibly adjust the view or navigate through menus.
;   - Performs a left mouse click on a specified button and waits for a triggered action to complete.
; Dependencies:
;   - moveMouseToCentreOfScreen, scrollMouseWheel, leftClickMouseAndWait: Functions that control mouse movement, scrolling, and clicking.
; Parameters:
;   - Button: The specific button on which the click action is to be performed. This should be defined or passed as a coordinate or identifier.
; Return: None; directly modifies the UI by interacting with it.
; ----------------------------------------------------------------------------------------
clickMachineButton(Button) {
    moveMouseToCentreOfScreen()  ; Moves the mouse cursor to the center of the screen to avoid positional inaccuracies.
    scrollMouseWheel("{WheelUp}", 2)  ; Scrolls up the mouse wheel twice, adjusting the interface if necessary before the click.
    leftClickMouseAndWait(Button, "SupercomputerAfterMenuButtonClicked")  ; Executes a left-click on the specified button and waits for a response, ensuring the click has been processed.
}

; ----------------------------------------------------------------------------------------
; clickMachineOkButton Function
; Description: Clicks the 'OK' button within the Supercomputer interface.
; Operation:
;   - Performs a left mouse click at the coordinates specified for the 'OK' button.
; Dependencies:
;   - leftClickMouseAndWait: Function to handle mouse click and wait for a predefined action to complete.
; Return: None; initiates UI interaction by clicking the 'OK' button.
; ----------------------------------------------------------------------------------------
clickMachineOkButton() {
    leftClickMouseAndWait(COORDS["Supercomputer"]["Ok"], "SupercomputerAfterOkButtonClicked")
}

; ----------------------------------------------------------------------------------------
; clickMachineSuccessButton Function
; Description: Clicks the 'Success' button within the Supercomputer interface after an operation is successfully completed.
; Operation:
;   - Performs a left mouse click at the coordinates specified for the 'Success' button.
; Dependencies:
;   - leftClickMouseAndWait: Function to handle mouse click and wait for a predefined action to complete.
; Return: None; initiates UI interaction by clicking the 'Success' button.
; ----------------------------------------------------------------------------------------
clickMachineSuccessButton() {
    leftClickMouseAndWait(COORDS["Supercomputer"]["SuccessOk"], "SupercomputerAfterSuccessOkButtonClicked")
}

; ----------------------------------------------------------------------------------------
; closeSuperComputerMenu Function
; Description: Closes the Supercomputer menu by clicking the 'X' button.
; Operation:
;   - Performs a left mouse click at the coordinates specified for the 'X' button to close the interface.
; Dependencies:
;   - leftClickMouseAndWait: Function to handle mouse click and wait for a predefined action to complete.
; Return: None; closes the Supercomputer interface.
; ----------------------------------------------------------------------------------------
closeSuperComputerMenu() {
    leftClickMouseAndWait(COORDS["Supercomputer"]["X"], "SupercomputerAfterClosed")
}

; ----------------------------------------------------------------------------------------
; findAngle Function
; Description: Calculates the angle needed to select the correct amount of items from a circular UI element based on OCR readings. This function adjusts its operation based on the presence of specific items that should be ignored, as defined by the "Ignore" parameter, ensuring that only relevant items are considered for interaction.
; Operation:
;   - Activates the Roblox window to ensure it's the active window.
;   - Configures item coordinates and OCR settings based on the Mastery setting.
;   - Handles ignored items by adjusting item selection according to OCR results that match the "Ignore" pattern.
;   - Simulates user interactions to read full and half stack amounts.
;   - Determines the angle required to select the specified amount of items.
;   - Adjusts item selection based on calculated angles or defaults to minimal conversion on OCR failure.
; Dependencies:
;   - activateRoblox, SendEvent, readStackAmount, leftClickMouseAndWait, MouseMove, shiftLeftClickMouse, setCurrentAction, getOcrResult, regexMatch: Functions for interaction and feedback.
; Parameters:
;   - Amount: Number of units needed.
;   - Multiplier: Factor that modifies the amount required.
;   - Mastery: Boolean indicating if mastery level settings are used.
;   - Ignore: Regular expression pattern to match items that should be ignored during the process.
; Return: None; selects items within the game based on calculated or minimal required angles.
; ----------------------------------------------------------------------------------------
findAngle(amountToMake, amountMultiplier, hasMastery, itemToIgnore) {
    activateRoblox()  ; Make sure the Roblox window is active for interaction.
    amountNeeded := amountToMake * amountMultiplier  ; Calculate total amount needed.

    writeToLogFile("*** SUPERCOMPUTER CONVERSION ***")
    writeToLogFile("  Amount To Make: " amountToMake "   Multiplier: " amountMultiplier "   Amount Needed: " amountNeeded "   Mastery: " hasMastery "   Ignore: " itemToIgnore)

    ; Set coordinates based on whether Mastery is true or false.
    machineItem := hasMastery ? COORDS["Supercomputer"]["Item1Mastery"] : COORDS["Supercomputer"]["Item1"]
    pixelCheckLocation := hasMastery ? COORDS["Pixel"]["SupercomputerPetMastery"] : COORDS["Pixel"]["SupercomputerPet"]
    ocrStart := hasMastery ? COORDS["OCR"]["SupercomputerAmountStartMastery"] : COORDS["OCR"]["SupercomputerAmountStart"]
    Size := COORDS["OCR"]["SupercomputerAmountSize"]

    ; Additional handling for ignored items based on OCR results.
    if (itemToIgnore != "") {  ; Check if there is a specific pattern or keyword to ignore.
        Loop 2 {  ; Perform the loop twice to ensure robustness in handling dynamic UI elements.
            MouseMove machineItem[1], machineItem[2]  ; Move the mouse to the initial position of the item.
            activateMouseHover()  ; Activate any hover effects that might display additional information.
            waitTime(200)  ; Delay to allow any hover effects or tooltips to appear.

            ; Define the exact location to perform OCR.
            petInfoBox := [machineItem[1] + COORDS["OCR"]["PetInfoStart"][1], machineItem[2] + COORDS["OCR"]["PetInfoStart"][2]]
            ocrTextResult := getOcrResult(petInfoBox, COORDS["OCR"]["PetInfoSize"], 20)  ; Perform OCR to read potentially ignored information.

            if (regexMatch(ocrTextResult, itemToIgnore)) {  ; Check if the OCR results contain the ignored text.
                ; Adjust item and OCR coordinates to skip the ignored item.
                machineItem := [machineItem[1] + COORDS["Supercomputer"]["ItemOffset"][1], machineItem[2]]
                ocrStart := [ocrStart[1] + COORDS["Supercomputer"]["ItemOffset"][1], ocrStart[2]]
                writeToLogFile("  Ignore: " itemToIgnore)
            }
        }
    }

    ; Read the full stack amount by simulating a Shift+Click on the item.
    SendEvent "{Shift down}"
    SendEvent "{Click, " machineItem[1] ", " machineItem[2] + 52 ", 1}"
    Sleep 250  ; Allow some time for the UI to update.
    fullStackAmount := readStackAmount(ocrStart, Size)  ; Use OCR to read the amount.
    SendEvent "{Shift up}"
    leftClickMouseAndWait(machineItem, 100)  ; Deselect the item.

    ; Read the half stack amount by a normal click.
    SendEvent "{Click, " machineItem[1] ", " machineItem[2] + 52 ", 1}"
    Sleep 250  ; Allow some time for the UI to update.
    halfStackAmount := readStackAmount(ocrStart, Size)  ; Use OCR to read the amount.
    leftClickMouseAndWait(machineItem, 100)  ; Deselect the item again.

    ; Check if OCR results are reliable by comparing full and half stack amounts.
    areStackAmountsCorrect := (fullStackAmount != 0 && halfStackAmount != 0) && (Round(fullStackAmount / halfStackAmount) == 2)
    
    ocrTextResult := (areStackAmountsCorrect) ? "PASS" : "FAIL"
    writeToLogFile("  Full Stack: " fullStackAmount "   Half Stack: " halfStackAmount "   Stack Correct: " areStackAmountsCorrect "   OCR Result: " ocrTextResult)

    if (areStackAmountsCorrect) {
        if (amountNeeded >= fullStackAmount) {
            setCurrentAction("OCR PASSED: Using Full Stack")  ; Notify action taken.
            writeToLogFile("  Full Stack Used")
            MouseMove machineItem[1], machineItem[2]
            shiftLeftClickMouse(machineItem)  ; Select the full stack.
            return
        } else {
            angleFor1Pet := 360 / fullStackAmount  ; Calculate the angle for one unit.
            angleModifier := 1.1
            angleRequired := Min(Ceil(angleFor1Pet * amountNeeded * angleModifier), 360)  ; Adjust the angle with a buffer.

            if (angleRequired > 10) {
                setCurrentAction("OCR PASSED: Calculated Conversion")  ; Notify action taken.
                writeToLogFile("  Calculated Conversion:   Angle for one Pet: " Round(angleFor1Pet, 2) "   Amount Needed: " AmountNeeded "   Angle Required: " Round(AngleRequired, 2))
                ; Calculate the coordinates to click based on the angle.
                smallerRadius := 52
                X := machineItem[1] + smallerRadius * Cos((angleRequired - 90) * PI / 180)
                Y := machineItem[2] + smallerRadius * Sin((angleRequired - 90) * PI / 180)
                leftClickMouseAndWait([X, Y], 200)  ; Perform the click.
            } else {
                setCurrentAction("OCR PASSED: Minimum Conversion")  ; Notify minimal action taken.
                PerformMinimumConversion(machineItem, pixelCheckLocation, 2.5)  ; Perform minimum conversion.
            }
        }
    } else {
        setCurrentAction("OCR FAILED: Minimum Conversion")  ; Notify OCR failure and fallback action.
        PerformMinimumConversion(machineItem, pixelCheckLocation, 5)  ; Perform minimum conversion on OCR failure.
    }
}

; ----------------------------------------------------------------------------------------
; PerformMinimumConversion Function
; Description: Performs a minimal conversion by selecting a small number of items from a stack.
; Operation:
;   - Initiates a click and holds it down to start the selection.
;   - Moves the mouse in a circle to gradually select items.
;   - Continuously checks if enough items have been selected to perform an upgrade.
;   - Stops the selection process once enough items are detected in the upgrade window.
; Dependencies:
;   - SendEvent, MouseMove, PixelSearch: Functions for simulating mouse movements and checking pixels.
; Parameters:
;   - machineItem: Coordinates of the item stack.
;   - pixelCheckLocation: Coordinates for checking pixel color to confirm selection.
; Return: None; manipulates UI elements to select a minimal number of items.
; ----------------------------------------------------------------------------------------
PerformMinimumConversion(machineItem, pixelCheckLocation, incrementAmount) {
    SendEvent "{Click down, " machineItem[1] ", " machineItem[2] ", 1}"  ; Start the selection by holding down a click at the initial stack coordinates.
    MouseMove machineItem[1] + RADIUS, machineItem[2]  ; Move mouse slightly to start the selection circle.

    ; Loop to rotate the selection in small steps.
    totalIncrements := (360 / incrementAmount)
    Loop totalIncrements {
        angleCalculated := A_Index * incrementAmount
        ; Calculate new coordinates for each step in the circle using trigonometric functions.
        X := machineItem[1] + RADIUS * Cos((angleCalculated - 90) * PI / 180)
        Y := machineItem[2] + RADIUS * Sin((angleCalculated - 90) * PI / 180)
        MouseMove X, Y  ; Move mouse to the new calculated position.
        Sleep 200  ; Pause briefly to allow UI to update.

        ; Check if enough items have been selected by looking for a specific pixel color in the upgrade window.
        if !(PixelSearch(&X, &Y, pixelCheckLocation[1], pixelCheckLocation[2], pixelCheckLocation[1] + 5, pixelCheckLocation[2] + 5, 0xFFFFFF, 15))
            break  ; Exit the loop if the correct pixel is detected, indicating enough items are selected.
    }
    SendEvent "{Click up}" ; Release the mouse click after selection.
    writeToLogFile("  Minimum Conversion   Angle Used: " Round(angleCalculated, 2))
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; AUTO-RECONNECT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; checkForDisconnection Function
; Description: Monitors the game to detect if a disconnection has occurred and attempts to reconnect.
; Operation:
;   - Updates the current action status to reflect the connection check.
;   - Determines if a disconnection has occurred.
;   - Initiates a reconnection process if disconnected.
;   - Resets the action status after checking.
; Dependencies:
;   - setCurrentAction, checkForDisconnect, Reconnect: Functions to update UI, check connection, and handle reconnection.
; Return: None; primarily controls game connectivity status.
; ----------------------------------------------------------------------------------------
checkForDisconnection() {
    setCurrentAction("Checking Connection")  ; Indicate checking connection status.

    isDisconnected := checkForDisconnect()  ; Check for any disconnection.
    if (isDisconnected == true) {
        reconnectClient()  ; Reconnect if disconnected.
        Reload  ; Reload the script to refresh all settings and start fresh.
    }

    setCurrentAction("-")  ; Reset action status.
}

; ----------------------------------------------------------------------------------------
; Reconnect Function
; Description: Handles the reconnection process by attempting to reconnect to a Roblox game, optionally using a private server.
; Operation:
;   - Retrieves the necessary reconnection settings (time and private server code).
;   - Initiates a connection to Roblox using the appropriate URL scheme.
;   - Displays the reconnect progress in the system tray icon.
; Dependencies:
;   - getSetting, setCurrentAction: Functions to retrieve settings and update UI.
; Return: None; attempts to reconnect to the game.
; ----------------------------------------------------------------------------------------
reconnectClient(*) {
    writeToLogFile("*** RECONNECTING ***")
    reconnectTime := getSetting("ReconnectTimeSeconds")  ; Get the reconnect duration.

    privateServerLinkCode := getSetting("PrivateServerLinkCode")  ; Get the private server code.
    if (privateServerLinkCode == "") {
        try Run "roblox://placeID=8737899170"  ; Default reconnect without private server.
    }
    else {
        try Run "roblox://placeID=8737899170&linkCode=" privateServerLinkCode  ; Reconnect using private server link.
    }

    Loop reconnectTime {
        setCurrentAction("Reconnecting " A_Index "/" reconnectTime)  ; Update reconnecting progress.
        Sleep ONE_SECOND  ; Wait for 1 second.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ULTIMATE FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; useUltimate Function
; Description: Activates the ultimate ability in the game.
; Operation:
;   - Updates the current action to indicate that the ultimate ability is being used.
;   - Clicks on the ultimate button and waits for the action to process.
;   - Updates the current action to indicate completion.
; Dependencies:
;   - setCurrentAction, leftClickMouseAndWait: Functions for updating UI actions and performing clicks.
; Return: None; interacts with the game's UI to use an ultimate ability.
; ----------------------------------------------------------------------------------------
useUltimate() {
    setCurrentAction("Using Ultimate")
    leftClickMouseAndWait(COORDS["Controls"]["Ultimate"], "UltimateAfterUsed")
    setCurrentAction("-")
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FRUIT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; eatFruit Function
; Description: Automatically consumes available fruitArray if the setting is enabled.
; Operation:
;   - Checks if the 'Eat fruitArray' setting is enabled.
;   - Iterates through a list of fruitArray and uses each one.
;   - Closes the inventory and any error messages after eating fruitArray.
; Dependencies:
;   - getSetting, useItem, closeInventoryMenu, closeErrorMessageWindow: Functions to check settings, use items, and manage UI.
; Return: None; modifies the game state by consuming fruitArray.
; ----------------------------------------------------------------------------------------
eatFruit() {
    if (getSetting("EatFruit") == "true") {
        fruitArray := ["Apple", "Banana", "Orange", "Pineapple", "Rainbow Fruit", "Watermelon"]
        for fruitItem in fruitArray {
            useItem(fruitItem, 2, 2, true)
        }
        closeInventoryMenu()
        closeErrorMessageWindow()
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; AUTO FARM FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; clickAutoFarmButton Function
; Description: Toggles the auto-farm feature based on gamepass availability.
; Operation:
;   - Checks if the auto-farm gamepass is enabled.
;   - Updates the current action to reflect auto-farm toggling.
;   - Clicks the auto-farm button and waits for a brief period.
;   - Resets the mouse position to the center of the screen.
;   - Updates the current action again to indicate completion.
; Dependencies:
;   - getSetting, setCurrentAction, leftClickMouseAndWait, moveMouseToCentreOfScreen: Functions for checking settings, updating UI actions, clicking, and repositioning the mouse.
; Return: None; directly modifies the game state by toggling an auto-farm feature.
; ----------------------------------------------------------------------------------------
clickAutoFarmButton() {
    if (getSetting("HasGamepassAutoFarm") == "true") {  ; Only proceed if the auto-farm gamepass is active.
        setCurrentAction("Enabling/Disabling Auto Farm...")
        leftClickMouseAndWait(COORDS["Controls"]["AutoFarm"], 200)
        moveMouseToCentreOfScreen()
        setCurrentAction("-")
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; AUTO HATCH FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; applyAutoHatchSettings Function
; Description: Configures the auto hatch settings in the Roblox game by interacting with the game's UI.
; Operation:
;   - Ensures the Roblox window is active before making any changes.
;   - Closes the auto hatch menu if it is currently open to start from a known state.
;   - Opens the auto hatch menu to access setting controls.
;   - Toggles the auto hatch feature based on the current settings.
;   - Applies user settings for hatching charged and golden pets.
;   - Closes the auto hatch menu after applying all settings.
; Dependencies:
;   - activateRoblox, closeAutoHatchMenu, leftClickMouseAndWait: Functions to manage window focus and simulate mouse interactions.
;   - getSetting: Retrieves user preferences from a settings structure.
; Return: None; modifies the game's UI settings directly.
; ----------------------------------------------------------------------------------------
applyAutoHatchSettings(chargedOverride := false) {
    activateRoblox()  ; Activate the Roblox window.
    closeAutoHatchMenu()  ; Close the auto hatch menu if it's open.
    leftClickMouseAndWait(COORDS["Controls"]["HatchSettings"], 500)  ; Click the auto hatch button to open the menu.
    leftClickMouseAndWait(COORDS["HatchSettings"]["AutoHatchOn"], 200)  ; Turn on auto hatch.
    setCurrentAction("Updating Auto Hatch Settings")
    ; Set hatch charged pets option based on settings.
    if chargedOverride
        leftClickMouseAndWait(COORDS["HatchSettings"]["ChargedEggsOff"], 200)
    else {
        if (getSetting("HatchChargedEggs") == "true")
            leftClickMouseAndWait(COORDS["HatchSettings"]["ChargedEggsOff"], 200)
        else
            leftClickMouseAndWait(COORDS["HatchSettings"]["ChargedEggsOn"], 200)
    }

    ; Set hatch golden pets option based on settings.
    if (getSetting("HatchGoldenEggs") == "true")
        leftClickMouseAndWait(COORDS["HatchSettings"]["GoldenEggsOff"], 200)
    else
        leftClickMouseAndWait(COORDS["HatchSettings"]["GoldenEggsOn"], 200)

    closeAutoHatchMenu()  ; Close the auto hatch menu after applying settings.
}

; ----------------------------------------------------------------------------------------
; closeAutoHatchMenu Function
; Description: Closes the auto hatch menu by clicking the 'X' button.
; Operation:
;   - Directly clicks the close button using coordinates from the UI control structure.
; Dependencies:
;   - leftClickMouseAndWait: Function to perform mouse click and wait operations.
; Return: None; interacts directly with the game's UI.
; ----------------------------------------------------------------------------------------
closeAutoHatchMenu() {
    leftClickMouseAndWait(COORDS["HatchSettings"]["X"], 50)
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FREE GIFTS / REWARDS FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; claimFreeGifts Function
; Description: Claims free gifts available in the game when they are ready by interacting with the UI.
; Operation:
;   - Checks if free gifts are ready using the areFreeGiftsReady function.
;   - If gifts are ready, clicks the free gifts button to open the rewards menu.
;   - Retrieves coordinates and offsets for the placement of gifts within the UI.
;   - Iterates over rows and columns of gifts, calculating exact coordinates for each gift.
;   - Clicks on each gift sequentially to claim it.
;   - Closes the free gifts menu after all gifts are claimed.
; Dependencies:
;   - areFreeGiftsReady, leftClickMouseAndWait: Functions to check gift readiness and perform timed clicks.
;   - COORDS: Global variable containing coordinate data for UI elements.
; Return: None; directly interacts with the game's UI to claim gifts.
; ----------------------------------------------------------------------------------------
claimFreeGifts() {
    if (areFreeGiftsReady() == true) {  ; Check if the free gifts are ready to be claimed.
        leftClickMouseAndWait(COORDS["Controls"]["FreeGifts"], "FreeGiftsAfterOpened")  ; Open the free gifts menu.
        firstGiftLocation := COORDS["FreeRewards"]["Reward1"]  ; Get coordinates for the first gift.
        giftOffset := COORDS["FreeRewards"]["Offset"]  ; Get offset for positioning between gifts.

        ; Iterate over three rows of gifts.
        Loop 3 {
            giftToClickY := firstGiftLocation[2] + ((A_Index - 1) * giftOffset[2])  ; Calculate y-coordinate for the current row.

            ; Iterate over four gifts in the current row.
            Loop 4 {
                giftToClickX := firstGiftLocation[1] + ((A_Index - 1) * giftOffset[1])  ; Calculate x-coordinate for the current gift.
                giftToClick := [giftToClickX, giftToClickY]  ; Form the coordinate array for the gift.

                leftClickMouseAndWait(giftToClick, "FreeGiftAfterClicked")  ; Click on the gift to claim it.
            }
        }

        leftClickMouseAndWait(COORDS["FreeRewards"]["X"], "FreeGiftsAfterClosed")  ; Close the gifts menu after all gifts are claimed.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; RANK REWARDS FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; clickRewardsButton Function
; Description: Activates the Roblox window and clicks the rewards button to open the rewards menu.
; Operation:
;   - Ensures the Roblox window is active.
;   - Retrieves and sets the mouse cursor to the rewards button coordinates.
;   - Moves the mouse slightly to trigger any hover effects before clicking.
;   - Waits briefly after clicking to allow the rewards menu to fully open.
; Dependencies:
;   - activateRoblox, MouseMove, activateMouseHover: Functions to activate window, move cursor, and simulate mouse hover.
;   - Sleep: Pauses the execution to wait for UI changes.
; Return: None; interacts directly with the game's UI.
; ----------------------------------------------------------------------------------------
clickRewardsButton() {
    activateRoblox()  ; Focus on Roblox window.

    rewardsButton := COORDS["Controls"]["Rewards1"]  ; Get the rewards button coordinates.
    MouseMove rewardsButton[1], rewardsButton[2]  ; Position cursor at the rewards button.
    activateMouseHover()  ; Trigger hover effects.
    Click  ; Perform click action.

    Sleep 750  ; Delay to allow rewards menu to open.
}

; ----------------------------------------------------------------------------------------
; closeRewardsMenu Function
; Description: Closes the rewards menu by clicking the designated 'X' (close) button after activating the Roblox window.
; Operation:
;   - Activates the Roblox window.
;   - Clicks the 'X' button at the specific coordinates for the rewards menu.
; Dependencies:
;   - activateRoblox, leftClickMouseAndWait: Functions to activate window and perform a timed left click.
; Return: None; directly interacts with the game's UI to close the menu.
; ----------------------------------------------------------------------------------------
closeRewardsMenu() {
    activateRoblox()  ; Ensure the Roblox window is active.
    leftClickMouseAndWait(COORDS["RankRewards"]["X"], 250)  ; Click the close button and wait for the menu to close.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ZONE/AREA TRAVEL FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; goToSupercomputer Function
; Description: Directs the player to the Supercomputer location within the game, handling various conditions.
; Operation:
;   - Checks if the player is already at the Supercomputer and returns if true.
;   - Checks if the player has the Auto Farm gamepass and if they are not in the best zone, then moves them to the best ZONE
;   - Directs the player to the first zone if they are not already on a path towards the Supercomputer.
;   - Executes the movement towards the Supercomputer.
; Dependencies:
;   - getCurrentArea, moveBackToTheSupercomputer, getSetting, getCurrentZone, farmBestZone, moveToSupercomputer: Functions to check conditions, move to zones, and direct player movements.
; Return: None; alters the player's location within the game environment.
; ----------------------------------------------------------------------------------------
goToSupercomputer() {
    ; Check if the current area is already the Supercomputer.
    if (getCurrentArea() == "Supercomputer!") {
        moveBackToTheSupercomputer()  ; If already at the Supercomputer, adjust player's position.
        return
    }

    ; If the player has the Auto Farm gamepass.
    if (getSetting("HasGamepassAutoFarm") == "true") {
        ; Check if the player is not in the best ZONE
        if (getCurrentZone() != BEST_ZONE)
            farmBestZone()  ; Send pets to the best zone if applicable.
    }

    goToVoid()
    moveToSupercomputer()  ; Final movement towards the Supercomputer.
}

; ---------------------------------------------------------------------------------
; goToVoid Function
; Description: Ensures safe teleportation to the "Void" area in the game, handling 
;              specific conditions to avoid bugs related to hoverboard equipment.
; Operation:
;   - Checks the current zone to determine the necessary teleportation steps.
;   - Ensures the hoverboard is effectively "disabled" by first teleporting to another
;     zone if needed before heading to the Void.
;   - Executes the teleport command to the Void and updates the UI and internal states.
; Dependencies:
;   - getCurrentZone, teleportToZone, openTeleportMenu, setCurrentZone, 
;     setCurrentAction, leftClickMouseAndWait: Functions for managing game states,
;     UI interactions, and teleportation.
; Parameters:
;   - None; relies on global variables and settings to manage game navigation.
; Return: None; primarily modifies game state and UI indicators.
; ---------------------------------------------------------------------------------
goToVoid() {
    currentZone := getCurrentZone()  ; Get the name of the zone currently being occupied.

    ; If the player is already in the Void or an undefined zone, teleport to the first zone to reset.
    if (currentZone == "Void" || currentZone == "-")
        teleportToZone(BEST_ZONE)  

    ; Open the teleportation menu to navigate to the Void.
    openTeleportMenu()
    setCurrentZone("Void")  ; Update the internal state to reflect the new current ZONE
    setCurrentAction("Teleporting to the Void")  ; Display an action update to the user.

    ; Perform the final teleportation action.
    leftClickMouseAndWait(COORDS["Worlds"][3], "TeleportAfterSearchCompleted")  ; Click the Void's teleport button.
}

; ----------------------------------------------------------------------------------------
; goToVipArea Function
; Description: Navigates to the VIP area and performs actions associated with VIP access.
; Operation:
;   - Checks if the current area is already VIP, and returns if true.
;   - Verifies possession of the Auto Farm gamepass and sends pets to the best zone if not already there.
;   - Moves to the first zone, activates auto-farming, and navigates to the VIP area.
;   - Closes any open menus by toggling the auto-farm button.
;   - Uses items like flags or sprinklers in the VIP area based on user settings.
; Dependencies:
;   - getCurrentArea, getSetting, farmBestZone, goToVoid, clickAutoFarmButton, 
;     moveToVipArea, useItem: Functions that assist in checking settings, navigating, and using items.
; Return: None; modifies game state by navigating and utilizing game features.
; ----------------------------------------------------------------------------------------
goToVipArea() {
    if (getCurrentArea() == "VIP")  ; Exit if already in VIP.
        return

    goToVoid()  ; Start by going to the first ZONE
    clickAutoFarmButton()  ; Close any open menus.
    moveToVipArea()  ; Navigate to the VIP area.
    clickAutoFarmButton()  ; Close menus again.

    if (getSetting("UseFlagInVip") == "true")  ; Check for flag use setting.
        useItem("Diamonds Flag", 2)  ; Use flag if applicable.
    if (getSetting("UseSprinklerInVip") == "true")  ; Check for sprinkler use setting.
        useItem("Sprinkler", 2)  ; Use sprinkler if applicable.
}

; ----------------------------------------------------------------------------------------
; farmBestZone Function
; Description: Ensures the player is in the best zone, utilizing features like teleportation and item usage.
; Operation:
;   - Verifies if already in the best zone and uses ultimate ability if so.
;   - Teleports to the second-best zone if the current zone is unknown, then proceeds to the best ZONE
;   - Activates auto-farming, navigates to the center of the zone, and manages menu interactions.
;   - Uses flags and sprinklers in the best zone based on settings.
;   - Employs the ultimate ability to maximize effectiveness.
; Dependencies:
;   - getCurrentZone, teleportToZone, clickAutoFarmButton, moveToCentreOfTheBestZone, 
;     useItem, useUltimate: Functions that facilitate navigation, item use, and ability activation.
; Return: None; alters gameplay by optimizing player's zone positioning and item use.
; ----------------------------------------------------------------------------------------
farmBestZone() {

    if getCurrentArea() != "Best Area" {

        clickAutoFarmButton()
        if getCurrentArea() == "Best Egg"
            moveToBestAreaFromBestEgg()
        else {

            if getCurrentZone() == "-" || getCurrentZone() == BEST_ZONE
                teleportToZone(SECOND_BEST_ZONE)

            teleportToZone(BEST_ZONE)
            moveToCentreOfTheBestZone()
        }

        setCurrentArea("Best Area")
        clickAutoFarmButton()        
    }

    if (getSetting("UseFlagInBestZone") == "true") {  ; Check for flag usage setting.
        flagToUse := getSetting("FlagToUseInBestZone")
        useItem(flagToUse, 2)  ; Use the designated flag.
    }
    if (getSetting("UseSprinklerInBestZone") == "true")  ; Check for sprinkler usage setting.
        useItem("Sprinkler", 2)  ; Use a sprinkler.

    useUltimate()  ; Employ the ultimate ability.

}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; INVENTORY FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; openInventoryMenu Function
; Description: Opens the inventory menu by simulating a key press.
; Operation:
;   - Sends a keystroke to open the inventory (default key 'f').
;   - Waits for a short delay to ensure the inventory menu is fully opened.
; Dependencies:
;   - SendEvent: Sends specified keystrokes or mouse events.
;   - Wait: Pauses the script execution for a predefined time or until a certain condition is met.
; Return: None; interacts directly with the game's UI.
; ----------------------------------------------------------------------------------------
openInventoryMenu() {
    SendEvent "{f}"  ; Trigger the inventory open key.
    waitTime("InventoryAfterOpened")  ; Ensure inventory is opened.
}

; ----------------------------------------------------------------------------------------
; closeInventoryMenu Function
; Description: Closes the inventory menu by clicking the 'X' (close) button.
; Operation:
;   - Performs a left click at the 'X' button's coordinates and waits until the menu is observed to be closed.
; Dependencies:
;   - leftClickMouseAndWait: Performs a left-click and waits for a UI response.
; Return: None; directly interacts with the game's UI.
; ----------------------------------------------------------------------------------------
closeInventoryMenu() {
    leftClickMouseAndWait(COORDS["Inventory"]["X"], "InventoryAfterClosed")  ; Click to close the inventory.
}

; ----------------------------------------------------------------------------------------
; clickInventoryTab Function
; Description: Navigates to a specific tab within the inventory menu.
; Parameters:
;   - Tab: Numerical identifier of the tab (e.g., 2 for Items, 3 for Potions).
; Operation:
;   - Determines the coordinates of the specified tab.
;   - Clicks on the tab to switch to it.
; Dependencies:
;   - leftClickMouseAndWait: Performs a left-click and waits for a UI response.
; Return: None; modifies the visible inventory tab.
; ----------------------------------------------------------------------------------------
clickInventoryTab(tabToUse) {
    Switch tabToUse {
        Case 2:  ; For "Items" tab.
            inventoryTab := COORDS["Inventory"]["Items"]
        Case 3:  ; For "Potions" tab.
            inventoryTab := COORDS["Inventory"]["Potions"]
        Default:
    }
    leftClickMouseAndWait(inventoryTab, "InventoryAfterTabClicked")  ; Click the tab.
}

; ----------------------------------------------------------------------------------------
; clickInventorySearchBox Function
; Description: Clicks the search box in the inventory to enable text entry.
; Operation:
;   - Clicks the search box and waits for the UI to show it's active.
; Dependencies:
;   - leftClickMouseAndWait: Performs a left-click and waits for a UI response.
; Return: None; prepares the search box for text input.
; ----------------------------------------------------------------------------------------
clickInventorySearchBox() {
    leftClickMouseAndWait(COORDS["Inventory"]["Search"], "InventoryAfterSearchClicked")  ; Activate the search box.
}

; ----------------------------------------------------------------------------------------
; searchInventoryForItem Function
; Description: Searches for an item within the specified tab of the inventory.
; Parameters:
;   - Tab: The tab to search under (e.g., Items, Potions).
;   - Item: The name of the item to search for.
; Operation:
;   - Sends the item name to the search box.
;   - Waits for the search to complete.
;   - Optionally, could include a pixel search to verify item presence.
; Dependencies:
;   - SendText, Wait: Used for entering text and pausing execution.
; Return: Boolean indicating whether the item was found (demonstrative, depending on pixel search results).
; ----------------------------------------------------------------------------------------
searchInventoryForItem(tabToUse, itemToUse) {
    SendText(itemToUse)  ; Input the item name.
    waitTime("InventoryAfterSearchCompleted")  ; Wait for search results.
    Switch tabToUse {
        Case 2:  ; Locate first item slot under "Items".
            inventoryTab := COORDS["Inventory"]["Item1"]
        Case 3:  ; Locate first item slot under "Potions".
            inventoryTab := COORDS["Inventory"]["Potion1"]
        Default:
    }
    return !(PixelSearch(&X, &Y, inventoryTab[1], inventoryTab[2], inventoryTab[1], inventoryTab[2], 0xFFFFFF, 5))  ; Optional: Check item's presence.
}

; ----------------------------------------------------------------------------------------
; useItem Function
; Description: Manages the process of using an item from the inventory based on specified parameters.
; Parameters:
;   - itemToUse: Name or identifier of the item to be used.
;   - tabToUse: Optional, defaults to 2 (typically 'Items' tab). Tab number in the inventory where the item is located.
;   - amountToUse: Optional, defaults to 1. The number of times the item should be used.
;   - useMaxItem: Optional, defaults to false. Flag indicating whether to attempt to use the maximum amount of the item.
;   - checkForitemFound: Optional, defaults to false. Flag that determines whether to verify if the item is found during the search.
; Operation:
;   - Opens the inventory menu and navigates to the specified tab.
;   - Activates the search box and conducts a search for the specified item.
;   - Depending on the checkForitemFound flag, it checks if the item was found.
;   - If the item is found, uses the item as specified by Amount and useMaxItem.
;   - Closes the inventory and any error message windows.
;   - Resets the mouse position to the center of the screen.
; Dependencies:
;   - openInventoryMenu, clickInventoryTab, clickInventorySearchBox, searchInventoryForItem, clickItem, 
;     closeInventoryMenu, closeErrorMessageWindow, moveMouseToCentreOfScreen: Functions to manipulate UI and perform item interactions.
; Return: itemFound (boolean) indicating whether the item was successfully found and potentially used.
; ----------------------------------------------------------------------------------------
useItem(itemToUse, tabToUse := 2, amountToUse := 1, useMaxItem := false, checkForitemFound := false) {
    openInventoryMenu()  ; Open the inventory to access items.
    clickInventoryTab(tabToUse)  ; Navigate to the specified tab in the inventory.
    clickInventorySearchBox()  ; Activate the search box for item input.

    ; Conditionally search for the item and check if it's found.
    if (checkForitemFound == false) {
        searchInventoryForItem(tabToUse, itemToUse)  ; Search for the item without verification.
        isitemFound := true  ; Assume item is found if not checking.
    } else {
        isitemFound := searchInventoryForItem(tabToUse, itemToUse)  ; Search for the item and verify presence.
    }
    
    ; Use the item if it's found.
    if (isitemFound == true) {
        clickItem(tabToUse, amountToUse, useMaxItem)  ; Interact with the item based on the specified amount and max usage flag.
    }
    
    closeInventoryMenu()  ; Close the inventory after operations are complete.
    closeErrorMessageWindow()  ; Handle any potential errors by closing error messages.
    moveMouseToCentreOfScreen()  ; Re-center the mouse on the screen.
    return isitemFound  ; Return the result of the item search and use process.
}

; ----------------------------------------------------------------------------------------
; clickItem Function
; Description: Interacts with items in the inventory based on the specified tab and amount, with an option to use the maximum amount available.
; Parameters:
;   - Tab: The tab in the inventory where the item is located (e.g., 2 for "Items", 3 for "Potions").
;   - Amount: The number of times to interact with the item.
;   - UseMax: Boolean flag indicating whether to attempt using the maximum amount of the item.
; Operation:
;   - Determines the coordinates of the first item in the specified tab.
;   - If UseMax is true, attempts to use the maximum amount by right-clicking the item and reading the OCR result to find and click a 'Max' or other specified quantity button.
;   - If the maximum amount cannot be used or UseMax is false, clicks on the item the number of times specified by Amount.
; Dependencies:
;   - rightClickMouseAndWait, leftClickMouseAndWait: Functions to perform right and left mouse clicks and wait for a UI response.
;   - getOcrResult: Function to obtain OCR text from a specified screen area.
;   - OcrResult.FindString: Method to find specific strings in the OCR results.
; Return: None; modifies in-game inventory interactions based on user input.
; ----------------------------------------------------------------------------------------
clickItem(tabToUse, amountToUse, useMaxItem) {
    ; Identify first item coordinates based on inventory tab.
    Switch tabToUse {
        Case 2:  ; "Items"
            inventoryTab := COORDS["Inventory"]["Item1"]
        Case 3:  ; "Potions"
            inventoryTab := COORDS["Inventory"]["Potion1"]
        Default:
    }

    ; Initialize flag to track if maximum usage operation was performed.
    multipleItemUsed := false

    ; Handle max usage based on user input.
    if (useMaxItem) {
        rightClickMouseAndWait(inventoryTab, 200)  ; Right-click to open options for using items.
        ocrObjectResult := getOcrResult(COORDS["OCR"]["FruitMenuStart"], COORDS["OCR"]["FruitMenuSize"], 5, false)  ; Obtain text from the item menu.
        ocrTextResult := ocrObjectResult.Text

        ; Determine the highest quantity option available from OCR results.
        searchString := ""
        if InStr(ocrTextResult, "Max") {
            searchString := "Max"
        } else if InStr(ocrTextResult, "20") {
            searchString := "20"
        } else if InStr(ocrTextResult, "10") {
            searchString := "10"
        } else if InStr(ocrTextResult, "5") {
            searchString := "5"
        }
        Sleep 200
        
        ; Click the highest available quantity button if identified.
        if (searchString != "") {
            try {
                eatMaxButtonStart := ocrObjectResult.FindString(searchString)
                Sleep 200
                eatMaxButton := [COORDS["OCR"]["FruitMenuStart"][1] + eatMaxButtonStart.X + (eatMaxButtonStart.W / 2), COORDS["OCR"]["FruitMenuStart"][2] + eatMaxButtonStart.Y + (eatMaxButtonStart.H / 2)]
                leftClickMouseAndWait(eatMaxButton, 200)
                multipleItemUsed := true
            }
            catch {
                multipleItemUsed := false  ; Handle cases where the item moved or the OCR failed.
            }
        } else {
            leftClickMouseAndWait(inventoryTab, "InventoryAfterItemClicked")  ; Fallback if no max options found.
        }
    }

    ; If not using maximum amount, perform standard item click actions.
    if (!multipleItemUsed) {
        if (amountToUse == 1) {
            leftClickMouseAndWait(inventoryTab, "InventoryAfterItemClicked")  ; Single item interaction.
        } else {
            Loop amountToUse {  ; Multiple item interactions based on Amount.
                leftClickMouseAndWait(inventoryTab, "InventoryBetweenMultipleItemsUsed")
            }
        }
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; moveRight Function
; Description: Simulates moving right by pressing and holding the 'd' key.
; Parameters:
;   - milliseconds: Duration to hold the 'd' key.
; Operation:
;   - Presses and holds the 'd' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveRight(milliseconds) {
    Send "{d down}"
    Sleep milliseconds
    Send "{d up}"
}

; ----------------------------------------------------------------------------------------
; moveLeft Function
; Description: Simulates moving left by pressing and holding the 'a' key.
; Parameters:
;   - milliseconds: Duration to hold the 'a' key.
; Operation:
;   - Presses and holds the 'a' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveLeft(milliseconds) {
    Send "{a down}"
    Sleep milliseconds
    Send "{a up}"
}

; ----------------------------------------------------------------------------------------
; moveUp Function
; Description: Simulates moving up by pressing and holding the 'w' key.
; Parameters:
;   - milliseconds: Duration to hold the 'w' key.
; Operation:
;   - Presses and holds the 'w' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveUp(milliseconds) {
    Send "{w down}"
    Sleep milliseconds
    Send "{w up}"
}

; ----------------------------------------------------------------------------------------
; moveDown Function
; Description: Simulates moving down by pressing and holding the 's' key.
; Parameters:
;   - milliseconds: Duration to hold the 's' key.
; Operation:
;   - Presses and holds the 's' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveDown(milliseconds) {
    Send "{s down}"
    Sleep milliseconds
    Send "{s up}"
}

; ----------------------------------------------------------------------------------------
; moveUpLeft Function
; Description: Simulates moving diagonally up-left by pressing and holding the 'w' and 'a' keys.
; Parameters:
;   - milliseconds: Duration to hold the 'w' and 'a' keys.
; Operation:
;   - Presses and holds both the 'w' and 'a' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveUpLeft(milliseconds) {
    Send "{w down}{a down}"
    Sleep milliseconds
    Send "{w up}{a up}"
}

; ----------------------------------------------------------------------------------------
; moveUpRight Function
; Description: Simulates moving diagonally up-right by pressing and holding the 'w' and 'd' keys.
; Parameters:
;   - milliseconds: Duration to hold the 'w' and 'd' keys.
; Operation:
;   - Presses and holds both the 'w' and 'd' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveUpRight(milliseconds) {
    Send "{w down}{d down}"
    Sleep milliseconds
    Send "{w up}{d up}"
}

; ----------------------------------------------------------------------------------------
; moveDownLeft Function
; Description: Simulates moving diagonally down-left by pressing and holding the 's' and 'a' keys.
; Parameters:
;   - milliseconds: Duration to hold the 's' and 'a' keys.
; Operation:
;   - Presses and holds both the 's' and 'a' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveDownLeft(milliseconds) {
    Send "{s down}{a down}"
    Sleep milliseconds
    Send "{s up}{a up}"
}

; ----------------------------------------------------------------------------------------
; moveDownRight Function
; Description: Simulates moving diagonally down-right by pressing and holding the 's' and 'd' keys.
; Parameters:
;   - milliseconds: Duration to hold the 's' and 'd' keys.
; Operation:
;   - Presses and holds both the 's' and 'd' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ----------------------------------------------------------------------------------------
moveDownRight(milliseconds) {
    Send "{s down}{d down}"
    Sleep milliseconds
    Send "{s up}{d up}"
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TELEPORT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; openTeleportMenu Function
; Description: Opens the teleport menu by clicking a specified control.
; Operation:
;   - Performs a left click at the coordinates of the 'Teleport' button and waits until the menu is observed to be open.
; Dependencies:
;   - leftClickMouseAndWait: Function that performs a left-click and waits for a UI response.
;   - COORDS: Global variable storing coordinates for UI elements.
; Return: None; opens the teleport menu within the application.
; ----------------------------------------------------------------------------------------
openTeleportMenu() {
    leftClickMouseAndWait(COORDS["Controls"]["Teleport"], "TeleportAfterOpened")  ; Click to open the teleport menu.
}

; ----------------------------------------------------------------------------------------
; closeTeleportMenu Function
; Description: Closes the teleport menu by clicking a designated 'X' (close) button.
; Operation:
;   - Performs a left click at the coordinates of the 'X' button on the teleport menu and waits until the menu is observed to be closed.
; Dependencies:
;   - leftClickMouseAndWait: Function that performs a left-click and waits for a UI response.
;   - COORDS: Global variable storing coordinates for UI elements.
; Return: None; closes the teleport menu within the application.
; ----------------------------------------------------------------------------------------
closeTeleportMenu() {
    leftClickMouseAndWait(COORDS["Teleport"]["X"], "TeleportAfterClosed")  ; Click to close the teleport menu.
}

; ----------------------------------------------------------------------------------------
; teleportToZone Function
; Description: Teleports the player to a specified zone within Roblox by interacting with the teleport menu.
; Parameters:
;   - zoneNumber: The numerical identifier of the zone to teleport to.
; Operation:
;   - Updates the current action to reflect the teleportation process.
;   - Ensures the Roblox window is active for UI interaction.
;   - Updates the UI to show no current area and sets the current zone to the target ZONE
;   - Manages the teleport menu by closing it if open, and then reopening it.
;   - Interacts with the search box to input the zone name, which is retrieved based on zoneNumber.
;   - Simulates mouse movement and clicks to activate and select the appropriate zone option.
;   - Handles any error messages by closing them.
;   - Finally, closes the teleport menu after the action is completed.
; Dependencies:
;   - setCurrentAction, setCurrentArea, setCurrentZone, activateRoblox, closeTeleportMenu,
;     openTeleportMenu, leftClickMouseAndWait, SendText, Wait, MouseMove, activateMouseHover: Functions
;     and commands used to manipulate the UI and perform necessary actions.
; Return: None; performs complex interactions with the game UI to change zones.
; ----------------------------------------------------------------------------------------
teleportToZone(zoneNumber) {
    setCurrentAction("Teleporting to Zone " zoneNumber)  ; Update UI to show teleport action.
    writeToLogFile("  Teleporting to Zone: " zoneNumber)
    activateRoblox()  ; Ensure Roblox window is active.
    setCurrentArea("-")  ; Clear current area display.
    setCurrentZone(zoneNumber)  ; Set new zone number.
    closeTeleportMenu()  ; Ensure the teleport menu is not already open.
    openTeleportMenu()  ; Open the teleport menu.
    leftClickMouseAndWait(COORDS["Teleport"]["Search"], "TeleportAfterSearchClicked")  ; Click in the search box.
    zoneName := ZONE.Get(zoneNumber)  ; Retrieve the name of the ZONE
    SendText zoneName  ; Enter the zone name into the search.
    waitTime("TeleportAfterSearchCompleted")  ; Wait for search to process.
    MouseMove COORDS["Teleport"]["Zone"][1], COORDS["Teleport"]["Zone"][2]  ; Position cursor over the zone button.
    activateMouseHover()  ; Simulate hover to enable the button.
    leftClickMouseAndWait(COORDS["Teleport"]["Zone"], 250)  ; Click to initiate teleport.
    leftClickMouseAndWait(COORDS["Errors"]["Ok"], 200)  ; Close any error messages that might appear.
    leftClickMouseAndWait(COORDS["Teleport"]["X"], "TeleportAfterZoneClicked")  ; Close the teleport menu.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; RANK REWARDS FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; clickClaimRewardsButton Function
; Description: Activates the Roblox window and simulates a mouse click on the 'claim rewards' button.
; Operation:
;   - Activates the Roblox game window to ensure it's in focus.
;   - Performs a left-click at the specified coordinates for the rewards button and waits for a response.
; Dependencies:
;   - activateRoblox: Function to make Roblox the active window.
;   - leftClickMouseAndWait: Function that performs a left-click and pauses, waiting for UI changes.
;   - COORDS: A global variable that stores UI element coordinates.
; Return: None; directly interacts with the game UI to claim rewards.
; ----------------------------------------------------------------------------------------
clickClaimRewardsButton() {
    activateRoblox()  ; Focus on Roblox window.
    leftClickMouseAndWait(COORDS["Controls"]["Rewards2"], "RewardsAfterOpened")  ; Click on the claim rewards button.
}

; ----------------------------------------------------------------------------------------
; checkForClaimRewards Function
; Description: Checks if rewards are available to be claimed and performs actions to claim them.
; Operation:
;   - Updates the current action to "Checking For Rank Up".
;   - Retrieves the current rewards text and checks for keywords indicating rewards are claimable.
;   - If rewards are claimable, updates the action to "Claiming Rewards" and initiates reward claiming:
;       - Closes any open rewards menu.
;       - Clicks the claim rewards button.
;       - Ensures the window focus by clicking a specific heading.
;       - Claims rewards row by row, scrolling down as necessary between rows.
;       - Clicks a "Click For More" button to load more rewards if available.
;       - Finally, closes the rewards menu.
;   - Resets the current action to inactive.
; Dependencies:
;   - setCurrentAction, getRewardsText, closeRewardsMenu, clickClaimRewardsButton, 
;     leftClickMouseAndWait, claim8Rewards, scrollMouseWheel: Functions used for various tasks.
; Return: None; orchestrates UI interactions to manage reward claiming processes.
; ----------------------------------------------------------------------------------------
checkForClaimRewards() {
    setCurrentAction("Checking For Rank Up")
    rewardsText := getRewardsText()  ; Retrieve rewards text.
    if (regexMatch(rewardsText, "CLAIM|REW|ARD|MAX")) {  ; Check for claimable rewards.
        setCurrentAction("Claiming Rewards")
        closeRewardsMenu()  ; Close any rewards menu.
        clickClaimRewardsButton()  ; Initiate the claim process.
        leftClickMouseAndWait(COORDS["RankRewards"]["Heading"], 50)  ; Focus on the heading.
        ; Sequentially claim rewards from each row, scrolling as needed.
        claim8Rewards(COORDS["RankRewards"]["Button1"])
        scrollMouseWheel("{WheelDown}", 3)
        claim8Rewards(COORDS["RankRewards"]["Button9"])
        scrollMouseWheel("{WheelDown}", 3)
        claim8Rewards(COORDS["RankRewards"]["Button17"])
        scrollMouseWheel("{WheelDown}", 2)
        claim8Rewards(COORDS["RankRewards"]["Button25"])
        scrollMouseWheel("{WheelDown}", 3)
        claim8Rewards(COORDS["RankRewards"]["Button33"])
        scrollMouseWheel("{WheelDown}", 3)
        claim8Rewards(COORDS["RankRewards"]["Button41"])
        scrollMouseWheel("{WheelDown}", 3)
        claim8Rewards(COORDS["RankRewards"]["Button49"])
        scrollMouseWheel("{WheelDown}", 5)  ; Scroll to the last row.
        claim8Rewards(COORDS["RankRewards"]["ButtonLast"])
        ; Click for more rewards if applicable.
        Loop 4 {
            leftClickMouseAndWait(COORDS["RankRewards"]["ClickForMore"], 500)
        }
        closeRewardsMenu()  ; Close the rewards menu after claiming.

        writeToLogFile("**************************************************")        
        writeToLogFile("*** RANK UP ***")        
        writeToLogFile("**************************************************")        
    }
    setCurrentAction("-")  ; Reset the current action.
}

; ----------------------------------------------------------------------------------------
; claim8Rewards Function
; Description: Simulates mouse clicks to claim eight rewards arranged in two rows.
; Parameters:
;   - rewardButton: An array containing the starting X and Y coordinates for the first reward button.
; Operation:
;   - Retrieves the coordinate offsets for moving between reward buttons from a predefined structure.
;   - Loops twice to address two rows of rewards, calculating the Y coordinate for each row.
;   - For each row, loops four times to claim four rewards, calculating the X coordinate for each reward.
;   - Performs a mouse click at each calculated reward button coordinate.
;   - Includes a brief pause after each click to mimic human interaction.
; Dependencies:
;   - COORDS: Global variable storing coordinates and offsets for UI elements.
;   - SendEvent: Function used to simulate mouse clicks.
; Return: None; performs screen interactions to claim rewards.
; ----------------------------------------------------------------------------------------
claim8Rewards(rewardButton) {
    rewardButtonOffset := COORDS["RankRewards"]["Offset"]  ; Get the offset for moving between reward buttons.
    Loop 2 {  ; Loop to handle two rows of rewards.
        yOffset := rewardButtonOffset[2] * (A_Index - 1)  ; Calculate Y coordinate offset for the current row.
        yToClick := rewardButton[2] + yOffset  ; Determine the Y coordinate for the current row's rewards.
        Loop 4 {  ; Loop to handle four rewards per row.
            xOffset := rewardButtonOffset[1] * (A_Index - 1)  ; Calculate X coordinate offset for the current reward.
            xToClick := rewardButton[1] + xOffset  ; Determine the X coordinate for the current reward.
            SendEvent "{Click, " xToClick ", " yToClick ", 1}"  ; Simulate click at the reward button coordinate.
            Sleep 200  ; Pause to simulate realistic clicking speed.
        }
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HATCHING FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


hatchBestEgg(amountToHatch) {
    if getCurrentArea() != "Best Egg" {

        if getCurrentArea() == "Best Area"
            moveToBestEggFromBestArea()
        else {
            if getSetting("HasGamepassAutoFarm") == "true" {
                farmBestZone()
                moveToBestEggFromBestArea()  
            }
            else {
                if getCurrentArea() == "-"
                    teleportToZone(SECOND_BEST_ZONE)

                teleportToZone(BEST_ZONE)
                moveToBestEgg()     
            }
            Sleep 100
        }
    }

    eggsAtOnce := getSetting("EggsAtOnce")
    timesToHatch := Ceil(amountToHatch / eggsAtOnce)    
    hatchEgg(timesToHatch)
}

; ----------------------------------------------------------------------------------------
; hatchRarePetEgg Function
; Description: Handles the process of hatching rare pet eggs based on specified amounts and conditions.
; Operation:
;   - Checks if the current area is not the rare egg zone and navigates there if necessary.
;   - Calculates the number of times to hatch eggs based on the amount and a predefined rate.
;   - Hatches the rare pet eggs as per the calculated frequency.
; Dependencies:
;   - getCurrentArea, getSetting, getCurrentZone, farmBestZone, moveToRareEgg, hatchEgg: Functions to verify and change locations, retrieve settings, and manage egg hatching.
; Return: None; changes the player's location and initiates the hatching of rare pet eggs.
; ----------------------------------------------------------------------------------------
hatchRarePetEgg() {
    if (getCurrentArea() != "Rare Egg") {
        if (getSetting("HasGamepassAutoFarm") == "true") {
            if (getCurrentZone() != BEST_ZONE)
                farmBestZone()
        }
        teleportToZone(SECOND_BEST_ZONE)
        moveToRareEgg()
        applyAutoHatchSettings(true)
        Sleep 100  ; Allow a brief pause for UI updates.
    }

    timesToHatch := getSetting("NumberOfRareEggHatches")
    hatchEgg(timesToHatch)
}

; ----------------------------------------------------------------------------------------
; hatchEgg Function
; Description: Automates the process of hatching a specified number of eggs within the game.
; Operation:
;   - Closes any unnecessary open windows that could interfere with the hatching process.
;   - Iteratively sends the 'e' key event to simulate the action of hatching eggs, according to the specified amount.
;   - Uses mouse clicks to interact with the UI, specifically for buying max eggs and closing unhatched eggs.
;   - Incorporates pauses to allow for animation completion and UI updates.
;   - Invokes the use of an ultimate ability at the end of each loop if applicable.
;   - Clears the screen of any residual UI elements post-hatching by clicking on the middle of the screen.
; Dependencies:
;   - closeInventoryMenu, closeErrorMessageWindow, setCurrentAction, leftClickMouseAndWait, useUltimate: Functions to manage UI, update action statuses, and enhance gameplay interactions.
; Return: None; focuses on game UI manipulation and keyboard/mouse event simulation.
; ----------------------------------------------------------------------------------------
hatchEgg(timesToHatch) {
    closeInventoryMenu()  ; Close any potential obstructive windows.
    closeErrorMessageWindow()  ; Close any error messages that might appear.
    
    ; Loop through the specified number of Eggs.
    Loop timesToHatch {
        setCurrentAction("Hatching Eggs (" A_Index "/" timesToHatch ")")  ; Indicate current progress in hatching eggs.
        SendEvent "{e}"  ; Simulate pressing 'e' to hatch an egg.
        Sleep 400  ; Allow time for the hatching animation to complete.

        leftClickMouseAndWait(COORDS["BuyEggs"]["BuyMax"], 200)  ; Click to buy the maximum number of eggs.
        
        ; Click multiple times to close any pop-ups or unhatched eggs.
        Loop 20 {
            leftClickMouseAndWait(COORDS["Other"]["HatchSpamClick"], 100)
        }
        writeToLogFile("  Hatching Eggs (" A_Index "/" timesToHatch ")")        
        Sleep ONE_SECOND  ; Pause to allow the game interface to update.
        useUltimate()  ; Use ultimate ability if applicable during the hatching process.
    }

    ; Final cleanup click to ensure all interfaces are closed.
    Loop 20 {
        leftClickMouseAndWait(COORDS["Other"]["HatchSpamClick"], 100)
    }

    setCurrentAction("-")  ; Reset the current action status to indicate completion.
}

; ----------------------------------------------------------------------------------------
; stopHatching Function
; Description: Stops the auto-hatching process in Roblox by performing a series of UI interactions.
; Operation:
;   - Activates the Roblox window to ensure it has focus.
;   - Closes the hatching menu through a custom function.
;   - Updates the status to indicate that hatching is stopping and resets the current area.
;   - Moves the character away from eggs to prevent further automatic hatching.
;   - Clears any remaining eggs on screen by repeatedly clicking a specific coordinate.
;   - Waits to allow time for the game to process the changes.
; Dependencies:
;   - activateRoblox, closeHatchingMenu, setCurrentAction, setCurrentArea, : Custom functions for specific actions.
;   - leftClickMouse, Wait: Functions for UI interaction and timing.
; Return: None; directly manipulates game elements and UI.
; ----------------------------------------------------------------------------------------
stopHatching() {
    activateRoblox()  ; Ensure Roblox window is active.
    closeHatchingMenu()  ; Close the hatching interface.
    setCurrentAction("Stopping Hatching")  ; Update UI to reflect stopping action.
    setCurrentArea("-")  ; Reset current area information.
    ;MoveAwayFromEggs()  ; Move character to stop auto-hatching.
    Loop 75 {  ; Perform clicks to clear any remaining eggs.
        leftClickMouse(COORDS["Other"]["HatchSpamClick"])
    }
    waitTime(1500)  ; Allow time for the game to clear eggs and update.
}

; ----------------------------------------------------------------------------------------
; closeHatchingMenu Function
; Description: Closes the hatching menu by clicking the designated 'X' (close) button after activating the Roblox window.
; Operation:
;   - Activates the Roblox window.
;   - Clicks the 'X' button at the specific coordinates for the hatching menu.
; Dependencies:
;   - activateRoblox, leftClickMouseAndWait: Functions to activate window and perform a timed left click.
; Return: None; directly interacts with the game's UI to close the menu.
; ----------------------------------------------------------------------------------------
closeHatchingMenu() {
    activateRoblox()  ; Ensure the Roblox window is active.
    leftClickMouseAndWait(COORDS["BuyEggs"]["X"], 250)  ; Click the close button and wait for the menu to close.
}

; ----------------------------------------------------------------------------------------
; moveMouseToCentreOfScreen Function
; Description: Moves the mouse cursor to the center of the screen.
; Operation:
;   - Calculates the center of the screen based on screen width and height.
;   - Moves the mouse cursor to this central location.
;   - Pauses briefly to ensure the cursor movement completes.
; Dependencies:
;   - MouseMove: Function used to reposition the mouse cursor.
;   - A_ScreenWidth, A_ScreenHeight: Variables representing the dimensions of the screen.
; Return: None; modifies the position of the mouse cursor.
; ----------------------------------------------------------------------------------------
moveMouseToCentreOfScreen() {
    MouseMove A_ScreenWidth / 2, A_ScreenHeight / 2  ; Move cursor to screen center.
    Sleep 100  ; Pause to stabilize cursor position.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CAMERA FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; changeCameraView Function
; Description: Changes the camera view in Roblox to an overhead perspective if the related setting is enabled.
; Operation:
;   - Checks if the overhead camera view setting is enabled.
;   - Activates the Roblox window.
;   - Waits briefly, then clicks at the center of the screen to initiate camera movement.
;   - Adjusts the camera angle by moving the mouse downward.
;   - Clicks to finalize the upward camera movement.
;   - Waits again before zooming the camera out for a broader view.
; Dependencies:
;   - getSetting: Retrieves the value of a specified setting.
;   - activateRoblox: Activates the Roblox game window.
;   - Wait: Pauses execution for a specified duration.
;   - SendEvent, MouseMove, Click, ZoomCameraOut: Perform UI manipulations.
; Return: None; modifies the camera view in the game.
; ----------------------------------------------------------------------------------------
changeCameraView() {
    if (getSetting("CameraOverheadView") == "true") {  ; Check camera setting.
        activateRoblox()  ; Focus on Roblox window.
        waitTime(500)  ; Initial delay for window activation.
        SendEvent "{Click, " A_ScreenWidth / 2 ", " 100 ", 1, Down Right}"  ; Begin camera adjustment.
        waitTime(100)  ; Short delay before moving mouse.
        MouseMove 0, 400,, "R"  ; Adjust camera angle by moving mouse.
        Click "Up Right"  ; Confirm the camera position change.
        waitTime(500)  ; Delay before final camera adjustment.
        ZoomCameraOut(1000)  ; Zoom out for an overhead view.
    }
}

; ----------------------------------------------------------------------------------------
; ZoomCameraOut Function
; Description: Holds the 'o' key down to zoom out the camera for a specified duration.
; Parameters:
;   - milliseconds: Duration in milliseconds for which the 'o' key is held down.
; Operation:
;   - Presses and holds the 'o' key.
;   - Pauses execution for the duration specified by 'milliseconds'.
;   - Releases the 'o' key.
; Return: None; modifies the camera zoom level in an application.
; ----------------------------------------------------------------------------------------
ZoomCameraOut(milliseconds) {
    Send "{o Down}"  ; Press and hold the 'o' key.
    Sleep milliseconds  ; Wait for the specified duration.
    Send "{o Up}"  ; Release the 'o' key.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOUSE FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; leftClickMouse Function
; Description: Executes a left-click at a specified screen position.
; Parameters:
;   - Position: Can be an array with X and Y coordinates or a string key for coordinates from 'COORDS'.
; Operation:
;   - Checks if 'Position' is an object (array) or a string.
;   - Performs a left-click at the appropriate coordinates.
; Return: None; directly interacts with the UI by performing a click.
; ----------------------------------------------------------------------------------------
leftClickMouse(clickPosition) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1}"  ; Left-click using array coordinates.
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1}"  ; Left-click using named position coordinates.
}

; ----------------------------------------------------------------------------------------
; leftClickMouseAndWait Function
; Description: Executes a left-click at a specified screen position, followed by a pause.
; Parameters:
;   - Position: Can be an array with X and Y coordinates or a string key for named coordinates from 'COORDS'.
;   - Time: Duration in milliseconds to wait after the click.
; Operation:
;   - Determines if 'Position' is an object (array) or a string, and performs a left-click at the coordinates.
;   - Waits for the specified 'Time' to allow UI interactions to complete.
; Return: None; affects the UI by executing a click and delay.
; ----------------------------------------------------------------------------------------
leftClickMouseAndWait(clickPosition, timeToWait) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1}"  ; Left-click using array coordinates.
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1}"  ; Left-click using named position coordinates.
    waitTime(timeToWait)  ; Pause for specified duration.
}

; ----------------------------------------------------------------------------------------
; rightClickMouse Function
; Description: Performs a right-click at the specified position on the screen.
; Parameters:
;   - Position: An array of X and Y coordinates, or a string key to access coordinates from the 'COORDS' object.
; Operation:
;   - Determines if 'Position' is an object or a string.
;   - Executes a right-click at the resolved coordinates.
; Return: None; this function performs a UI action without returning data.
; ----------------------------------------------------------------------------------------
rightClickMouse(clickPosition) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1, Right}"  ; Right-click using direct coordinates.
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1, Right}"  ; Right-click using coordinates from 'COORDS'.
}

; ----------------------------------------------------------------------------------------
; rightClickMouseAndWait Function
; Description: Executes a right-click at a specific position and waits for a specified duration.
; Parameters:
;   - Position: Can be an array with X and Y coordinates or a key to retrieve coordinates from 'COORDS'.
;   - Time: Duration in milliseconds to wait after the click.
; Operation:
;   - Determines if 'Position' is an array or a string and performs a right-click at the coordinates.
;   - Pauses execution for the specified 'Time'.
; Return: None (affects the UI by performing click and wait operations).
; ----------------------------------------------------------------------------------------
rightClickMouseAndWait(clickPosition, timeToWait) {
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1, Right}"  ; Right-click using array coordinates.
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1, Right}"  ; Right-click using named position coordinates.
    waitTime(timeToWait)  ; Delay following the click.
}

; ----------------------------------------------------------------------------------------
; shiftLeftClickMouse Function
; Description: Performs a shift-left-click at a specified position. Useful for selection actions that require modifier keys.
; Parameters:
;   - Position: Can be an array with X and Y coordinates, or a key to retrieve coordinates from 'COORDS'.
; Operation:
;   - Holds down the shift key.
;   - Determines whether 'Position' is an object (array) or string and performs a click using appropriate coordinates.
;   - Releases the shift key.
; Return: None (directly interacts with the UI).
; ----------------------------------------------------------------------------------------
shiftLeftClickMouse(clickPosition) {
    SendEvent "{Shift down}"  ; Hold shift key.
    if IsObject(clickPosition)
        SendEvent "{Click, " clickPosition[1] ", " clickPosition[2] ", 1}"  ; Click at array coordinates.
    else
        SendEvent "{Click, " COORDS[clickPosition][1] ", " COORDS[clickPosition][2] ", 1}"  ; Click at named position coordinates.
    SendEvent "{Shift up}"  ; Release shift key.
}

; ----------------------------------------------------------------------------------------
; activateMouseHover Function
; Description: Simulates a mouse hover by briefly moving the cursor. Useful for triggering hover-sensitive UI elements.
; Operation:
;   - Pauses for 50 ms, moves the cursor by 1 pixel right and down, pauses again, moves back by 1 pixel, and final pause.
; Return: None (affects the mouse's position only)
; ----------------------------------------------------------------------------------------
activateMouseHover() {
    Sleep 50  ; Stabilizes mouse context.
    MouseMove 1, 1,, "R"  ; Move cursor right and down by 1 pixel.
    Sleep 50  ; Allows UI to react.
    MouseMove -1, -1,, "R"  ; Return cursor to original position.
    Sleep 50  ; Ensures UI updates.
}

; ----------------------------------------------------------------------------------------
; scrollMouseWheel Function
; Description: Scrolls the mouse wheel in a specified direction for a given number of increments.
; Parameters:
;   - Direction: The direction to scroll ('up' or 'down').
;   - Scrolls: The number of increments to scroll.
; Operation:
;   - Loops through the number of specified scrolls.
;   - Sends a scroll command in the given direction for each iteration.
;   - Includes a brief pause between scrolls to simulate a realistic scrolling speed.
; Return: None; directly manipulates the mouse wheel.
; ----------------------------------------------------------------------------------------
scrollMouseWheel(scrollDirection, timesToScroll) {
    Loop timesToScroll {  ; Repeat scroll for the number of specified increments.
        Send scrollDirection  ; Send scroll command in the specified direction.
        Sleep 50  ; Short pause to mimic natural scrolling behavior.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HOVERBOARD FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; clickHoverboard Function
; Description: Manages the activation or deactivation of a hoverboard in a UI, depending on the startRiding state.
; Parameters:
;   - startRiding: A boolean indicating whether the hoverboard is currently active (true) or inactive (false).
; Operation:
;   - If startRiding is true, performs a left click at the hoverboard control's position and waits for a specific UI response.
;   - If startRiding is false, performs a left click at the hoverboard control's position and waits 200 ms.
; Return: None (executes actions based on the startRiding status)
; ----------------------------------------------------------------------------------------
clickHoverboard(startRiding := true) {
    if (startRiding == true)
        leftClickMouseAndWait(COORDS["Controls"]["Hoverboard"], "HoverboardAfterEquipped")  ; Activates the hoverboard.
    else
        leftClickMouseAndWait(COORDS["Controls"]["Hoverboard"], 200)  ; Deactivates the hoverboard.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OCR FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; getOcrResult Function
; Description: Performs OCR on a specified rectangular area of the screen and returns the extracted text.
; Operation:
;   - Calculates the end coordinates based on start position and size.
;   - Optionally, draws a visual border around the OCR area if enabled via settings.
;   - Performs OCR on the defined area and scales it as specified.
;   - Removes the visual border after OCR if it was added.
; Dependencies:
;   - OCR: A library or function capable of optical character recognition.
;   - Pin, Wait, Destroy: Functions or methods uesed for drawing and managing visual cues.
; Parameters:
;   - Start: Starting coordinates of the OCR area.
;   - Size: Width and height of the OCR area.
;   - Scale: Scale factor for the OCR operation.
; Return: String; the text extracted from the specified screen area.
; ----------------------------------------------------------------------------------------
getOcrResult(ocrStart, ocrSize, ocrScale, returnText := true) {
    ocrEnd := [ocrStart[1] + ocrSize[1], ocrStart[2] + ocrSize[2]]  ; Calculate end coordinates for OCR.

    if (SHOW_OCR_OUTLINE == "true") {
        ocrBorder := Pin(ocrStart[1], ocrStart[2], ocrEnd[1], ocrEnd[2], 500, "b3 flash0") ; Draw a border around the OCR area for visual feedback.
        waitTime("QuestAfterOcrBorderDrawn")  ; Wait for the border to be visually confirmed.
    }

    ocrObjectResult := OCR.FromRect(ocrStart[1], ocrStart[2], ocrSize[1], ocrSize[2], , ocrScale)  ; Perform OCR on the specified rectangular area with the given scale.

    if (SHOW_OCR_OUTLINE == "true") {
        ocrBorder.Destroy() ; Remove the drawn border after OCR is complete.
    }

    if (returnText)
        return ocrObjectResult.Text  ; Return the text result of the OCR.
    else
        return ocrObjectResult  ; Return the object result of the OCR.
} 

; ----------------------------------------------------------------------------------------
; readStackAmount Function
; Description: Reads the amount of a stack from a specified area on the screen using OCR and returns it as an integer.
; Operation:
;   - Uses OCR to extract text from a defined rectangular area.
;   - Filters the OCR result to retain only digit characters, representing the stack amount.
;   - Converts the filtered result to an integer, defaulting to zero if no digits are found.
;   - Includes a brief pause to allow the UI to stabilize if needed before proceeding.
; Dependencies:
;   - OCR: A library or function capable of optical character recognition.
;   - RegExReplace: A function to perform regular expression operations.
; Parameters:
;   - Start: Starting coordinates of the OCR area.
;   - Size: Width and height of the OCR area.
; Return: Integer; the amount of the stack extracted from the screen.
; ----------------------------------------------------------------------------------------
readStackAmount(ocrStart, ocrSize) {
    ocrObjectResult := OCR.FromRect(ocrStart[1], ocrStart[2], ocrSize[1], ocrSize[2], , 40)  ; Perform OCR on the specified area and scale the readability.
    stackAmount := RegExReplace(ocrObjectResult.Text, "\D", "")  ; Use regular expressions to filter out non-digit characters from the OCR result.
    stackAmount := (stackAmount = "") ? 0 : stackAmount  ; Convert the filtered string to an integer. If the string is empty (no digits), return zero.
    Sleep 200  ; Brief pause to ensure UI stability after reading.
    return stackAmount  ; Return the numeric stack amount.
}

; ----------------------------------------------------------------------------------------
; getRewardsText Function
; Description: Activates the Roblox window and retrieves text using OCR from a specified screen area.
; Operation:
;   - Activates the Roblox window to ensure it is in focus for accurate OCR.
;   - Uses OCR to capture text from a defined area specified by starting coordinates and size.
; Dependencies:
;   - activateRoblox: Ensures Roblox is the active window.
;   - getOcrResult: Performs OCR on a specified area of the screen.
;   - COORDS: A data structure that holds coordinates used for OCR.
; Return: Returns the captured text as a string, often used to interpret rewards or rank information.
; ----------------------------------------------------------------------------------------
getRewardsText() {
    activateRoblox()  ; Focus on Roblox window for accurate text capture.
    return getOcrResult(COORDS["OCR"]["RankUpStart"], COORDS["OCR"]["RankUpSize"], 20)  ; Retrieve text via OCR from the specified area.
}

; ----------------------------------------------------------------------------------------
; checkForDisconnect Function
; Description: Uses OCR to detect disconnection messages within the Roblox game interface.
; Operation:
;   - Activates the Roblox window to ensure it's in focus.
;   - Uses OCR to read the specified screen area for disconnection keywords.
; Dependencies:
;   - activateRoblox, getOcrResult: Functions to focus window and perform OCR.
; Return: Boolean; true if disconnected, false otherwise.
; ----------------------------------------------------------------------------------------
checkForDisconnect() {
    activateRoblox()  ; Focus the Roblox window.
    ocrTextResult := getOcrResult(COORDS["OCR"]["DisconnectMessageStart"], COORDS["OCR"]["DisconnectMessageSize"], 20)  ; Get OCR results.
    return (regexMatch(ocrTextResult, "Disconnected|Reconnect|Leave"))  ; Check for disconnection phrases.
}

; ----------------------------------------------------------------------------------------
; areFreeGiftsReady Function
; Description: Checks if free gifts are ready to be claimed based on OCR results.
; Operation:
;   - Performs OCR to read the free rewards area and checks for the 'ready' indication.
; Dependencies:
;   - getOcrResult, regexMatch: Functions to obtain OCR results and match patterns.
; Return: Boolean indicating whether free gifts are ready to be claimed.
; ----------------------------------------------------------------------------------------
areFreeGiftsReady() {
    ocrTextResult := getOcrResult(COORDS["OCR"]["FreeRewardsReadyStart"], COORDS["OCR"]["FreeRewardsReadySize"], 20)
    return (regexMatch(ocrTextResult, "i)ready")) ; Returns true if 'ready' is found in the OCR results.
}

; ----------------------------------------------------------------------------------------
; checkForMaxRank Function
; Description: Checks if the player has reached the maximum rank in Roblox.
; Operation:
;   - Activates the Roblox window and retrieves the current rewards text.
;   - Checks for the presence of "MAX" in the rewards text to determine rank status.
; Dependencies:
;   - activateRoblox, getRewardsText: Functions to focus window and retrieve text.
; Return: None; optionally pauses the script if max rank is reached.
; ----------------------------------------------------------------------------------------
checkForMaxRank() {
    activateRoblox()  ; Focus the Roblox window.
    rewardsText := getRewardsText()  ; Retrieve rewards text.

    if (regexMatch(rewardsText, "MAX")) {
        MsgBox "Maximum rank already."  ; Notify user of max rank.
        pause  ; Pause script execution.
    }
}

; ---------------------------------------------------------------------------------
; fixAmount Function
; Description: Corrects OCR text extraction errors for specific quest readings, ensuring accurate numerical extraction.
;              It also handles special cases such as misreadings or shorthand notations like "k" for thousands.
; Parameters:
;   - ocrTextResult: The string result from OCR that may contain numeric and non-numeric characters.
;   - questId: The identifier for the quest, used to apply quest-specific corrections.
; Returns: The corrected numeric amount. If the OCR result is unusable, returns 1 as a default.
; ---------------------------------------------------------------------------------
fixAmount(ocrTextResult, questId) {
    ; Apply a specific correction for the "Hatch Rare Pets" quest where OCR may misread text.
    if (questId == "42") ; Check if it's the "Hatch Rare Pets" quest
        ocrTextResult := RegExReplace(ocrTextResult, '".*?"', "")  ; Remove any quoted text that might be OCR artifacts

    ; Remove all non-digit characters from the OCR result to ensure only numerical data is left.
    ocrAmount := RegExReplace(ocrTextResult, "[^\d.]", "")
    
    ; If the cleaning results in an empty string (no numbers were found), return 1 as a default amount.
    if (ocrAmount == "")
        return 1

    ; Check if the OCR result includes shorthand for thousands, e.g., "1.5k" should be converted to 1500.
    hasThousandsShorthand := regexMatch(ocrTextResult, "\b\d+(\.\d+)?k\b")
    if hasThousandsShorthand
        ocrAmount *= 1000  ; Multiply the amount by 1000 if 'k' is found to reflect the correct number

    if IsNumber(ocrAmount)
        return Round(ocrAmount, 0)  ; Return the corrected amount as a number
    else
        return 1
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ROBLOX CLIENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; activateRoblox Function
; Description: Activates the Roblox game window, ensuring it's the current foreground application.
; Operation:
;   - Attempts to activate the Roblox window using its executable name.
;   - If the window cannot be found, displays an error message and exits the application.
;   - Waits for a predefined delay after successful activation to stabilize the environment.
; Dependencies:
;   - WinActivate: AHK command to focus a window based on given criteria.
;   - MsgBox ExitApp: Functions to handle errors and exit.
;   - Wait: Function to pause the script, ensuring timing consistency.
; Return: None; the function directly interacts with the system's window management.
; ----------------------------------------------------------------------------------------
activateRoblox() {
    try {
        WinActivate "ahk_exe RobloxPlayerBeta.exe"  ; Try to focus on Roblox window.
    } catch {
        MsgBox "Roblox window not found."  ; Error message if window is not found.
        ExitApp  ; Exit the script.
    }
    waitTime("AfterRobloxActivated")  ; Delay for stabilization after activation.
}

; ----------------------------------------------------------------------------------------
; ChangeToFullscreen Function
; Description: Toggles the Roblox game window to full screen mode if not already.
; Operation:
;   - Checks current window size against the screen resolution and sends F11 if not full screen.
; Dependencies: None.
; Return: None; alters the window state of the game.
; ----------------------------------------------------------------------------------------
ChangeToFullscreen() {
    WinGetPos &X, &Y, &W, &H, "ahk_exe RobloxPlayerBeta.exe"  ; Get current window position.
    if (H != A_ScreenHeight) {
        Send "{F11}"  ; Toggle full screen.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; getCurrentQuest Function
; Description: Retrieves the displayed quest information from a designated cell in a ListView control.
; Operation:
;   - Fetches the text from the first row and fourth column of the ListView, indicating the current quest.
; Dependencies:
;   - lvCurrent.GetText: Method used to get text from specified cells in a ListView control.
; Return: Returns the quest text as a string, reflecting the current quest status or task.
; ----------------------------------------------------------------------------------------
getCurrentQuest() {
    return lvCurrent.GetText(1, 4)  ; Return text from the first row, fourth column.
}

; ----------------------------------------------------------------------------------------
; getCurrentArea Function
; Description: Retrieves the displayed area information from a specific cell in a ListView control.
; Operation:
;   - Fetches the text from the first row and third column of the ListView, which holds the current area information.
; Dependencies:
;   - lvCurrent.GetText: Method used to get text from specified cells in a ListView control.
; Return: Returns the area text as a string, providing current context or location.
; ----------------------------------------------------------------------------------------
getCurrentArea() {
    return lvCurrent.GetText(1, 3)  ; Return text from the first row, third column.
}

; ----------------------------------------------------------------------------------------
; getCurrentZone Function
; Description: Retrieves the displayed zone information from a ListView control.
; Operation:
;   - Fetches the text from the first row and second column of the ListView, which holds the current zone information.
; Dependencies:
;   - lvCurrent.GetText: Method used to get text from specified cells in a ListView control.
; Return: Returns the zone text as a string.
; ----------------------------------------------------------------------------------------
getCurrentZone() {
    return lvCurrent.GetText(1, 2)  ; Return text from the first row, second column.
}

; ----------------------------------------------------------------------------------------
; getCurrentLoop Function
; Description: Retrieves the displayed quest information from a designated cell in a ListView control.
; Operation:
;   - Fetches the text from the first row and first column of the ListView, indicating the current quest.
; Dependencies:
;   - lvCurrent.GetText: Method used to get text from specified cells in a ListView control.
; Return: Returns the quest text as a string, reflecting the current quest status or task.
; ----------------------------------------------------------------------------------------
getCurrentLoop() {
    return lvCurrent.GetText(1, 1)  ; Return text from the first row, first column.
}


; ----------------------------------------------------------------------------------------
; setCurrentLoop Function
; Description: Updates the displayed loop number in a specific UI element to reflect the current iteration.
; Parameters:
;   - loopNumber: The current loop number to display, usually an integer.
; Operation:
;   - Modifies the text of the first row in a ListView control to show the new loop number.
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated loop number.
; ----------------------------------------------------------------------------------------
setCurrentLoop(loopNumber) {
    lvCurrent.Modify(1, , loopNumber)  ; Modify the first row to display the new loop number.
}

; ----------------------------------------------------------------------------------------
; setCurrentZone Function
; Description: Updates the displayed zone in a specific UI element to reflect changes or current status.
; Parameters:
;   - Zone: The new zone to display, typically a string representing the geographic or contextual area.
; Operation:
;   - Modifies the text of the first row in a ListView control to show the updated ZONE
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated zone information.
; ----------------------------------------------------------------------------------------
setCurrentZone(currentZone) {
    lvCurrent.Modify(1, , , currentZone)  ; Modify the first row to display the new ZONE
}

; ----------------------------------------------------------------------------------------
; setCurrentArea Function
; Description: Updates the displayed area in a specific UI element to reflect the current location or context.
; Parameters:
;   - Area: The new area to display, typically a string representing the location or context.
; Operation:
;   - Modifies the text of the first row in a ListView control to show the new area.
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated area information.
; ----------------------------------------------------------------------------------------
setCurrentArea(currentArea) {
    lvCurrent.Modify(1, , , , currentArea)  ; Modify the first row to display the new area.
}

; ----------------------------------------------------------------------------------------
; setCurrentQuest Function
; Description: Updates the displayed quest in a specific UI element to reflect the current quest status.
; Parameters:
;   - Quest: The new quest to display, usually a string describing the ongoing quest.
; Operation:
;   - Modifies the text of the first row in a ListView control to show the new quest.
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated quest information.
; ----------------------------------------------------------------------------------------
setCurrentQuest(currentQuest) {
    lvCurrent.Modify(1, , , , , currentQuest)  ; Modify the first row to display the new quest.
}

; ----------------------------------------------------------------------------------------
; setCurrentAction Function
; Description: Updates the displayed action in a specific UI element to reflect current activities.
; Parameters:
;   - Action: The new action to display, typically a string describing the current activity.
; Operation:
;   - Modifies the text of a specified row in a ListView control to show the new action.
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated action.
; ----------------------------------------------------------------------------------------
setCurrentAction(currentAction) {
    lvCurrent.Modify(1, , , , , , currentAction)  ; Modify the first row to display the new action.
}

; ----------------------------------------------------------------------------------------
; setCurrentTime Function
; Description: Updates the displayed time in a specific UI element.
; Parameters:
;   - Time: The new time to display, typically a string.
; Operation:
;   - Modifies the text of a specified row in a ListView control to reflect the new time.
; Dependencies:
;   - lvCurrent.Modify: A method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated time.
; ----------------------------------------------------------------------------------------
setCurrentTime(currentTime) {
    lvCurrent.Modify(1, , , , , , , currentTime)  ; Modify the first row to display the new time.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; SETTINGS.INI FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; getSetting Function
; Description: Retrieves a setting value from an INI file based on a given key.
; Parameters:
;   - Key: The setting key whose value is to be retrieved.
; Operation:
;   - Reads the value associated with the specified key from a designated INI file section.
; Dependencies:
;   - IniRead: Function used to read data from an INI file.
;   - SETTINGS_INI: Global variable specifying the path to the INI file.
; Return: The value of the specified setting key, returned as a string.
; ----------------------------------------------------------------------------------------
getSetting(keyName) {
    return IniRead(SETTINGS_INI, "Settings", keyName)  ; Read and return the setting value from the INI file.
}

; ----------------------------------------------------------------------------------------
; putSetting Function
; Description: Writes a setting value to an INI file under a specified key.
; Parameters:
;   - Value: The value to be written to the INI file.
;   - Key: The setting key under which the value is to be stored.
; Operation:
;   - Writes the specified value under the specified key in a designated INI file section.
; Dependencies:
;   - IniWrite: Function used to write data to an INI file.
;   - SETTINGS_INI: Global variable specifying the path to the INI file.
; Return: None; modifies the INI file by updating the setting.
; ----------------------------------------------------------------------------------------
putSetting(keyValue, keyName) {
    IniWrite keyValue, SETTINGS_INI, "Settings", keyName  ; Write the specified value under the given key in the INI file.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO SETTINGS/FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; completeInitialisationTasks Function
; Description: Performs a series of initialization tasks to set up the Roblox game environment.
; Operation:
;   - Updates the system tray icon to a custom one.
;   - Activates the Roblox window to ensure it's in focus.
;   - Changes the game window to full screen if not already.
;   - Replaces default Roblox fonts with custom ones for better readability.
;   - Defines hotkeys for macro controls.
; Dependencies:
;   - updateTrayIcon, activateRoblox, ChangeToFullscreen, replaceRobloxFonts, defineHotKeys: Functions to adjust UI elements and settings.
; Return: None; performs setup operations only.
; ----------------------------------------------------------------------------------------
completeInitialisationTasks() {
    updateTrayIcon()
    activateRoblox()
    ChangeToFullscreen()
    replaceRobloxFonts()
    defineHotKeys()
}

; ----------------------------------------------------------------------------------------
; defineHotKeys Function
; Description: Sets up hotkeys for controlling macros based on user settings.
; Operation:
;   - Retrieves hotkey settings and binds them to macro control functions.
; Dependencies: getSetting: Retrieves user-configured hotkey preferences.
; Return: None; configures hotkeys for runtime use.
; ----------------------------------------------------------------------------------------
defineHotKeys() {
    HotKey getSetting("pauseMacroKey"), pauseMacro  ; Bind pause macro hotkey.
    HotKey getSetting("exitMacroKey"), exitMacro  ; Bind exit macro hotkey.
}

; ----------------------------------------------------------------------------------------
; updateTrayIcon Function
; Description: Sets a custom icon for the application in the system tray.
; Operation:
;   - Composes the file path for the icon and sets it as the tray icon.
; Dependencies: None.
; Return: None; changes the tray icon appearance.
; ----------------------------------------------------------------------------------------
updateTrayIcon() {
    iconFile := A_WorkingDir . "\Assets\PS99_Ranks.ico"  ; Set the tray icon file path.
    TraySetIcon iconFile  ; Apply the new tray icon.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OTHER FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; Wait Function
; Description: Pauses script execution for a specified duration.
; Parameters:
;   - Time: Can be a direct integer value (milliseconds) or a string key to retrieve a predefined delay from 'Delay'.
; Operation:
;   - Determines if 'Time' is an integer or a string and pauses execution accordingly.
; Return: None; affects script timing by introducing a delay.
; ----------------------------------------------------------------------------------------
waitTime(timeToWait) {
    newWaitTime := IsInteger(timeToWait) ? timeToWait : Delay[timeToWait]

    if (newWaitTime > ONE_SECOND) {
        totalSeconds := Ceil(newWaitTime / 1000)  ; Calculate breaking duration.
        setCurrentTime(totalSeconds)  ; Set initial countdown timer.
        Loop totalSeconds {
            setCurrentTime(totalSeconds - A_Index)  ; Update the countdown timer.
            Sleep ONE_SECOND  ; Wait one second.
        }        
    }
    else
        Sleep newWaitTime  ; Pause execution for 'Time' milliseconds or predefined 'Delay'.

}

; ----------------------------------------------------------------------------------------
; changeToDefaultFont Function
; Description: Copies specific font files to the Roblox font directory to update the default fonts.
; Operation:
;   - Copies the 'FredokaOne-Regular.ttf' font file to the Roblox font path.
;   - Copies the 'SourceSansPro-Bold.ttf' font file to the Roblox font path.
; Parameters:
;   - *: Indicates the function may potentially accept parameters, though not used here.
; Dependencies:
;   - FREDOKA_ONE_REGULAR, SOURCE_SANS_PRO_BOLD: Global variables holding the paths to the font files.
;   - g_robloxFontPath: Global variable holding the path to the Roblox font directory.
;   - FileCopy: Function used to copy files.
; Return: None; modifies the file system by updating font files in Roblox directory.
; ----------------------------------------------------------------------------------------
changeToDefaultFont(*) {
    robloxFontPath := StrReplace(WinGetProcessPath("ahk_exe RobloxPlayerBeta.exe"), "RobloxPlayerBeta.exe", "") "content\fonts\"  ; Path to Roblox fonts directory.
    FileCopy FREDOKA_ONE_REGULAR, robloxFontPath "FredokaOne-Regular.ttf", true  ; Copy Fredoka One font.
    FileCopy SOURCE_SANS_PRO_BOLD, robloxFontPath "SourceSansPro-Bold.ttf", true  ; Copy Source Sans Pro Bold font.
}

; ----------------------------------------------------------------------------------------
; replaceRobloxFonts Function
; Description: Replaces default Roblox fonts with the Times New Roman font for consistent text rendering.
; Operation:
;   - Copies the Times New Roman font file to overwrite the 'FredokaOne-Regular.ttf' and 'SourceSansPro-Bold.ttf' files in the Roblox font directory.
; Dependencies:
;   - FileCopy: Function used to copy files.
;   - TIMES_NEW_ROMAN, g_robloxFontPath: Global variables specifying the source font file and the destination font path.
; Return: None; updates the file system by copying font files.
; ----------------------------------------------------------------------------------------
replaceRobloxFonts() {
    robloxFontPath := StrReplace(WinGetProcessPath("ahk_exe RobloxPlayerBeta.exe"), "RobloxPlayerBeta.exe", "") "content\fonts\"  ; Path to Roblox fonts directory.
    FileCopy TIMES_NEW_ROMAN, robloxFontPath "FredokaOne-Regular.ttf", true  ; Replace 'FredokaOne-Regular' with Times New Roman.
    FileCopy TIMES_NEW_ROMAN_INVERTED, robloxFontPath "SourceSansPro-Bold.ttf", true  ; Replace 'SourceSansPro-Bold' with Times New Roman (Inverted).
}

; ----------------------------------------------------------------------------------------
; closeErrorMessageWindow Function
; Description: Ensures that any error message windows are closed by clicking the close button.
; Operation:
;   - Loops twice to click on the close button of the error message window, addressing any delays in closure or reappearances.
;   - Includes a short delay after the last click to ensure the window has time to close.
; Dependencies:
;   - leftClickMouseAndWait: Function that performs a left-click on a specified coordinate and waits for a set duration.
;   - Wait: Function to pause the script execution for a predefined time or until a certain condition is met.
; Return: None; directly interacts with the UI to close error messages.
; ----------------------------------------------------------------------------------------
closeErrorMessageWindow() {
    Loop 2 {  ; Attempt to close the error message window twice in case it persists or reopens.
        leftClickMouseAndWait(COORDS["Errors"]["X"], 50)  ; Click the close button of the error message.
    }
    waitTime("ErrorAfterClosed")  ; Wait for a brief period to confirm the window is closed.
}

; ---------------------------------------------------------------------------------
; writeToLogFile Function
; Description: Appends a log message to a daily log file, prefixing it with a timestamp.
; Operation:
;   - Generates a timestamp for the exact moment the function is called.
;   - Formats the log message to include this timestamp.
;   - Determines the filename of the log based on the current date.
;   - Appends the formatted message to the appropriate log file, creating a new file each day.
; Dependencies:
;   - FileAppend: AHK function used to append text to a file.
;   - FormatTime: AHK function used to format the date and time.
; Parameters:
;   - LogMessage: The message to be logged. This should be a string.
; Return: None; the function outputs directly to a log file.
; ---------------------------------------------------------------------------------
writeToLogFile(logMessage) {
    logDateTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")  ; Capture the current date and time formatted as "Year-Month-Day Hours:Minutes:Seconds".
    formattedMessage := "[" logDateTime "]   " logMessage "`n"  ; Construct the log message by prefixing it with the timestamp and enclosing it in brackets.

    try
        logFile := LOG_FOLDER DATE_TODAY ".log"  ; Define the log file path using the global log directory and current date, appending ".log" to make it a log file.
    FileAppend formattedMessage, logFile  ; Append the formatted message to the log file, automatically creating the file if it doesn't exist.
}