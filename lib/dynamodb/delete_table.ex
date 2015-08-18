defmodule DynamoDB.DeleteTable do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def delete_table(config, table_name) do
        payload = %{
          TableName: table_name
        }

        case post(config, "DeleteTable", payload) do
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
