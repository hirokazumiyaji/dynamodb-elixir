defmodule DynamoDBTest do
  use ExUnit.Case

  test "create table" do
    config = DynamoDB.Config.new("127.0.0.1", 8080, false)
    DynamoDB.create_table(
      config,
      [%{AttributeName: "id", AttributeType: "S"}],
      "Users",
      [%{AttributeName: "id", KeyType: "Hash"}],
      %{ReadCapacityUnits: 1, WriteCapacityUnits: 1})

    # http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html#DDB-CreateTable-request-KeySchema
    DynamoDB.create_table(
      config,
      [
        %{AttributeName: "ForumName", AttributeType: "S"},
        %{AttributeName: "Subject", AttributeType: "S"},
        %{AttributeName: "LastPostDateTime", AttributeType: "S"},
      ],
      "Thread",
      [
        %{AttributeName: "id", KeyType: "ForumName"},
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
      })
  end

  test "list tables" do
  end

  test "get item" do
  end

  test "put item" do
  end

  test "scan" do
  end
end
