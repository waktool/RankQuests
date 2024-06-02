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


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

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

    ; ========================================
    ; Edit the following in need.
    ; ========================================      
    Sleep 500
    moveLeft(1425 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    ; ========================================
    
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
    moveLeft(700 * SHINY_HOVERBOARD_MODIFIER)
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
    moveRight(700 * SHINY_HOVERBOARD_MODIFIER)
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
    Sleep 500
    moveDownLeft(460 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
    moveDown(100 * SHINY_HOVERBOARD_MODIFIER)
    Sleep 500
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
    moveDown(600 * SHINY_HOVERBOARD_MODIFIER)
    moveRight(4050 * SHINY_HOVERBOARD_MODIFIER)
    ; ========================================
   
    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; moveToCentreOfTheBestZone Function
; Description: Moves the character to the center of the best zone.
; ----------------------------------------------------------------------------------------
moveToCentreOfTheBestZone() {
    ; Modify the current status to indicate moving to the zone center.
    setCurrentAction("Moving To Zone Centre")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================    
    moveLeft(650 * SHINY_HOVERBOARD_MODIFIER)
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
    moveLeft(2000)
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
    moveRight(2500)
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
    moveRight(2000 * SHINY_HOVERBOARD_MODIFIER) 
    ; ========================================    

    clickHoverboard(false)

    ; Modify the current status back to default.
    setCurrentAction("-")  
}

; ----------------------------------------------------------------------------------------
; moveToCentreOfTheBestZone Function
; Description: Moves the character to the center of the best zone.
; ----------------------------------------------------------------------------------------
moveToZoneCentre(ZoneNumber) {
    ; Modify the current status to indicate moving to the zone center.
    setCurrentAction("Moving To Centre Of Zone")
    
    clickHoverboard(true)

    ; ========================================
    ; Edit the following in need.
    ; ========================================    
    Switch ZoneNumber {
        Case 200, 201, 202, 203, 204:
            moveRight(700 * SHINY_HOVERBOARD_MODIFIER)
        Case 205, 206, 207, 208, 209:
            moveRight(625 * SHINY_HOVERBOARD_MODIFIER)        
        Default:
    }
    ; ========================================
    
    clickHoverboard(false)
    
    ; Modify the current status back to default.
    setCurrentAction("-")
}