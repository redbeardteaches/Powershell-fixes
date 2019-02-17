#PS script that will take a script saved in "Script.txt" and encode it base64 and save it to "EncodedScript.txt"
$scriptRaw = Get-Content "$PSScriptRoot\Script.txt" | Out-String
$bytes = [System.Text.Encoding]::Unicode.GetBytes($scriptRaw)
$encodedCommand = [Convert]::ToBase64String($bytes)
OUt-File -InputObject $encodedCommand  "$PSScriptRoot\EncodedScript.txt" -Encoding unicode 
