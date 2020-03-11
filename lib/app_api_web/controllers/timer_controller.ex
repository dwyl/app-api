defmodule AppApiWeb.TimerController do
  use AppApiWeb, :controller
  alias AppApi.Timers
  alias AppApi.Captures

  def index(conn, %{"capture_id" => capture_id}) do
    timers = Timers.get_capture_timers(capture_id)
    render(conn, "index.json", timers: timers)
  end

  def create(conn, params) do
    capture = Captures.get_capture!(params["capture_id"])
    # timer can be added only if the auth person
    # has previously created the capture
    if capture.id_person == conn.assigns.person.id_person do
      attrs = %{started_at: NaiveDateTime.utc_now()}
      {:ok, timer} = Timers.create_timer(capture, attrs)
      render(conn, "create.json", timer: timer)
    else
      conn
      |> put_resp_header("www-authenticate", "Bearer realm=\"Person access\"")
      |> send_resp(401, "unauthorized")
      |> halt()
    end
  end

  def update(conn, %{"capture_id" => capture_id, "id" => timer_id, "action" => action}) do
    case action do
      "stop" ->
        capture = Captures.get_capture!(capture_id)
        if capture.id_person == conn.assigns.person.id_person do
          timer = Timers.stop_timer(timer_id)
          render(conn, "update.json", timer: timer)
        else
          conn
          |> put_resp_header("www-authenticate", "Bearer realm=\"Person access\"")
          |> send_resp(401, "unauthorized")
          |> halt()
        end
      _ ->
          conn
          |> send_resp(404, "timer action not found")
          |> halt()
    end
  end


end
