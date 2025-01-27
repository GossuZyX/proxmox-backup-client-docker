#!/bin/bash

CUSTOM_HOST_STRING=""
CUSTOM_NAMESPACE_STRING=""
if [ ! -z "$CUSTOM_HOST" ]; then
    CUSTOM_HOST_STRING="--backup-id $CUSTOM_HOST"
fi

if [ ! -z "$CUSTOM_NAMESPACE" ]; then
    CUSTOM_NAMESPACE_STRING="--ns $CUSTOM_NAMESPACE"
fi

echo "------------------------------------------------------------"
proxmox-backup-client backup $BACKUP_TARGETS $CUSTOM_HOST_STRING $CUSTOM_NAMESPACE_STRING
echo "------------------------------------------------------------"
