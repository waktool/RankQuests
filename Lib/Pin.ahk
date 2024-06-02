; Pin v0.1
; Highlighting area
; x1,y1 <int> Upper-left coordinates of the highlighted area, coordmode: screen
; x2,y2 <int> Lower-right coordinates of the highlighted area, coordmode: screen
; life <int> Duration in milliseconds. If less than or equal to 0, it will be displayed permanently
; opt <str> Other settings. Each setting keyword is followed by parameters, separated by spaces. For example, "b3 cD0A0FF flash300"
;	b <int> Border thickness. 5 pixels by default
;	c <str|int> Color name or RGB value (excluding FFFFFE, as it is used as a transparent color). Default is "red"
;	flash <int> Blinking interval. Default is 300 milliseconds. 0 = do not blink, minus value = blink only once in given ms
; Returns <gui object> Represents the GUI object of Pin instance. You can close the display by calling its .destroy() method
Pin(x1, y1, x2, y2, life:=0, opt:=""){
	transColor := "FFFFFE"
	optRegex := "i)^(b|c|flash)(.+)$"
	cfg := Map()
	cfg["b"] := 5
	cfg["c"] := "red"
	cfg["flash"] := 300
	
	; Parse options
	opt := RegExReplace(opt, "[ \t]+", " ")
	match := ""
	Loop parse, opt, " `t", " `t"
	{
		isFind := RegExMatch(A_LoopField, optRegex, &match)
		if(isFind){
			cfg.set(StrLower(match[1]), match[2])
		}
	}
	
	b := cfg["b"]
	
	pin:=Gui("+AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x0A000020")
	pin_id := pin.hwnd
	pin.BackColor := cfg["c"]
	pin.add("Text", "x" b " y" b " w" (x2-x1) " h" (y2-y1) " Background" . transColor)
	pin.show("NA x" (x1-b) " y" (y1-b) " w" (x2-x1+2*b) " h" (y2-y1+2*b))
	
	WinSetTransColor(transColor, "ahk_id " pin_id)
	
	; blink
	SetTimer(flash, cfg["flash"])
	
	; die
	if(life > 0){
		SetTimer(()=>pin.destroy(), -life)
	}
	
	; pawsome pin
	flash(){
		if(pin && WinExist("ahk_id " pin_id)){
			try pin.hide()
		} else {
			try pin.show("NA")
		}
	}
	
	return pin
}
