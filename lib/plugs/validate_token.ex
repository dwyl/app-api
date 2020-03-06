defmodule AppApi.Plugs.ValidateToken do
  @moduledoc """
  Plug to authenticate a jwt.
  Check if the Authorization is define in the request headers
  and use this token to get the person information from the auth service
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case AppApiWeb.AuthServiceApi.get_person_information(conn) do
      {:error, _} -> unauthorized(conn)
      {:ok, person} -> assign(conn, :person, person)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_resp_header("www-authenticate", "Bearer realm=\"Person access\"")
    |> send_resp(401, "unauthorized")
    |> halt()
  end

end
