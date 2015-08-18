defmodule DynamoDB do
  use DynamoDB.BatchGetItem
  use DynamoDB.BatchWriteItem
  use DynamoDB.CreateTable
  use DynamoDB.DeleteItem
  use DynamoDB.DeleteTable
  use DynamoDB.DescribeTable
  use DynamoDB.GetItem
  use DynamoDB.ListTables
  use DynamoDB.PutItem
  use DynamoDB.Query
  use DynamoDB.Scan
  use DynamoDB.UpdateItem
  use DynamoDB.UpdateTable
end
