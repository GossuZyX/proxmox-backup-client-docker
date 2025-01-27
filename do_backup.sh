#!/bin/bash

CUSTOM_HOST_STRING=""
CUSTOM_NAMESPACE_STRING=""
if [ ! -z "$CUSTOM_HOST" ]; then
    CUSTOM_HOST_STRING="--backup-id $CUSTOM_HOST"
fi

if [ ! -z "$NAMESPACE" ]; then
    CUSTOM_NAMESPACE_STRING="--ns $NAMESPACE"
fi

echo "------------------------------------------------------------"
proxmox-backup-client backup $BACKUP_TARGETS $CUSTOM_HOST_STRING $CUSTOM_NAMESPACE_STRING
echo "------------------------------------------------------------"
