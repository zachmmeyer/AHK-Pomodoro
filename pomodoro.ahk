#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; SoundPlay, sound.wav, Wait

#SingleInstance, force

Gui, Add, Text,, Pomodoro Time:
Gui, Add, Text,, Break Time:
Gui, Add, Edit, ym
Gui, Add, UpDown, vPomodoroTime, 50 ; The ym option starts a new column of controls.
Gui, Add, Edit
Gui, Add, UpDown, vBreakTime, 10
Gui, Add, Button, default, Start ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Add, Button, default, Stop ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Add, Button, default, Reset ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Show, AutoSize Center, Pomodoro
return

GuiClose:
; ButtonOK:
;   Gui, Submit ; Save the input from the user to each control's associated variable.
;   MsgBox You entered "%PomodoroTime%" and "%BreakTime%".
ExitApp

^x::ExitApp
