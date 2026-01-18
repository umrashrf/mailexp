# EMAIL (36245 port)

Note: In this guide, I am using my domain but you must use your domain. You must set A and MX records.

```
A       YOUR_IP_ADDRESS
MX      YOUR_DOMAIN             10
```

## Build

```
docker build -t riamumail:latest .
```

## Run

```
docker run --rm --dns 8.8.8.8 --hostname riamumail.com -p 0.0.0.0:36245:36245 -p 0.0.0.0:10143:143 riamumail
```
