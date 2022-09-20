

## install

```
curl -O https://download.redis.io/redis-stable.tar.gz
tar zxf redis-stable.tar.gz 
cd redis-stable/
make
make PREFIX=$HOME/opt/redis install
```

```
export PATH="$PATH:$HOME/opt/redis/bin"
```

```
$ exec -l $SHELL
```


```
$ redis-server -v
Redis server v=7.0.4 sha=ac771e84:0 malloc=jemalloc-5.2.1 bits=64 build=adb149a6e527595c
$ redis-cli -v
redis-cli 7.0.4 (git:ac771e84)
```


