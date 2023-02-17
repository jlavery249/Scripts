############################################################################################################
#  Powershell Single Port Scanner                                                                                       #
#  Created by John Lavery                                                                                  #
#  Year of 2018                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  A small Powershell script simply checkts to see if a port is open or not based on the port hardcoded in #
#  the script.                                                                                             #
############################################################################################################

$q4 = 0

for ($i = 1; $i -le 254; $i++) {
    $port = "88"
    $ip = "192.168.13.$i"
    $req = Test-Connection -ComputerName $ip -Count 1 -Quiet
    
    if ($req -eq $true) {
        try {
            $socket = New-Object System.Net.Sockets.TcpClient($ip, $port)
        }
        catch {
            Write-Host "$ip not listening on port $port"
        }
        
        if ($socket.Connected) {
            Write-Host "$ip listening on port $port"
            $q4++
            $socket.Close()
        }
    }
}
