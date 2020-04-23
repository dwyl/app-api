defmodule AppApiWeb.PersonViewTest do
  use AppApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders index.json" do
    person = %{email: "email", name: "name"}
    assert render(AppApiWeb.PersonView, "index.json", %{person: person}) == %{data: person}
  end
end
