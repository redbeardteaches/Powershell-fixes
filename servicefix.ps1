$path1='HKLM:\SOFTWARE\<yoursoftwarename>\service';
$path2='HKLM:\SOFTWARE\<yoursoftwarename>\service\settings';
$array1 = @("<key1>","<key2>");
$array2 = @("<key3>","<key4>","<key5>","<key6>","<key7>","<key8>");
Stop-Service <yourservice> -force -confirm:$false;
Stop-Service <yourservice> -force -confirm:$false;
ForEach($item in $array1)
{Remove-ItemProperty -path $path1 -name $item };
ForEach($item in $array2)
{Remove-ItemProperty -path $path2 -name $item };
Start-Service <yourservice>;
Start-Service <yourservice>;
