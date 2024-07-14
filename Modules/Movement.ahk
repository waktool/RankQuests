#Requires AutoHotkey v2.0  ; Ensures the script runs only on AutoHotkey version 2.0, which supports the syntax and functions used in this script.

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT/PATHS CONFIGURATION FILE
; ----------------------------------------------------------------------------------------
; This file contains all of the character movement paths to various areas within the game.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

SHINY_HOVERBOARD_MODIFIER := (GetSetting("HasShinyHoverboard") = "true") ? 20 / 27 : 1 ; Calculate a modifier for shiny hoverboard use.

; ---------------------------------------------------------------------------------
; DIRECTION Map
; Description: Stores key mappings for different directions, including single keys for up, down, left, and right, as well as combinations of keys for diagonal movements.
; Operation:
;   - Defines a map named DIRECTION to store key mappings.
;   - Sets default value to an empty string.
;   - Maps single keys for basic directions: Up, Down, Left, and Right.
;   - Maps combinations of keys for diagonal movements: Up-Right, Up-Left, Down-Right, and Down-Left.
; Dependencies:
;   - Map: AHK object to store key-value pairs.
; Return: None; the map stores key mappings for various directions.
; ---------------------------------------------------------------------------------
DIRECTION_MAP := Map()
DIRECTION_MAP.Default := ""  ; Set default value to an empty string.
DIRECTION_MAP["Up"] := "W"  ; Map key for moving up.
DIRECTION_MAP["Down"] := "S"  ; Map key for moving down.
DIRECTION_MAP["Left"] := "A"  ; Map key for moving left.
DIRECTION_MAP["Right"] := "D"  ; Map key for moving right.
DIRECTION_MAP["UpRight"] := ["D", "W"]  ; Map keys for moving up-right.
DIRECTION_MAP["UpLeft"] := ["A", "W"]  ; Map keys for moving up-left.
DIRECTION_MAP["DownRight"] := ["D", "S"]  ; Map keys for moving down-right.
DIRECTION_MAP["DownLeft"] := ["A", "S"]  ; Map keys for moving down-left.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; moveToCentreOfTheBestZone Function
; Description: Moves the character to the center of the best zone.
; ----------------------------------------------------------------------------------------
moveToZoneCentre(zoneNumber) {
    ; Modify the current status to indicate moving to the zone center.
    setCurrentAction("Moving To Centre Of Zone")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================    
    Switch zoneNumber {
        Case 200, 201, 202, 203, 204:
            direction := DIRECTION_MAP["Right"]
            time := 700
        Case 205, 206, 207, 208, 209:
            direction := DIRECTION_MAP["Left"]
            time := 625            
        Case 210:
            direction := DIRECTION_MAP["Left"]
            time := 915               
        Case 211:
            direction := DIRECTION_MAP["Right"]
            time := 915                
        Case 212:
            direction := DIRECTION_MAP["Down"]
            time := 915             
        Case 213:
            direction := DIRECTION_MAP["Left"]
            time := 915               
        Case 214:
            direction := DIRECTION_MAP["Up"]
            time := 915               
        Default:
    }

    stabiliseHoverboard(direction)
    moveDirection(direction, time * SHINY_HOVERBOARD_MODIFIER)

    clickHoverboard(false)
    
    ; Modify the current status back to default.
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; moveToBestEgg Function
; Description: Moves the character to the location of the best egg.
; ----------------------------------------------------------------------------------------
moveToBestEgg() {
    ; Modify the current status to indicate moving to the best egg.
    setCurrentArea("Best Egg")
    setCurrentAction("Moving To Best Egg")
    writeToLogFile("  Moving to the Best Egg")
    
    clickHoverboard(true)
    stabiliseHoverboard(DIRECTION_MAP["Up"])
    moveDirection(DIRECTION_MAP["Up"], 950 * SHINY_HOVERBOARD_MODIFIER)
    moveDirection(DIRECTION_MAP["UpRight"], 550 * SHINY_HOVERBOARD_MODIFIER)    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")
}

moveToBestEggFromBestArea() {
    ; Modify the current status to indicate moving to the best egg.
    setCurrentArea("Best Egg")
    setCurrentAction("Moving To Best Egg")
    writeToLogFile("  Moving to the Best Egg")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    Sleep 500
    moveDirection(DIRECTION_MAP["UpRight"], 350 * SHINY_HOVERBOARD_MODIFIER)  
    Sleep 500
    ; ========================================
    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")    
}

moveToBestAreaFromBestEgg() {
    ; Modify the current status to indicate moving to the best egg.
    setCurrentArea("Best Area")
    setCurrentAction("Moving To Best Area")
    writeToLogFile("  Moving to the Best Area")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    Sleep 500
    moveDirection(DIRECTION_MAP["DownLeft"], 350 * SHINY_HOVERBOARD_MODIFIER) 
    Sleep 500
    ; ========================================
    
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")    
}

; ----------------------------------------------------------------------------------------
; moveToRareEgg Function
; Description: Moves the character to the location of the rare pet egg).
; ----------------------------------------------------------------------------------------
moveToRareEgg() {
    ; Modify the current status to indicate moving to the rare egg.
    setCurrentArea("Rare Egg")
    setCurrentAction("Moving To Rare Egg")
    writeToLogFile("  Moving to the Rare Egg")

    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================
    /*      
    ; Path for egg 222 in zone 210.
    Sleep 500
    moveDirection(DIRECTION_MAP["Left"], 100 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    moveDirection(DIRECTION_MAP["Down"], 825 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    moveDirection(DIRECTION_MAP["Right"], 100 * SHINY_HOVERBOARD_MODIFIER)    
    Sleep 500
    */
    ; Path for egg 221 in zone 209.
    moveDirection(DIRECTION_MAP["Left"], 1500 * SHINY_HOVERBOARD_MODIFIER)
    ; ========================================
   
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; moveToVipArea Function
; Description: Moves the character to the VIP area.
; ----------------------------------------------------------------------------------------
moveToVipArea() {
    ; Modify the current status to indicate moving to the VIP area.
    setCurrentArea("VIP")
    setCurrentAction("Moving To VIP")
    writeToLogFile("  Moving to the VIP Area")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================
    moveDirection(DIRECTION_MAP["Down"], 600 * SHINY_HOVERBOARD_MODIFIER)
    moveDirection(DIRECTION_MAP["Right"], 4050 * SHINY_HOVERBOARD_MODIFIER)
    ; ========================================
   
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; moveAwayFromTheSupercomputer Function
; Description: Moves the character away from the location of the supercomputer.
; ----------------------------------------------------------------------------------------
moveAwayFromTheSupercomputer() {
    ; Update the current area to indicate arrival at the Supercomputer.
    setCurrentArea("Supercomputer!")    
    ; Modify the current status to indicate moving away from the supercomputer.
    setCurrentAction("Moving Away From the Supercomputer!")

    ; ========================================
    ; Edit the following in need.
    ; ========================================  
    moveDirection(DIRECTION_MAP["Left"], 2000)
    ; ========================================

    ; Modify the current status back to default.
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; MoveBackToTheSupercomputer Function
; Description: Moves the character back to the location of the supercomputer.
; ----------------------------------------------------------------------------------------
MoveBackToTheSupercomputer() {
    ; Modify the current status to indicate moving back to the supercomputer.
    setCurrentAction("Moving Back To the Supercomputer!")

    ; ========================================
    ; Edit the following in need.
    ; ========================================  
    moveDirection(DIRECTION_MAP["Right"], 2000)
    ; ========================================

    ; Modify the current status back to default.
    setCurrentAction("-")  
}

; ----------------------------------------------------------------------------------------
; moveToSupercomputer Function
; Description: Moves the character to the supercomputer.
; ----------------------------------------------------------------------------------------
moveToSupercomputer() {
    ; Modify the current status to indicate moving back to the supercomputer.
    setCurrentAction("Moving To the Supercomputer!")
    writeToLogFile("  Moving to the Supercomputer!")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    moveDirection(DIRECTION_MAP["Right"], 2000 * SHINY_HOVERBOARD_MODIFIER) 
    ; ========================================    

    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")  
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; stabiliseHoverboard Function
; Description: Simulates pressing a movement key three times with short intervals and then waits for 1000 milliseconds to stabilize the hoverboard.
; Operation:
;   - Loops three times to send a key down event, wait for a short interval, and send a key up event.
;   - Waits for 1000 milliseconds after the loop to allow the hoverboard to stabilize.
; Dependencies:
;   - Send: AHK command to send key events.
;   - Sleep: AHK command to pause execution for a specified duration.
; Return: None; the function stabilizes the hoverboard by simulating key presses.
; ---------------------------------------------------------------------------------
stabiliseHoverboard(moveKey) {
    Loop 3 {
        moveDirection(moveKey, 10)
    }
    Sleep 1000  ; Wait for 1000 milliseconds to stabilize the hoverboard.
}

; ---------------------------------------------------------------------------------
; moveDirection Function
; Description: Simulates movement by sending a key down event, waiting for a specified time, and then sending a key up event.
; Operation:
;   - Sends a key down event for the specified movement key.
;   - Waits for the specified duration in milliseconds.
;   - Sends a key up event to stop the movement.
; Dependencies:
;   - Send: AHK command to send key events.
;   - Sleep: AHK command to pause execution for a specified duration.
; Return: None; the function simulates movement by pressing and releasing a key.
; ---------------------------------------------------------------------------------
moveDirection(moveKey, timeMs) {
    if IsObject(moveKey)
        Send "{" moveKey[1] " down}{" moveKey[2] " down}"
    else
        Send "{" moveKey " down}"  ; Send the key down event for the specified movement key.

    Sleep timeMs  ; Wait for the specified duration in milliseconds.

    if IsObject(moveKey)
        Send "{" moveKey[1] " up}{" moveKey[2] " up}"
    else
        Send "{" moveKey " up}"  ; Send the key down event for the specified movement key.    
}