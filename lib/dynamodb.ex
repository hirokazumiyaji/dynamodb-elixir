defmodule DynamoDB do

  def create_table(config, attribute_definitions, table_name, key_schema, provisioned_throughput, parameters) do
    # http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html
    url = "#{config[:scheme]}://#{config[:endpoint]}"
    data = %{
      AttributeDefinitions: attribute_definitions,
      KeySchema: key_schema,
      ProvisionedThroughput: provisioned_throughput,
      TableName: table_name,
    }
    data = Dict.merge(data, parameters)
    data = encode(data)
  end

  def create_table(config, attribute_definitions, table_name, key_schema, provisioned_throughput) do
    create_table(config, attribute_definitions, table_name, key_schema, provisioned_throughput, %{})
  end

  def describe_table() do
    raise UndefinedFunctionError
  end

  def update_table() do
    raise UndefinedFunctionError
  end

  def list_tables(config) do
    raise UndefinedFunctionError
  end

  def delete_table() do
    raise UndefinedFunctionError
  end

  def get_item() do
    raise UndefinedFunctionError
  end

  def batch_get_item() do
    raise UndefinedFunctionError
  end

  def query() do
    raise UndefinedFunctionError
  end

  def scan(config, table_name, parameters) do
    raise UndefinedFunctionError
  end

  def scan(config, table_name, parameters, start_key) do
    scan(config, table_name, parameters)
  end

  def put_item(config, table_name, item) do
    raise UndefinedFunctionError
  end

  def update_item() do
    raise UndefinedFunctionError
  end

  def delete_item() do
    raise UndefinedFunctionError
  end

  def batch_write_item() do
    raise UndefinedFunctionError
  end

  defp request() do
  end

  defp encode(value, options \\ []) do
    Poison.Encoder.encode(value, options) |> IO.iodata_to_binary
  end

  defp decode() do
  end
end
