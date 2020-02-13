defmodule AppApi.Repo do
  use Ecto.Repo,
    otp_app: :app_api,
    adapter: Ecto.Adapters.Postgres
end
