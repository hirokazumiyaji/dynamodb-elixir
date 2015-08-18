defmodule DynamoDB.Query do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def query(config, table_name, parameters \\ %{}) do
        payload = %{
          TableName: table_name
        }
        |> Dict.merge(parameters)

        case post(config, "Query", payload) do
          {:ok, %{status: status, headers: headers, data: data}} ->
            data
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
