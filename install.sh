#!/bin/sh

set -x

curl -L https://github.com/umrashrf/mailexp/archive/refs/heads/script.zip -o /tmp/mailexp.zip
unzip /tmp/mailexp.zip -d /tmp
cd /tmp/mailexp-script

cp -rf postfix/* /etc/postfix/
cp -rf dovecot.conf /etc/dovecot/
cp users /etc/dovecot/

chown root:dovecot /etc/dovecot/users
chmod 640 /etc/dovecot/users

if ! getent group mail > /dev/null 2>&1; then
    addgroup mail
fi
useradd -m -g mail umair

mkdir -p /home/umair/Maildir/cur && \
    mkdir -p /home/umair/Maildir/new && \
    mkdir -p /home/umair/Maildir/tmp

chown umair:umair -R /home/umair/Maildir

echo "umair:test" | chpasswd

awk '{gsub(/smtp\t+25/, "smtp\t\t36245"); print}' /etc/services > /tmp/services
cp /tmp/services /etc/ && rm /tmp/services

rm -rf /tmp/mailexp*

# newaliases && postfix start
# dovecot -F
