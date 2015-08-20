defmodule DynamoDBLocalGetItemTest do
  use ExUnit.Case, async: true

  setup_all do
    table_name = "GetItem"
    config = %DynamoDB.Config{
      is_secure: false,
      host: System.get_env("DYNAMODB_HOST"),
      port: System.get_env("DYNAMODB_PORT")}

    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      table_name,
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    on_exit fn ->
      DynamoDB.delete_table(config, table_name)
    end

    :ok
  end

  test "get item" do
    table_name = "GetItem"
    config = %DynamoDB.Config{
      is_secure: false,
      host: System.get_env("DYNAMODB_HOST"),
      port: System.get_env("DYNAMODB_PORT")}

    key = %{
      Id: %{
        S: "12345"
      }
    }
    assert DynamoDB.get_item(config, key, table_name) == nil

    item = %{
      Id: "12345",
      Name: "Example"
    }
    DynamoDB.put_item(config, item, table_name)

    assert DynamoDB.get_item(config, key, table_name) == %{"Id" => %{"S" => "12345"}, "Name" => %{"S" => "Example"}}
  end
end
