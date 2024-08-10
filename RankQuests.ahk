#Requires AutoHotkey v2.0  ; Ensures the script runs only on AutoHotkey version 2.0, which supports the syntax and functions used in this script.

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; RANK QUEST - AutoHotKey 2.0 Macro for Pet Simulator 99
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; DIRECTIVES & CONFIGURATIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

#SingleInstance Force  ; Forces the script to run only in a single instance. If this script is executed again, the new instance will replace the old one.
CoordMode "Mouse", "Client"  ; Sets the coordinate mode for mouse functions (like Click, MouseMove) to be relative to the active window's client area, ensuring consistent mouse positioning across different window states.
CoordMode "Pixel", "Client"  ; Sets the coordinate mode for pixel functions (like PixelSearch, PixelGetColor) to be relative to the active window's client area, improving accuracy in color detection and manipulation.
SetMouseDelay 10  ; Sets the delay between mouse events to 10 milliseconds, balancing speed and reliability of automated mouse actions.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Titles and versioning for GUI elements.
MACRO_TITLE := "Rank Quests"  ; The title displayed in main GUI elements.
MACRO_VERSION := "1.0.0 (Test Build 2)"  ; Script version, helpful for user support and debugging.
LOG_FOLDER := A_ScriptDir "\Logs\"  ; Path to the README file, provides additional information to users.
DATE_TODAY := FormatTime(A_Now, "yyyyMMdd")

; Mathematics and constants.
RADIUS := 100  ; Standard radius used for calculations in positioning or graphics.
PI := 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679  ; Mathematical constant Pi, crucial for circular calculations.
ONE_SECOND := 1000  ; Number of milliseconds in one second, used for timing operations.

; Zone settings defining game areas.
BEST_ZONE := 219  ; Identifier for the best zone, typically where optimal actions occur.
SECOND_BEST_ZONE := 218  ; Identifier for the second-best ZONE
RARE_EGG_ZONE := 209
USE_FLAG_ZONES := [200, 201, 202, 203, 204]  ; Define the zones where flags will be used.

; Font settings for GUI and other text displays.
TIMES_NEW_ROMAN := A_ScriptDir "\Assets\TimesNewRoman.ttf"  ; Path to Times New Roman font.
TIMES_NEW_ROMAN_INVERTED := A_ScriptDir "\Assets\TimesNewRoman-Inverted.ttf"  ; Path to Times New Roman font (inverted).
FREDOKA_ONE_REGULAR := A_ScriptDir "\Assets\FredokaOne-Regular.ttf"  ; Path to Fredoka One Regular font.
SOURCE_SANS_PRO_BOLD := A_ScriptDir "\Assets\SourceSansPro-Bold.ttf"  ; Path to Source Sans Pro Bold font.

; User settings loaded from an INI file.
SETTINGS_INI := A_ScriptDir "\Settings.ini"  ; Path to settings INI file.
DARK_MODE := getSetting("DarkMode")  ; User preference for dark mode, loaded from settings.
SHOW_OCR_OUTLINE := getSetting("ShowOcrOutline")  ; User preference for displaying OCR outlines.

; Pixel colours for the Supercomputer menus.
UPGRADE_POTIONS_BUTTON := ["0x281759", "0x0CC60F"]
UPGRADE_ENCHANTS_BUTTON := ["0xFADB35", "0x810606"]
GOLD_PETS_BUTTON := ["0xFFFFC8", "0xC98151"]
RAINBOW_PETS_BUTTON := ["0xF4D200", "0x1EFB01"]

; Pixel colours for the close icon for each of the user interface windows.
ERROR_WINDOW_X := Map("Start", [603, 109], "End", [603, 109], "Colour", "0xFF155F", "Tolerance", 2)
INVENTORY_MENU_X := Map("Start", [730, 109], "End", [730, 109], "Colour", "0xFF155F", "Tolerance", 2)
REWARDS_MENU_X := Map("Start", [730, 109], "End", [730, 109], "Colour", "0xFF155F", "Tolerance", 2)
FREE_GIFTS_MENU_X := Map("Start", [608, 109], "End", [608, 109], "Colour", "0xFF155F", "Tolerance", 2)
TELEPORT_MENU_X := Map("Start", [725, 109], "End", [725, 109], "Colour", "0xFF155F", "Tolerance", 2)
HATCHING_MENU_X := Map("Start", [614, 109], "End", [614, 109], "Colour", "0xFF155F", "Tolerance", 2)
AUTOHATCH_MENU_X := Map("Start", [605, 109], "End", [605, 109], "Colour", "0xFF155F", "Tolerance", 2)
SUPERCOMPUTER_MENU_X := Map("Start", [730, 109], "End", [730, 109], "Colour", "0xFF155F", "Tolerance", 2)

; Pixel colours for other checks.
CHAT_ICON_WHITE := Map("Start", [81, 24], "End", [81, 24], "Colour", "0xFFFFFF", "Tolerance", 2)
LEADERBOARD_RANK_STAR := Map("Start", [652, 43], "End", [678, 59], "Colour", "0xB98335", "Tolerance", 50)
OOPS_ERROR_QUESTION_MARK := Map("Start", [434, 287], "End", [438, 291], "Colour", "0xFFB436", "Tolerance", 5)
ITEM_MISSING := Map("Start", [293, 425], "End", [293, 425], "Colour", "0xA51116", "Tolerance", 5)
CLAIM_BUTTON_SHADOW := Map("Start", [294, 113], "End", [747, 469], "Colour", "0x6E864D", "Tolerance", 2)
INVENTORY_BUTTON := Map("Start", [384, 505], "End", [384, 505], "Colour", "0x15DECF", "Tolerance", 2)
ZONE_SEARCH := Map("Start", [437, 243], "End", [437, 243], "Colour", "0x5BDBFF", "Tolerance", 2)
HATCHING_MENU_BUY := Map("Start", [191, 451], "End", [191, 451], "Colour", "0x6BF206", "Tolerance", 2)
FREE_GIFTS_READY := Map("Start", [67, 172], "End", [67, 172], "Colour", "0xFF0948", "Tolerance", 2)
AUTO_HATCH_MENU := Map("Start", [439, 155], "End", [604, 438], "Colour", "0x6FF308", "Tolerance", 2)
SKILL_MASTERY := Map("Start", [88, 309], "End", [88, 309], "Colour", "0xFFFFFF", "Tolerance", 2)

; Pixel colours for droppable boosts.
LUCKY_BLOCK_PINK := Map("Start", [140, 0], "End", [660, 400], "Colour", "0xEFB4FB", "Tolerance", 2)
LUCKY_BLOCK_BLUE := Map("Start", [140, 280], "End", [660, 400], "Colour", "0x00ACFF", "Tolerance", 2)        
LUCKY_BLOCK_YELLOW := Map("Start", [140, 280], "End", [660, 400], "Colour", "0xFFA300", "Tolerance", 2)  
COMET_COLOUR := Map("Start", [140, 280], "End", [660, 400], "Colour", "0x00A6FB", "Tolerance", 2)
PINATA_COLOUR := Map("Start", [140, 200], "End", [660, 400], "Colour", "0xFF00FF", "Tolerance", 2)

; OCR Text Render display.
OCR_RESULTS_RENDER := TextRender()

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; LIBRARIES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Third-party Libraries:
#Include <OCR>        ; Includes an Optical Character Recognition library for extracting text from images.
#Include <Pin>        ; Includes a library for creating pinned overlays or highlights on the screen, enhancing visual interfaces.
#Include <JXON>       ; Includes a library for handling JSON data, useful for configuration and data management tasks.
#Include <DarkMode>   ; Includes a library to support dark mode functionality, improving UI aesthetics and reducing eye strain.
#Include <TextRender> ; Includes a library to render text to the screen.

; Macro Related Libraries:
#Include "%A_ScriptDir%\Modules"    ; Includes all scripts located in the 'Modules' directory relative to the script's directory.
#Include "Coords.ahk"               ; Includes a script defining coordinates for GUI elements, useful for automation tasks.
#Include "Delays.ahk"               ; Includes a script that defines various delay times for operations, ensuring timing accuracy.
#Include "Movement.ahk"             ; Includes a script managing movement or navigation automation within the application.
#Include "Quests.ahk"               ; Includes a script that handles quest-related data and operations.
#Include "Zones.ahk"                ; Includes a script that defines different game zones or areas, used in navigation and contextual actions.
#Include "Ranks.ahk"                ; Includes a script that defines different game ranks.

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

runMacro()

