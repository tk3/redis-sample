
### 2. 成功のレスポンスを返すだけ

```
$ ./server.rb 
server is on 12345:127.0.0.1:127.0.0.1
```

```
$ ./client.rb 12345
port: 12345
"OK\r\n"
```


### 3. リクエストの値の数を表示する

```
$ ./server.rb 
server is on 12345:127.0.0.1:127.0.0.1
#<TCPSocket:0x00007ff101497d58> is accepted
params_length: 3
#<TCPSocket:0x00007ff101497d58> is gone
```


### 4. SETリクエストの値を表示する

```
$ ./03_server.rb 
server is on 12345:127.0.0.1:127.0.0.1
#<TCPSocket:0x00007f7ff36eb0e8> is accepted
params_length: 3
param[0]: length: 3, value: set
param[1]: length: 4, value: abcd
param[2]: length: 10, value: 0123456789
#<TCPSocket:0x00007f7ff36eb0e8> is gone
```

値を保存する処理はGETが実装する際に作成する。

