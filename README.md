<p align="center">
  <img width="50%" src="https://user-images.githubusercontent.com/4926565/92831262-06e69580-f38b-11ea-9cbd-5218e13f41f5.gif" />
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

Requirements:
* [Docker](https://docs.docker.com/engine/install/)
* [Docker-Compose](https://docs.docker.com/compose/install/)
* Git

**Start** the instance
```bash
# -d means to run detached
docker-compose up -d 
```
**Stop** the instance
```bash
docker-compose down
```
___
Forked from `mattikus/docker-murmur` to provide some small features
* Reduced size with multi-stage build
* Use docker-compose for easier permanent instance
* Use unprivileged user

By default, the file `data/murmur.ini` is bound and used inside the container  
The sqlite file is stored in `data/sqlite/murmur.sqlite`
