defmodule AppApi.Repo.Migrations.CapturesTags do
  use Ecto.Migration

  def change do
    create table(:captures_tags, primary_key: false) do
      add(:capture_id, references(:captures, on_delete: :delete_all), primary_key: true)
      add(:tag_id, references(:tags, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:captures_tags, [:capture_id]))
    create(index(:captures_tags, [:tag_id]))

    create(
      unique_index(:captures_tags, [:capture_id, :tag_id], name: :capture_id_tag_id_unique_index)
    )

  end
end
