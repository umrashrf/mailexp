# EMAIL (36245 port)

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
