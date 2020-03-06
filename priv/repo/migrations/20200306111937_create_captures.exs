defmodule AppApi.Repo.Migrations.CreateCaptures do
  use Ecto.Migration

  def change do
    create table(:captures) do
      add :id_person, :integer
      add :text, :string
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
