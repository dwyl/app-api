defmodule AppApiWeb.TagView do
  use AppApiWeb, :view

  def render("index.json", %{tags: tags}) do
    %{data: Enum.map(tags, &tag_to_json/1)}
  end

  def tag_to_json(tag) do
    %{
      text: tag.text,
      id_person: tag.id_person
    }
  end
end
