#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#SingleInstance, force
file := File.Open(config.txt, "r`n")
FileReadLine, PomodoroTimeMin, config.txt, 1
FileReadLine, PomodoroTimeSec, config.txt, 2
FileReadLine, BreakTimeMin, config.txt, 3
FileReadLine, BreakTimeSec, config.txt, 4
;reads config file and sets last timer settings

Gui, Add, Text,,
Gui, Add, Text, +Right w150, Pomodoro Time:
Gui, Add, Text, +Right w150, Break Time:
Gui, Add, Text, w120 vShowMin,
Gui, Add, Text, w120 vShowSec,
Gui, add, text, ys, Minutes ;wtf is ys
Gui, Add, Edit,
Gui, Add, UpDown, vPomodoroTimeMin Range1-1000, %PomodoroTimeMin% ; The ym option starts a new column of controls.
Gui, Add, Edit
Gui, Add, UpDown, vBreakTimeMin, %BreakTimeMin%
Gui, add, text, ys, Seconds
Gui, Add, Edit,
Gui, Add, UpDown, vPomodoroTimeSec Range0-59, %PomodoroTimeSec%
Gui, Add, Edit
Gui, Add, UpDown, vBreakTimeSec, %BreakTimeSec%
Gui, Add, Button, Default, Start ; The label ButtonStart (if it exists) will be run when the button is pressed.
Gui, Add, Button, , Stop 
Gui, Add, Button,w50 vPauser, Pause ; lets us change button from pause and unpause
Gui, Show, AutoSize Center, Pomodoro
Return ; finish adding gui, return to idle

ButtonStart:
  Gui, Submit, NoHide ; Save the input from the user to each control's associated variable.
  if (PomodoroTimeSec < 1 AND PomodoroTimeMin < 1) { ;jfk not &
    Return
  }
  GuiControl, , Pauser, Pause ; reset pause just in case
  SetTimer, Countdown, 1000 
  mins := PomodoroTimeMin
  secs := PomodoroTimeSec
Return

ButtonStop:
  GuiControl, , Pauser, Pause ; reset pause just in case
Return

ButtonPause:
  If (timerState == true){
    SetTimer, Countdown, Off
    timerState := false ; turn off countdown
    GuiControl, , Pauser, Unpause ; change button to unpause
  }
  else{
    GuiControl, , Pauser, Pause ; set's button to pause, then resumes countdown
    SetTimer, Countdown, 1000 
  }
Return

Countdown:
  timerState := true ; Timer is on
  GuiControl, Text, ShowSec, %secs% Seconds Remaining ; Label for timer display
  GuiControl, Text, ShowMin, %mins% Minutes Remaining
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
  Gui, Submit, NoHide
  file := FileOpen("config.txt", "w`n")
  File.WriteLine(PomodoroTimeMin)
  File.WriteLine(PomodoroTimeSec)
  File.WriteLine(BreakTimeSec)
  File.WriteLine(BreakTimeSec)
  File.Close()
ExitApp

^i::ExitApp

;TODO - Label minutes and seconds countdown display on GUI
;TODO - Start button should turn into pause button and unpause button. 
;TODO - Should be able to reset timer, button should appear after start
;TODO - Should be able to store count down value in a text file and update the text file when the value changes
;TODO - Once count down is finished, should change to given string, like "Break!" or "Study!" in the same file
;TODO - Need to be able to countdown for breaks as well
;TODO - Play a sound on the completion of any timer
;TODO - Default sound should be system beep if no file given
;TODO - Update a status file upon completion of any timer to be relevant to the context of said timer. Example: if Study timer finishes, status file should read "Status: Study!"
