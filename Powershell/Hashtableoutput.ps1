############################################################################################################
#  Hash Compare Specific Dirs                                                                              #
#  Created by John Lavery                                                                                  #
#  Year of 2018                                                                                            #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  Gathers a systems file hashes in the directory hardcoded in the script and then outputs them to a table #  
#  script is helpful specifically if you are looking for bad files and then compare them to the proper     #
#  hashes online
############################################################################################################

# Get hashes of System32 directory and save the results to a file
Get-FileHash -Path C:\Windows\System32\* |
    Format-Table -AutoSize |
    Out-File -FilePath C:\Users\test\Documents\hashtable.txt

# Get hashes of System\drivers directory and add the results to the same file
Get-FileHash -Path C:\Windows\System\drivers\* |
    Format-Table -AutoSize |
    Out-File -FilePath C:\Users\test\Documents\hashtable.txt -Append
