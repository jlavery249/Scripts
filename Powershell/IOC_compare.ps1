############################################################################################################
#  IOC compare                                                                                             #
#  Created by John Lavery                                                                                  #
#  Year of 2018                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  Scans through . #
############################################################################################################

$a = 1
$fileiocs = Get-Content <list of iocs you are looking for>
$regiocs = get-content <

while ($a -le 255)
{
    if (Test-Connection -Count 1 -Quiet 10.10.10.$a)
    {
        $ip = 10.10.10.$a
        set-item WSMan:\localhost\Client\TrustedHosts -Value "$ip" -Concatenate
        Invoke-command -ComputerName $ip -ScriptBlock {
            $using:fileiocs | ForEach-Object {
                $x = null
                $x = Get-ChildItem $_
                if ($x.Length -ne 0) { $x }
            }
        }
    }
    $a++
}

Get-item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run | % {
    $reg = $_.Property
    $using:regicos | ? { $reg -eq $_ }
}
