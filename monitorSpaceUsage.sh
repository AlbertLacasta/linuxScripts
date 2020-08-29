#!/bin/bash

LIMIT='80'
#Here we declare variable LIMIT with max of used spave

DIR='/'
#Here we declare variable DIR with name of directory that we want to monitor

MAILTO='stormdatacenter@gmail.com'
#Here we declare variable MAILTO with email address

SUBJECT="$DIR disk usage"
#Here we declare variable SUBJECT with subject of email

MAILX='mailx'
#Here we declare variable MAILX with mailx command that will send email

which $MAILX > /dev/null 2>&1
#Here we check if mailx command exist

if ! [ $? -eq 0 ]
#We check exit status of previous command if exit status not 0 this mean that mailx is not installed on system
then
          echo "Please install $MAILX"
#Here we warn user that mailx not installed
          exit 1
#Here we will exit from script
fi

cd $DIR
#To check real used size, we need to navigate to folder

USED=`df . | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`    
#This line will get used space of partition where we currently, this will use df command, and get used space in %, and after cut % from value.

if [ $USED -gt $LIMIT ]
#If used space is bigger than LIMIT

then
      du -sh ${DIR}/* | $MAILX -s "$SUBJECT" "$MAILTO"
#This will print space usage by each directory inside directory $DIR, and after MAILX will send email with SUBJECT to MAILTO
fi
