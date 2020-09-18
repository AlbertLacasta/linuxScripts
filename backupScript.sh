#!/bin/bash
# Create INCREMENTAL Backup entire linux system using rsynk

# The directory that you want to backup
readonly SOURCE_DIR="/"

# Destination of the backup
readonly BACKUP_DIR="/mnt/backups"

# Get system datetime
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"

# make backup path
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"

# Get the lastest link for the incremental backup
readonly LATEST_LINK="${BACKUP_DIR}/latest"

# execute backup
rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  --exclude=".cache" \
  "${BACKUP_PATH}"

# Remove old link
rm -rf "${LATEST_LINK}"

# generate new one
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
