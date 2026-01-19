[<img src="https://i.imgur.com/oRFWBv7.png" height="80px" />](https://buymeacoffee.com/umrashrf)

# EMAIL (36245 port)

mailexp stands for mail experiment. 

The purpose of this software is to re-invent email not replace it. mailexp will not be able to send email on port 25 which is the default port used by email services like gmail, hotmail, yahoo, etc and you name it. This means that you will NOT be able to send or receive emails from your gmail, hotmail, outlook, live, microsoft, yahoo, fastmail, or any other services which already exist.

mailexp runs on port 36245 and only email servers sending email on that port will be able to receive them. At this moment, this is only mailexp.

For your friends, family, coworkers or any other person to send you an email using mailexp software, they have to also have the same mailexp software.

You do not need to run your mailexp software all the time. mailexp uses postfix which is designed to retry sending email if not sent.

## Caution:

This is an extremely early minimum viable product (MVP) and privacy and security is overlooked for rapid development. Future releases will add additional security and privacy.

## Requirements:

1. Linux, Mac or Windows running computer or laptop
2. Download and Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Setup your domain name

Note 1: In this guide, I am using my domain but you must use your domain. You must set A and MX records.

```
A       YOUR_IP_ADDRESS
MX      YOUR_DOMAIN             10
```

Note 2: If your firewall is enabled, allow port 36245 on your computer firewall as well as your router.

## Build

```
docker build -t riamumail:latest .
```

## Run

```
docker run --rm --dns 8.8.8.8 --hostname riamumail.com -p 0.0.0.0:36245:36245 -p 0.0.0.0:10143:143 riamumail
```

Now hopefully you have postfix and dovecot running, hook up your [Thunderbird](https://www.thunderbird.net) with IMAP to send and receive emails.

```
IMAP Host: localhost
IMAP Receive Port: 10143

SMTP: localhost
SMTP Port: 36245

User: umair
Pass: test
```

** You can change username and password in users file but make sure to also change postfix/aliases and Dockerfile.

Note 3: If you are sending an email from an external server whose hostname is not resolved from public DNS server, you can add the IP and Hostname to the /etc/hosts of the docker container to get around the limitation temporarily.

In production, ofcourse normally all senders and receivers will have their domain names pointing to an IP address so there is no need to edit /etc/hosts file.

```
docker ps
docker exec -it <DOCKER CONTAINER ID> /bin/sh
vim /etc/hosts
```

Note: 4: If you are not able to send email, please check if postfix is running inside docker. Sorry I am not very good with Docker yet and I am still trying to figure out how to make postfix and dovecot run with the run command.

```
docker ps
docker exec -it <DOCKER CONTAINER ID> /bin/sh
postfix status

# if not running
postfix start
```
