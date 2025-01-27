# Dockerized Proxmox Backup Client

## Benefits

There are two primary benefits to using this container:

- The PBS client is only officially available for Debian or Ubuntu.  This container enables backups on servers that have docker, but are either not based on Debian or do not want the app installed directly on the server.  Unraid is a great example.

- The PBS client is only officially available for AMD64 architecture.  A [workaround](https://docs.jdbnet.co.uk/Proxmox/Install-Proxmox-Backup-Client-on-ARM64/) has been bundled which allows this to also run on ARM64.  The most popular use would probably be Raspberry Pi servers.

## Usage

1. Install docker on server you want to backup
2. Run command below with your credentials and settings

The [official client environment variables](https://pbs.proxmox.com/docs/backup-client.html) are leveraged, along with additional environment variables:

| Variable | Required? | Description | Example |
| -------- | :-------: | ----------- | ------- |
| CRON_SCHEDULE | Yes | Schedule you want backups to run | 00 03 * * * |
| BACKUP_TARGETS | Yes | Targets you wish to back up | etc.pxar:/etc var.pxar:/var |
| EXCLUDED_DIRECTORIES | No | Directories paths you wish to EXCLUDE from back up separated by whitespace | /proc /sys /dev /run /tmp /mnt /media /var/cache /var/tmp |
| NAMESPACE | No | Save to this Namespace on Proxmox Backup Server if you dont want to save to root dir of your storage | My_favorite_servers |
| CUSTOM_HOST | No | Sets the host label on the backup server, defaults to container host name | nas1 |

### Example

```bash
docker run \
    -e BACKUP_TARGETS="root.pxar:/mnt/root" \
    -e EXCLUDED_DIRECTORIES="/proc /sys /dev /run /tmp /mnt /media /var/cache /var/tmp" \
    -e CRON_SCHEDULE="00 03 * * *" \
    -e PBS_REPOSITORY="your@user@your.server.ip.or.hostname:your_storage_name" \
    -e PBS_FINGERPRINT="XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX" \
    -e PBS_PASSWORD="REPLACE_WITH_YOUR_PBS_PASS" \
    -e CUSTOM_HOST="bobs-server" \
    -e NAMESPACE="My_favorite_servers" \
    --tmpfs /tmp \
    -v /:/mnt/root:ro \
    -d \
    gossuzyx/proxmox-backup-client:latest
```

### Note
When running your docker container, you need to set [the tmpfs mount](https://docs.docker.com/storage/tmpfs/) to /tmp.  If you don't, [your fidx and didx files from the previous backup will not be readable](https://forum.proxmox.com/threads/proxmox-backup-client-in-docker-subsequential-backups-never-reuse-data.107472/post-462447) and you won't get an accurate incremental backup.

