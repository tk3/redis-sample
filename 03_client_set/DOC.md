
## SETコマンドを作成してみる

ソースコードはclient.rbを参照。

```
$ redis-server
263214:C 20 Sep 2022 06:50:14.561 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
263214:C 20 Sep 2022 06:50:14.561 # Redis version=7.0.4, bits=64, commit=ac771e84, modified=0, pid=263214, just started
263214:C 20 Sep 2022 06:50:14.561 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
263214:M 20 Sep 2022 06:50:14.563 * Increased maximum number of open files to 10032 (it was originally set to 1024).
263214:M 20 Sep 2022 06:50:14.563 * monotonic clock: POSIX clock_gettime
                _._                                                  
           _.-``__ ''-._                                             
      _.-``    `.  `_.  ''-._           Redis 7.0.4 (ac771e84/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._                                  
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 263214
  `-._    `-._  `-./  _.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |           https://redis.io       
  `-._    `-._`-.__.-'_.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |                                  
  `-._    `-._`-.__.-'_.-'    _.-'                                   
      `-._    `-.__.-'    _.-'                                       
          `-._        _.-'                                           
              `-.__.-'                                               

263214:M 20 Sep 2022 06:50:14.564 # Server initialized
263214:M 20 Sep 2022 06:50:14.564 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
263214:M 20 Sep 2022 06:50:14.565 * Loading RDB produced by version 7.0.4
263214:M 20 Sep 2022 06:50:14.565 * RDB age 7 seconds
263214:M 20 Sep 2022 06:50:14.565 * RDB memory usage when created 0.91 Mb
263214:M 20 Sep 2022 06:50:14.565 * Done loading RDB, keys loaded: 1, keys expired: 0.
263214:M 20 Sep 2022 06:50:14.565 * DB loaded from disk: 0.000 seconds
263214:M 20 Sep 2022 06:50:14.565 * Ready to accept connections
```

client.rbを実行する。
```
$ ./client.rb 
port: 6379
"+OK\r\n"
```

```
$ redis-cli 
127.0.0.1:6379> get abcd
"0123456789"
```

