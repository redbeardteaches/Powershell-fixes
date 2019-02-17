#Requires -Version 3.0

#PSASADMIN

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

#securitystuff

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

#check if cert exists

if (Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object {$_.Thumbprint -eq "b1bc968bd4f49d622aa89a81f2150152a41d829c"}){"The cert exists!!!"} else 
{

#Download the cert

$url = "https://secure.globalsign.net/cacert/Root-R1.crt"
$output = "C:\windows\temp\Root-R1.crt"
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#install the cert

CERTUTIL -addstore -enterprise -f -v root "C:\Windows\temp\Root-R1.crt"
}
