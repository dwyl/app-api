defmodule AppApi.Timers.Timer do
  use Ecto.Schema
  import Ecto.Changeset
  alias AppApi.Captures.Capture

  schema "timers" do
    field :started_at, :naive_datetime
    field :stopped_at, :naive_datetime

    belongs_to :capture, Capture
    timestamps()
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:started_at, :stopped_at])
    |> validate_required([:started_at])
  end
end
