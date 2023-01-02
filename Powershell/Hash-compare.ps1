
############################################################################################################
#  Hash Compare                                                                                            #
#  Created by John Lavery                                                                                  #
#  Year of 2022                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  Gathers a systems file hashes and then compares them to a list of file hashes that are specified. This  #
#  script is helpful specifically if you are looking for bad files by file system hash integrity           #
############################################################################################################

## Declaring functions
Function IOCHash-Compare
{
    select-string -Pattern (gc $fin) -Path C:\FilesHash.csv
}

Function Compilesystem-Hashes
{
    Get-ChildItem -Path C:\ -Recurse -Exclude C:\FilesHash.csv -ErrorAction SilentlyContinue |
        Get-FileHash -ErrorAction SilentlyContinue |
        Export-Csv -Path C:\FilesHash.csv -NoTypeInformation
}

## user prompt and run through declared functions

$fin = read-host -Prompt "Hash List File Location"
write-host "Gathering system file hashes now, This may take a while..." 
Compilesystem-Hashes 
IOCHash-Compare
