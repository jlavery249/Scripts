############################################################################################################
#  Extension search script                                                                                 #
#  Created by John Lavery                                                                                  #
#  Year of 2018                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  First line - list of all items in the specified directory and its subdirectories, and then pipes the    #
#  results to the Where-Object. This filters the list of items based on the either ".rar" or ".zip"        #
#  Second line - uses the -Include parameter to specify a list of patterns for the files that should       #
#  be included in the results. Any files that match the specified patterns will be included in the output. #
############################################################################################################

Get-ChildItem '<insert directory here>' -Recurse | ? { $_.Extension -eq ".rar" -or $_.Extension -eq "zip" }
Get-ChildItem '<insert directory here>' -Recurse -Include *.zip, *.rar
