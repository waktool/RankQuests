; ---------------------------------------------------------------------------------
; SetWindowAttribute Function
; Description: Toggles dark mode settings for a GUI based on Windows 10's dark mode capabilities. 
;              It adapts to the latest Windows versions by adjusting dark mode API usage.
; Operation:
;   - Defines color schemes for dark mode and creates a corresponding GDI brush.
;   - Maps application mode preferences for dark mode settings.
;   - Checks OS version compatibility for dark mode features.
;   - Adjusts GUI attributes to either enable or disable dark mode based on the DarkMode flag.
; Dependencies:
;   - DllCall: Used for making calls to system DLLs for handling dark mode settings.
; Parameters:
;   - GuiObj: The GUI object to which dark mode settings will be applied.
;   - DarkMode: A boolean flag to toggle dark mode (True to enable, False to disable).
; Return: None; modifies GUI attributes directly.
; ---------------------------------------------------------------------------------
SetWindowAttribute(GuiObj, DarkMode := True)
{
    global DarkColors := Map("Background", "0x121212", "Controls", "0x303030", "Font", "0xE0E0E0")
    global TextBackgroundBrush := DllCall("gdi32\CreateSolidBrush", "UInt", DarkColors["Background"], "Ptr")

    static PreferredAppMode := Map("Default", 0, "AllowDark", 1, "ForceDark", 2, "ForceLight", 3, "Max", 4)

    ; Check Windows version for dark mode compatibility.
    if (VerCompare(A_OSVersion, "10.0.17763") >= 0)
    {
        DWMWA_USE_IMMERSIVE_DARK_MODE := 19
        ; Update attribute index for newer Windows builds.
        if (VerCompare(A_OSVersion, "10.0.18985") >= 0)
        {
            DWMWA_USE_IMMERSIVE_DARK_MODE := 20
        }
        uxtheme := DllCall("kernel32\GetModuleHandle", "Str", "uxtheme", "Ptr")
        SetPreferredAppMode := DllCall("kernel32\GetProcAddress", "Ptr", uxtheme, "Ptr", 135, "Ptr")
        FlushMenuThemes := DllCall("kernel32\GetProcAddress", "Ptr", uxtheme, "Ptr", 136, "Ptr")

        ; Apply or revert dark mode based on the DarkMode flag.
        switch DarkMode
        {
            case True:
                DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", GuiObj.hWnd, "Int", DWMWA_USE_IMMERSIVE_DARK_MODE, "Int*", True, "Int", 4)
                DllCall(SetPreferredAppMode, "Int", PreferredAppMode["ForceDark"])
                DllCall(FlushMenuThemes)
                GuiObj.BackColor := DarkColors["Background"]  ; Apply dark colors.
            
            default:
                DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", GuiObj.hWnd, "Int", DWMWA_USE_IMMERSIVE_DARK_MODE, "Int*", False, "Int", 4)
                DllCall(SetPreferredAppMode, "Int", PreferredAppMode["Default"])
                DllCall(FlushMenuThemes)
                GuiObj.BackColor := "Default"  ; Revert to default colors.
        }
    }
}

