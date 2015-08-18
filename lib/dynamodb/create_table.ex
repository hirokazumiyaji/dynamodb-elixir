defmodule DynamoDB.CreateTable do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      @spec create_table([{binary, binary}], [{binary, binary}], binary, [{binary, binary}], [{binary, integer}], [{binary, binary}]) :: :ok | {:error, {binary, binary}} | {:error, binary}
      def create_table(config, attribute_definitions, table_name, key_schema, provisioned_throughput, parameters \\ %{}) do
        payload = %{
          AttributeDefinitions: attribute_definitions,
          KeySchema: key_schema,
          ProvisionedThroughput: provisioned_throughput,
          TableName: table_name,
        }
        |> Dict.merge(parameters)

        case post(config, "CreateTable", payload) do
          {:ok, _} ->
            :ok
          {:error, {type, message}} ->
            {:error, {type, message}}
          {:error, reason} ->
            {:error, reason}
        end
      end

      defoverridable Module.definitions_in(__MODULE__)
    end
  end
end
