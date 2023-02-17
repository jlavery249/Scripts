############################################################################################################
#  Powershell Quick Network Survey Tool                                                                                         #
#  Created by John Lavery                                                                                  #
#  Year of 2018                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  A small Powershell script that prompts you with a menu to perform a ping sweep on a hardcoded range,    #
#  do a port sweep on the hardcoded range of common ports or remotely connect to a specific machine via    #
#  Enter-Pssession if necessary                                                                            #
############################################################################################################

function pingsweep {
    $subnet = "X.X.X.X"
    $start = 1
    $end = 40
    $ping = 1
    while ($start -lt $end) {
        $IP = "X.X.X.$start"
        Write-Host "Pinging $IP" -ForegroundColor Cyan
        Test-Connection -ComputerName $IP -Count 1 -Quiet
        $start++
    }
}

function portsweep {
    $ports = @(80, 3389, 135, 443, 45, 139, 22, 23, 8080, 8000, 53)
    $ip = "X.X.X.X"
    foreach ($port in $ports) {
        try {
            $socket = New-Object System.Net.Sockets.TcpClient($ip, $port)
        } catch {}
        if ($socket -eq $null) {
            echo "$ip:$port - Closed"
        } else {
            echo "$ip:$port - Open"
            $socket = $null
        }
    }
}

Write-Host "Quick PS Scanner Tool"
Write-Host "What do you want to do?"
Write-Host ""
Write-Host "1. Ping Sweep"
Write-Host "2. Port Sweep"
Write-Host "3. Remotely connect to machine X.X.X.X"
Write-Host ""

$Readhost = Read-Host "> "
Switch ($Readhost) {
    1 {
        pingsweep
    }
    2 {
        portsweep
    }
    3 {
        Enter-PSSession X.X.X.X
    }
}
