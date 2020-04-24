defmodule AppApiWeb.TagController do
  use AppApiWeb, :controller
  alias AppApi.Tags

  def index(conn, _params) do
    tags = Tags.get_tags_by_id_person(conn.assigns.person.id_person)
    default_tags = Tags.get_default_tags()
    render(conn, "index.json", tags: default_tags ++ tags)
  end
end
