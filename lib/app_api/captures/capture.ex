defmodule AppApi.Captures.Capture do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.Timers.Timer
  alias AppApi.Tags.Tag
  import Ecto.Query, warn: false
  alias AppApi.Repo

  schema "captures" do
    field :completed, :boolean, default: false
    field :id_person, :integer
    field :text, :string
    has_many :timers, Timer

    many_to_many :tags, Tag,
      join_through: "captures_tags",
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(capture, attrs) do
    capture
    |> cast(attrs, [:id_person, :text, :completed])
    |> validate_required([:id_person, :text, :completed])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  defp parse_tags(params) do
    (params["tags"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> insert_and_get_all()
  end

  defp insert_and_get_all([]) do
    []
  end

  defp insert_and_get_all(names) do
    maps = Enum.map(names, &%{text: &1})
    Repo.insert_all(Tag, maps, on_conflict: :nothing)
    Repo.all(from t in Tag, where: t.name in ^names)
  end
end
