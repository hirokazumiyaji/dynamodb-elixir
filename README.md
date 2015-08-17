DynamoDB Client for elixir
======

Usage
---
* DynamoDB

```
config = DynamoDB.Config.new("ACCESS_KEY", "SECRET_ACCESS_KEY", "us-west-1")
DynamoDB.create_table(config, "example")

DynamoDB.put_item(config)
DynamoDB.get_item(config)
```


* DynamoDB-Local

```
config = DynamoDB.Config.new("127.0.0.1", 8080)
DynamoDB.create_table()
```
