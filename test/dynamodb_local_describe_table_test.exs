defmodule DynamoDBLocalDescribeTableTest do
  use ExUnit.Case, async: true

  setup_all do
    table_name = "DescribeTable"
    not_found_table_name = "DescribeTable2"
    config = %DynamoDB.Config{
      is_secure: false,
      host: System.get_env("DYNAMODB_HOST"),
      port: System.get_env("DYNAMODB_PORT")}

    DynamoDB.delete_table(config, not_found_table_name)

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

  test "describe table" do
    table_name = "DescribeTable"
    not_found_table_name = "DescribeTable2"
    config = %DynamoDB.Config{
      is_secure: false,
      host: System.get_env("DYNAMODB_HOST"),
      port: System.get_env("DYNAMODB_PORT")}

    data = DynamoDB.describe_table(config, table_name)
    assert data["TableName"] == table_name

    assert DynamoDB.describe_table(config, not_found_table_name) == {:error, {"com.amazonaws.dynamodb.v20120810#ResourceNotFoundException", "Cannot do operations on a non-existent table"}}
  end
end
