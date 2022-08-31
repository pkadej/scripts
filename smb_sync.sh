#!/bin/bash

BACKUP_DIR=/mnt/backup
SOURCE_DIR=/mnt/source/

MNT_SOURCE_SAMBA="-t cifs -o vers=2.0,user=login,pass=pass //ip.ip.ip.ip/shared"
MNT_BACKUP_SAMBA="-t cifs -o vers=2.0,user=login,pass=pass //ip.ip.ip.ip/backup"

echo `date`
if mountpoint -q $SOURCE_DIR; then
        echo "Unmounting $SOURCE_DIR";
        umount -f $SOURCE_DIR
fi

if mountpoint -q $BACKUP_DIR; then
        echo "Unmounting $BACKUP_DIR";
        umount -f $BACKUP_DIR
fi


mount $MNT_SOURCE_SAMBA $SOURCE_DIR
mount $MNT_BACKUP_SAMBA $BACKUP_DIR
echo "Everything mounted. Launching rsync."

rsync -av --delete $SOURCE_DIR $BACKUP_DIR

echo "Cleaning up."
umount $SOURCE_DIR
umount $BACKUP_DIR
