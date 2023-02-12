#! /bin/bash

while true
do
FOLDER=/var/lib/pterodactyl/volumes

MAXSIZEINGIGS=32

MAXSIZE=$(( $MAXSIZEINGIGS * 51200 * 51200 ))
FOLDERSIZE=`du -ks $FOLDER | cut -f1`

if [ $FOLDERSIZE -gt $MAXSIZE ]
then
        rm -r $FOLDER/*
fi
sleep 1
done
