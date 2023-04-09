::     ______                     __
::    / ____/  ______  ___  _____/ /_
::   / __/ | |/_/ __ \/ _ \/ ___/ __/
::  / /____>  </ /_/ /  __/ /  / /_
:: /_____/_/|_/ .___/\___/_/   \__/
::           /_/
::     ____                          __              __
::    / __ \____ _      _____  _____/ /_____  ____  / /
::   / /_/ / __ \ | /| / / _ \/ ___/ __/ __ \/ __ \/ /
::  / ____/ /_/ / |/ |/ /  __/ /  / /_/ /_/ / /_/ / /
:: /_/    \____/|__/|__/\___/_/   \__/\____/\____/_/

::  ____                                _ _ _                 _ _
:: | __ ) _   _ _   ___ _ __ ___   __ _| | | |__   ___ _ __  (_|_)
:: |  _ \| | | (_) / __| '_ ` _ \ / _` | | | '_ \ / _ \ '_ \ | | |
:: | |_) | |_| |_  \__ \ | | | | | (_| | | | |_) |  __/ | | || | |
:: |____/ \__, (_) |___/_| |_| |_|\__,_|_|_|_.__/ \___|_| |_|/ |_|
::        |___/                                            |__/

@ECHO off
title Powertool
goto menu



:dism

dism /online /cleanup-image /restorehealth
sfc /scannow

pause 

goto menu

:userFolder

explorer c:\users

goto menu


:robocopy
cls

echo Copy files from user directory
echo.
echo Name of user folder
set /P userfolder=">"
echo.
echo drive letter for backup drive
set /P driveletter=">"

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%a-%%b)

cls

::robocopy c:\users\%userfolder%\Pictures %driveletter%:\%userfolder%-%mydate%\Pictures

for %%d in (Pictures,Documents,Desktop,Downloads,Music,Videos) do robocopy c:\users\%userfolder%\%%d %driveletter%:\%userfolder%-%mydate%\%%d

pause

goto menu

:WifiPasswords

cls 

netsh wlan show profile key=clear

pause

goto menu

:test

FOR /F "tokens=*" %%g IN ('netsh wlan show profile') do (SET VAR=%%g)

for %%a in (%VAR%) do echo %%a

pause

goto menu

:menu

%input%=.

cls

echo Expert Powertool
echo Written by: smallbenji
echo.
echo.
echo 1. sfc + dism
echo 2. user folder
echo 3. robocopy user folder
echo 4. diskpart
echo 5. Export Wifi Passwords
echo.
echo type 'exit' to exit

set /P INPUT=Type input: 

if /I "%input%"=="1" goto dism
if /I "%input%"=="2" goto userFolder
if /I "%input%"=="3" goto robocopy
if /I "%input%"=="4" diskpart
if /I "%input%"=="5" goto WifiPasswords
if /I "%input%"=="test" goto test
if /I "%input%"=="exit" exit

goto menu

