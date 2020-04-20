defmodule AppApi.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.Captures.Capture

  schema "tags" do
    field :text, :string
    field :id_person, :integer

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:text, :id_person])
    |> validate_required([:text])
  end
end
