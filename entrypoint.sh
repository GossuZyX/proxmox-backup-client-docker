#!/bin/bash

cleanup() {
	echo "Exiting..."
	exit 0
}

trap cleanup SIGINT
trap cleanup SIGTERM

# Exit if BACKUP_TARGETS is not set
if [ -z "$BACKUP_TARGETS" ]; then
	echo "BACKUP_TARGETS is not set. Set in the form of 'root.pxar:/' or several separated by space, like 'etc.pxar:/etc var.pxar:/var'. Exiting."
	exit 1
fi

# Exit if no CRON_SCHEDULE is set
if [ -z "$CRON_SCHEDULE" ]; then
	echo "CRON_SCHEDULE is not set. Set in the form of Cron timing, e.g. '00 03 * * *' for 3am every day.  Exiting."
	exit 1
fi

# Warn that no NAMESPACE is set
if [ -z "$NAMESPACE" ]; then
	echo "NAMESPACE is not set. We will use root directory of storage."
fi

env > /cronfile
echo "$CRON_SCHEDULE /do_backup.sh > /proc/1/fd/1 2>&1" >> /cronfile
crontab /cronfile
rm -f /cronfile
cron

echo "Backup targets: $BACKUP_TARGETS"
echo "Cron schedule: $CRON_SCHEDULE"
echo "Namespace: $NAMESPACE"
echo "Excluded directories: $EXCLUDED_DIRECTORIES"
echo "Starting backup service..."

# Loop forever
while true; do
	sleep 1
done
