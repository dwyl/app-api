defmodule AppApi.Repo.Migrations.RemoveTimestampCapturesTags do
  use Ecto.Migration

  def change do
    alter table(:captures_tags) do
      remove :inserted_at
      remove :updated_at
    end
  end
end
