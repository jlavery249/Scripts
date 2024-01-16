############################################################################################################
#  Download Simulator Script                                                                               #
#  Created by John Lavery                                                                                  #
#  1/16/2024                                                                                               #
#  Written in Powershell                                                                                   #
#  Description:                                                                                            #
#  This script was created to simulate downloading of files as a user would at different intervals within  #
#  a time range specified. In order for this to work properly, there are a few of prereqs:                 #
#  1) A file with file names you want to download must be specified in the script. This is the file where  #
#  the names will come from to download from the remote server.                                            #
#  2) A URL where the files will be downloaded from, the files that are in the list of file names MUST     #
#  match with the file names on the server or it will fail                                                 #
#  3) A place to put the "Downloaded_strings.txt" file, this file contains all the names of the files      #
#  already downloaded so it doesn't create duplicates. Not a deal breaker but if you don't want duplicate  #
#  files....                                                                                               #
#                                                                                                          #
#  Inspired by the MITRE Caldera platform for advesary simulation:                                         #
#  https://github.com/mitre/caldera                                                                        #
############################################################################################################

# Specify the full path to the file that has the list of filenames you want to download
$filePath = "C:\filelist.txt"

# Specify the web server URL hosting the files
$webServerURL = "http://your-ip:port/"

# Specify the directory for where downloaded files go
$downloadDirectory = "C:\DownloadedFiles\"

# Create file that tracks the filenames it already downloaded
$trackingFile = "C:\downloaded_strings.txt"

# Function to generate a random delay between 2 and 3 seconds (for testing purposes)
# To increadse just change the minium and maximum parameters to your liking
function Get-RandomDelay {
    Get-Random -Minimum 2 -Maximum 3 # min an max are annotated in seconds
}

# Infinite loop
while ($true) {
    # Wait for a random delay between 2 and 3 seconds
    Start-Sleep -Seconds (Get-RandomDelay)

    # Check if the file exists
    if (Test-Path $filePath) {
        # Get the content of the tracking file
        $downloadedStrings = Get-Content -Path $trackingFile -ErrorAction SilentlyContinue

        # Get the content of the file
        $fileContent = Get-Content -Path $filePath -Raw

        # Split the content into an array of strings
        $fileArray = $fileContent -split "`r`n" -split "`n" -split "`r"

        # Filter out empty lines
        $fileArray = $fileArray | Where-Object { $_ -ne '' }

        # Exclude already downloaded strings
        $remainingStrings = $fileArray | Where-Object { $_ -notin $downloadedStrings }

        # Check if there are remaining strings
        if ($remainingStrings.Count -gt 0) {
            # Get a random index from the remaining strings
            $randomIndex = Get-Random -Minimum 0 -Maximum $remainingStrings.Count

            # Select the random string
            $randomString = $remainingStrings[$randomIndex]

            # Construct the URL using the random string
            $downloadURL = "$webServerURL$randomString"

            # Specify the full path for the downloaded file
            $downloadPath = Join-Path -Path $downloadDirectory -ChildPath $randomString

            # Use Invoke-WebRequest to download the content
            Invoke-WebRequest -Uri $downloadURL -OutFile $downloadPath

            # Add the downloaded string to the tracking file
            Add-Content -Path $trackingFile -Value $randomString

            Write-Output "Content downloaded successfully. Saved as: $downloadPath"
        } else {
            Write-Output "No remaining strings to download."
        }
    } else {
        Write-Output "File not found at path: $filePath"
    }
}
