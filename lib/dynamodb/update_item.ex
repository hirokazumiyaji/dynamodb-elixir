defmodule DynamoDB.UpdateItem do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def update_item(config, key, table_name, parameters \\ %{}) do
        payload = %{
          Key: key,
          TableName: table_name
        }
        |> Dict.merge(parameters)

        case post(config, "UpdateItem", payload) do
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
