DynamoDB Client for elixir
===

[![Build Status](https://travis-ci.org/hirokazumiyaji/dynamodb.svg?branch=master)](https://travis-ci.org/hirokazumiyaji/dynamodb)

Usage
---
* DynamoDB

```
config = DynamoDB.Config.new("ACCESS_KEY", "SECRET_ACCESS_KEY", "us-west-1")
DynamoDB.create_table(
  config,
  [
    %{AttributeName: "Id", AttributeType: "S"},
  ],
  "Example",
  [
    %{AttributeName: "Id", KeyType: "HASH"}
  ],
  %{ReadCapacityUnits: 1, WriteCapacityUnits: 1}) == :ok

DynamoDB.put_item(config, %{Id: "12345", Name: "Example"}, "Example")
DynamoDB.get_item(config, %{Id: %{S: "12345"}}, "Example")
```


* DynamoDB-Local

```
config = DynamoDB.Config.new("127.0.0.1", 8080)
DynamoDB.create_table(
  config,
  [
    %{AttributeName: "Id", AttributeType: "S"},
  ],
  "Example",
  [
    %{AttributeName: "Id", KeyType: "HASH"}
  ],
  %{ReadCapacityUnits: 1, WriteCapacityUnits: 1}) == :ok

DynamoDB.put_item(config, %{Id: "12345", Name: "Example"}, "Example")
DynamoDB.get_item(config, %{Id: %{S: "12345"}}, "Example") 
```
