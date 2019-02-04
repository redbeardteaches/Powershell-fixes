$RegKey = “HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System”
if (-Not(Test-Path “$RegKey”)) 
{New-Item -Path “$($RegKey.TrimEnd($RegKey.Split(‘\’)[-1]))” -Name “$($RegKey.Split(‘\’)[-1])” -Force | Out-Null}
Set-ItemProperty -Path “$RegKey” -Name “FilterAdministratorToken” -Type Dword -Value “1”
