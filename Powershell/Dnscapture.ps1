############################################################################################################
#  DNS Capture Script                                                                                           #
#  Created by John Lavery                                                                                  #
#  Year of 2018                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  Scirpt performs a networks scan on a hardcoded network range and checks to see if the host is active    #
#  it then checks to see if it matches a DNS name hardcoded using the Resolve-DNSName cmdlet               #
############################################################################################################

for ($i=1; $i -le 254; $i++) {
    $ip = "192.168.13.$i"
    $req = Test-Connection -ComputerName $ip -Count 1 -Quiet
    Write-Host "Pinging $ip"
    if ($req -eq $true) {
        Write-Host "Success" -ForegroundColor Green
        Write-Host "Testing DNS for $ip"
        $dns = Resolve-DnsName -Name google.com -Server $ip -QuickTimeout -ErrorAction SilentlyContinue
        if ($dns) {
            Write-Host "Success" -ForegroundColor Green
        } else {
            Write-Host "Failed" -ForegroundColor Red
        }
    }
    if ($req -eq $false) {
        Write-Host "Failed" -ForegroundColor Red
    }
}
