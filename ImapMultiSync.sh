#!/bin/bash

#Source server
SERVER1=imap.gmail.com

#Destination server
SERVER2=imap.gmail.com

#Speed up by skipping folder size parse
#SKIP="--nofoldersizes"

#Dryrun
#DRY="--dry"

#Only copy folders
#FOLDERS="--justfolders"

#Set path to imapsync
imapsync=imapsync

#User file format: User1;Pass1;User2;Pass2
if [ -z "$1" ]
then
    echo "No input file."
    exit
fi

if [ ! -f "$1" ]
then
    echo "\"$1\" not found."
    exit
fi

{ while IFS=';' read  u1 p1 u2 p2; do

    $imapsync --usecache --tmpdir /var/tmp \
        --host1 ${SERVER1} --user1 "$u1" \
        --password1 "$p1" --ssl1 \
        --host2 ${SERVER2} \
        --port2 993 --user2 "$u2" \
        --password2 "$p2" --ssl2 \
        ${SKIP} ${DRY} ${FOLDERS} \
        --exclude 'INBOX.Trash|INBOX.spam|INBOX.Apple Mail To Do'

done ; } < $1

