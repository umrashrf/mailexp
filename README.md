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
