defmodule AppApiWeb.TimerView do
  use AppApiWeb, :view

  def render("index.json", %{timers: timers}) do
    %{data: Enum.map(timers, &timer_to_json/1)}
  end

  def render("create.json", %{timer: timer}) do
    %{data: timer_to_json(timer)}
  end

  def timer_to_json(timer) do
    %{
      timer_id: timer.id,
      started_at: timer.started_at,
      stopped_at: timer.stopped_at,
      capture_id: timer.capture_id
    }
  end
end
