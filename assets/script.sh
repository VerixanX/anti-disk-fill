#! /bin/bash

while true
do
FOLDER=/var/lib/pterodactyl/volumes

MAXSIZEINGIGS=32

MAXSIZE=$(( $MAXSIZEINGIGS * 1024 * 1024 ))
FOLDERSIZE=`du -ks $FOLDER | cut -f1`

if [ $FOLDERSIZE -gt $MAXSIZE ]
then
        rm -r $FOLDER/*
fi
sleep 1
done
