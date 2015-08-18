defmodule DynamoDB.PutItem do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def put_item(config, item, table_name, parameters \\ %{}) do
        payload = %{
          Item: item,
          TableName: table_name
        }
        |> Dict.merge(parameters)

        case post(config, "PutItem", payload) do
          {:ok, %{status: status, headers: headers, data: data}} ->
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
