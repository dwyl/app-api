defmodule AppApi.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :text, :string
      add :id_person, :integer

      timestamps()
    end

    create unique_index(:tags, [:text])
  end

end
