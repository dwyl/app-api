defmodule AppApiWeb.CaptureController do
  use AppApiWeb, :controller
  alias AppApi.Captures
  alias AppApi.Timers

  def index(conn, _params) do
    captures = Captures.get_capture_by_id_person(conn.assigns.person.id_person)
    render(conn, "index.json", captures: captures)
  end

  def show(conn, params) do
    capture = Captures.get_capture!(params["id"])

    if capture.id_person == conn.assigns.person.id_person do
      render(conn, "show.json", capture: capture)
    else
      conn
      |> put_resp_header("www-authenticate", "Bearer realm=\"Capture access\"")
      |> send_resp(401, "unauthorized")
      |> halt()
    end
  end

  def update(conn, params) do
    capture = Captures.get_capture!(params["id"])

    if capture.id_person == conn.assigns.person.id_person do
      stop_timer(Enum.at(capture.timers, 0))

      updates = %{
        completed: params["completed"],
        text: params["text"],
        task: params["task"]
      }

      udpatedCatpure = Captures.update_capture(capture, updates)

      render(conn, "show.json", capture: udpatedCatpure)
    else
      conn
      |> put_resp_header("www-authenticate", "Bearer realm=\"Capture access\"")
      |> send_resp(401, "unauthorized")
      |> halt()
    end
  end

  def create(conn, params) do
    capture = %{text: params["text"], id_person: conn.assigns.person.id_person}
    capture = Captures.create_capture(capture)
    render(conn, "create.json", capture: capture)
  end

  defp stop_timer(%{stopped_at: nil} = timer), do: Timers.stop_timer(timer.id)

  defp stop_timer(_), do: nil
end
