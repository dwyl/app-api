defmodule AppApiWeb.TimerController do
  use AppApiWeb, :controller
  alias AppApi.Timers
  alias AppApi.Captures

  def index(conn, %{"capture_id" => capture_id}) do
    timers = Timers.get_capture_timers(capture_id)
    render(conn, "index.json", timers: timers)
  end

  def create(conn, params) do
    # check capture_id from id belong to assigns.person
    # otherwise return 401

    capture = Captures.get_capture!(params["capture_id"])
    attrs = %{started_at: NaiveDateTime.utc_now()}

    # return the timer created
    {:ok, timer} = Timers.create_timer(capture, attrs)
    render(conn, "create.json", timer: timer)
  end

  def update(conn, %{"capture_id" => _capture_id, "id" => timer_id, "action" => action}) do
    case action do
      "stop" -> Timers.stop_timer(timer_id)
      _ -> IO.inspect("wrong action on timer")
    end

    render(conn, "index.json", timers: [])
  end
end
