# Monitoring centos server and send mails

## Introduction

The ability to send e-mail alerts is essential for the day to day management of any VPS. For system administrators (and users alike), being able to take advantage of this [new] possibility not only makes things easier, but also provides you with many allies in your combat against thieves or downtime with triggers you can create.

We are going to learn how to simply send e-mail alerts on a CentOS VPS and talk about various triggers that we can set to establish better overall security and to maintain a smooth running system all around. We will do this by understanding basics of e-mail, going over the necessary applications along with examples of various e-mail alert triggers you can set and the logic behind identifying critical needs to create more.

## Installation of mailx

We will be working with **Heirloom mailx**, a fantastic Mail User Agent derived from *Berkeley Mail*. It provides additional support for several protocols including (but not limited to) IMAP, POP3 and of course SMTP. It will be the tool we use to receive alerts and system warnings.

Let’s begin with updating our system.

**In order to update your system, run the following:**

```bash
yum update
```

Getting started with mailx is quite simple. We will be using the yum package manager to download and have it installed.

```bash
yum install -y mailx
```

Some monitoring scripts and applications might use “email” instead “mail” or “mailx” to send e-mails. If you find yourself in this situation, you can create a *symbolic link*, pointing (referencing) to mailx.

Below, we are creating a symbolic link for “mail” to execute “mailx”.

**In order to create a symbolic link, run the following (replace /bin/email with the link name required):**

```bash
 ln -s /bin/mailx /bin/email
```

**Open up “mail.rc” using “vim”:**

```
vim /etc/mail.rc
```

Add the following lines:

```bash
set smtp-use-starttls
set ssl-verify=ignore
set smtp-auth=login
set smtp=smtp://smtp.gmail.com:587
set from="your-mail@gmail.com(storm)"
set smtp-auth-user=your-mail@gmail.com
set smtp-auth-password=your-mail-password
set ssl-verify=ignore
set nss-config-dir=folder-with-gmail-cert

```

##Sending e-mails with `mail` (or `mailx`)

** Befor to send email activate the following option in your sender google acount : https://myaccount.google.com/u/1/lesssecureapps?gar=1 **

Here are some of the available options of **Heirloom mailx**:

- `-a` **file** Allows you to attach the given file to the e-mail
- `-b` **address** Sends *blind carbon copies* to the comma separated e-mail address list
- `-c` **address** Sends *copies* to a list of users
- `-q` **file** Sets the message contents from the given file
- `-r` **from address** Sets the from address of the e-mail to be sent
- `-s` **subject** Sets the e-mail subject

**Example usage:**

Sending a simple message:

```bash
 echo "Your message" | mail -s "Message Subject" email@address
```

##Setting Up Alerts for System Monitoring, Warnings and Security Alarms

As we have everything ready, we can now look into several different examples of alerts we can get our server to issue and email.

**Create a new text file using vim for the bash script:**

```bash
vim monitor_disk_space.sh
```

**Copy and paste the contents from the URL:**

```bash
#!/bin/bash
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=90

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Disk Space Alert' your-mail@gmail.com << EOF
Your root partition remaining free space is critically low. Used: $CURRENT%
EOF
fi
```

**Note:** Please do not forget to replace `your-mail@gmail.com` with your e-mail address.

**Give the file executable permission using “chmod”:**

```bash
$ chmod +x monitor_disk_space.sh
```



**More scripts on the github : <https://github.com/AlbertLacasta/linuxScripts/tree/master>**
