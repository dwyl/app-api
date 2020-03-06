defmodule AppApiWeb.PersonController do
  use AppApiWeb, :controller

  def index(conn, _params) do
    case AppApiWeb.AuthServiceApi.get_person_information(conn) do
      {:ok, person} -> render(conn, "index.json", person: person)
      {:error, :not_found} ->
          conn
          |> send_resp(404, "not found")
          |> halt()
      {:error, :not_authorized} ->
          conn
          |> send_resp(401, "unauthorized")
          |> halt()

      {:error, _} ->
          conn
          |> send_resp(500, "api error")
          |> halt()
    end
  end
end
