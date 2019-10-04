defmodule FflLocatorWeb.BigCommerceController do
  use FflLocatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def install(conn, %{"code" => code, "scope" => scope, "context" => context}) do
    {:ok, response} = bigcommerce_auth(code, scope, context)

    # @todo: store response body?
    IO.puts("RESPONSE BODY:")
    IO.inspect(response.body)

    conn
    |> Plug.Conn.delete_resp_header("x-frame-options")
    |> render("index.html")
  end

  def load(conn, _params) do
    verify_signed_request(conn.query_params["signed_payload"])

    conn
    |> Plug.Conn.delete_resp_header("x-frame-options")
    |> render("index.html")
  end

  def bigcommerce_auth(code, scope, context) do
    headers =
      headers = [
        {"Content-type", "application/json"},
        {"Accept", "application/json"}
      ]

    body =
      Jason.encode!(%{
        "client_id" => System.get_env("BC_APP_CLIENT_ID"),
        "client_secret" => System.get_env("BC_APP_CLIENT_SECRET"),
        # @todo: make this url dynamic
        "redirect_uri" => "https://bc-ffl-server.herokuapp.com/install",
        "grant_type" => "authorization_code",
        "code" => code,
        "scope" => scope,
        "context" => context
      })

    # @todo: make this url dynamic
    HTTPoison.post("https://login.bigcommerce.com/oauth2/token", body, headers)
  end

  # signed_payload : encoded_json_string.encoded_hmac_signature
  #    => Verify that the request came from BigCommerce.
  #    => Identify the store.
  #    => Identify the store owner or user.
  def verify_signed_request(signed_payload) do
    # Split signed_payload into its two parts at the . delimiter
    case String.split(signed_payload) do
      [payload, signature] ->
        IO.inspect(payload)

        # Decode encoded_json_string & encoded_hmac_signature using base64url
        json = Base.decode64!(payload)
        signature = Base.decode64!(signature)

        # Confirm the signature with your app client secret
        case :crypto.hmac(:sha256, System.get_env("BC_APP_CLIENT_SECRET"), json)
             |> Base.encode16(case: :lower) do
          ^signature ->
            # Convert the decoded JSON string into an object
            {:ok, Jason.decode!(json)}

          _ ->
            {:error, "Signature did not match"}
        end

      _ ->
        {:error, "Invalid payload"}
    end
  end
end
