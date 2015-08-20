DynamoDB Client for elixir
===

[![Build Status](https://travis-ci.org/hirokazumiyaji/dynamodb.svg?branch=master)](https://travis-ci.org/hirokazumiyaji/dynamodb)

Usage
---
* DynamoDB

```
config = %DynamoDB.Config{access_key_id: "ACCESS_KEY", secret_access_key: "SECRET_ACCESS_KEY", region: "us-west-1")
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
config = %DynamoDB.Config{is_secure: false, host: "127.0.0.1", port: 8080}
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
