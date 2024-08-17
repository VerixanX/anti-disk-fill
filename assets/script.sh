#!/bin/bash

FOLDER=/var/lib/pterodactyl/volumes
MAXSIZEINGIGS=5  # Changed to 5GB

# Convert GB to KB (1GB = 1024*1024 KB)
MAXSIZE=$(( $MAXSIZEINGIGS * 1024 * 1024 ))

while true
do
    FOLDERSIZE=$(du -ks "$FOLDER" | cut -f1)

    if [ $FOLDERSIZE -gt $MAXSIZE ]
    then
        rm -r "$FOLDER"/*
    fi

    sleep 10
done
