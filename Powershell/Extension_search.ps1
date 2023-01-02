Get-ChildItem 'C:\users\DCI Student\Documents\exercise_8' -Recurse | ? { $_.Extension -eq ".rar" -or $_.Extension -eq "zip" }
Get-ChildItem 'C:\users\DCI Student\Documents\exercise_8' -Recurse -Include *.zip *.rar
