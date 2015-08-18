defmodule DynamoDB.GetItem do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def get_item(config, key, table_name, parameters \\ %{}) do
        payload = %{
          Key: key,
          TableName: table_name
        }
        |> Dict.merge(parameters)

        case post(config, "GetItem", payload) do
          {:ok, %{status: status, headers: headers, data: data}} ->
            data["Item"]
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
