defmodule DynamoDB.ConfigTest do
  use ExUnit.Case

  test "new host port" do
    config = DynamoDB.Config.new("127.0.0.1", 8080, true)
    assert config == %{
      access_key_id: "ACCESS_KEY_ID",
      secret_access_key: "SECRET_ACCESS_KEY",
      region: "us-east-1",
      scheme: "https",
      endpoint: "127.0.0.1:8080"}

    config = DynamoDB.Config.new("localhost", 8000, false)
    assert config == %{
      access_key_id: "ACCESS_KEY_ID",
      secret_access_key: "SECRET_ACCESS_KEY",
      region: "us-east-1",
      scheme: "http",
      endpoint: "localhost:8000"}

    config = DynamoDB.Config.new("12345", "12345678910", "us-east-1", true)
    assert config == %{
      access_key_id: "12345",
      secret_access_key: "12345678910",
      region: "us-east-1",
      scheme: "https",
      endpoint: "dynamodb.us-east-1.amazonaws.com"}
  end
end
