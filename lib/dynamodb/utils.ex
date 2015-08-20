defmodule DynamoDB.Utils do
  @http_method "POST"
  @service "dynamodb"
  @target_prefix "DynamoDB_20120810"

  alias DynamoDB.Config

  def post(config, action, payload) do
    url = DynamoDB.Config.url(config)
    payload = payload |> encode
    headers = gen_headers(config, action)

    headers = headers
      |> Dict.put("Authorization", auth_signature(config, url, headers, payload))

    case HTTPoison.post(url, payload, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, headers: response_headers, body: response_body}} ->
        {:ok, %{
            status: 200,
            headers: response_headers,
            data: response_body |> decode
        }}
      {:ok, %HTTPoison.Response{status_code: _, headers: _, body: response_body}} ->
        data = response_body |> decode
        {:error, {data["__type"], data["message"]}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp encode(value, options \\ []) do
    Poison.Encoder.encode(value, options) |> IO.iodata_to_binary
  end

  defp decode(value) do
    value |> Poison.decode!
  end

  defp auth_signature(config, url, headers, payload) do
    AWSAuth.sign_authorization_header(
      config.access_key_id,
      config.secret_access_key,
      @http_method,
      url,
      config.region,
      @service,
      headers,
      payload)
  end

  defp x_amz_target(action) do
    "#{@target_prefix}.#{action}"
  end

  defp gen_headers(config, action) do
    %{
      "X-Amz-Target" => x_amz_target(action),
      "Host" => DynamoDB.Config.endpoint(config),
      "Content-Type" => "application/x-amz-json-1.0"
    }
  end
end
