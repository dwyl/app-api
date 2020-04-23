defmodule AppApi.TagControllerTest do
  use AppApiWeb.ConnCase
  alias AppApi.Tags

  @valid_attrs %{id_person: 42, text: "tag1"}

  def tag_fixture(attrs \\ %{}) do
    attrs
    |> Enum.into(@valid_attrs)
    |> Tags.create_tag()
  end

  describe "test tag endoints" do
    test "index endpoint", %{conn: conn} do
      tag_fixture()
      conn = get(conn, Routes.tag_path(conn, :index))
      response = json_response(conn, 200)
      assert Enum.count(response["data"]) == 1
    end
  end
end
