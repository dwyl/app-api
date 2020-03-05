defmodule AppApiWeb.PersonView do
  use AppApiWeb, :view

  def render("index.json", %{person: person}) do
    %{data: person}
  end

end
