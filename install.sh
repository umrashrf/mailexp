#!/bin/sh

set -x

curl -L https://github.com/umrashrf/mailexp -o /tmp/mailexp.zip
mkdir -p /tmp/mailexp
unzip /tmp/mailexp.zip -d /tmp/mailexp/
cd /tmp/mailexp

cp -rf postfix/* /etc/postfix/
cp -rf dovecot.conf /etc/dovecot/
cp users /etc/dovecot/

chown root:dovecot /etc/dovecot/users
chmod 640 /etc/dovecot/users

adduser -D umair mail

mkdir -p /home/umair/Maildir/cur && \
    mkdir -p /home/umair/Maildir/new && \
    mkdir -p /home/umair/Maildir/tmp

chown umair:umair -R /home/umair/Maildir

echo "umair:test" | chpasswd

awk '{gsub(/smtp\t+25/, "smtp\t\t36245"); print}' /etc/services > /tmp/services
cp /tmp/services /etc/ && rm /tmp/services

rm -rf /tmp/mailexp

# newaliases && postfix start
# dovecot -F
