defmodule DynamoDBLocalListTablesTest do
  use ExUnit.Case, async: true

  test "list tables" do
    config = %DynamoDB.Config{
      is_secure: false,
      host: System.get_env("DYNAMODB_HOST"),
      port: System.get_env("DYNAMODB_PORT")}

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      "ListTables1",
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      "ListTables2",
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      "ListTables3",
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      "ListTables4",
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      "ListTables5",
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      "ListTables6",
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    {table_names, last_table_name} = DynamoDB.list_tables(config)
    assert Enum.find(table_names, fn(x) -> x == "ListTables1" end) != nil
    assert Enum.find(table_names, fn(x) -> x == "ListTables2" end) != nil
    assert Enum.find(table_names, fn(x) -> x == "ListTables3" end) != nil
    assert Enum.find(table_names, fn(x) -> x == "ListTables4" end) != nil
    assert Enum.find(table_names, fn(x) -> x == "ListTables5" end) != nil
    assert Enum.find(table_names, fn(x) -> x == "ListTables6" end) != nil
    assert last_table_name == nil

    {table_names, last_table_name} = DynamoDB.list_tables(config, 3)
    assert length(table_names) == 3
    assert last_table_name != nil

    {table_names, _} = DynamoDB.list_tables(config, last_table_name)
    assert length(table_names) > 0

    {table_names, _} = DynamoDB.list_tables(config, last_table_name, 3)
    assert length(table_names) == 3
  end
end
