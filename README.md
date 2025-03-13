# AHK Classroom Cleanup Music 🎵

This **AutoHotkey script** automatically plays a cleanup song **one minute before class ends** to help students transition smoothly. It can also **pause and resume Spotify**, ensuring no interruptions to the teacher's personal music.

---

## 📌 Features:
✅ **Auto-Pause & Resume Spotify** 🎶  
✅ **Customizable Class Schedules** 🕒  
✅ **Volume Fade-In for Smooth Playback** 🔊  
✅ **Portable – No Manual File Path Setup Needed** 📂  
✅ **Easy to Modify for Any School** 🏫  

---

## 📥 Installation

### 1️⃣ **Download & Install AutoHotkey**
This script requires **AutoHotkey** (AHK).  
[🔗 Download AutoHotkey](https://www.autohotkey.com/) and install it.

### 2️⃣ **Download This Repository**
1. Click the green **"Code"** button (above).  
2. Select **"Download ZIP"**.  
3. Extract the ZIP file to any folder (e.g., `Documents\AHK-Classroom-Cleanup-Music`).

### 3️⃣ **Run the Script**
1. Open the extracted folder.  
2. **Double-click `main.ahk`** to run the script.  

The cleanup song will now **automatically play one minute before class ends**!

---

## ⚙️ Configuration

### 🔹 **Changing the Cleanup Song**
- The cleanup song is located inside the repository (`Barney Cleanup Song.mp3`).
- To **use a different song**, replace the MP3 file in the same folder.
- The script automatically detects the new file name, so no code changes are needed.

### 🕒 **Changing the Class Schedule**
To modify the **period times**, open `main.ahk` in a text editor and edit these lists:
```ahk
MondayToThursdayTimes := ["08:52", "09:48", "10:59", "11:55", "12:51", "13:21", "14:17", "15:13"]
FridayTimes :=           ["08:36", "09:16", "09:59", "10:49", "11:29", "12:09", "12:39", "13:19"]
DelayedTimes :=          ["10:49", "11:29", "12:11", "12:51", "13:21", "13:59", "14:36", "15:13"]
