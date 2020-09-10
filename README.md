Forked from `mattikus/docker-murmur` to provide some small features
* Reduced size with multi-stage build
* Use docker-compose for easier permanent instance
* Use unprivileged user
___

## Description

This is a barebones docker container meant to be used with docker-compose.  
Usage should be as simple as 

```
git pull https://github.com/tyler71/murmurd-noroot
docker-compose up -d
```

By default, the file `data/murmur.ini` is bound and used inside the container
The sqlite file used is stored in `data/sqlite`

### Getting the super-user password

On first run, if you don't already have an existing state database, you'll want to look at the logs for your container to get the super-user password: 

```bash
docker-compose up -d; docker-compose logs -f 2>&1 | grep Password
<W>2014-07-27 01:41:31.256 1 => Password for 'SuperUser' set to '(mAq3hkwnkD'
```
