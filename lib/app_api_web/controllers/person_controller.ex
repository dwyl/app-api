defmodule AppApiWeb.PersonController do
  use AppApiWeb, :controller

  def index(conn, _params) do
    jwt =
      conn.req_headers
      |> List.keyfind("authorization", 0)
      |> get_token_from_header()

    headers = ["Authorization": "Bearer #{jwt}"]
    url = "https://auth-mvp.herokuapp.com/person/info"

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        data = Poison.decode!(body)
        # get name from api
        person = %{name: "", email: data["data"]["email"]}
        render(conn, "index.json", person: person)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end

    # redirect(conn, external: "https://auth-mvp.herokuapp.com/auth/urls")
  end

  defp get_token_from_header(nil), do: nil

  defp get_token_from_header({"authorization", value}) do
    # regex check value start with Bearer follow by a space and any characters
    case Regex.run(~r/^Bearer\s(.*)/, value) do
      [_, jwt] -> jwt
      _ -> nil
    end
  end
end
