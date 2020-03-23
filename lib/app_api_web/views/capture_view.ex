defmodule AppApiWeb.CaptureView do
  use AppApiWeb, :view
  alias AppApiWeb.TimerView

  def render("index.json", %{captures: captures}) do
    %{data: Enum.map(captures, &capture_to_json/1)}
  end

  def render("show.json", %{capture: capture}) do
    %{data: capture_to_json(capture)}
  end

  def render("create.json", %{capture: capture}) do
    %{data: capture_to_json(capture)}
  end

  def capture_to_json(capture) do
    %{
      capture_id: capture.id,
      id_person: capture.id_person,
      text: capture.text,
      completed: capture.completed,
      timers: Enum.map(capture.timers, &TimerView.timer_to_json/1)
    }
  end
end
