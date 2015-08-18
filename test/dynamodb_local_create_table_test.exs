defmodule DynamoDBLocalCreateTableTest do
  use ExUnit.Case, async: true

  setup_all do
    table_name1 = "Users"
    table_name2 = "Thread"
    config = DynamoDB.Config.new(System.get_env("DYNAMODB_HOST"), System.get_env("DYNAMODB_PORT"), false)

    DynamoDB.delete_table(config, table_name1)
    DynamoDB.delete_table(config, table_name2)

    on_exit fn ->
      DynamoDB.delete_table(config, table_name1)
      DynamoDB.delete_table(config, table_name2)
    end
  end


  test "create table" do
    table_name1 = "Users"
    table_name2 = "Thread"
    config = DynamoDB.Config.new(System.get_env("DYNAMODB_HOST"), System.get_env("DYNAMODB_PORT"), false)

    assert DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      table_name1,
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1}) == :ok

    assert DynamoDB.create_table(
      config,
      [
        %{AttributeName: "Id", AttributeType: "S"},
      ],
      table_name1,
      [
        %{AttributeName: "Id", KeyType: "HASH"}
      ],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1}) == {:error, {"com.amazonaws.dynamodb.v20120810#ResourceInUseException", "Cannot create preexisting table"}}

    assert DynamoDB.create_table(
      config,
      [
        %{AttributeName: "ForumName", AttributeType: "S"},
        %{AttributeName: "Subject", AttributeType: "S"},
        %{AttributeName: "LastPostDateTime", AttributeType: "S"},
      ],
      table_name2,
      [
        %{AttributeName: "ForumName", KeyType: "HASH"},
        %{AttributeName: "Subject", KeyType: "RANGE"}
      ],
      %{ReadCapacityUnits: 5, WriteCapacityUnits: 5},
      %{
        LocalSecondaryIndexes: [
          %{
            IndexName: "LastPostIndex",
            KeySchema: [
              %{AttributeName: "ForumName", KeyType: "HASH"},
              %{AttributeName: "LastPostDateTime", KeyType: "RANGE"}
            ],
            Projection: %{ProjectionType: "KEYS_ONLY"}
          }
        ],
      }) == :ok
  end
end
