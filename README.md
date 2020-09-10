Forked from `mattikus/docker-murmur` to provide some small features
* Reduced size with multi-stage build
* Use docker-compose for easier permanent instance
* Use unprivileged user
___

## Description
Usage should be as simple as 

```
git clone https://github.com/tyler71/murmurd-noroot
cd murmurd-noroot
docker-compose up -d
docker-compose logs -f 2>&1 | grep -oE "Password [a-Z]+ '[a-Z]+' set to .*"
```

On future runs,  
**Start** the instance
```bash
# -d means to run detached
docker-compose up -d 
```
**Stop** the instance
```bash
docker-compose down
```

By default, the file `data/murmur.ini` is bound and used inside the container  
The sqlite file used is stored in `data/sqlite`
