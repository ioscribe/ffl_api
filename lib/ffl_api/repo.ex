defmodule FflApi.Repo do
  use Ecto.Repo,
    otp_app: :ffl_api,
    adapter: Ecto.Adapters.Postgres
end
