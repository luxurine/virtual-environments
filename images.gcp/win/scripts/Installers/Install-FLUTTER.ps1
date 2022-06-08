################################################################################
##  File:  Install-FLUTTER.ps1
##  Desc:  Install FLUTTER SDK
################################################################################

Write-Host "Install-Package Android Studio"
Choco-Install -PackageName androidstudio

Write-Host "Install-Package vscode"
Choco-Install -PackageName vscode

Write-Host "Download Latest flutter archive"
$toolsetVersion = (Get-ToolsetContent).flutter.version
$ZipballUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_$toolsetVersion-stable.zip"
$flutterArchivePath = Start-DownloadWithRetry -Url $ZipballUrl -Name "flutter.zip"

Write-Host "Expand flutter archive"
$flutterPath = "C:\"
Extract-7Zip -Path $flutterArchivePath -DestinationPath $flutterPath

# Add flutter to path
Add-MachinePathItem "${flutterPath}\flutter\bin"

# Set Android Studio Dir
#flutter config --android-studio-dir="C:\Program Files\Android\Android Studio"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "FLUTTER"