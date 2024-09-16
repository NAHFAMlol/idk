@echo off
mode 80,30
title Ultimate Multi-Tool
chcp 65001 >nul

:main
cls
echo.
echo.
echo.

:: Function to display gradient banner from red to yellow
call :banner

echo.
echo.

:: Display the main menu with pipe lines and colored options
call :mainmenu

:: Get user choice
echo|set /p=".          [90;1m╚══>[0m"
choice /c 1234567890 /n >nul
set "opt=%errorlevel%"

:: Navigate based on user choice
if "%opt%"=="1" goto sysinfo
if "%opt%"=="2" goto diskusage
if "%opt%"=="3" goto netinfo
if "%opt%"=="4" goto processviewer
if "%opt%"=="5" goto killprocess
if "%opt%"=="6" goto syscleanup
if "%opt%"=="7" goto filesearch
if "%opt%"=="8" goto apps
if "%opt%"=="9" goto shutdownmenu
if "%opt%"=="10" goto exit

:: Invalid choice, return to main menu
goto main

:sysinfo
cls
systeminfo | more
pause
goto main

:diskusage
cls
echo Disk Usage:
wmic logicaldisk get name,size,freespace
pause
goto main

:netinfo
cls
ipconfig /all | more
pause
goto main

:processviewer
cls
echo Active Processes:
tasklist | more
pause
goto main

:killprocess
cls
echo Enter the name or PID of the process to kill:
set /p "pname=Process Name/PID: "
taskkill /F /IM "%pname%" /T
pause
goto main

:syscleanup
cls
echo Cleaning up system...
del /s /q %temp%\*
del /s /q C:\Windows\Temp\*
cleanmgr /sagerun:1
echo System cleanup complete.
pause
goto main

:filesearch
cls
echo Enter the filename to search for:
set /p "filename=Filename: "
echo Searching, please wait...
dir /s /b "%systemdrive%\%filename%" > search_results.txt
echo Search complete. Results saved in search_results.txt
notepad search_results.txt
del search_results.txt
pause
goto main

