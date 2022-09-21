

### COMMANDリクエスト

COMMANDリクエストは何もせず、0個のパラメータを返す


### redis-cliからデータを操作する

```
$ redis-cli -p 12345
127.0.0.1:12345> set a b
OK
127.0.0.1:12345> get a
"b"
127.0.0.1:12345> 
```


redis-cli を終了すると次のエラーメッセージが表示される。クライアントの接続が切れている状態でreadlineを実行したためである。このEOFErrorに対応する。

```
#<Thread:0x00007fd608a9d9f0 ./server.rb:57 run> terminated with exception (report_on_exception is true):
./server.rb:6:in `readline': end of file reached (EOFError)
        from ./server.rb:6:in `parse_request'
        from ./server.rb:34:in `do_request'
        from ./server.rb:61:in `block in <main>'
```

もう一度server.rbを起動し、次のコマンドを実行する。

```
$ redis-cli -p 12345
127.0.0.1:12345> set aaa bb
OK
127.0.0.1:12345> get aaa
"bb"
127.0.0.1:12345> 
```

クライアントが終了してもEOFErrorで終了することはなくなった。

```
#<TCPSocket:0x00007f3cdd3b97c0> is accepted
params_length: 2
param) length: 7, value: COMMAND
param) length: 4, value: DOCS
["COMMAND", "DOCS"]
params_length: 3
param) length: 3, value: set
param) length: 3, value: aaa
param) length: 2, value: bb
["set", "aaa", "bb"]
params_length: 2
param) length: 3, value: get
param) length: 3, value: aaa
["get", "aaa"]
#<TCPSocket:0x00007f3cdd3b97c0> is gone
```

