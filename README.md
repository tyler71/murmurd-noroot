Forked from `mattikus/docker-murmur` to provide a no-root instance and add other small features (like multi-stage builds to reduce size).
___

## Description

This is a barebones docker container built using busybox and a statically compiled version of murmurd from the [official website](https://www.mumble.info).

It's configured to look for the configuration file in `/etc/murmur.ini`.

## Usage

### Docker

```bash
$ docker run -d -p 64738:64738 -p 64738:64738/udp tyler71/docker-murmurd
```

To have the container store the sqlite database on your filesystem instead, you can run:

```bash
$ docker run -d -p 64738:64738 -p 64738:64738/udp \
    -v /path/to/data:/data tyler71/docker-murmurd
```

### Docker-Compose

```
version: '3.3'
services:
    murmur:
        restart: unless-stopped
        ports:
            - '64738:64738'
            - '64738:64738/udp'
        volumes:
            - './data/sqlite/:/data'
#           - './data/config/murmur.ini:/etc/murmur.ini:ro'
#           - '/etc/letsencrypt/live/domain.tld/fullchain.pem:/etc/cert/crt.pem:ro'
#           - '/etc/letsencrypt/live/domain.tld/privkey.pem:/etc/cert/key.pem:ro'
        image: tyler71/docker-murmurd
```

## Important notes

### Getting the super-user password

On first run, if you don't already have an existing state database, you'll want to look at the logs for your container to get the super-user password: 

```bash
$ docker logs murmur 2>&1 | grep Password
<W>2014-07-27 01:41:31.256 1 => Password for 'SuperUser' set to '(mAq3hkwnkD'
```

### Providing your own murmur.ini

If you want to tweak the provided murmur.ini, you should run:

```bash
mkdir -p data/config
docker cp your-container-name:/etc/murmur.ini data/config/murmur.ini

If you are using the built in volume at `/data/`, then you should sure your config contains:

```ini
database=/data/murmur.sqlite
```

To run the container with your tweaked murmur.ini:

```bash
$ docker run -d -p 64738:64738 -p 64738:64738/udp \
    -v /path/to/murmur.ini:/etc/murmur.ini:ro tyler71/docker-murmurd
```



