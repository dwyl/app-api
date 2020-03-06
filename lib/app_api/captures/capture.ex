defmodule AppApi.Captures.Capture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "captures" do
    field :completed, :boolean, default: false
    field :id_person, :integer
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(capture, attrs) do
    capture
    |> cast(attrs, [:id_person, :text, :completed])
    |> validate_required([:id_person, :text, :completed])
  end
end
