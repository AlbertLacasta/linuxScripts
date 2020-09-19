#!/bin/bash
# Create INCREMENTAL Backup entire linux system using rsynk

# The directory that you want to backup
readonly SOURCE_DIR="/"

# Destination of the backup
readonly BACKUP_DIR="/mnt/backups"

# Get system datetime
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"

readonly HOST_NAME="${hostname}"

# make backup path
readonly BACKUP_PATH="${BACKUP_DIR}/${HOST_NAME}-${DATETIME}"

# Get the lastest link for the incremental backup
readonly LATEST_LINK="${BACKUP_DIR}/latest"

# execute backup  
rsync -avx --delete --exclude="/tmp/*" --exclude="/mnt/*" --exclude="proc/*" --link-dest "${LATEST_LINK}" "${SOURCE_DIR}" "${BACKUP_PATH}"

# Remove old link
rm -rf "${LATEST_LINK}"

# generate new one
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
