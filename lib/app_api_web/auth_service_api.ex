defmodule AppApiWeb.AuthServiceApi do
  @moduledoc """
  Module which manage communication with auth service
  """

  @base_url "https://auth-mvp.herokuapp.com"

  @doc """
  return the information about the person
  {:ok, %{name:..., email:... }}

  {:error, :not_found} if reply with 404
  {:error, reason: reason} for any other errors
  """
  def get_person_information(conn) do
    jwt = get_jwt_authorization_header(conn)
    fetch_person_information(jwt)
  end

  defp fetch_person_information(nil), do: {:error, :not_authorized}

  defp fetch_person_information(jwt) do
    headers = [Authorization: "Bearer #{jwt}"]
    url = "#{@base_url}/person/info"

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        data = Poison.decode!(body)
        # get name from api
        person = %{
          id_person: data["data"]["id_person"],
          name: "",
          email: data["data"]["email"],
          avatar: data["data"]["avatar"]
        }

        {:ok, person}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Response{status_code: 401}} ->
        {:error, :not_authorized}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason: reason}
    end
  end

  defp get_jwt_authorization_header(conn) do
    conn.req_headers
    |> List.keyfind("authorization", 0)
    |> get_token_from_header()
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
