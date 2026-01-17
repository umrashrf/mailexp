# EMAIL (36245 port)

## Build

```
    docker build -t riamumail:latest .
```

## Run

```
    docker run --rm \
        -p 0.0.0.0:36245:36245 \
        -p 0.0.0.0:10143:143 \
        riamumail
```
