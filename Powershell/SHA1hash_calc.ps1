#############################################################################################
#  SHA1 Hash calculator                                                                     #
#  Created by John Lavery                                                                   #
#  Year of 2018                                                                             #
#  Written in Powershell                                                                    #
#  Description:                                                                             #
#   This oneliner searches for all files in the specified directory and its subdirectories  #
#   and calculates the SHA1 hash for each file. The hash and path for each file are then    #
#   displayed in a list.                                                                    #
#############################################################################################

Get-ChildItem 'C:\users\DCI Student\Documents\exercise_8' -Recurse | % { Get-Item $_.FullName -Stream * } | where stream -ne ':$Data' | % { Get-filehash -algorithm SHA1 $_.filename } | select hash, path | format-list
