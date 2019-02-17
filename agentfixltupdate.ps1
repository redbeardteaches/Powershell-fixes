#run PS as admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

'running with full privileges'

#Set exec policy to remote signed
Set-ExecutionPolicy RemoteSigned

#Do the LabTech Things, this will delete folder in C:\windows\_LtUpdate 

if ((Get-Service  LTService) -ne $null)
{
    $lc = Get-Date (Get-ItemProperty HKLM:\Software\LabTech\Service).LastSuccessStatus -EA SilentlyContinue

    if ($lc -eq $null)
    {
        $lc = Get-Date (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\LabTech\Service).LastSuccessStatus -EA SilentlyContinue
    }

    if ($lc -ne $null -and $lc -lt (Get-Date).AddHours(2))
    {
        
        & taskkill /im ltsvcmon.exe /f 
        & taskkill /im ltsvc.exe /f 
        & taskkill /im lttray.exe /f
        Sleep 15;
        & Remove-Item -Path "C:\Windows\Temp\_LTUPDATE\" -Force -Recurse
        & Net Start LTService;
        & Start-Process -FilePath "C:\Windows\LTSvc\LTTray.exe";      
       Write-Host "Agent repair complete"
    }
}
else
{
    Write-Host "Agent is not installed currently"
}
