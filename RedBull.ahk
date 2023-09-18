#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode RegEx
#Include %A_ScriptDir%

Disabled:= "RedBull is disabled`n(Ctrl+0 to toggle)"
Enabled:= "RedBull is enabled`n(Ctrl+0 to toggle)"
KeyboardMapDisabled:= "Keyboard Map is disabled`n(Ctrl+. to toggle)"
KeyboardMapEnabled:= "Keyboard Map is enabled`n(Ctrl+. to toggle)"

Mode:="RedBull Mode"
KeyboardMap:="Keyboard Map"

isTeamsActive:= false

stdDelay:= 500
SetKeyDelay, 50, 50

#Persistent
Menu, Tray, Tip , %Disabled%

redbullModeVar := false
keyboardMapVar := false
SetTimer, redbullMode, 30000

Esc:: ; Esc becomes copy
if  (global keyboardMapVar)
	{
		send ^c
	}
return

F1:: ; F1 becomes paste
if  (global keyboardMapVar)
	{
		send ^v
	}
return

F2:: ; F2 becomes cut
if  (global keyboardMapVar)
	{
		send ^x
	}
return

^+.::
^NumpadDel::
global keyboardMapVar := !keyboardMapVar
if (global keyboardMapVar)
	{
		TrayTip, %KeyboardMap%, %KeyboardMapEnabled%, 2, 17
		Menu, Tray, Tip , %KeyboardMapEnabled%
	}
else
	{
		TrayTip, %KeyboardMap%, %KeyboardMapDisabled%, 2, 17
		Menu, Tray, Tip , %KeyboardMapDisabled%
	}
return

^+0::
^NumpadIns::
global redbullModeVar := !redbullModeVar
if (global redbullModeVar)
	{
		TrayTip, %Mode%, %Enabled%, 2, 17
		Menu, Tray, Tip , %Enabled%
	}
else
	{
		TrayTip, %Mode%, %Disabled%, 2, 17
		Menu, Tray, Tip , %Disabled%
	}
return

redbullMode:
if (global redbullModeVar) {
	MouseMove, 1, 1, 1, R
    MouseMove, -1, -1, 1, R
}
return

^+1::
^NumpadEnd::
SendTeamsStatus("busy")
return

^+2::
^NumpadDown::
SendTeamsStatus("available")
return

^+3::
^NumpadPgDn::
SendTeamsStatus("dnd")
return

^+4::
^NumpadLeft::
SendTeamsStatus("away")
return

^+5::
^NumpadClear::
SendTeamsStatus("offline")
return

^+6::
^NumpadRight::
SendTeamsStatus("brb")
return

^+7::
^NumpadPgUp::
Send, How are you? I hope you're doing fine
return

^+8::
^NumpadHome::
Send, I'm good thank you, I hope you're doing fine too
return

^+9::
^NumpadUp::
Send, I hope you're doing well,
return

SendTeamsStatus(St)
{
	WinGetActiveTitle, Title
	WinActivate, ahk_exe Teams.exe
	Sleep, %stdDelay%
	ControlSend, , ^/, ahk_exe Teams.exe
	ControlSend, , %St%{Enter}, ahk_exe Teams.exe
	Sleep, %stdDelay%
	WinClose
	if InStr(Title, "Teams") = 0
		send {Alt Down}{Tab}{Alt Up}
	return
}