:apps
cls
echo.
ping localhost -n 1 >nul
echo     [90;1m#═╦═══════»[0m  [92m[Calculator][0m            [95m[1][0m
ping localhost -n 1 >nul
echo       [90;1m╚═╦══════»[0m  [92m[Discord][0m               [95m[2][0m
ping localhost -n 1 >nul
echo         [90;1m╚═╦═════»[0m  [92m[Process Hacker][0m        [95m[3][0m
ping localhost -n 1 >nul
echo           [90;1m╚═══»[0m  [92m[Back to Main Menu][0m      [95m[4][0m
echo.
echo|set /p=".          [90;1m╚══>[0m"
choice /c 1234 /n >nul
set "appopt=%errorlevel%"

if "%appopt%"=="1" start calc.exe
if "%appopt%"=="2" start "" "C:\Users\%USERNAME%\AppData\Local\Discord\Update.exe" --processStart Discord.exe
if "%appopt%"=="3" start "" "C:\Program Files\Process Hacker 2\ProcessHacker.exe"
if "%appopt%"=="4" goto main

goto apps

:shutdownmenu
cls
echo.
ping localhost -n 1 >nul
echo     [90;1m#═╦═══════»[0m  [92m[Shutdown System][0m       [95m[1][0m
ping localhost -n 1 >nul
echo       [90;1m╚═╦══════»[0m  [92m[Restart System][0m        [95m[2][0m
ping localhost -n 1 >nul
echo         [90;1m╚═╦═════»[0m  [92m[Log Off][0m               [95m[3][0m
ping localhost -n 1 >nul
echo           [90;1m╚═══»[0m  [92m[Back to Main Menu][0m     [95m[4][0m
echo.
echo|set /p=".          [90;1m╚══>[0m"
choice /c 1234 /n >nul
set "shutdownopt=%errorlevel%"

if "%shutdownopt%"=="1" shutdown /s /t 0
if "%shutdownopt%"=="2" shutdown /r /t 0
if "%shutdownopt%"=="3" shutdown /l
if "%shutdownopt%"=="4" goto main

goto shutdownmenu

:exit
exit

:: Banner function
:banner
setlocal EnableDelayedExpansion
set "text1= ███▄ ▄███▓ █    ██  ██▓  ▄▄▄█████▓ ██▓   ▄▄▄█████▓ ▒█████   ▒█████   ██▓    "
set "text2= ▓██▒▀█▀ ██▒ ██  ▓██▒▓██▒  ▓  ██▒ ▓▒▓██▒   ▓  ██▒ ▓▒▒██▒  ██▒▒██▒  ██▒▓██▒    "
set "text3= ▓██    ▓██░▓██  ▒██░▒██░  ▒ ▓██░ ▒░▒██▒   ▒ ▓██░ ▒░▒██░  ██▒▒██░  ██▒▒██░    "
set "text4= ▒██    ▒██ ▓▓█  ░██░▒██░  ░ ▓██▓ ░ ░██░   ░ ▓██▓ ░ ▒██   ██░▒██   ██░▒██░    "
set "text5= ▒██▒   ░██▒▒▒█████▓ ░██████▒▒██▒ ░ ░██░     ▒██▒ ░ ░ ████▓▒░░ ████▓▒░░██████▒"
set "text6= ░ ▒░   ░  ░░▒▓▒ ▒ ▒ ░ ▒░▓  ░▒ ░░   ░▓       ▒ ░░   ░ ▒░▒░▒░ ░ ▒░▒░▒░ ░ ▒░▓  ░"
set "text7= ░  ░      ░░░▒░ ░ ░ ░ ░ ▒  ░  ░     ▒ ░       ░      ░ ▒ ▒░   ░ ▒ ▒░ ░ ░ ▒  ░"
set "text8= ░      ░    ░░░ ░ ░   ░ ░   ░       ▒ ░     ░      ░ ░ ░ ▒  ░ ░ ░ ▒    ░ ░   "
set "text9=        ░      ░         ░  ░        ░                  ░ ░      ░ ░      ░  ░"

for /L %%i in (1,1,9) do (
    set "line=!text%%i!"
    set /a "colorcode=196 + (%%i -1)*6"
    call :colorline "!line!" !colorcode!
    ping localhost -n 1 >nul
)
endlocal
goto :eof

:colorline
setlocal
set "line=%~1"
set "colorcode=%~2"
echo [38;5;%colorcode%m%line%[0m
endlocal
goto :eof

:: Main menu function with pipe lines
:mainmenu
echo.
ping localhost -n 1 >nul
echo     [90;1m#═╦═══════»[0m  [92m[System Information][0m       [95m[1][0m
ping localhost -n 1 >nul
echo       [90;1m╚═╦══════»[0m  [92m[Disk Usage][0m              [95m[2][0m
ping localhost -n 1 >nul
echo         [90;1m╚═╦═════»[0m  [92m[Network Information][0m     [95m[3][0m
ping localhost -n 1 >nul
echo           [90;1m╚═╦════»[0m  [92m[Process Viewer][0m          [95m[4][0m
ping localhost -n 1 >nul
echo             [90;1m╚═╦═══»[0m  [92m[Kill a Process][0m         [95m[5][0m
ping localhost -n 1 >nul
echo               [90;1m╚═╦══»[0m  [92m[System Cleanup][0m         [95m[6][0m
ping localhost -n 1 >nul
echo                 [90;1m╚═╦═»[0m  [92m[File Search][0m           [95m[7][0m
ping localhost -n 1 >nul
echo                   [90;1m╚═╦»[0m  [92m[Apps][0m                  [95m[8][0m
ping localhost -n 1 >nul
echo                     [90;1m╚═»[0m  [92m[Shutdown/Restart Options][0m [95m[9][0m
ping localhost -n 1 >nul
echo                       [90;1m»[0m  [92m[Exit][0m                    [95m[0][0m
echo.
goto :eof
