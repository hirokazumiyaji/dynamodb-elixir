defmodule DynamoDB.Config do

  #@api_version = "2012-08-10"
  #@default_region_name = "us-east-1"
  #@default_region_endpoint = "dynamodb.us-east-1.amazonaws.com"
  #@service_name = "DynamoDB"
  #@target_refix = "DynamoDB_20120810"

  def new(access_key_id, secret_access_key, region, true) do
    %{
      access_key_id: access_key_id,
      secret_access_key: secret_access_key,
      region: region,
      scheme: "https",
      endpoint: "dynamodb.#{region}.amazonaws.com"
    }
  end

  def new(access_key_id, secret_access_key, region, false) do
    %{
      access_key_id: access_key_id,
      secret_access_key: secret_access_key,
      region: region,
      scheme: "http",
      endpoint: "dynamodb.#{region}.amazonaws.com"
    }
  end

  def new(host, port, true) do
    %{
      access_key_id: "ACCESS_KEY_ID",
      secret_access_key: "SECRET_ACCESS_KEY",
      region: "us-east-1",
      scheme: "https",
      endpoint: "#{host}:#{port}"
    }
  end

  def new(host, port, false) do
    %{
      access_key_id: "ACCESS_KEY_ID",
      secret_access_key: "SECRET_ACCESS_KEY",
      region: "us-east-1",
      scheme: "http",
      endpoint: "#{host}:#{port}"
    }
  end
end
