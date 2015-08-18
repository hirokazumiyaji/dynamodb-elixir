defmodule DynamoDB.BatchWriteItem do
  import DynamoDB.Utils

  defmacro __using__(_) do
    quote do
      def batch_write_item(config, request_items, parameters \\ %{}) do
        payload = %{
          RequestItems: request_items,
        }
        |> Dict.merge(parameters)

        case post(config, "BatchWriteItem", payload) do
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
