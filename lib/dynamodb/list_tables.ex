defmodule DynamoDB.ListTables do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def list_tables(config) do
        payload = %{}

        request(config, payload)
      end

      def list_tables(config, limit) when is_integer(limit) do
        payload = %{
          Limit: limit
        }

        request(config, payload)
      end

      def list_tables(config, exclusive_start_table_name) do
        payload = %{
          ExclusiveStartTableName: exclusive_start_table_name
        }

        request(config, payload)
      end

      def list_tables(config, exclusive_start_table_name, limit) when is_integer(limit) do
        payload = %{
          ExclusiveStartTableName: exclusive_start_table_name,
          Limit: limit
        }

        request(config, payload)
      end

      defp request(config, payload) do
        case post(config, "ListTables", payload) do
          {:ok, %{status: status, headers: headers, data: data}} ->
            {
              data["TableNames"],
              data["LastEvaluatedTableName"]
            }
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
