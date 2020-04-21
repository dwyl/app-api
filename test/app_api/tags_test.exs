defmodule AppApi.TagsTest do
  use AppApi.DataCase

  alias AppApi.Tags

  describe "tags" do
    alias AppApi.Tags.Tag

    @valid_attrs %{id_person: 42, text: "tag1"}
    @invalid_attrs %{id_person: 42, text: ""}

    def tag_fixture(attrs \\ %{}) do
      attrs
      |> Enum.into(@valid_attrs)
      |> Tags.create_tag()
    end

    test "get_default_tags/0 returns all tags" do
      tag = tag_fixture(%{id_person: nil})
      assert Tags.get_default_tags() == [tag]
    end

    test "get_tags_by_id_person/1 returns all tags for a person" do
      tag1 = tag_fixture(%{text: "a", id_person: 32})
      tag2 = tag_fixture(%{text: "b", id_person: 32})
      assert Tags.get_tags_by_id_person(32) == [tag1, tag2] # order by tag name
    end

    test "create tag with wrong attr return an error" do
      assert catch_error(Tags.create_tag(@invalid_attrs))
    end

    test "create_tag/1 with valid data creates a tag" do
      assert %Tag{} = tag = Tags.create_tag(@valid_attrs)
      assert tag.id_person == 42
      assert tag.text == "tag1"
    end
  end
end
