
## SETコマンドを作成してみる

ソースコードはclient.rbを参照。

```
$ redis-cli 
127.0.0.1:6379> set hello world
OK
```

client.rbを実行する。
```
$ ./client.rb 
port: 6379
"+OK\r\n"
```

