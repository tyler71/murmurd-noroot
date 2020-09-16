<p align="center">
  <img width="75%" src="https://user-images.githubusercontent.com/4926565/93353517-dec6be80-f7f0-11ea-8c99-2c1ab65d5cc3.png" />
</p>

## Quickstart
Setup should be as simple as running the following commands.  
The last command will create a file called `adminpass.txt`. This contains the admin username and password.

```
git clone https://github.com/tyler71/murmurd-noroot
cd murmurd-noroot
docker-compose up -d
docker-compose logs -f 2>&1 | grep -o -m1 -E 'Password for .*$' | head -1 | tee adminpass.txt 
```

## Usage

Install [Docker-Compose](https://docs.docker.com/compose/install/) to run these commands.

**Start** the instance
```bash
# -d means to run detached
docker-compose up -d 
```
**Stop** the instance
```bash
docker-compose down
```

**Restart** the instance
```bash
docker-compose restart
```

## Info

By default, the file `data/murmur.ini` is bound to the container and is used for [server config](https://wiki.mumble.info/wiki/Murmurguide#Configuring_ini_File).
 Just restart the container if adjusted.

Backing up the files in `data/` should make it easy to restore.
```
.
├── data
│   ├── murmur.ini
│   └── sqlite
│       └── murmur.sqlite
```

Variables in `.env` are loaded into the container at runtime.  
To set the SuperUser password on first run, place this in `.env`
```
SUPERUSER_PASSWORD=mypassword
```

### SSL
If you are using [Let's Encrypt](https://letsencrypt.org/getting-started), you can specify them for your server.
 To include them, we'll bind them inside the container on runtime.  
Murmurd takes the certificates as root before dropping privileges, so there shouldn't be any permission issues
 and should be able to take them from anywhere, such as Caddy's [stored certs](https://caddyserver.com/docs/automatic-https#storage).
```
# Uncomment this
# data/murmur.ini
;sslCert=/etc/cert/crt.pem
;sslKey=/etc/cert/key.pem

# Uncomment and change domain.tld to your domain name.
# docker-compose.yml
#           - '/etc/letsencrypt/live/domain.tld/fullchain.pem:/etc/cert/crt.pem:ro'
#           - '/etc/letsencrypt/live/domain.tld/privkey.pem:/etc/cert/key.pem:ro'
```
___
Forked from `mattikus/docker-murmur` to provide some small features
* Reduced size with multi-stage build
* Use docker-compose for easier permanent instance
* Use unprivileged user

