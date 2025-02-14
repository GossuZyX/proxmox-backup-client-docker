#!/bin/bash

CUSTOM_HOST_STRING=""
CUSTOM_NAMESPACE_STRING=""
CUSTOM_EXCLUDED_DIRECTORIES_STRING=""
if [ ! -z "$CUSTOM_HOST" ]; then
    CUSTOM_HOST_STRING="--backup-id $CUSTOM_HOST"
fi

if [ ! -z "$NAMESPACE" ]; then
    CUSTOM_NAMESPACE_STRING="--ns $NAMESPACE"
fi

if [ ! -z "$EXCLUDED_DIRECTORIES" ]; then
    CUSTOM_EXCLUDED_DIRECTORIES_STRING=""

    # Split EXCLUDED_DIRECTORIES by spaces
    read -ra DIR_ARRAY <<< "$EXCLUDED_DIRECTORIES"

    for DIR in "${DIR_ARRAY[@]}"; do
        # Trim spaces and check if directory exists
        DIR=$(echo "$DIR" | xargs)
        if [ -d "$DIR" ]; then
            CUSTOM_EXCLUDED_DIRECTORIES_STRING+="--exclude $DIR "
        fi
    done

    # Remove trailing space
    CUSTOM_EXCLUDED_DIRECTORIES_STRING=$(echo "$CUSTOM_EXCLUDED_DIRECTORIES_STRING" | xargs)
fi


echo "------------------------------------------------------------"
echo $(date +"%d.%m.%Y %H:%M:%S")
echo "Executing: proxmox-backup-client backup $BACKUP_TARGETS $CUSTOM_EXCLUDED_DIRECTORIES_STRING $CUSTOM_HOST_STRING $CUSTOM_NAMESPACE_STRING"
proxmox-backup-client backup $BACKUP_TARGETS $CUSTOM_EXCLUDED_DIRECTORIES_STRING $CUSTOM_HOST_STRING $CUSTOM_NAMESPACE_STRING
echo "------------------------------------------------------------"
