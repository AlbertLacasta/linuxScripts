#!/bin/bash
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=90

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Disk Space Alert' stormdatacenter@gmail.com << EOF
Your root partition remaining free space is critically low. Used: $CURRENT%
EOF
fi
