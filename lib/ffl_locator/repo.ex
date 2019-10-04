defmodule FflLocator.Repo do
  use Ecto.Repo,
    otp_app: :ffl_locator,
    adapter: Ecto.Adapters.Postgres
end
