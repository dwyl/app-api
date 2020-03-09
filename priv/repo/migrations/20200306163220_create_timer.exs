defmodule AppApi.Repo.Migrations.CreateTimer do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :started_at, :naive_datetime
      add :stopped_at, :naive_datetime
      add :capture_id, references(:captures, on_delete: :nothing)
      timestamps()
    end

    create index(:timers, [:capture_id])
  end
end