; ----------------------------------------------------------------------------------------
; runMacro Function
; Description: Executes the main macro loop, performing initial setup tasks, running tests, and continuously checking for key game conditions and quest priorities.
; Operation:
;   - Performs initial setup tasks and environment preparation.
;   - Writes a start log entry.
;   - Displays a GUI for quest management.
;   - Activates the Roblox window for reliable input.
;   - Runs preliminary tests.
;   - Continuously checks for disconnection to ensure ongoing functionality.
;   - Closes unnecessary windows.
;   - Checks if the player has reached the maximum rank.
;   - Prioritizes and completes quests based on current priorities.
; Dependencies:
;   - completeInitialisationTasks: Prepares the macro environment by setting variables and performing initial tasks.
;   - writeToLogFile: Logs macro start information.
;   - displayQuestsGui: Displays a GUI for managing quests.
;   - activateRoblox: Ensures the Roblox window is active.
;   - runTests: Executes preliminary tests.
;   - checkForDisconnection: Monitors the connection status.
;   - closeAllWindows: Closes all unnecessary windows.
;   - checkForMaxRank: Verifies if the player has reached the maximum rank.
;   - priortiseAndCompleteQuests: Manages and executes quests based on priority.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
runMacro() {
    completeInitialisationTasks()  ; Perform all initial tasks necessary for the macro's setup, such as setting variables or preparing the environment.
    writeToLogFile("*** MACRO START ***")
    displayQuestsGui()  ; Creates and displays a graphical user interface that lists quests and other activities, enhancing user interaction and control.
    activateRoblox()  ; Ensures that the Roblox window is active and ready for input, critical for reliably sending commands to the game.
    runTests()  ; Executes preliminary tests to ensure the macro's functionality.
    checkForDisconnection()  ; Continuously monitors the connection status to handle any disconnections promptly, maintaining the macro's functionality.
    closeAllWindows()  ; Closes any unnecessary windows that may interfere with the macro's operations.
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
    guiMain.SetFont("s8", "Segoe UI")  ; Use "Segoe UI" font for a modern look.

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
    btnPause := guiMain.AddButton("xs", "⏸ &Pause (" getSetting("pauseMacroKey") ")")
    btnWiki := guiMain.AddButton("yp", "🌐 &Wiki")
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
    btnWiki.OnEvent("Click", openWiki)
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
; openWiki Function
; Description: Opens a help text file in Notepad for user assistance.
; Operation:
;   - Executes Notepad with a specified file path to display help documentation.
; Dependencies:
;   - Run: Function to execute external applications.
; Parameters:
;   - None; uses a global variable for the file path.
; Return: None; opens a text file for user reference.
; ----------------------------------------------------------------------------------------
openWiki(*) {
    Run "https://github.com/waktool/RankQuests/wiki"
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
;   - Various game-specific functions like changeCameraView, applyAutoHatchSettings, checkForClaimRewards, refreshQuests, setCurrentLoop, doQuest, useUltimate, checkForDisconnection, claimFreeGifts.
; Parameters:
;   - None; utilizes game settings and state to determine actions.
; Return: None; loops indefinitely, managing game actions continuously.
; ----------------------------------------------------------------------------------------
priortiseAndCompleteQuests(*) {
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
; Description: Processes the quests in the game by performing OCR, combining text lines, and updating the quest list view.
; Operation:
;   - Activates the game window and prepares the environment for quest processing.
;   - Clears existing quest data and performs OCR to read new quest information.
;   - Combines OCR text lines based on proximity and formatting rules.
;   - Updates the quest list view with new quest data, including quest ID, name, status, priority, zone, and amount.
;   - Logs the OCR results and quest details.
;   - Updates the GUI with rank and reward progress.
; Dependencies:
;   - activateRoblox: Ensures the game window is focused.
;   - lvQuests.Delete: Clears the quest list view.
;   - closeAllWindows: Closes any open windows.
;   - clickRewardsButton: Clicks the rewards button to open the rewards menu.
;   - writeToLogFile: Logs the current action or message.
;   - getOcrResult: Performs OCR on the specified screen area and returns the results.
;   - getSetting: Retrieves the specified setting.
;   - getquestId: Determines the quest ID from the OCR text.
;   - fixAmount: Corrects the OCR-extracted amount if necessary.
;   - waitTime: Pauses for a specified duration.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
refreshQuests(*) {
    setCurrentAction("Reading Quests")  ; Signal the beginning of quest processing.
    activateRoblox()  ; Focus the game window for interaction.

    lvQuests.Delete()  ; Clear existing quest data from the list view.
    closeAllWindows()  ; Close all open windows.
    clickRewardsButton()  ; Click the rewards button to open the rewards menu.

    writeToLogFile("*** REFRESH QUESTS ***")  ; Log the refresh quest action.

    ocrQuests := getOcrResult([130, 280], [135, 135], 30, false)  ; Perform OCR to read quest information.

    ; Combine lines from the OCR result based on a number of factors.
    combinedLines := []
    for line in ocrQuests.Lines {  ; Loop all quest lines.
        ; Combine with previous line if the first character is lowercase.
        if (combinedLines.Length > 0 && RegExMatch(line.Text, "^[a-z]")) {  
            combinedLines[combinedLines.Length] .= " " line.Text
        ; Combine with previous line if the distance between the lines is less than or equal to 15 pixels.
        } else if (combinedLines.Length > 0 && (line.Words[1].y - previousLineY <= 15)) {  
            combinedLines[combinedLines.Length] .= " " line.Text
        } else {
            combinedLines.Push(line.Text)
        }
        previousLineY := line.Words[1].y
    }

    ; Process each combined quest line.
    for quest in combinedLines {
        if (getSetting("Do" A_Index "StarQuests") == "true") {  ; Check settings if the quest level should be processed.
            ocrTextResult := quest
            questId := getquestId(ocrTextResult)  ; Identify the quest type from OCR results.
            questName := QUEST_DATA[questId]["Name"]  ; Retrieve the name of the quest from a map based on questId.
            questStatus := QUEST_DATA[questId]["Status"]  ; Get the status of the quest.
            questPriority := QUEST_PRIORITY[questId]  ; Determine the priority of the quest.
            questZone := QUEST_DATA[questId]["Zone"]  ; Get the associated quest zone.
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
    rankArray := StrSplit(ocrTextResult, " ")
    rankDetails := getRankDetails(rankArray[2])
    writeToLogFile("  Rank Details: " ocrTextResult)  ; Log the rank details.

    ; Update the main GUI title with the rank, reward progress, and current time.
    guiMain.Title := MACRO_TITLE " v" MACRO_VERSION "  (Rank: " rankDetails.rankNumber ", " rankDetails.rankName ", " rankArray[1] ")  (" FormatTime(A_Now, "h:mm tt") ")"

    closeAllWindows()  ; Close all open windows.
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
            upgradePotions(questId, questAmount)
        Case "15":  ; Quest for collecting enchants.
            upgradeEnchants(questId, questAmount)
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
            makeGoldenPets(questId, questAmount)
        Case "41":  ; Quest for making rainbow pets from the best egg.
            makeRainbowPets(questId, questAmount)
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
; Description: Executes the task of breaking comets in the game by navigating to the best zone and performing a series of actions based on quest requirements.
; Operation:
;   - Navigates to the optimal zone for breaking comets.
;   - Iterates through the number of comets specified by the quest.
;   - Uses a boost keybind for each comet and breaks the loop if the item is not used.
;   - Performs a pixel search within specified coordinates to locate comets by color.
;   - Clicks on the comet's location if found within the time limit.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves settings such as the time to break a comet and the keybind for comets.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - useBoostKeybind: Uses the specified keybind for the comet quest.
;   - PixelSearch: Searches for a pixel within specified coordinates.
;   - leftClickMouse: Simulates a left mouse click at the specified coordinates.
; Parameters:
;   - questId: The ID of the quest that specifies which comets to break.
;   - questAmount: The number of comets to be broken as part of the quest.
; Return: None
; ----------------------------------------------------------------------------------------
breakComets(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking comets.

    keybind := getSetting("CometKeybind")
    timeToBreakComet := getSetting("TimeToBreakComet")

    Loop questAmount {
        currentAction := "Breaking Comets (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Update and display the current action status.
        writeToLogFile(currentAction)  ; Log the current action status.

        itemUsed := useBoostKeybind(keybind, questId)
        if !itemUsed
            break  ; Exit the loop if the item is not used successfully.

        newTime := DateAdd(A_Now, timeToBreakComet, "Seconds")
        Loop {
            if PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
                COMET_COLOUR["Start"][1], COMET_COLOUR["Start"][2], 
                COMET_COLOUR["End"][1], COMET_COLOUR["End"][2],  
                COMET_COLOUR["Colour"], COMET_COLOUR["Tolerance"])
            {
                leftClickMouse([foundX, foundY])  ; Click on the comet's location if found.
            }

            if A_Now > newTime {
                break  ; Exit the inner loop if the time limit is reached.
            }
        }
    }
}

; ----------------------------------------------------------------------------------------
; breakPinatas Function
; Description: Executes the task of breaking piñatas in the game by navigating to the best zone and performing a series of actions based on quest requirements.
; Operation:
;   - Navigates to the optimal zone for breaking piñatas.
;   - Determines the appropriate keybind and time setting for breaking piñatas.
;   - Iterates through the number of piñatas specified by the quest.
;   - Uses a boost keybind for each piñata and breaks the loop if the item is not used.
;   - Performs a pixel search within specified coordinates to locate piñatas by color.
;   - Clicks on the piñata's location if found within the time limit.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves settings such as the time to break a piñata and the keybind for piñatas.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - useBoostKeybind: Uses the specified keybind for the piñata quest.
;   - PixelSearch: Searches for a pixel within specified coordinates.
;   - leftClickMouse: Simulates a left mouse click at the specified coordinates.
; Parameters:
;   - questId: The ID of the quest that specifies which piñatas to break.
;   - questAmount: The number of piñatas to be broken as part of the quest.
; Return: None
; ----------------------------------------------------------------------------------------
breakPinatas(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking piñatas.

    keybind := getSetting("PinataKeybind")
    timeToBreakPinata := getSetting("TimeToBreakPinata")
    
    ; Loop through the number of piñatas to break.
    Loop questAmount {
        currentAction := "Breaking Pinatas (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Update and display the current action status.
        writeToLogFile(currentAction)  ; Log the current action status.

        itemUsed := useBoostKeybind(keybind, questId)
        if !itemUsed
            break  ; Exit the loop if the item is not used successfully.

        newTime := DateAdd(A_Now, timeToBreakPinata, "Seconds")
        Loop {
            ; Perform pixel search within specified coordinates and color.
            if PixelSearch(&foundX, &foundY, 
                PINATA_COLOUR["Start"][1], PINATA_COLOUR["Start"][2], 
                PINATA_COLOUR["End"][1], PINATA_COLOUR["End"][2],  
                PINATA_COLOUR["Colour"], PINATA_COLOUR["Tolerance"])
            {
                leftClickMouse([foundX, foundY])  ; Click on the piñata's location if found.
            }

            if A_Now > newTime {
                break  ; Exit the inner loop if the time limit is reached.
            }
        }
    }
}

; ----------------------------------------------------------------------------------------
; breakLuckyBlocks Function
; Description: Executes the task of breaking Lucky Blocks in the game by navigating to the best zone and performing a series of actions based on quest requirements.
; Operation:
;   - Navigates to the optimal zone for breaking Lucky Blocks.
;   - Retrieves the keybind and time setting for breaking Lucky Blocks.
;   - Iterates through the number of Lucky Blocks specified by the quest.
;   - Uses a boost keybind for each Lucky Block and breaks the loop if the item is not used.
;   - Performs a pixel search within specified coordinates to locate Lucky Blocks by color.
;   - Clicks on the Lucky Block's location if found within the time limit.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves settings such as the time to break a Lucky Block and the keybind for Lucky Blocks.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - useBoostKeybind: Uses the specified keybind for the Lucky Block quest.
;   - PixelSearch: Searches for a pixel within specified coordinates.
;   - leftClickMouse: Simulates a left mouse click at the specified coordinates.
; Parameters:
;   - questId: The ID of the quest that specifies which Lucky Blocks to break.
;   - questAmount: The number of Lucky Blocks to be broken as part of the quest.
; Return: None
; ----------------------------------------------------------------------------------------
breakLuckyBlocks(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking Lucky Blocks.
    keybind := getSetting("LuckyBlockKeybind")
    timeToBreakLuckyBlock := getSetting("TimeToBreakLuckyBlock")  ; Get the set time to break a Lucky Block.    

    ; Loop through the number of Lucky Blocks to break.
    Loop questAmount {
        currentAction := "Breaking Lucky Blocks (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Display the current action in the UI.
        writeToLogFile(currentAction)  ; Log the current action status.
        
        itemUsed := useBoostKeybind(keybind, questId)
        if !itemUsed
            break  ; Exit the loop if the item is not used successfully.

        newTime := DateAdd(A_Now, timeToBreakLuckyBlock, "Seconds")
        
        Loop {
            ; Perform pixel search for pink Lucky Blocks within specified coordinates and color.
            if PixelSearch(&foundX, &foundY, 
                LUCKY_BLOCK_PINK["Start"][1], LUCKY_BLOCK_PINK["Start"][2], 
                LUCKY_BLOCK_PINK["End"][1], LUCKY_BLOCK_PINK["End"][2],  
                LUCKY_BLOCK_PINK["Colour"], LUCKY_BLOCK_PINK["Tolerance"]) 
            {
                leftClickMouse([foundX, foundY])  ; Click on the Lucky Block's location if found.
            }

            ; Perform pixel search for blue Lucky Blocks within specified coordinates and color.
            if PixelSearch(&foundX, &foundY, 
                LUCKY_BLOCK_BLUE["Start"][1], LUCKY_BLOCK_BLUE["Start"][2], 
                LUCKY_BLOCK_BLUE["End"][1], LUCKY_BLOCK_BLUE["End"][2],  
                LUCKY_BLOCK_BLUE["Colour"], LUCKY_BLOCK_BLUE["Tolerance"]) 
            {
                leftClickMouse([foundX, foundY])  ; Click on the Lucky Block's location if found.
            }

            ; Perform pixel search for yellow Lucky Blocks within specified coordinates and color.
            if PixelSearch(&foundX, &foundY, 
                LUCKY_BLOCK_YELLOW["Start"][1], LUCKY_BLOCK_YELLOW["Start"][2], 
                LUCKY_BLOCK_YELLOW["End"][1], LUCKY_BLOCK_YELLOW["End"][2],  
                LUCKY_BLOCK_YELLOW["Colour"], LUCKY_BLOCK_YELLOW["Tolerance"]) 
            {
                leftClickMouse([foundX, foundY])  ; Click on the Lucky Block's location if found.
            }

            if A_Now > newTime {
                break  ; Exit the inner loop if the time limit is reached.
            }
        }
    }
}

; ----------------------------------------------------------------------------------------
; breakBasicCoinJars Function
; Description: Executes the task of breaking basic coin jars in the game by navigating to the best zone and performing a series of actions based on quest requirements.
; Operation:
;   - Navigates to the optimal zone for breaking coin jars.
;   - Iterates through the number of coin jars specified by the quest.
;   - Uses a boost keybind for each coin jar and breaks the loop if the item is not used.
;   - Waits for the specified amount of time to break each coin jar.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves settings such as the time to break a coin jar and the keybind for coin jars.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - useBoostKeybind: Uses the specified keybind for the coin jar quest.
;   - loopAmountOfSeconds: Waits for a specified amount of time.
; Parameters:
;   - questId: The ID of the quest that specifies which coin jars to break.
;   - questAmount: The number of coin jars to be broken as part of the quest.
; Return: None
; ----------------------------------------------------------------------------------------
breakBasicCoinJars(questId, questAmount) {
    farmBestZone()  ; Navigate to the optimal zone for breaking coin jars.

    ; Loop through the number of coin jars to break.
    Loop questAmount {
        currentAction := "Breaking Coin Jars (" A_Index "/" questAmount ")"
        setCurrentAction(currentAction)  ; Update and display the current action status.
        writeToLogFile(currentAction)  ; Log the current action status.

        keybind := getSetting("BasicCoinJarKeybind")
        itemUsed := useBoostKeybind(keybind, questId)
        if !itemUsed
            break  ; Exit the loop if the item is not used successfully.

        loopAmountOfSeconds(getSetting("TimeToBreakBasicCoinJar"))  ; Wait for the specified amount of time to break the coin jar.
    }
}

; ----------------------------------------------------------------------------------------
; breakMiniChests Function
; Description: Executes the task of breaking mini-chests in the game by navigating to the best zone and performing actions based on settings.
; Operation:
;   - Navigates to the optimal zone for breaking mini-chests.
;   - Sets and displays the current action status.
;   - Logs the current action.
;   - Waits for the specified amount of time to break mini-chests.
;   - Resets the action status after completion.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves the setting for the time to break mini-chests.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - loopAmountOfSeconds: Waits for a specified amount of time.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
breakMiniChests() {
    farmBestZone()  ; Navigate to the optimal zone for breaking mini-chests.

    currentAction := "Breaking Mini-Chests"
    setCurrentAction(currentAction)  ; Update and display the current action status.
    writeToLogFile(currentAction)  ; Log the current action status.

    loopAmountOfSeconds(getSetting("TimeToBreakMiniChests"))  ; Wait for the specified amount of time to break the mini-chests.
}

; ----------------------------------------------------------------------------------------
; breakSuperiorMiniChests Function
; Description: Executes the task of breaking superior mini-chests in the game by navigating to the best zone and performing actions based on settings.
; Operation:
;   - Navigates to the optimal zone for breaking superior mini-chests.
;   - Sets and displays the current action status.
;   - Logs the current action.
;   - Waits for the specified amount of time to break superior mini-chests.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves the setting for the time to break superior mini-chests.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - loopAmountOfSeconds: Waits for a specified amount of time.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
breakSuperiorMiniChests() {
    farmBestZone()  ; Navigate to the optimal zone for breaking superior mini-chests.

    currentAction := "Breaking Superior Mini-Chests"
    setCurrentAction(currentAction)  ; Update and display the current action status.
    writeToLogFile(currentAction)  ; Log the current action status.

    loopAmountOfSeconds(getSetting("TimeToBreakSuperiorMiniChests"))  ; Wait for the specified amount of time to break the superior mini-chests.
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
; Description: Uses a specified number of flags in different zones by teleporting to each zone, moving to the center, and executing the flag action.
; Operation:
;   - Initializes necessary variables.
;   - Iterates through predefined zones to use flags.
;   - Teleports to each zone and moves to its center.
;   - Uses flags and handles any errors that occur.
;   - Repeats until the specified number of flags is used or the quest is completed.
; Dependencies:
;   - getSetting: Retrieves settings such as the keybind for using flags.
;   - teleportToZone: Teleports to the specified zone.
;   - moveToZoneCentre: Moves to the center of the specified zone.
;   - shootDownBalloons: Executes the action to shoot down balloons in the zone.
;   - setCurrentAction: Updates the current action status display.
;   - isOopsWindowOpen: Checks if the 'Oops' window is open, indicating an error.
;   - closeAllWindows: Closes all open windows.
;   - moveMouseToCentreOfScreen: Re-centers the mouse on the screen.
; Parameters:
;   - amountToUse: The number of flags to use.
; Return: None
; ----------------------------------------------------------------------------------------
useFlags(amountToUse) {
    flagsUsed := 0
    keybind := getSetting("QuestFlagKeybind")
    questCompleted := false

    for zoneItem in USE_FLAG_ZONES {  ; Iterate through each zone
        teleportToZone(zoneItem)  ; Teleport to the current zone
        moveToZoneCentre(zoneItem)  ; Move to the center of the zone 
        shootDownBalloons()  ; Shoot down balloons in the zone

        Loop {
            flagsUsed += 1
            setCurrentAction("Using Flags (" flagsUsed "/" amountToUse ")")  ; Update and display the current action status
            SendEvent keybind  ; Send the keybind event to use the flag
            Sleep 250  ; Wait for 250 milliseconds

            if isOopsWindowOpen() {
                flagsUsed -= 1  ; Decrement the flag count if 'Oops' window is open
                break  ; Exit the loop
            }

            questCompleted := (flagsUsed == amountToUse)
            if questCompleted
                break  ; Exit the loop if the quest is completed
        }

        closeAllWindows()  ; Close all open windows
        moveMouseToCentreOfScreen()  ; Re-center the mouse on the screen

        if questCompleted
            return  ; Exit the function if the quest is completed
    }
}

; ----------------------------------------------------------------------------------------
; usePotions Function
; Description: Uses a specified number of potions based on the quest ID by sending the appropriate keybind.
; Operation:
;   - Determines the potion type keybind based on the quest ID.
;   - Iterates through the specified number of potions to use.
;   - Sets and displays the current action status.
;   - Sends the keybind for using the potion and waits for a short duration between uses.
; Dependencies:
;   - getSetting: Retrieves the setting for the potion keybind based on the quest ID.
;   - setCurrentAction: Updates the current action status display.
; Parameters:
;   - questId: The ID of the quest that specifies which type of potion to use.
;   - amountToUse: The number of potions to be used.
; Return: None
; ----------------------------------------------------------------------------------------
usePotions(questId, amountToUse) {
    Switch questId {  ; Determine the potion type based on the quest ID.
        Case "34-1":
            keybind := getSetting("PotionTier3Keybind")
        Case "34-2":
            keybind := getSetting("PotionTier4Keybind")
        Case "34-3":
            keybind := getSetting("PotionTier5Keybind")
        Default:
            keybind := ""  ; No action for undefined questId.
    }
    
    if keybind != "" {
        Loop amountToUse {
            currentAction := "Using potions (" A_Index "/" amountToUse ")"
            setCurrentAction(currentAction)  ; Update and display the current action status.
            SendEvent keybind  ; Send the keybind for using the potion.
            Sleep 500  ; Wait for 0.5 seconds between each use.
        }
    }
}

; ----------------------------------------------------------------------------------------
; breakBreakables Function
; Description: Executes the task of breaking breakable objects in the game by navigating to the best zone and performing actions based on settings.
; Operation:
;   - Navigates to the optimal zone for breaking breakables.
;   - Sets and displays the current action status.
;   - Logs the current action.
;   - Waits for the specified amount of time to break breakables.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves the setting for the time to break breakables.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - loopAmountOfSeconds: Waits for a specified amount of time.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
breakBreakables() {
    farmBestZone()  ; Navigate to the optimal zone for breaking breakables.

    currentAction := "Breaking Breakables"
    setCurrentAction(currentAction)  ; Update and display the current action status.
    writeToLogFile(currentAction)  ; Log the current action status.

    loopAmountOfSeconds(getSetting("TimeToBreakBreakables"))  ; Wait for the specified amount of time to break the breakables.
}

; ----------------------------------------------------------------------------------------
; breakDiamondBreakables Function
; Description: Executes the task of breaking diamond breakables in the game by navigating to the VIP area if available or the best zone otherwise, and performing actions based on settings.
; Operation:
;   - Checks if the player has a VIP gamepass.
;   - Navigates to the VIP area if the gamepass is available, otherwise navigates to the best zone.
;   - Sets and displays the current action status.
;   - Logs the current action.
;   - Waits for the specified amount of time to break diamond breakables.
; Dependencies:
;   - getSetting: Retrieves the setting for VIP gamepass availability and the time to break diamond breakables.
;   - goToVipArea: Navigates to the VIP area for exclusive activities.
;   - farmBestZone: Navigates to the best zone for general activities.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - loopAmountOfSeconds: Waits for a specified amount of time.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
breakDiamondBreakables() {
    if (getSetting("HasGamepassVip") == "true") {  ; Check for VIP gamepass availability.
        goToVipArea()  ; Navigate to VIP area for exclusive activities.
    } else {
        farmBestZone()  ; Navigate to the best zone for general activities.
    }

    currentAction := "Breaking Diamond Breakables"
    setCurrentAction(currentAction)  ; Update and display the current action status.
    writeToLogFile(currentAction)  ; Log the current action status.

    loopAmountOfSeconds(getSetting("TimeToBreakDiamondBreakables"))  ; Wait for the specified amount of time to break the diamond breakables.
}

; ----------------------------------------------------------------------------------------
; earnDiamonds Function
; Description: Executes the task of earning diamonds in the game by navigating to the best zone and performing actions based on settings.
; Operation:
;   - Navigates to the best zone for earning diamonds.
;   - Sets and displays the current action status.
;   - Logs the current action.
;   - Waits for the specified amount of time to earn diamonds.
; Dependencies:
;   - farmBestZone: Navigates to the optimal zone for the task.
;   - getSetting: Retrieves the setting for the time to earn diamonds.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action.
;   - loopAmountOfSeconds: Waits for a specified amount of time.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
earnDiamonds() {
    farmBestZone()  ; Navigate to the best zone for earning diamonds.

    currentAction := "Earning Diamonds"
    setCurrentAction(currentAction)  ; Update and display the current action status.
    writeToLogFile(currentAction)  ; Log the current action status.

    loopAmountOfSeconds(getSetting("TimeToEarnDiamonds"))  ; Wait for the specified amount of time to earn diamonds.
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
upgradePotions(questId, amountToMake) {
    hasMastery := hasSkillMastery()
    doSupercomputerStuff(questId, UPGRADE_POTIONS_BUTTON, amountToMake, getSetting("PotionsRequiredForUpgrade"), hasMastery, getSetting("PotionToUpgrade"))
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
upgradeEnchants(questId, amountToMake) {
    hasMastery := hasSkillMastery()
    doSupercomputerStuff(questId, UPGRADE_ENCHANTS_BUTTON, amountToMake, getSetting("EnchantsRequiredForUpgrade"), hasMastery, getSetting("EnchantToUpgrade"))
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
makeRainbowPets(questId, amountToMake) {
    doSupercomputerStuff(questId, RAINBOW_PETS_BUTTON, amountToMake, getSetting("GoldenPetsRequiredForUpgrade"),, getSetting("PetToConvertToRainbow"), "i)shiny")
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
makeGoldenPets(questId, amountToMake) {
    doSupercomputerStuff(questId, GOLD_PETS_BUTTON, amountToMake, getSetting("StandardPetsRequiredForUpgrade"),, getSetting("PetToConvertToGolden"), "i)shiny")
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
doSupercomputerStuff(questId, buttonColours, amountToMake, amountMultiplier, hasMastery := false, searchText := "", itemToIgnore := "") {
    activateRoblox()  ; Ensure Roblox is the active application.
    goToSupercomputer()  ; Navigate to the supercomputer location.
    findAndClickSupercomputerButton(buttonColours) 

    if (searchText != "") {
        selectSupercomputerSearchBox()  ; Focus on the search box within the supercomputer.
        SendText searchText  ; Enter the required search terms.
        Sleep 500  ; Allow time for the text entry to be processed.
    }

    ; Ensure the user has the required pet/item for conversion.
    itemCoordinates := hasMastery ? COORDS["Supercomputer"]["Item1Mastery"] : COORDS["Supercomputer"]["Item1"]
    if PixelGetColor(itemCoordinates[1], itemCoordinates[2]) == "0xFFFFFF" {
        QUEST_PRIORITY[questId] := 0
        return
    }

    findAngle(amountToMake, amountMultiplier, hasMastery)  ; Calculate necessary adjustments for the operation.
    clickMachineOkButton()  ; Confirm the operation by clicking the OK button.
    moveAwayFromTheSupercomputer()  ; Step back from the supercomputer post-operation.
    closeAllWindows()
    clickMachineSuccessButton()  ; Acknowledge the successful operation.
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
clickMachineButton(button) {
    moveMouseToCentreOfScreen()  ; Moves the mouse cursor to the center of the screen to avoid positional inaccuracies.
    scrollMouseWheel("{WheelUp}", 2)  ; Scrolls up the mouse wheel twice, adjusting the interface if necessary before the click.
    leftClickMouseAndWait(button, "SupercomputerAfterMenuButtonClicked")  ; Executes a left-click on the specified button and waits for a response, ensuring the click has been processed.
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
    Loop 2 {
        leftClickMouseAndWait(COORDS["Supercomputer"]["SuccessOk"], "SupercomputerAfterSuccessOkButtonClicked")
        Sleep 10
    }
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
    closeWindow(SUPERCOMPUTER_MENU_X) 
}

; ----------------------------------------------------------------------------------------
; findAngle Function
; Description: Determines the optimal angle for selecting a specified amount of items in the game using the supercomputer.
; Operation:
;   - Activates the Roblox window for interaction.
;   - Calculates the total amount needed based on the amount to make and multiplier.
;   - Logs the details of the conversion process.
;   - Sets coordinates based on whether the player has mastery.
;   - Iteratively adjusts the selection angle to match the required amount using OCR results.
;   - Logs the final selected amount and angle.
; Dependencies:
;   - activateRoblox: Ensures the Roblox window is active.
;   - writeToLogFile: Logs the current action and details.
;   - selectAngle: Adjusts the selection angle for the supercomputer.
;   - readSelectedAmount: Reads the selected amount using OCR.
;   - displayOcrResult: Displays OCR results on the screen.
;   - clearOcrResult: Clears the displayed OCR results.
; Parameters:
;   - amountToMake: The number of items to make.
;   - amountMultiplier: The multiplier for the amount to make.
;   - hasMastery: Boolean indicating whether the player has mastery.
; Return: None
; ----------------------------------------------------------------------------------------
findAngle(amountToMake, amountMultiplier, hasMastery) {
    activateRoblox()  ; Make sure the Roblox window is active for interaction.
    amountNeeded := amountToMake * amountMultiplier  ; Calculate total amount needed.

    writeToLogFile("*** SUPERCOMPUTER CONVERSION ***")
    writeToLogFile("  Amount To Make: " amountToMake "   Multiplier: " amountMultiplier "   Amount Needed: " amountNeeded "   Mastery: " hasMastery)

    ; Set coordinates based on whether Mastery is true or false.
    itemCoordinates := hasMastery ? COORDS["Supercomputer"]["Item1Mastery"] : COORDS["Supercomputer"]["Item1"]
    ocrStart := hasMastery ? COORDS["OCR"]["SupercomputerAmountStartMastery"] : COORDS["OCR"]["SupercomputerAmountStart"]
    ocrSize := COORDS["OCR"]["SupercomputerAmountSize"]

    ; Start the selection by holding down a click at the initial stack coordinates.
    SendEvent "{Click down, " itemCoordinates[1] ", " itemCoordinates[2] ", 1}"

    angle := 180  ; Starting angle.
    direction := 1  ; Starting direction.
    selectionTolerance := 1.1  ; Selection tolerance.
    maxAnglesChanges := 200  ; Maximum amount of angle changes.
    smallAngleIncrement := 0.25  ; Small angle increment.

    Loop {
        selectAngle(itemCoordinates, angle)

        ; Read the selected amount.
        ocrResults := readSelectedAmount(ocrStart, ocrSize)  
        selectedAmount := ocrResults["SelectedAmount"]
        
        invalidAmount := false

        ; Handle cases where OCR misreads large numbers.
        currentLength := StrLen(selectedAmount)  ; Store the length of the current number.
        ; Adjust the number if it is not the first selected, its length has increased (usually due to a false '1' from the border), and the first two digits are '11'.
        if (A_Index > 1) && (currentLength > previousLength) && (SubStr(selectedAmount, 1, 2) == "1" previousFirstnumber) {
            selectedAmount := Integer(SubStr(selectedAmount, 2))
        }
        else if (currentLength < StrLen(selectedAmount)) && (direction == -1)
            invalidAmount := true
        else if (currentLength > StrLen(selectedAmount)) && (direction == 1)
            invalidAmount := true

        ; Display the OCR results on the screen using TextRender.
        displayOcrResult(selectedAmount "/" amountNeeded, [334, 120])

        ; Break the loop if the angle is too extreme or the amount is within tolerance.
        if angle >= 340 {
            Loop 30 {
                selectAngle(itemCoordinates, angle + A_Index)
            }
            break
        }

        if angle <= 15 {
            selectMinimumAngle(itemCoordinates)
            break
        }

        if !invalidAmount {
            if selectedAmount == 0 {  ; If OCR fails, rotate 1 degree in the current direction.
                degreesToMove := Random(1, 3)
            } else if selectedAmount >= amountNeeded && selectedAmount <= (amountNeeded * selectionTolerance) {
                break  ; Exit if the selected amount is within the tolerance. 
            } else {
                ; If outside tolerance, use random large increments to rotate the angle.
                ; * Note: Random increments are applied to prevent repeated failed readings of the same amount.
                ; If within tolerance, use small increments to rotate the angle.
                incrementTolerance := 0.1
                lowerBound := amountNeeded * (1 - incrementTolerance)
                upperBound := amountNeeded * (1 + incrementTolerance)
                withinTolerance := (selectedAmount >= lowerBound && selectedAmount <= upperBound)
                degreesToMove := withinTolerance ? smallAngleIncrement : Random(4, 6)
                ; Determine the direction to rotate.
                lessThanRequired := (selectedAmount < amountNeeded)
                direction := lessThanRequired ? 1 : -1
            }
        }

        angle += degreesToMove * direction  ; Change the angle and direction if needed.

        ; Reset the angle if maximum adjustments are reached.
        if A_Index == maxAnglesChanges {
            closeSuperComputerMenu()
            break
        }

        previousLength := StrLen(selectedAmount)  ; Store the length of the current number to compare to the next number.
        previousFirstnumber := SubStr(selectedAmount, 1, 1)
    }

    writeToLogFile("  Amount Needed: " amountNeeded "   Amount Selected: " selectedAmount "   Angle: " angle)

    SendEvent "{Click up}" ; Release the mouse click after selection.
    clearOcrResult()  ; Clear the OCR TextRender results from the screen.
}

selectMinimumAngle(itemCoordinates) {
    ; Select 20 degrees and rotate anti-clockwise to 0 degrees for clockwise rotation.
    initialAngle := 15
    Loop initialAngle {
        selectAngle(itemCoordinates, initialAngle)
        initialAngle--
        Sleep 50  ; Pause briefly between angle adjustments.
    }

    Sleep 100  ; Pause briefly.

    ; Rotate in 0.1 degree increments up to 60 degrees to find the diamond indicator.
    Loop 150 {
        selectAngle(itemCoordinates, A_Index / 10)
        Sleep 50  ; Pause briefly between angle adjustments.
        if itemCanBeFused()
            break  ; Exit the loop if the diamond indicator is displayed.
    }
}

itemCanBeFused() {
    okButtonPosition := [200, 433]
    potionBackground := "0xC13AF7"
    enchantsBackground := "0x3AC3F8"
    goldenPetsBackground := "0xF6C03D"
    rainbowPetsBackground := "0xFFC785"
    
    ; Perform pixel search within specified coordinates and color.
    if PixelSearch(&foundX, &foundY, 
        okButtonPosition[1], okButtonPosition[2],  
        okButtonPosition[1], okButtonPosition[2],  
        potionBackground, 2)
        return false

    if PixelSearch(&foundX, &foundY, 
        okButtonPosition[1], okButtonPosition[2],  
        okButtonPosition[1], okButtonPosition[2],  
        enchantsBackground, 2)
        return false        
    
    if PixelSearch(&foundX, &foundY, 
        okButtonPosition[1], okButtonPosition[2],  
        okButtonPosition[1], okButtonPosition[2],  
        goldenPetsBackground, 2)
        return false    
        
    if PixelSearch(&foundX, &foundY, 
        okButtonPosition[1], okButtonPosition[2],  
        okButtonPosition[1], okButtonPosition[2],  
        rainbowPetsBackground, 2)
        return false    

    return true             
}

; ----------------------------------------------------------------------------------------
; selectAngle Function
; Description: Calculates the X and Y coordinates based on the given angle and moves the mouse to the new position relative to the machine item.
; Operation:
;   - Converts the given angle to radians.
;   - Calculates the new X and Y coordinates using trigonometric functions (cosine and sine).
;   - Moves the mouse to the new coordinates.
; Dependencies: None
; Parameters:
;   - itemCoordinates: An array containing the base X and Y coordinates of the machine item.
;   - angle: The angle in degrees to calculate the new mouse position.
; Return: None
; ----------------------------------------------------------------------------------------
selectAngle(itemCoordinates, angle) {
    X := itemCoordinates[1] + RADIUS * Cos((angle - 90) * PI / 180)  ; Calculate the X coordinate.
    Y := itemCoordinates[2] + RADIUS * Sin((angle - 90) * PI / 180)  ; Calculate the Y coordinate.
    MouseMove X, Y  ; Move mouse to the new calculated position.
}

; ----------------------------------------------------------------------------------------
; readSelectedAmount Function
; Description: Performs OCR on a specified rectangular area of the Roblox window to read the selected amount of items.
; Operation:
;   - Retrieves the position of the Roblox window.
;   - Adjusts the OCR start coordinates based on the window position.
;   - Calculates the end coordinates for the OCR area.
;   - Highlights the OCR area for visual reference (optional).
;   - Performs OCR on the specified rectangular area.
;   - Extracts and cleans the selected amount from the OCR result.
;   - Returns the cleaned selected amount and the raw OCR text.
; Dependencies:
;   - WinGetClientPos: Retrieves the position of the Roblox window.
;   - OCR.FromRect: Performs OCR on the specified rectangular area.
;   - Pin: Highlights the OCR area (optional).
; Parameters:
;   - ocrStart: An array containing the X and Y start coordinates for the OCR area.
;   - ocrSize: An array containing the width and height of the OCR area.
; Return: A map containing the cleaned selected amount and the raw OCR text.
; ----------------------------------------------------------------------------------------
readSelectedAmount(ocrStart, ocrSize) {
    
    WinGetClientPos &windowTopLeftX, &windowTopLeftY, , , "ahk_exe RobloxPlayerBeta.exe"  ; Get the position of the Roblox window.
    
    ocrStart := [ocrStart[1] + windowTopLeftX, ocrStart[2] + windowTopLeftY]  ; Adjust OCR start coordinates based on the window position.
    ocrEnd := [ocrStart[1] + ocrSize[1], ocrStart[2] + ocrSize[2]]  ; Calculate end coordinates for the OCR area.
    ocrBorder := Pin(ocrStart[1], ocrStart[2], ocrEnd[1], ocrEnd[2], 100, "b1 flash0")  ; Highlight the OCR area for visual reference (optional).
    ocrObjectResult := OCR.FromRect(ocrStart[1], ocrStart[2], ocrSize[1], ocrSize[2], , 20)  ; Perform OCR on the specified rectangular area with the given scale.
    
    ; Extract and clean the selected amount from the OCR result.
    selectedAmount := RegExReplace(ocrObjectResult.Text, "\D", "")
    selectedAmount := (selectedAmount = "") ? 0 : selectedAmount
    
    ocrBorder.Destroy()  ; Destroy the OCR area highlight.
    
    return Map("SelectedAmount", selectedAmount, "OcrRawText", ocrObjectResult.Text)  ; Return the cleaned selected amount and the raw OCR text.
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
        closeAllWindows()
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
    closeAllWindows()
    leftClickMouseAndWait(COORDS["Controls"]["HatchSettings"], 500)  ; Click the auto hatch button to open the menu.
    setCurrentAction("Updating Auto Hatch Settings")

    Loop 10 {
        if PixelSearch(&foundX, &foundY, 
            AUTO_HATCH_MENU["Start"][1], AUTO_HATCH_MENU["Start"][2],  
            AUTO_HATCH_MENU["End"][1], AUTO_HATCH_MENU["End"][2],  
            AUTO_HATCH_MENU["Colour"], AUTO_HATCH_MENU["Tolerance"])
            leftClickMouseAndWait([foundX, foundY], 100)
        else
            break
    }

    if chargedOverride
        leftClickMouseAndWait(COORDS["HatchSettings"]["ChargedEggsOff"], 200)

    closeAllWindows()
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
    closeWindow(AUTOHATCH_MENU_X)
}

isHatchMenuOpen() {
    ; Perform pixel search within specified coordinates and color.
    return PixelSearch(&foundX, &foundY,  
        HATCHING_MENU_BUY["Start"][1], HATCHING_MENU_BUY["Start"][2], 
        HATCHING_MENU_BUY["End"][1], HATCHING_MENU_BUY["End"][2],  
        HATCHING_MENU_BUY["Colour"], HATCHING_MENU_BUY["Tolerance"])     
}



; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FREE GIFTS / REWARDS FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


claimFreeGifts() {
    if !areFreeGiftsReady()  ; Check if the free gifts are ready to be claimed.
        return
        
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
            MouseMove giftToClickX, giftToClickY
            activateMouseHover()
            leftClickMouseAndWait(giftToClick, "FreeGiftAfterClicked")  ; Click on the gift to claim it.
        }
    }

    closeFreeGiftsMenu()

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
    closeWindow(REWARDS_MENU_X)
}

closeFreeGiftsMenu() {
    closeWindow(FREE_GIFTS_MENU_X)
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
    leftClickMouseAndWait(COORDS["Worlds"][3], "TeleportAfterZoneClicked")  ; Click the Void's teleport button.
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
    clickAutoFarmButton()
    moveToVipArea()  ; Navigate to the VIP area.
    clickAutoFarmButton()

    if (getSetting("UseFlagInVip") == "true")  ; Check for flag use setting.
        useItem("Diamonds Flag", 2)  ; Use flag if applicable.
    if (getSetting("UseSprinklerInVip") == "true")  ; Check for sprinkler use setting.
        useItem("Sprinkler", 2)  ; Use sprinkler if applicable.
}

; ----------------------------------------------------------------------------------------
; farmBestZone Function
; Description: Navigates to the best farming zone, activates auto-farming, and uses various abilities and items based on settings.
; Operation:
;   - Checks the current area and moves to the best area if not already there.
;   - Activates auto-farming.
;   - Uses flags and sprinklers in the best zone based on settings.
;   - Uses the ultimate ability, closes any open windows, zooms the camera out, and shoots down balloons.
; Dependencies:
;   - getCurrentArea: Retrieves the current area in the game.
;   - getCurrentZone: Retrieves the current zone in the game.
;   - clickAutoFarmButton: Toggles the auto-farm button.
;   - moveToBestAreaFromBestEgg: Moves to the best area from the best egg.
;   - teleportToZone: Teleports to a specified zone.
;   - moveToZoneCentre: Moves to the center of a specified zone.
;   - setCurrentArea: Sets the current area in the game.
;   - getSetting: Retrieves various settings like flag and sprinkler usage.
;   - SendEvent: Sends a key event.
;   - useUltimate: Uses the ultimate ability.
;   - closeAllWindows: Closes any open windows.
;   - zoomCameraOut: Zooms the camera out.
;   - shootDownBalloons: Shoots down balloons.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
farmBestZone() {
    if getCurrentArea() != "Best Area" {  ; Check if the current area is not "Best Area".

        clickAutoFarmButton()  ; Activate auto-farming.
        if getCurrentArea() == "Best Egg"
            moveToBestAreaFromBestEgg()  ; Move to the best area from the best egg.
        else {
            if getCurrentZone() == "-" || getCurrentZone() == BEST_ZONE
                teleportToZone(SECOND_BEST_ZONE)  ; Teleport to the second best zone if current zone is unknown or the best zone.

            teleportToZone(BEST_ZONE)  ; Teleport to the best zone.
            moveToZoneCentre(BEST_ZONE)  ; Move to the center of the best zone.
        }
        setCurrentArea("Best Area")  ; Set the current area to "Best Area".
        clickAutoFarmButton()  ; Activate auto-farming again.
    }

    if (getSetting("UseFlagInBestZone") == "true") {  ; Check for flag usage setting.
        keybind := getSetting("FlagLastZoneKeybind")
        SendEvent keybind  ; Use the flag keybind.
    }
    if (getSetting("UseSprinklerInBestZone") == "true") { ; Check for sprinkler usage setting.
        keybind := getSetting("SprinklerKeybind")
        SendEvent keybind  ; Use the sprinkler keybind.
    }

    useUltimate()  ; Use the ultimate ability.
    closeAllWindows()  ; Close all open windows.
    zoomCameraOut(1500)  ; Zoom the camera out.
    shootDownBalloons()  ; Shoot down balloons.
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
    closeWindow(INVENTORY_MENU_X)
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

    isitemFound := searchInventoryForItem(tabToUse, itemToUse)

    ; Use the item if it's found.
    if !checkForitemFound || (checkForitemFound && isitemFound) {
        clickItem(tabToUse, amountToUse, useMaxItem)  ; Interact with the item based on the specified amount and max usage flag.
    }
    
    closeAllWindows()
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
    if useMaxItem {
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
    closeWindow(TELEPORT_MENU_X)
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
    closeAllWindows()
    openTeleportMenu()  ; Open the teleport menu.
    leftClickMouseAndWait(COORDS["Teleport"]["Search"], "TeleportAfterSearchClicked")  ; Click in the search box.
    zoneName := ZONE.Get(zoneNumber)  ; Retrieve the name of the ZONE
    SendText zoneName  ; Enter the zone name into the search.
    waitTime("TeleportAfterSearchCompleted")  ; Wait for search to process.
    
    if !isAlreadyInZone() {
        MouseMove COORDS["Teleport"]["Zone"][1], COORDS["Teleport"]["Zone"][2]  ; Position cursor over the zone button.
        activateMouseHover()  ; Simulate hover to enable the button.
        leftClickMouseAndWait(COORDS["Teleport"]["Zone"], 250)  ; Click to initiate teleport.
        leftClickMouseAndWait(COORDS["Errors"]["Ok"], 200)  ; Close any error messages that might appear.
        leftClickMouseAndWait(COORDS["Teleport"]["X"], "TeleportAfterZoneClicked")  ; Close the teleport menu.
    }

    closeAllWindows()
}

isAlreadyInZone() {
    return PixelSearch(&foundX, &foundY, 
        ZONE_SEARCH["Start"][1], ZONE_SEARCH["Start"][2],  
        ZONE_SEARCH["End"][1], ZONE_SEARCH["End"][2],  
        ZONE_SEARCH["Colour"], ZONE_SEARCH["Tolerance"])    
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
;     leftClickMouseAndWait, scrollMouseWheel: Functions used for various tasks.
; Return: None; orchestrates UI interactions to manage reward claiming processes.
; ----------------------------------------------------------------------------------------
checkForClaimRewards() {
    setCurrentAction("Checking For Rank Up")
    rewardsText := getRewardsText()  ; Retrieve rewards text.
    if (regexMatch(rewardsText, "CLAIM|REW|ARD|MAX")) {  ; Check for claimable rewards.
        setCurrentAction("Claiming Rewards")
        closeAllWindows()
        clickClaimRewardsButton()  ; Initiate the claim process.
        findAndClickClaimButtons()
        closeAllWindows()

        writeToLogFile("**************************************************")        
        writeToLogFile("*** RANK UP ***")        
        writeToLogFile("**************************************************")        
    }
    setCurrentAction("-")  ; Reset the current action.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HATCHING FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; hatchBestEgg Function
; Description: Hatches the best egg a specified number of times by navigating to the appropriate area and using the hatch function.
; Operation:
;   - Checks the current area and moves to the best egg location if not already there.
;   - Uses different strategies based on the current area and settings to navigate to the best egg.
;   - Calculates the number of times to hatch eggs based on the setting for eggs at once.
;   - Calls the hatchEgg function with the calculated number of times.
; Dependencies:
;   - getCurrentArea: Retrieves the current area in the game.
;   - moveToBestEggFromBestArea: Moves to the best egg from the best area.
;   - getSetting: Retrieves various settings like auto farm gamepass and eggs at once.
;   - farmBestZone: Navigates to the best farming zone.
;   - teleportToZone: Teleports to a specified zone.
;   - moveToBestEgg: Moves to the best egg in the game.
;   - hatchEgg: Hatches the egg a specified number of times.
; Parameters:
;   - amountToHatch: The number of eggs to hatch.
; Return: None
; ----------------------------------------------------------------------------------------
hatchBestEgg(amountToHatch) {
    if getCurrentArea() != "Best Egg" {  ; Check if the current area is not "Best Egg"
        
        if getCurrentArea() == "Best Area" {  ; If the current area is "Best Area"
            moveToBestEggFromBestArea()  ; Move to the best egg from the best area
        } else {
            if getSetting("HasGamepassAutoFarm") == "true" {  ; Check if the player has the Auto Farm gamepass
                farmBestZone()  ; Navigate to the best farming zone
                moveToBestEggFromBestArea()  ; Move to the best egg from the best area
            } else {
                if getCurrentArea() == "-"  ; Check if the current area is unknown ("-")
                    teleportToZone(SECOND_BEST_ZONE)  ; Teleport to the second best zone

                teleportToZone(BEST_ZONE)  ; Teleport to the best zone
                moveToBestEgg()  ; Move to the best egg in the best zone
            }
            Sleep 100  ; Short delay to ensure the moves are completed
        }
    }

    eggsAtOnce := getSetting("EggsAtOnce")  ; Get the setting for the number of eggs to hatch at once
    timesToHatch := Ceil(amountToHatch / eggsAtOnce)  ; Calculate the number of hatching cycles needed
    hatchEgg(timesToHatch)  ; Hatch the eggs the calculated number of times
}

; ----------------------------------------------------------------------------------------
; hatchRarePetEgg Function
; Description: Hatches rare pet eggs by navigating to the rare egg location and using the hatch function.
; Operation:
;   - Checks the current area and moves to the rare egg location if not already there.
;   - Uses different strategies based on the current area and settings to navigate to the rare egg.
;   - Applies auto hatch settings if necessary.
;   - Calculates the number of times to hatch rare eggs based on the settings.
;   - Calls the hatchEgg function with the calculated number of times.
; Dependencies:
;   - getCurrentArea: Retrieves the current area in the game.
;   - getSetting: Retrieves various settings like auto farm gamepass and number of rare egg hatches.
;   - getCurrentZone: Retrieves the current zone in the game.
;   - farmBestZone: Navigates to the best farming zone.
;   - teleportToZone: Teleports to a specified zone.
;   - moveToRareEgg: Moves to the rare egg in the specified zone.
;   - applyAutoHatchSettings: Applies auto hatch settings.
;   - hatchEgg: Hatches the egg a specified number of times.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
hatchRarePetEgg() {
    if (getCurrentArea() != "Rare Egg") {  ; Check if the current area is not "Rare Egg"
        if (getSetting("HasGamepassAutoFarm") == "true") {  ; Check if the player has the Auto Farm gamepass
            if (getCurrentZone() != BEST_ZONE)  ; Check if the current zone is not the best zone
                farmBestZone()  ; Navigate to the best farming zone
        }
        else
            teleportToZone(BEST_ZONE)
        teleportToZone(RARE_EGG_ZONE)  ; Teleport to the rare egg zone
        moveToRareEgg()  ; Move to the rare egg in the rare egg zone
        applyAutoHatchSettings(true)  ; Apply auto hatch settings
        Sleep 100  ; Allow a brief pause for UI updates
    }

    timesToHatch := getSetting("NumberOfRareEggHatches")  ; Get the setting for the number of rare egg hatches
    hatchEgg(timesToHatch)  ; Hatch the rare eggs the specified number of times
}

; ----------------------------------------------------------------------------------------
; hatchEgg Function
; Description: Hatches a specified number of eggs by interacting with the game's UI, handling edge cases where the hatch menu might not open, and ensuring the process completes.
; Operation:
;   - Closes all open windows to start with a clean state.
;   - Loops through the specified number of times to hatch eggs.
;   - Sends the 'e' key repeatedly to open the hatch menu.
;   - Handles cases where the hatch menu does not open by logging and resetting the current area.
;   - Clicks to buy the maximum number of eggs and waits for the process to complete.
;   - Ensures that the inventory button is visible before and after the hatching process.
; Dependencies:
;   - closeAllWindows: Closes all open windows.
;   - isHatchMenuOpen: Checks if the hatch menu is open.
;   - setCurrentArea: Sets the current area in the game.
;   - setCurrentAction: Updates the current action status display.
;   - writeToLogFile: Logs the current action or message.
;   - leftClickMouse: Simulates a left mouse click at the specified coordinates.
;   - isInventoryButtonVisible: Checks if the inventory button is visible.
; Parameters:
;   - timesToHatch: The number of times to attempt hatching eggs.
; Return: None
; ----------------------------------------------------------------------------------------
hatchEgg(timesToHatch) {
    closeAllWindows()  ; Close all open windows to start with a clean state.

    eggHatched := false

    ; Loop through the specified number of Eggs.
    Loop timesToHatch {      
        
        Loop 100 {  ; Keep sending the 'e' button until the hatch menu is displayed.
            SendEvent "{e}"  ; Simulate pressing 'e' to hatch an egg.
            Sleep 10
            if isHatchMenuOpen()
                break  ; Exit the loop when the hatch menu is displayed.
        }

        if A_Index == 1 && !isHatchMenuOpen() {  ; If the hatch menu is not displayed on the first attempt.
            setCurrentArea("-")
            setCurrentAction("Missed Egg")  ; Indicate current progress in hatching eggs.
            writeToLogFile("  Missed Egg")
            return
        } else {
            setCurrentAction("Hatching Eggs (" A_Index "/" timesToHatch ")")  ; Indicate current progress in hatching eggs.
            writeToLogFile("  Hatching Eggs (" A_Index "/" timesToHatch ")")

            if A_Index == 1 {  ; Fix the issue where the button remains depressed on the first use, causing the click to fail.
                Sleep 100
                MouseMove COORDS["BuyEggs"]["BuyMax"][1], COORDS["BuyEggs"]["BuyMax"][2]
                activateMouseHover()
            }

            leftClickMouse(COORDS["BuyEggs"]["BuyMax"])  ; Click to buy the maximum number of eggs.

            Loop 100 {  ; Wait for the hatch menu to close.
                if !isHatchMenuOpen()
                    break
                Sleep 50
            }

            Loop 100 {  ; Wait for the eggs to display and cover the inventory button.
                if !isInventoryButtonVisible()
                    break
                Sleep 50
            }

            Loop 100 {  ; Spam click the eggs until the inventory button becomes visible again.
                if isInventoryButtonVisible()
                    break
                leftClickMouse(COORDS["Other"]["HatchSpamClick"])
            }
        }
    }

    Loop 100 {  ; Clear remaining eggs.
        if isInventoryButtonVisible()
            break
        leftClickMouse(COORDS["Other"]["HatchSpamClick"])
    }

    setCurrentAction("-")  ; Reset the current action status to indicate completion.
}

; ----------------------------------------------------------------------------------------
; stopHatching Function
; Description: Stops the hatching process by ensuring the Roblox window is active, clearing any open windows, updating the UI, and performing necessary clicks to clear remaining eggs.
; Operation:
;   - Activates the Roblox window to ensure it's ready for input.
;   - Closes all open windows.
;   - Updates the current action status to reflect that hatching is being stopped.
;   - Resets the current area information.
;   - Performs repeated clicks to clear any remaining eggs if the inventory button is not visible.
;   - Waits for a specified time to allow the game to clear eggs and update.
; Dependencies:
;   - activateRoblox: Ensures the Roblox window is active.
;   - closeAllWindows: Closes all open windows.
;   - setCurrentAction: Updates the current action status display.
;   - setCurrentArea: Resets the current area information.
;   - isInventoryButtonVisible: Checks if the inventory button is visible.
;   - leftClickMouse: Simulates a left mouse click at the specified coordinates.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
stopHatching() {
    activateRoblox()  ; Ensure Roblox window is active.
    closeAllWindows()  ; Close all open windows.
    
    setCurrentAction("Stopping Hatching")  ; Update UI to reflect stopping action.
    setCurrentArea("-")  ; Reset current area information.

    ; Perform clicks to clear any remaining eggs.
    Loop 75 {
        if isInventoryButtonVisible()
            break        
        leftClickMouse(COORDS["Other"]["HatchSpamClick"])
    }
    
}

; ----------------------------------------------------------------------------------------
; closeHatchingMenu Function
; Description: Closes the hatching menu in the game by calling the closeWindow function with the specified coordinates.
; Operation:
;   - Calls the closeWindow function with the coordinates for the hatching menu.
; Dependencies:
;   - closeWindow: Function that closes a window given its X coordinate.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
closeHatchingMenu() {
    closeWindow(HATCHING_MENU_X)  ; Close the hatching menu using its X coordinate.
}

; ----------------------------------------------------------------------------------------
; moveMouseToCentreOfScreen Function
; Description: Moves the mouse cursor to the center of the screen and pauses briefly to stabilize its position.
; Operation:
;   - Moves the mouse cursor to the center coordinates (400, 300).
;   - Pauses for a short duration to ensure the cursor stabilizes.
; Dependencies:
;   - MouseMove: Function that moves the mouse cursor to specified coordinates.
;   - Sleep: Function that pauses execution for a specified duration.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
moveMouseToCentreOfScreen() {
    MouseMove 400, 300  ; Move cursor to screen center (assuming 800x600 resolution).
    Sleep 100  ; Pause to stabilize cursor position.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; CAMERA FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; zoomCameraOut Function
; Description: Holds the 'o' key down to zoom out the camera for a specified duration.
; Parameters:
;   - milliseconds: Duration in milliseconds for which the 'o' key is held down.
; Operation:
;   - Presses and holds the 'o' key.
;   - Pauses execution for the duration specified by 'milliseconds'.
;   - Releases the 'o' key.
; Return: None; modifies the camera zoom level in an application.
; ----------------------------------------------------------------------------------------
zoomCameraOut(milliseconds) {
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
; Description: Performs a shift-left-click at a specified position. Useful for selection actions that require degreesToMove keys.
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
scrollMouseWheel(scrollDirection, timesToScroll := 1) {
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
; Description: Simulates pressing the 'q' key to start or stop riding the hoverboard and waits for a specified time to ensure the action is completed.
; Operation:
;   - Sends the 'q' key event to toggle the hoverboard.
;   - Waits for a specific duration based on whether starting or stopping the hoverboard.
; Dependencies:
;   - SendEvent: Function that sends a key event.
;   - waitTime: Function that pauses execution for a specified duration.
; Parameters:
;   - startRiding: Boolean indicating whether to start (true) or stop (false) riding the hoverboard. Default is true.
; Return: None
; ----------------------------------------------------------------------------------------
clickHoverboard(startRiding := true) {
    SendEvent "{q}"  ; Simulate pressing the 'q' key to toggle the hoverboard.
    
    if (startRiding == true)
        waitTime("HoverboardAfterEquipped")  ; Wait for the hoverboard to be equipped.
    else
        waitTime(200)  ; Wait for a short duration when stopping the hoverboard.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OCR FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; getOcrResult Function
; Description: Performs OCR (Optical Character Recognition) on a specified rectangular area of the Roblox window and optionally returns the text or the OCR object.
; Operation:
;   - Retrieves the position of the Roblox window.
;   - Adjusts the OCR start coordinates based on the window position.
;   - Calculates the end coordinates for the OCR area.
;   - Optionally draws a border around the OCR area for visual feedback.
;   - Performs OCR on the specified rectangular area with the given scale.
;   - Optionally removes the drawn border after OCR is complete.
;   - Returns either the text result or the OCR object based on the returnText parameter.
; Dependencies:
;   - WinGetClientPos: Retrieves the position of the Roblox window.
;   - Pin: Draws a border around the OCR area (optional).
;   - OCR.FromRect: Performs OCR on the specified rectangular area.
;   - waitTime: Waits for a specified duration.
; Parameters:
;   - ocrStart: An array containing the X and Y start coordinates for the OCR area.
;   - ocrSize: An array containing the width and height of the OCR area.
;   - ocrScale: The scale to be used for OCR.
;   - returnText: Boolean indicating whether to return the text result (true) or the OCR object (false). Default is true.
; Return: Either the text result or the OCR object based on the returnText parameter.
; ----------------------------------------------------------------------------------------
getOcrResult(ocrStart, ocrSize, ocrScale, returnText := true) {
    ; Retrieve the position of the Roblox window.
    WinGetClientPos &windowTopLeftX, &windowTopLeftY, , , "ahk_exe RobloxPlayerBeta.exe"

    ; Adjust OCR start coordinates based on the window position.
    ocrStart := [ocrStart[1] + windowTopLeftX, ocrStart[2] + windowTopLeftY]

    ; Calculate end coordinates for the OCR area.
    ocrEnd := [ocrStart[1] + ocrSize[1], ocrStart[2] + ocrSize[2]]

    ; Optionally draw a border around the OCR area for visual feedback.
    if (SHOW_OCR_OUTLINE == "true") {
        ocrBorder := Pin(ocrStart[1], ocrStart[2], ocrEnd[1], ocrEnd[2], 100, "b1 flash0")  ; Draw a border around the OCR area.
        waitTime("QuestAfterOcrBorderDrawn")  ; Wait for the border to be visually confirmed.
    }

    ; Perform OCR on the specified rectangular area with the given scale.
    ocrObjectResult := OCR.FromRect(ocrStart[1], ocrStart[2], ocrSize[1], ocrSize[2], , ocrScale)

    ; Optionally remove the drawn border after OCR is complete.
    if (SHOW_OCR_OUTLINE == "true") {
        ocrBorder.Destroy()
    }

    ; Return either the text result or the OCR object based on the returnText parameter.
    if (returnText)
        return ocrObjectResult.Text
    else
        return ocrObjectResult
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
; Description: Checks if free gifts are ready by performing a pixel search in the specified area for a specific color.
; Operation:
;   - Uses PixelSearch to find the specified color within the defined coordinates.
;   - Returns the result of the PixelSearch function, indicating whether the specified color was found.
; Dependencies:
;   - PixelSearch: Function that searches a rectangular area of the screen for a pixel with a specific color.
; Parameters: None
; Return: Boolean indicating whether the free gifts are ready (true if the color is found, false otherwise).
; ----------------------------------------------------------------------------------------
areFreeGiftsReady() {
    return PixelSearch(&foundX, &foundY, 
        FREE_GIFTS_READY["Start"][1], FREE_GIFTS_READY["Start"][2],  
        FREE_GIFTS_READY["End"][1], FREE_GIFTS_READY["End"][2],  
        FREE_GIFTS_READY["Colour"], FREE_GIFTS_READY["Tolerance"])
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

; ----------------------------------------------------------------------------------------
; fixAmount Function
; Description: Corrects OCR text results to return the accurate numerical value for a given quest.
; Operation:
;   - Applies regular expressions to fix common OCR misreads.
;   - Handles special quest formatting where multipliers are used.
;   - Converts shorthand notation for thousands (e.g., "1.5k" to 1500).
;   - Returns the corrected numerical value or 1 if no valid amount is found.
; Dependencies:
;   - RegExReplace: Function to replace text using regular expressions.
;   - RegexMatch: Function to match text using regular expressions.
; Parameters:
;   - ocrTextResult: The OCR text result that needs to be corrected.
;   - questId: The ID of the quest (not used directly in this function).
; Return: The corrected numerical value for the quest.
; ----------------------------------------------------------------------------------------
fixAmount(ocrTextResult, questId) {
    ; Fix common OCR misreads.
    ocrTextResult := RegExReplace(ocrTextResult, "27 SO", "2750")  ; Fix number '2750' scanned as '27 SO'.
    ocrTextResult := RegExReplace(ocrTextResult, "\bS\b", "5")  ; Fix number '5' scanned as 'S'.
    ocrTextResult := RegExReplace(ocrTextResult, "\bSO\b", "50")  ; Fix number '50' scanned as 'SO'.
    ocrTextResult := RegExReplace(ocrTextResult, "\bSS\b", "55")  ; Fix number '55' scanned as 'SS'.

    ; Handle 'Index (x20) new pets quest' formatting.
    hasMultiplier := RegexMatch(ocrTextResult, "(\(x\d+\))", &multiplierAmount)
    if hasMultiplier {
        ocrAmount := RegExReplace(multiplierAmount[1], "[^\d.]", "")
        return ocrAmount
    }

    ; Check for shorthand notation for thousands (e.g., "1.5k").
    hasThousandsShorthand := RegexMatch(ocrTextResult, "(\b\d+(\.\d+)?k\b)", &shorthandAmount)
    if hasThousandsShorthand {
        ocrAmount := RegExReplace(shorthandAmount[1], "[^\d.]", "")
        ocrAmount *= 1000  ; Multiply the amount by 1000 if 'k' is found to reflect the correct number.
        return Round(ocrAmount, 0)
    }

    ; Extract standalone numbers.
    hasAmount := RegexMatch(ocrTextResult, "(\b\d+\b)", &standaloneAmount)
    if hasAmount
        return standaloneAmount[1]
    else
        return 1  ; Return 1 if no valid amount is found.
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
; resizeRobloxWindow Function
; Description: Resizes the Roblox window to specific dimensions to fix any scaling issues with the Supercomputer.
; Operation:
;   - Activates the Roblox window.
;   - Restores the Roblox window if it is minimized.
;   - Resizes the window twice to ensure any scaling issues are fixed.
; Dependencies:
;   - WinActivate: Activates the specified window.
;   - WinRestore: Restores the specified window if it is minimized.
;   - WinMove: Resizes and moves the specified window.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
resizeRobloxWindow() {
    try {
        windowHandle := WinGetID("ahk_exe RobloxPlayerBeta.exe")
    } catch {
        MsgBox "Roblox window not found."  ; Error message if window is not found.
        ExitApp  ; Exit the script.
    }

    WinActivate windowHandle ; Activate the Roblox window.
    WinRestore windowHandle   ; Restore the Roblox window if it is minimized.
    ; Resize the window twice to fix any scaling issues with the Supercomputer.
    WinMove , , A_ScreenWidth, 600, windowHandle  ; Resize the window to screen width by 600 pixels height.
    WinMove , , 800, 600, windowHandle  ; Resize the window to 800x600 pixels dimensions.    
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
    try {
        IniRead(SETTINGS_INI, "Settings", keyName) ; Read and return the setting value from the INI file.
    } catch {
        MsgBox keyName " setting not found."
    }
    return IniRead(SETTINGS_INI, "Settings", keyName)  
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
; INITIALISATION SETTINGS/FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; completeInitialisationTasks Function
; Description: Completes a series of initialization tasks to set up the environment for the Roblox macro.
; Operation:
;   - Updates the tray icon.
;   - Creates a folder for logs.
;   - Clears any previous OCR results.
;   - Resizes the Roblox window to address scaling issues.
;   - Replaces the Roblox fonts for better readability.
;   - Defines hotkeys for various macro functions.
;   - Zooms the camera out to the maximum level.
; Dependencies:
;   - updateTrayIcon: Updates the tray icon.
;   - createLogsFolder: Creates a folder for logs.
;   - clearOcrResult: Clears any previous OCR results.
;   - resizeRobloxWindow: Resizes the Roblox window to specific dimensions.
;   - replaceRobloxFonts: Replaces the Roblox fonts.
;   - defineHotKeys: Defines hotkeys for various macro functions.
;   - zoomCameraOut: Zooms the camera out to the maximum level.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
completeInitialisationTasks() {
    updateTrayIcon()  ; Update the tray icon.
    createLogsFolder()  ; Create a folder for logs.
    clearOcrResult()  ; Clear any previous OCR results.
    resizeRobloxWindow()  ; Resize the Roblox window to address scaling issues.
    replaceRobloxFonts()  ; Replace the Roblox fonts for better readability.
    defineHotKeys()  ; Define hotkeys for various macro functions.
    zoomCameraOut(1500)  ; Zoom the camera out to the maximum level.
}

; ---------------------------------------------------------------------------------
; createLogsFolder Function
; Description: Creates a directory named "Logs".
; Operation:
;   - Uses the DirCreate command to create a directory named "Logs" in the current working directory.
; Dependencies:
;   - DirCreate: AHK command to create a directory.
; Return: None; the function creates the "Logs" directory.
; ---------------------------------------------------------------------------------
createLogsFolder() {
    DirCreate "Logs"  ; Create a directory named "Logs".
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
; Description: Closes the error message window in the game by calling the closeWindow function with the specified coordinates.
; Operation:
;   - Calls the closeWindow function with the coordinates for the error message window.
; Dependencies:
;   - closeWindow: Function that closes a window given its X coordinate.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
closeErrorMessageWindow() {
    closeWindow(ERROR_WINDOW_X)  ; Close the error message window using its X coordinate.
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
    logFile := LOG_FOLDER DATE_TODAY ".log"  ; Define the log file path using the global log directory and current date, appending ".log" to make it a log file.

    try {
        FileAppend formattedMessage, logFile  ; Append the formatted message to the log file, automatically creating the file if it doesn't exist.
    }
}

; ----------------------------------------------------------------------------------------
; findAndClickClaimButtons Function
; Description: Searches for "Claim" buttons on the screen and clicks them if found.
; Operation:
;   - Repeatedly scrolls the screen down and searches for the "Claim" button shadow.
;   - If the "Claim" button shadow is found, clicks on it.
;   - After completing the scrolls and clicks, performs additional clicks at a specific screen location.
; Dependencies:
;   - activateMouseHover, scrollMouseWheel, leftClickMouseAndWait: Functions to control mouse movement and actions.
; Parameters: None
; Return: None; performs the search, click, and scroll operations.
; ----------------------------------------------------------------------------------------
findAndClickClaimButtons() {
    Loop 20 {  ; Perform 20 mouse scroll downs.
        Loop 20 {
            ; Search for the "Claim" button shadow within specified coordinates and color.
            if !PixelSearch(&foundX, &foundY, 
                CLAIM_BUTTON_SHADOW["Start"][1], CLAIM_BUTTON_SHADOW["Start"][2],  
                CLAIM_BUTTON_SHADOW["End"][1], CLAIM_BUTTON_SHADOW["End"][2],  
                CLAIM_BUTTON_SHADOW["Colour"], CLAIM_BUTTON_SHADOW["Tolerance"])
                break  ; Break the loop if the "Claim" button shadow is not found.

            MouseMove foundX, foundY  ; Move the mouse to the found coordinates.
            activateMouseHover()  ; Activate mouse hover.
            leftClickMouseAndWait([foundX, foundY], 200)  ; Click the "Claim" button and wait.
        }
        moveMouseToCentreOfScreen()  ; Move the mouse to the center of the screen.
        scrollMouseWheel("{WheelDown}")  ; Scroll the mouse wheel down.
        Sleep 200
    }
    Loop 5 {
        leftClickMouseAndWait([400, 300], 50)  ; Perform additional clicks at specific coordinates.
    }
}

; ----------------------------------------------------------------------------------------
; findAndClickSupercomputerButton Function
; Description: Searches for a supercomputer button on the screen by detecting specific button colors and clicks it if found.
; Operation:
;   - Defines the search area for the supercomputer window.
;   - Sets the color tolerance for the search.
;   - Repeatedly searches for the button colors within the supercomputer window.
;   - If the first color is found, narrows the search for the second color near the first.
;   - Clicks the button if both colors are found.
; Dependencies:
;   - moveMouseToCentreOfScreen, activateMouseHover, scrollMouseWheel, leftClickMouseAndWait: Functions to control mouse movement and actions.
; Parameters:
;   - buttonColours: Array of two colors to search for the button.
; Return: None; performs the search and click operations.
; ----------------------------------------------------------------------------------------
findAndClickSupercomputerButton(buttonColours) {
    superComputerWindow := Map("Start", [64, 173], "End", [754, 505])  ; Define the search area for the supercomputer window.
    colourTolerance := 2  ; Set the color tolerance for the search.

    Loop 5 {
        buttonFound := false
        moveMouseToCentreOfScreen()  ; Move the mouse to the center of the screen.
        Sleep 100
        activateMouseHover()  ; Activate mouse hover.
        scrollMouseWheel("{WheelUp}", 4)  ; Scroll the mouse wheel up 4 times.
        Sleep 100
        Loop 4 {
            ; Search for the first color within the supercomputer window.
            if PixelSearch(&foundX1, &foundY1, 
                superComputerWindow["Start"][1], superComputerWindow["Start"][2],  
                superComputerWindow["End"][1], superComputerWindow["End"][2],  
                buttonColours[1], colourTolerance) {
                
                MouseMove foundX1, foundY1  ; Move the mouse to the first color found.
                
                ; Search for the second color near the first color found.
                if PixelSearch(&foundX2, &foundY2, 
                    foundX1 - 50, foundY1 - 50,  
                    foundX1 + 50, foundY1 + 50,  
                    buttonColours[2], colourTolerance) {
                    
                    MouseMove foundX2, foundY2  ; Move the mouse to the second color found.
                    activateMouseHover()  ; Activate mouse hover.
                    leftClickMouseAndWait([foundX2, foundY2], 100)  ; Click the button and wait.
                    buttonFound := true
                    break
                }
            }
            moveMouseToCentreOfScreen()  ; Move the mouse to the center of the screen.
            scrollMouseWheel("{WheelDown}")  ; Scroll the mouse wheel down once.
            Sleep 100
        }
        if buttonFound
            break
    }
}

; ----------------------------------------------------------------------------------------
; isOopsWindowOpen Function
; Description: Checks if the "Oops" error window is open by searching for a specific icon on the screen.
; Operation:
;   - Uses PixelSearch to find the "Oops" error window icon within specified coordinates and color.
; Dependencies: None
; Parameters: None
; Return: Boolean; true if the "Oops" error window is found, false otherwise.
; ----------------------------------------------------------------------------------------
isOopsWindowOpen() {
    ; Perform pixel search within specified coordinates and color.
    return PixelSearch(&foundX, &foundY,  
        OOPS_ERROR_QUESTION_MARK["Start"][1], OOPS_ERROR_QUESTION_MARK["Start"][2], 
        OOPS_ERROR_QUESTION_MARK["End"][1], OOPS_ERROR_QUESTION_MARK["End"][2],  
        OOPS_ERROR_QUESTION_MARK["Colour"], OOPS_ERROR_QUESTION_MARK["Tolerance"])  
}

; ----------------------------------------------------------------------------------------
; closeLeaderboard Function
; Description: Searches for the leaderboard rank star icon on the screen and closes the leaderboard if found.
; Operation:
;   - Uses PixelSearch to find the leaderboard rank star icon within specified coordinates and color.
;   - If the leaderboard rank star icon is found, sends the Tab key to close the leaderboard.
; Dependencies: None
; Parameters: None
; Return: None; performs the search and send key operations to close the leaderboard.
; ----------------------------------------------------------------------------------------
closeLeaderboard() {
    ; Perform pixel search within specified coordinates and color.
    if PixelSearch(&foundX, &foundY,  
        LEADERBOARD_RANK_STAR["Start"][1], LEADERBOARD_RANK_STAR["Start"][2], 
        LEADERBOARD_RANK_STAR["End"][1], LEADERBOARD_RANK_STAR["End"][2],  
        LEADERBOARD_RANK_STAR["Colour"], LEADERBOARD_RANK_STAR["Tolerance"]) 
        SendEvent "{Tab}"  ; Send the Tab key to close the leaderboard.
}

; ----------------------------------------------------------------------------------------
; closeChatLog Function
; Description: Searches for the chat log icon on the screen and closes the chat log if found.
; Operation:
;   - Uses PixelSearch to find the chat log icon within specified coordinates and color.
;   - If the chat log icon is found, clicks on it to close the chat log.
; Dependencies:
;   - leftClickMouse: Function to simulate mouse click at given coordinates.
; Parameters: None
; Return: None; performs the search and click operations to close the chat log.
; ----------------------------------------------------------------------------------------
closeChatLog() {
    ; Perform pixel search within specified coordinates and color.
    if PixelSearch(&foundX, &foundY,  
        CHAT_ICON_WHITE["Start"][1], CHAT_ICON_WHITE["Start"][2], 
        CHAT_ICON_WHITE["End"][1], CHAT_ICON_WHITE["End"][2],  
        CHAT_ICON_WHITE["Colour"], CHAT_ICON_WHITE["Tolerance"]) 
        leftClickMouse([foundX, foundY])  ; Click on the found coordinates to close the chat log.
}

; ----------------------------------------------------------------------------------------
; closeWindow Function
; Description: Searches for a specific window on the screen and closes it if found.
; Operation:
;   - Uses PixelSearch to find the window within specified coordinates and color.
;   - If the window is found, clicks on it to close.
; Dependencies:
;   - leftClickMouse: Function to simulate mouse click at given coordinates.
; Parameters:
;   - WINDOW_X: Map containing the start and end coordinates, color, and tolerance for the search.
; Return: None; performs the search and click operations to close the window.
; ----------------------------------------------------------------------------------------
closeWindow(windowMap) {
    ; Perform pixel search within specified coordinates and color.
    if PixelSearch(&foundX, &foundY,  
        windowMap["Start"][1], windowMap["Start"][2], 
        windowMap["End"][1], windowMap["End"][2],  
        windowMap["Colour"], windowMap["Tolerance"]) 
        leftClickMouse([foundX, foundY])  ; Click on the found coordinates to close the window.
}

; ----------------------------------------------------------------------------------------
; closeAllWindows Function
; Description: Closes all open game menus and windows.
; Operation:
;   - Calls various functions to close specific game menus and windows.
; Dependencies:
;   - closeInventoryMenu, closeErrorMessageWindow, closeRewardsMenu, closeTeleportMenu, closeAutoHatchMenu, closeHatchingMenu, closeSuperComputerMenu, closeChatLog, closeLeaderboard:
;     Functions to close specific game menus and windows.
; Parameters: None
; Return: None; performs the action of closing all specified windows.
; ----------------------------------------------------------------------------------------
closeAllWindows() {
    closeInventoryMenu()         ; Close the inventory menu.
    closeErrorMessageWindow()    ; Close the error message window.
    closeRewardsMenu()           ; Close the rewards menu.
    closeFreeGiftsMenu()         ; Close the free gifts menu.
    closeTeleportMenu()          ; Close the teleport menu.
    closeAutoHatchMenu()         ; Close the auto hatch menu.
    closeHatchingMenu()          ; Close the hatching menu.
    closeSuperComputerMenu()     ; Close the super computer menu.
    closeChatLog()               ; Close the chat log.
    closeLeaderboard()           ; Close the leaderboard.
}

; ----------------------------------------------------------------------------------------
; useBoostKeybind Function
; Description: Repeatedly sends a keybind to use a boost and handles any error messages.
; Operation:
;   - Sends the specified keybind to use a boost.
;   - Continuously checks if an error message window ("Oops" window) is open and closes it if present.
; Dependencies:
;   - isOopsWindowOpen, closeErrorMessageWindow: Functions that check for and close the error message window.
; Parameters:
;   - keybind: The keybind to be sent. If empty, the function exits.
; Return: None; repeatedly sends the keybind and manages error messages until resolved.
; ----------------------------------------------------------------------------------------
useBoostKeybind(keybind, questId) {
    if keybind == "" {
        MsgBox "Keybind missing."  ; Notify user of max rank.
        return false
    } ; If keybind is empty, exit the function.
        
    Loop 10 {
        SendEvent keybind  ; Send the keybind.
        Sleep 1000  ; Wait for 1 second.

        if isItemMissing() {
            QUEST_PRIORITY[questId] := 0  ; Downgrade quest priority if item not found.
            return false
        }
            

        if !isOopsWindowOpen()  ; If the "Oops" window is not open, exit the function.
            return true
            
        while isOopsWindowOpen() {  ; While the "Oops" window is open.
            closeErrorMessageWindow()  ; Close the error message window.
            Sleep 250  ; Wait for 250 milliseconds.
        }
        Sleep 250  ; Wait for 250 milliseconds before the next iteration.
    }

}

; ----------------------------------------------------------------------------------------
; isItemMissing Function
; Description: Checks if an item is missing by performing a pixel search in the specified area for a specific color.
; Operation:
;   - Uses PixelSearch to find the specified color within the defined coordinates.
;   - Returns the result of the PixelSearch function, indicating whether the specified color was found.
; Dependencies:
;   - PixelSearch: Function that searches a rectangular area of the screen for a pixel with a specific color.
; Parameters: None
; Return: Boolean indicating whether the item is missing (true if the color is found, false otherwise).
; ----------------------------------------------------------------------------------------
isItemMissing() {
    ; Perform pixel search within specified coordinates and color.
    return PixelSearch(&foundX, &foundY,  
        ITEM_MISSING["Start"][1], ITEM_MISSING["Start"][2], 
        ITEM_MISSING["End"][1], ITEM_MISSING["End"][2],  
        ITEM_MISSING["Colour"], ITEM_MISSING["Tolerance"])      
}

; ----------------------------------------------------------------------------------------
; isInventoryButtonVisible Function
; Description: Checks if the inventory button is visible on the screen by performing a pixel search in the specified area for a specific color.
; Operation:
;   - Uses PixelSearch to find the specified color within the defined coordinates.
;   - Returns the result of the PixelSearch function, indicating whether the specified color was found.
; Dependencies:
;   - PixelSearch: Function that searches a rectangular area of the screen for a pixel with a specific color.
; Parameters: None
; Return: Boolean indicating whether the inventory button is visible (true if the color is found, false otherwise).
; ----------------------------------------------------------------------------------------
isInventoryButtonVisible() {
    return PixelSearch(&foundX, &foundY, 
        INVENTORY_BUTTON["Start"][1], INVENTORY_BUTTON["Start"][2],  
        INVENTORY_BUTTON["End"][1], INVENTORY_BUTTON["End"][2],  
        INVENTORY_BUTTON["Colour"], INVENTORY_BUTTON["Tolerance"])
}

; ----------------------------------------------------------------------------------------
; hasSkillMastery Function
; Description: Checks if the player has skill mastery by performing a pixel search in the specified area for a specific color.
; Operation:
;   - Uses PixelSearch to find the specified color within the defined coordinates.
;   - Returns the result of the PixelSearch function, indicating whether the specified color was found.
; Dependencies:
;   - PixelSearch: Function that searches a rectangular area of the screen for a pixel with a specific color.
; Parameters: None
; Return: Boolean indicating whether the player has skill mastery (true if the color is found, false otherwise).
; ----------------------------------------------------------------------------------------
hasSkillMastery() {
    return PixelSearch(&foundX, &foundY,  
        SKILL_MASTERY["Start"][1], SKILL_MASTERY["Start"][2], 
        SKILL_MASTERY["End"][1], SKILL_MASTERY["End"][2],  
        SKILL_MASTERY["Colour"], SKILL_MASTERY["Tolerance"])          
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ON SCREEN OCR DISPLAY FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; displayOcrResult Function
; Description: Displays the OCR result as a message on the screen at the specified coordinates.
; Operation:
;   - Retrieves the position of the Roblox window.
;   - Adjusts the coordinates based on the window position.
;   - Configures the rendering settings for the OCR result display.
;   - Draws and renders the OCR result message on the screen.
;   - Ensures the display is non-interactive and releases memory used for rendering.
; Dependencies:
;   - WinGetClientPos: Retrieves the position of the Roblox window.
;   - OCR_RESULTS_RENDER: Object responsible for rendering the OCR result.
; Parameters:
;   - message: The OCR result message to be displayed.
;   - coordinates: An array containing the X and Y coordinates for the display position.
; Return: None
; ----------------------------------------------------------------------------------------
displayOcrResult(message, coordinates) {
    ; Retrieve the position of the Roblox window.
    WinGetClientPos &windowTopLeftX, &windowTopLeftY, , , "ahk_exe RobloxPlayerBeta.exe"
    
    ; Adjust the coordinates based on the window position.
    coordinates := [coordinates[1] + windowTopLeftX, coordinates[2] + windowTopLeftY]

    OCR_RESULTS_RENDER.ClickThrough()  ; Set the render to be click-through.
    
    ; Draw the OCR result message on the screen.
    OCR_RESULTS_RENDER.Draw(
        message, 
        "x:" coordinates[1] " y:" coordinates[2] " h:32 c:#00000080 r:7 m:(0 0)", 
        "size:15pt bold:1 c:#FFFFFF v:center j:left outline:(stroke:1px color:black)"
    )
    
    OCR_RESULTS_RENDER.Render()  ; Render the message on the screen.
    OCR_RESULTS_RENDER.NoActivate()  ; Ensure the display is non-interactive.
    OCR_RESULTS_RENDER.FreeMemory()  ; Free memory used for rendering.
}

; ----------------------------------------------------------------------------------------
; clearOcrResult Function
; Description: Clears the OCR result rendering from the screen.
; Operation:
;   - Calls the Clear method on the OCR_RESULTS_RENDER object to remove any rendered OCR results from the screen.
; Dependencies:
;   - OCR_RESULTS_RENDER: Object responsible for rendering and clearing OCR results.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
clearOcrResult() {
    OCR_RESULTS_RENDER.Clear()  ; Clear the OCR result rendering from the screen.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; BALLOON FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; shootDownBalloons Function
; Description: Sets the current action and shoots down red and blue balloons on the screen.
; Operation:
;   - Sets the current action to "Shooting Down Balloons".
;   - Defines the search parameters for red and blue balloons.
;   - Calls the findAndShootBalloon function for each balloon color.
; Dependencies:
;   - setCurrentAction: Function to set the current action.
;   - findAndShootBalloon: Function to search for and shoot balloons.
; Parameters: None
; Return: None; performs the action of shooting down balloons.
; ----------------------------------------------------------------------------------------
shootDownBalloons() {
    setCurrentAction("Shooting Down Balloons")  ; Set the current action to "Shooting Down Balloons".

    ; Define search parameters for the red balloon.
    RED_BALLOON := Map("Start", [120, 0], "End", [680, 240], "Colour", "0xFF1010", "Tolerance", 2)
    ; Define search parameters for the blue balloon.
    BLUE_BALLOON := Map("Start", [120, 0], "End", [680, 240], "Colour", "0x00E8FF", "Tolerance", 5)

    findAndShootBalloon(RED_BALLOON)  ; Search for and shoot the red balloon.
    findAndShootBalloon(BLUE_BALLOON)  ; Search for and shoot the blue balloon.
}

; ----------------------------------------------------------------------------------------
; findAndShootBalloon Function
; Description: Searches for a balloon on the screen and shoots it multiple times if found.
; Operation:
;   - Uses PixelSearch to find the balloon within specified coordinates and color.
;   - If the balloon is found, clicks on it 10 times.
;   - Repeats the search up to 5 times or stops if the balloon is not found.
; Dependencies:
;   - leftClickMouse: Function to simulate mouse click at given coordinates.
; Parameters:
;   - balloonMap: Map containing the start and end coordinates, color, and tolerance for the search.
; Return: None; performs the search and click operations.
; ----------------------------------------------------------------------------------------
findAndShootBalloon(balloonMap) {
    Loop 10 {
        ; Perform pixel search within specified coordinates and color.
        balloonExists := PixelSearch(&foundX, &foundY,  
            balloonMap["Start"][1], balloonMap["Start"][2], 
            balloonMap["End"][1], balloonMap["End"][2],  
            balloonMap["Colour"], balloonMap["Tolerance"]) 

        if balloonExists {  ; If balloon is found, click on it 10 times.
            Loop 10 {
                leftClickMouse([foundX, foundY])
            }
        } else {  ; If balloon is not found, exit the loop.
            break        
        }
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; DEBUGGING
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; runTests Function
; Description: Contains a series of commented-out test commands used for debugging and testing various functionalities of the script.
; Operation:
;   - Includes a variety of test functions for different tasks such as claiming free gifts, applying settings, displaying OCR results, checking visibility, and more.
;   - All test commands are commented out, allowing selective activation for specific testing purposes.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
runTests() {
    ;msgbox getquestId("Make 1000 golden pets from best egg")
    ;msgbox getquestId("2000 ofyour best eggs")
    ;msgbox getquestId("50 Tier lv Potions")
    ;msgbox getquestId("Break 5 cornets in best area")
    ;msgbox getquestId("Use 20 Potions")
    
    
    
    ;findAngle(500, 9, false)
    ;pause
    ;msgbox getquestId(" iV Pot")
    ;pause
    ;msgbox PixelGetColor(HATCHING_MENU_BUY["Start"][1], HATCHING_MENU_BUY["Start"][2])
    ;pause
    ;msgbox PixelGetColor(88, 184)
    ;msgbox hasSkillMastery()
    ; Initialization tests
    ;completeInitialisationTasks()  ; Uncomment to test initial setup tasks
    ;activateRoblox()  ; Uncomment to ensure Roblox window is active and ready for input

    ; Interaction tests
    ;claimFreeGifts()  ; Uncomment to test claiming free gifts
    ;applyAutoHatchSettings(true)  ; Uncomment to test applying auto hatch settings
    ;moveMouseToCentreOfScreen()  ; Uncomment to test moving the mouse to the center of the screen

    ; OCR and visibility tests
    ;displayOcrResult("test message", [318, 121])  ; Uncomment to test displaying OCR result
    ;msgbox isInventoryButtonVisible()  ; Uncomment to test checking inventory button visibility
    ;msgbox PixelGetColor(67, 172)  ; Uncomment to test PixelGetColor at the specified coordinates

    ; Zone and movement tests
    ;teleportToZone(RARE_EGG_ZONE)  ; Uncomment to test teleporting to the rare egg zone
    ;moveToRareEgg()  ; Uncomment to test moving to the rare egg
    ;moveToBestEggFromBestArea()  ; Uncomment to test moving to the best egg from the best area
    ;moveToCentreOfTheBestZone()  ; Uncomment to test moving to the center of the best zone

    ; Action and stability tests
    ;findAngle(3000, 10, false)  ; Uncomment to test finding angle with specified parameters
    ;hasMastery := hasSkillMastery()
    ;findAngle(30, 5, hasMastery)  ; Uncomment to test finding angle with specified parameters
    ;clickHoverboard(true)  ; Uncomment to test starting riding the hoverboard
    ;clickHoverboard(false)  ; Uncomment to test stopping riding the hoverboard
    ;stabiliseHoverboard()  ; Uncomment to test stabilizing the hoverboard

    ; Macro and quest tests
    ;dropItem("ItemName")  ; Uncomment to test dropping an item by name
    ;areFreeGiftsReady()  ; Uncomment to test checking if free gifts are ready
    ;runMacro()  ; Uncomment to test running the entire macro sequence
    ;pause  ; Uncomment to test pausing the script
}