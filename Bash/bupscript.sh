#!/bin/bash

# Author: John Lavery
# Date created: 2023
# Description: This script performs data backup by creating a ZIP archive of a specified data directory and storing it in a backup directory. It checks for available disk space and ensures that the 'zip' command is available.
# Usage:
#   -d: Specify the data directory (optional, default is './data').
#   Example: $0 -d /path/to/data_directory
#   Note: The script must be run as root (sudo) and requires at least 10GB of available disk space.
#         The backup is stored in the user's home directory in a hidden directory '.data_backups'.

# Used for error correction
# Terminates if weird things are used
set -eu

# Declare default values
data_dir="./data"
user_home_dir="$HOME"
backup_dir="$user_home_dir/.data_backups"
min_disk_space_required=10

# Specifies options, allows optional backup dir location
# declared by user
while getopts "d:" opt; do
  case $opt in
    d) data_dir="$OPTARG";;
    \?) echo "Usage: $0 [-d data_directory]"; exit 1;;
  esac
done

# Check if the 'zip' command is available
check_dependencies() {
  if ! command -v zip > /dev/null; then
    echo "Error: 'zip' command not found. Please install it." >&2
    exit 1
  fi
}

# Check if the script is run as root (sudo)
check_root() {
  if [[ $(id -u) -ne 0 ]]; then
    echo "Error: Script must be run as root (sudo)." >&2
    exit 1
  fi
}

# Check if there is enough disk space for the backup
check_disk_space() {
  available_space=$(df -B1G --output=avail / | tail -n 1)
  if (( available_space < min_disk_space_required )); then
    echo "Error: Not enough disk space. Backup failed." >&2
    exit 1
  fi
}

# Create a backup of the specified data directory
backup_data() {
  timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
  zip_name="$backup_dir/data_backup_$timestamp.zip"

  if zip -q -r "$zip_name" "$data_dir"; then
    echo "Files archived and moved to '$zip_name'."
  else
    echo "Error: Archive not created." >&2
  fi
}

# Main function
main() {
  check_dependencies
  check_root
  check_disk_space

  # User confirmation before proceeding with the backup
  read -p "Do you want to proceed with the backup? (y/n): " confirm
  if [[ $confirm =~ ^[Yy]$ ]]; then
    if [[ ! -d "$data_dir" ]]; then
      mkdir -p "$data_dir"
    fi

    if [[ ! -d "$backup_dir" ]]; then
      mkdir -p "$backup_dir"
    fi

    backup_data
  else
    echo "Backup canceled."
  fi
}

# Call main()
main