; ---------------------------------------------------------------------------------
; SetWindowTheme Function
; Description: Configures the visual theme of GUI controls based on the DarkMode setting.
;              It applies specific visual themes to different types of GUI controls to
;              enhance the overall appearance according to user preference for dark or light mode.
; Operation:
;   - Defines constants for various Windows API and message IDs related to GUI appearance.
;   - Sets global dark/light mode configurations for different control types.
;   - Iterates over GUI controls and applies appropriate visual themes based on control type.
;   - Handles special cases for multiline edits and list views, including text and background colors.
;   - Initializes custom window procedure for additional customization, if not already done.
; Dependencies:
;   - DllCall, SendMessage: Used for system API calls to set themes and control properties.
;   - CallbackCreate: Used to manage custom callback functions for window procedures.
; Parameters:
;   - GuiObj: Map of GUI control objects with associated properties.
;   - DarkMode: Boolean indicating whether to apply dark mode (True) or light mode (False).
; Return: None; modifies GUI controls directly.
; ---------------------------------------------------------------------------------
SetWindowTheme(GuiObj, DarkMode := True)
{
    static GWL_WNDPROC := -4  ; Window procedure index.
    static GWL_STYLE := -16  ; Window style index.
    static ES_MULTILINE := 0x0004  ; Edit control multiline style bit.
    static LVM_GETTEXTCOLOR := 0x1023  ; ListView message to get text color.
    static LVM_SETTEXTCOLOR := 0x1024  ; ListView message to set text color.
    static LVM_GETTEXTBKCOLOR := 0x1025  ; ListView message to get text background color.
    static LVM_SETTEXTBKCOLOR := 0x1026  ; ListView message to set text background color.
    static LVM_GETBKCOLOR := 0x1000  ; ListView message to get background color.
    static LVM_SETBKCOLOR := 0x1001  ; ListView message to set background color.
    static LVM_GETHEADER := 0x101F  ; ListView message to get header object.
    static GetWindowLong := A_PtrSize = 8 ? "GetWindowLongPtr" : "GetWindowLong"  ; Adapt to 64-bit if needed.
    static SetWindowLong := A_PtrSize = 8 ? "SetWindowLongPtr" : "SetWindowLong"  ; Adapt to 64-bit if needed.
    static Init := False  ; Flag to check if custom window procedure is already set.
    static LV_Init := False  ; Flag to check if ListView colors are already initialized.
    global IsDarkMode := DarkMode  ; Store current mode globally.

    ; Define appearance modes for different control types.
    Mode_Explorer := (DarkMode ? "DarkMode_Explorer" : "Explorer")
    Mode_CFD := (DarkMode ? "DarkMode_CFD" : "CFD")
    Mode_ItemsView := (DarkMode ? "DarkMode_ItemsView" : "ItemsView")

    ; Iterate through each control in the GUI object map.
    for hWnd, GuiCtrlObj in GuiObj
    {
        switch GuiCtrlObj.Type
        {
            case "Button", "CheckBox", "ListBox", "UpDown":
                DllCall("uxtheme\SetWindowTheme", "Ptr", GuiCtrlObj.hWnd, "Str", Mode_Explorer, "Ptr", 0)
                
            case "ComboBox", "DDL":
                DllCall("uxtheme\SetWindowTheme", "Ptr", GuiCtrlObj.hWnd, "Str", Mode_CFD, "Ptr", 0)
                
            case "Edit":
                ; Check if the edit control is multiline.
                if (DllCall("user32\" GetWindowLong, "Ptr", GuiCtrlObj.hWnd, "Int", GWL_STYLE) & ES_MULTILINE)
                    DllCall("uxtheme\SetWindowTheme", "Ptr", GuiCtrlObj.hWnd, "Str", Mode_Explorer, "Ptr", 0)
                else
                    DllCall("uxtheme\SetWindowTheme", "Ptr", GuiCtrlObj.hWnd, "Str", Mode_CFD, "Ptr", 0)
                
            case "ListView":
                ; Initialize ListView colors once.
                if !(LV_Init)
                {
                    static LV_TEXTCOLOR := SendMessage(LVM_GETTEXTCOLOR, 0, 0, GuiCtrlObj.hWnd)
                    static LV_TEXTBKCOLOR := SendMessage(LVM_GETTEXTBKCOLOR, 0, 0, GuiCtrlObj.hWnd)
                    static LV_BKCOLOR := SendMessage(LVM_GETBKCOLOR, 0, 0, GuiCtrlObj.hWnd)
                    LV_Init := True
                }
                ; Temporarily disable redraw for color changes.
                GuiCtrlObj.Opt("-Redraw")
                ; Set text and background colors based on mode.
                switch DarkMode
                {
                    case True:
                        SendMessage(LVM_SETTEXTCOLOR, 0, DarkColors["Font"], GuiCtrlObj.hWnd)
                        SendMessage(LVM_SETTEXTBKCOLOR, 0, DarkColors["Controls"], GuiCtrlObj.hWnd)
                        SendMessage(LVM_SETBKCOLOR, 0, DarkColors["Controls"], GuiCtrlObj.hWnd)
                        
                    default:
                        SendMessage(LVM_SETTEXTCOLOR, 0, LV_TEXTCOLOR, GuiCtrlObj.hWnd)
                        SendMessage(LVM_SETTEXTBKCOLOR, 0, LV_TEXTBKCOLOR, GuiCtrlObj.hWnd)
                        SendMessage(LVM_SETBKCOLOR, 0, LV_BKCOLOR, GuiCtrlObj.hWnd)
                }
                DllCall("uxtheme\SetWindowTheme", "Ptr", GuiCtrlObj.hWnd, "Str", Mode_Explorer, "Ptr", 0)
                
                ; Apply theme to ListView header.
                LV_Header := SendMessage(LVM_GETHEADER, 0, 0, GuiCtrlObj.hWnd)
                DllCall("uxtheme\SetWindowTheme", "Ptr", LV_Header, "Str", Mode_ItemsView, "Ptr", 0)
                
                ; Re-enable redraw after changes.
                GuiCtrlObj.Opt("+Redraw")
        }
    }

    ; Setup custom window procedure if not already done.
    if !(Init)
    {
        global WindowProcNew := CallbackCreate(WindowProc)
        global WindowProcOld := DllCall("user32\" SetWindowLong, "Ptr", GuiObj.Hwnd, "Int", GWL_WNDPROC, "Ptr", WindowProcNew, "Ptr")
        Init := True
    }
}

; ---------------------------------------------------------------------------------
; WindowProc Function
; Description: Custom window procedure to handle messages for coloring GUI controls
;              when Dark Mode is enabled. It modifies text, background, and button colors
;              according to the specified dark color theme.
; Parameters:
;   - hwnd: Handle to the window receiving the message.
;   - uMsg: The message identifier.
;   - wParam: Additional message information. Typically used to handle device context.
;   - lParam: Additional message information. Varies depending on the message.
; Returns: Depending on the message, may return a handle to a brush for drawing controls.
; ---------------------------------------------------------------------------------
WindowProc(hwnd, uMsg, wParam, lParam)
{
    critical  ; Ensures that no other threads will execute this function simultaneously.
    
    ; Define message constants for control color handling.
    static WM_CTLCOLOREDIT := 0x0133  ; Message for the color of edit controls.
    static WM_CTLCOLORLISTBOX := 0x0134  ; Message for the color of listbox controls.
    static WM_CTLCOLORBTN := 0x0135  ; Message for the color of button controls.
    static WM_CTLCOLORSTATIC := 0x0138  ; Message for the color of static controls.
    static DC_BRUSH := 18  ; Brush type for drawing background.

    ; Check if Dark Mode is enabled and handle the respective coloring messages.
    if (IsDarkMode)
    {
        switch uMsg
        {
            case WM_CTLCOLOREDIT, WM_CTLCOLORLISTBOX:
                ; Set the text and background color for edit and listbox controls.
                DllCall("gdi32\SetTextColor", "Ptr", wParam, "UInt", DarkColors["Font"])
                DllCall("gdi32\SetBkColor", "Ptr", wParam, "UInt", DarkColors["Controls"])
                ; Set the drawing brush color.
                DllCall("gdi32\SetDCBrushColor", "Ptr", wParam, "UInt", DarkColors["Controls"])
                ; Return a solid brush to be used for the background.
                return DllCall("gdi32\GetStockObject", "Int", DC_BRUSH, "Ptr")

            case WM_CTLCOLORBTN:
                ; Set the brush color for button controls.
                DllCall("gdi32\SetDCBrushColor", "Ptr", wParam, "UInt", DarkColors["Background"])
                ; Return a solid brush to be used for button backgrounds.
                return DllCall("gdi32\GetStockObject", "Int", DC_BRUSH, "Ptr")

            case WM_CTLCOLORSTATIC:
                ; Set the text and background color for static controls.
                DllCall("gdi32\SetTextColor", "Ptr", wParam, "UInt", DarkColors["Font"])
                DllCall("gdi32\SetBkColor", "Ptr", wParam, "UInt", DarkColors["Background"])
                ; Return the pre-created solid brush for static text backgrounds.
                return TextBackgroundBrush
        }
    }

    ; For messages not handled above, call the original window procedure.
    return DllCall("user32\CallWindowProc", "Ptr", WindowProcOld, "Ptr", hwnd, "UInt", uMsg, "Ptr", wParam, "Ptr", lParam)
}