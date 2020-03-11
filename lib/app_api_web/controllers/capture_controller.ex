defmodule AppApiWeb.CaptureController do
  use AppApiWeb, :controller

  def index(conn, _params) do
    captures = AppApi.Captures.get_capture_by_id_person(conn.assigns.person.id_person)

    render(conn, "index.json", captures: captures)
  end

  def create(conn, params) do
    capture = %{text: params["text"], id_person: conn.assigns.person.id_person}
    {:ok, capture} = AppApi.Captures.create_capture(capture)
    render(conn, "create.json", capture: capture)
  end
end
