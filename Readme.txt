Those files are the files for my Rick Roll USB Stick.

ATTENTION: Do it on a USB Stick or it will have serious consequences (You will probably not be able to unlock your Device again)!!! 

Lite Version (windowssysri_LITE.bat)
1) Create an directory with the Name "files" on an USB Stick.
2) Download the Lite Version file and put it in the "files" folder on the USB Stick.
3) Download nircmd from https://www.nirsoft.net/utils/nircmd.html or direct download: https://www.nirsoft.net/utils/nircmd.zip
4) Extract the files from the .zip file and place the nircmd.exe in the "files" folder on the USB Stick (You only need this file, you can delete the others).
5) Download cmdmp3 made by Jim Lawless from https://github.com/jimlawless/cmdmp3 or https://jiml.us/posts/cmdmp3/ or direct download https://jiml.us/downloads/cmdmp3.zip
6) Extract the files from the .zip file and place the cmdmp3.exe in the "files" folder on the USB Stick (You only need this file, you can delete the others).
7) Now you need to download a song (you can chose one, it doesn't matter), it must be an .mp3
8) Rename the song to "song.mp3" and put it in the "files" folder on the USB Stick.

Full Version (windowssysri.bat)
1) Create an directory with the Name "files" on an USB Stick.
2) Download the Full Version file and put it in the "files" folder on the USB Stick.
3) Now you need to download a song (you can chose one, it doesn't matter), it must be an .mp3
4) Rename the song to "song.mp3" and put it in the "files" folder on the USB Stick.

Additionally
You can create a .bat file which will start the windowssysri_LITE.bat or windowssysri.bat so that you don't have to go to the "files" folder to double-click the file there.
You can name the this file however you want (make sure the file ending is .bat)
The code would look like this:
-----------
@echo off
if exist windowssysri.bat goto full
if exist windowssysri_LITE.bat start windowssysri_LITE.bat
exit
:full
start windowssysri.bat
exit
------------
If you have both versions, it will start the full version.
