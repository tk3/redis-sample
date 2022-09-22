

## エラー処理を実装する

- SETコマンドで引数が足りない時
- GETコマンドで引数が足りない時
- GETコマンドで、値が存在しないキーを指定した場合


###

```
127.0.0.1:6379> set
(error) ERR wrong number of arguments for 'set' command
127.0.0.1:6379> set aaa
(error) ERR wrong number of arguments for 'set' command
127.0.0.1:6379> get 
(error) ERR wrong number of arguments for 'get' command
127.0.0.1:6379> get none
(nil)
127.0.0.1:6379> get not_found
(nil)
```

