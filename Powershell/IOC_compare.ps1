$a= 1
$ipiocs = Get-Content ips.txt
$fileiocs = Get-Content files.txt
$regiocs = get-content reg.txt

while ($a -le 255)
{
    if(Test-Connection -Count 1 -Quiet 10.10.10.$a) {
    $ip = 10.10.10.$a
set-item WSMan:\localhost\Client\TrustedHosts -Value "$ip" -Concatenate
    Invoke-command -ComputerName $ip -ScriptBlock { $using:fileiocs | ForEach-Object { $x = null; $x = Get-ChildItem $_; if( $x.Length -ne 0) { $x } }  #using uses a local variable on a remote box
    }
    $a++;
}

    Get-item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run | % { $reg = $_.Property; $using:regicos | ? { $reg -eq $_ } }
