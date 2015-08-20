defmodule DynamoDBLocalDeleteTableTest do
  use ExUnit.Case, async: true

  setup_all do
    table_name = "DeleteTable"
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

    :ok
  end

  test "delete table" do
    table_name = "DeleteTable"
    config = %DynamoDB.Config{
      is_secure: false,
      host: System.get_env("DYNAMODB_HOST"),
      port: System.get_env("DYNAMODB_PORT")}

    assert DynamoDB.delete_table(config, table_name) == :ok

    assert DynamoDB.delete_table(config, table_name) == {:error, {"com.amazonaws.dynamodb.v20120810#ResourceNotFoundException", "Cannot do operations on a non-existent table"}}
  end
end
