#!/bin/bash


###########################################################################
# Script: backup_script.sh
# Purpose: Automate backups of IMP files and directories.
# Auther: Prajwal Deshpande 
# Date: 23-7-2023
###########################################################################


# Configuration
backup_folder="/path/to/backup/folder"  # Replace with the actual backup folder path
datestamp=$(date +%Y-%m-%d_%H-%M-%S)
backup_filename="backup_$datestamp.tar.gz"
log_file="backup_log.txt"

# List of files/directories to backup
files_to_backup=(
    "/path/to/important/file1.txt"
    "/path/to/important/directory"
    # Add more files/directories to backup as needed
)

# Check required commands
required_commands=("tar" "date" "mkdir")
for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" > /dev/null; then
        echo "Error: '$cmd' command not found. Make sure it's installed and available in the system PATH."
        exit 1
    fi
done

# Create backup folder if it doesn't exist
mkdir -p "$backup_folder"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
}

# Perform the backup
log "Starting backup..."

# Compress and backup each file/directory
for item in "${files_to_backup[@]}"; do
    if [ -e "$item" ]; then
        if [ "$item" != "$backup_folder" ]; then
            log "Backing up $item..."
            tar -czf "$backup_folder/$backup_filename" "$item" || log "Failed to backup $item!"
        else
            log "Skipping backup of the backup folder: $item"
        fi
    else
        log "$item does not exist. Skipping..."
    fi
done

log "Backup completed!"

