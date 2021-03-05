#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, Text,,
Gui, Add, Text,, Pomodoro Time:
Gui, Add, Text,, Break Time:
Gui, Add, Text, w30 vShowMin,
Gui, Add, Text, w30 vShowSec,
Gui, add, text, ys, Minutes ;wtf is ys
Gui, Add, Edit,
Gui, Add, UpDown, vPomodoroTimeMin, 50 ; The ym option starts a new column of controls.
Gui, Add, Edit
Gui, Add, UpDown, vBreakTimeMin, 10
Gui, add, text, ys, Seconds
Gui, Add, Edit,
Gui, Add, UpDown, vPomodoroTimeSec Range0-59, 0
Gui, Add, Edit
Gui, Add, UpDown, vBreakTimeSec, 0
Gui, Add, Button, Default, Start ; The label ButtonStart (if it exists) will be run when the button is pressed.
Gui, Add, Button, , Stop 
Gui, Add, Button, , Reset
Gui, Show, AutoSize Center, Pomodoro
Return ;finish adding gui, return to idle

ButtonStart:
  Gui, Submit, NoHide ; Save the input from the user to each control's associated variable.
  SetTimer, Countdown, 1000 
  mins := PomodoroTimeMin
  secs := PomodoroTimeSec
Return

ButtonStop:
Return
ButtonReset:
Return

Countdown:
  GuiControl, Text, ShowSec, %secs%
  GuiControl, Text, ShowMin, %mins%
  If((secs) < 1){
    If(mins < 1){
      SoundPlay, sound.wav
      SetTimer, Countdown, Off
    }
    secs := 59
    mins -= 1
  } else {
    secs -= 1
  }
Return

GuiClose:
ExitApp

^i::ExitApp

;TODO - Label minutes and seconds countdown display on GUI
;TODO - Should be able to pause timer
;TODO - Should be able to store count down value in a text file and update the text file when the value changes
;TODO - Once count down is finished, should change to given string, like "Break!" or "Study!" in the same file
;TODO - Need one of these for the break time
;TODO - Play a sound on the completion of any timer
;TODO - Default sound should be system beep if no file given
;TODO - Update a status file upon completion of any timer to be relevant to the context of said timer. Example: if Study timer finishes, status file should read "Status: Study!"

;DONE - Should be able to count down from a given value on button press- 50:00 - mm:ss format
