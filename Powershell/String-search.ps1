############################################################################################################
#  String-search.ps1                                                                                       #
#  Created by John Lavery                                                                                  #
#  Year of 2020                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  Asks for a string a user wants to look for and what directory they want to find it in, it then simply   #
#  looks for just that                                                                                     #
############################################################################################################

Clear-Host

$term = Read-Host 'Please enter the phrase or term you are looking for: '
$dirpath = Read-Host 'What directory do you want to look for this in? (example: C:\Users\example\Documents\) '

if ($dirpath -ne ' ') {
    Set-Location -Path $dirpath
}

Get-ChildItem -Recurse -OutBuffer 1000 | Select-String -Pattern $term | Group-Object -Property Path | Select-Object -Property Name
