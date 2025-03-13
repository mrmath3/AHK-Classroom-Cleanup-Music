/*
===============================================
 Cleanup Music Script for Class Transitions
===============================================
This AutoHotkey script plays a cleanup song **1 minute before class ends** 
to help students prepare for transition. 

🔹 **How It Works:**
   - Checks the system clock every second.
   - Plays a cleanup song based on the class schedule.
   - Automatically **pauses Spotify** if music is playing.
   - **Resumes Spotify** after the cleanup song finishes.
   - Supports **regular and delayed start schedules**.

🔹 **How to Customize:**
   - 🎵 **Change the cleanup song**: Modify `CleanupSongPath`.
   - 🕒 **Modify schedule times**: Edit `MondayToThursdayTimes`, `FridayTimes`, `DelayedTimes`.
   - 🔄 **Use Delayed Start Schedule**: Set `UseDelayedSchedule := True` (or `False` for normal schedule).
   - 🔊 **Adjust volume fade-in**: Modify `FadeStep` and `FadeDelay`.

Last Updated: March 13, 2025
===============================================
*/

#Persistent  ; Keeps script running continuously
#SingleInstance, Force  ; Prevents duplicate instances from running
SetBatchLines, -1  ; Runs script as fast as possible

; ========================
; 🎵 MUSIC & VOLUME SETTINGS
; ========================
VolumeOn := 40  ; Volume percentage when song is playing
MinPlayTime := 5000  ; Minimum play time in milliseconds (5 sec)
FadeStep := 2  ; Volume fade-in step (higher = faster fade)
FadeDelay := 250  ; Delay between fade-in steps in milliseconds
CleanupSongPath := "C:\Users\%A_UserName%\Music\Barney Cleanup Song.mp3"  ; Change this to your cleanup song file

; ========================
; 🔄 SCHEDULE SETTINGS
; ========================
UseDelayedSchedule := False  ; Change to True if using Delayed Start schedule

; 📅 **Class Period Ending Times (1 Minute Before Bell)**
; Modify these to match your school’s schedule.
MondayToThursdayTimes := ["08:52", "09:48", "10:59", "11:55", "12:51", "13:21", "14:17", "15:13"]
FridayTimes :=           ["08:36", "09:16", "09:59", "10:49", "11:29", "12:09", "12:39", "13:19"]
DelayedTimes :=          ["10:49", "11:29", "12:11", "12:51", "13:21", "13:59", "14:36", "15:13"]

; ========================
; 🎵 SPOTIFY CONTROL FUNCTIONS
; ========================
; 🔍 Check if Spotify is playing (returns True or False)
IsSpotifyPlaying() {
    WinGetTitle, SpotifyTitle, ahk_exe Spotify.exe
    return InStr(SpotifyTitle, " - ")  ; If title contains " - ", music is playing
}

; ⏯ Pause or Resume Spotify
ToggleSpotifyPlayback() {
    Send, {Media_Play_Pause}  ; Toggles play/pause
    Sleep, 500  ; Small delay for action to register
}

; ========================
; 🔊 VOLUME CONTROL FUNCTIONS
; ========================
; Set system volume
SetVolume(level) {
    SoundSet, % level
}

; Fade in volume gradually
FadeInVolume(endLevel) {
    global FadeStep, FadeDelay
    SoundGet, currentVolume

    if (currentVolume >= endLevel) {
        return 0  ; No fade-in needed
    }

    Steps := Ceil((endLevel - currentVolume) / FadeStep)
    FadeDuration := Steps * FadeDelay

    Loop, % Steps {
        currentVolume += FadeStep
        if (currentVolume > endLevel) {
            currentVolume := endLevel
        }
        SoundSet, %currentVolume%
        Sleep, FadeDelay
    }

    return FadeDuration
}

; ========================
; 🕒 CHECK CLASS SCHEDULE AND PLAY SONG
; ========================
CheckSchedule() {
    global VolumeOn, MondayToThursdayTimes, FridayTimes, DelayedTimes, MinPlayTime, UseDelayedSchedule, CleanupSongPath
    CurrentDay := A_WDay
    FormatTime, currentTime, , HH:mm

    ; 📅 Determine which schedule to use
    if (UseDelayedSchedule) {
        OnTimes := DelayedTimes
    } else if (CurrentDay >= 2 && CurrentDay <= 5) {  ; Monday to Thursday
        OnTimes := MondayToThursdayTimes
    } else if (CurrentDay = 6) {  ; Friday
        OnTimes := FridayTimes
    } else {
        return  ; Do nothing on Saturday and Sunday
    }

    ; ⏰ Check if it's time to play the cleanup song
    for index, alarmTime in OnTimes
    if (currentTime = alarmTime) {
        
        ; 🔍 Check if Spotify is playing
        SpotifyWasPlaying := IsSpotifyPlaying()
        if (SpotifyWasPlaying) {
            ToggleSpotifyPlayback()  ; Pause Spotify if it was playing
        }

        ; 🔊 Ensure volume is audible
        SoundGet, currentVolume
        if (currentVolume < 5) {
            SoundSet, 5  ; Set minimum volume if muted
        }

        ; 🎵 Play the Cleanup Song
        Run, % CleanupSongPath
        Sleep, MinPlayTime  ; Wait for the song to finish

        ; ▶ Resume Spotify if it was playing before
        if (SpotifyWasPlaying) {
            ToggleSpotifyPlayback()
        }

        ; ⏳ Prevent duplicate alarms within the same minute
        Sleep, 60000
    }
}

; 🕒 Run volume check every second
SetTimer, CheckSchedule, 1000
