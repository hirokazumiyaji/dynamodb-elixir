defmodule DynamoDB.ConfigTest do
  use ExUnit.Case, async: true

  test "enable host port" do
    config = %DynamoDB.Config{is_secure: true, host: "127.0.0.1", port: 8080}

    assert config == %DynamoDB.Config{
      access_key_id: "ACCESS_KEY_ID",
      secret_access_key: "SECRET_ACCESS_KEY",
      region: "us-east-1",
      is_secure: true,
      host: "127.0.0.1",
      port: 8080}
    assert DynamoDB.Config.endpoint(config) == "127.0.0.1:8080"
    assert DynamoDB.Config.url(config) == "https://127.0.0.1:8080"

    config = %DynamoDB.Config{is_secure: false, host: "localhost", port: 8000}

    assert config == %DynamoDB.Config{
      access_key_id: "ACCESS_KEY_ID",
      secret_access_key: "SECRET_ACCESS_KEY",
      region: "us-east-1",
      is_secure: false,
      host: "localhost",
      port: 8000}
    assert DynamoDB.Config.endpoint(config) == "localhost:8000"
    assert DynamoDB.Config.url(config) == "http://localhost:8000"
  end

  test "disable host port" do
    config = %DynamoDB.Config{
      access_key_id: "12345",
      secret_access_key: "12345678910",
      region: "us-west-1",
      is_secure: true}

    assert config == %DynamoDB.Config{
      access_key_id: "12345",
      secret_access_key: "12345678910",
      region: "us-west-1",
      is_secure: true,
      host: nil,
      port: nil}
    assert DynamoDB.Config.endpoint(config) == "dynamodb.us-west-1.amazonaws.com"
    assert DynamoDB.Config.url(config) == "https://dynamodb.us-west-1.amazonaws.com"
  end
end
