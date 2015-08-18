defmodule DynamoDB.Utils do
  @http_method "POST"
  @service "dynamodb"
  @target_prefix "DynamoDB_20120810"

  def post(config, action, payload) do
    url = gen_url(config)
    payload = payload |> encode
    headers = gen_headers(config, action)

    auth_header = AWSAuth.sign_authorization_header(
      config[:access_key],
      config[:secret_access_key],
      @http_method,
      url,
      config[:region],
      @service,
      headers,
      payload)

    headers = headers |> Dict.put("Authorization", auth_header)

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

  defp gen_url(config) do
    "#{config[:scheme]}://#{config[:endpoint]}"
  end

  defp x_amz_target(action) do
    "#{@target_prefix}.#{action}"
  end

  defp gen_headers(config, action) do
    %{
      "X-Amz-Target" => x_amz_target(action),
      "Host" => config[:endpoint],
      "Content-Type" => "application/x-amz-json-1.0"
    }
  end
end
