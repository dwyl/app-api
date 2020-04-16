defmodule :"Elixir.AppApi.Repo.Migrations.Task-note" do
  use Ecto.Migration

  def change do
    alter table(:captures) do
      add :task, :boolean, default: true, null: false
    end
  end
end
