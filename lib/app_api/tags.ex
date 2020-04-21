defmodule AppApi.Tags do
  @moduledoc """
  The Tags context.
  """

  import Ecto.Query, warn: false
  alias AppApi.Repo

  alias AppApi.Tags.Tag

  @doc """
  Returns the list of tags created by a person
  i.e. default tags
  """
  def get_tags_by_id_person(id_person) do
    query =
      from t in Tag,
        where: t.id_person == ^id_person,
        order_by: [asc: t.text]

    Repo.all(query)
  end

  @doc """
  Returns the list of tags where the person is not defined
  i.e. default tags
  """
  def get_default_tags() do
    query =
      from t in Tag,
        where: is_nil(t.id_person),
        order_by: [asc: t.text]

    Repo.all(query)
  end

  @doc """
  Creates a tag.
  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert!()
  end
end
