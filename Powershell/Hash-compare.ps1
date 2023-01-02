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

$fin = read-host -Prompt "Hash List File Location"
write-host "Gathering system file hashes now, This may take a while..." 
Compilesystem-Hashes 
IOCHash-Compare
