@echo off
setlocal
title Windows PE/RE Driver Loader
echo Program Name: Windows PE/RE Driver Loader
echo Version: 1.0.0
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli
"%windir%\System32\net.exe" user > nul 2>&1
if "%errorlevel%"=="0" goto "NotInWindowsRecoveryEnvironment"
goto "Start"

:"NotInWindowsRecoveryEnvironment"
echo.
echo You are not in Windows Preinstallation Environment! You must run this batch file in Windows Preinstallation Environment. Press any key to close this batch file.
pause > nul 2>&1
goto "Done"

:"Start"
echo.
echo lf you add a driver using this batch file, it will become the default driver for this device. If an updated driver is added in Windows Setup, the driver added through this batch file will be used. Press any key to continue.
pause > nul 2>&1
goto "Driver"

:"Driver"
echo.
set FullPath=
set /p FullPath="What is the full path to your driver(s) (.inf) file(s)? If you specify a folder, all drivers in that folder and its subfolders will install. "
if not exist "%FullPath%" goto "NotExist"
goto "SureDriver"

:"NotExist"
echo "%FullPath%" does not exist! You can try again.
goto "Start"

:"SureDriver"
echo.
set SureDriver=
set /p SureDriver="Are you sure "%FullPath%" is the full path to your driver(s) (.inf) file(s)? (Yes/No) "
if /i "%SureDriver%"=="Yes" goto "DriverLoad"
if /i "%SureDriver%"=="No" goto "Driver"
echo Invalid syntax!
goto "SureDriver"

:"DriverLoad"
echo.
echo Loading driver file "%FullPath%".
"%windir%\System32\drvload.exe" "%FullPath%" > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
goto "Another"

:"Error"
echo There has been an error! You can try again.
goto "Driver"

:"Another"
set Another=
set /p Another="Driver file(s) "%FullPath%" loaded. Do you want to load another driver(s) (.inf) file(s)? (Yes/No) "
if /i "%Another%"=="Yes" goto "Driver"
if /i "%Another%"=="No" goto "Done"
echo Invalid syntax!
goto "Another"

:"Done"
endlocal
exit