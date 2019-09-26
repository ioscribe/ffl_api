defmodule FflApi.Repo.Migrations.UpdateDealerTable do
  use Ecto.Migration

  def change do
    alter table(:dealers) do
      remove :fees
      remove :schedule
      remove :enabled
      remove :preferred
      add :license_district, :string
      add :license_county, :string
      add :license_type, :string
      add :license_expiration, :string
      add :license_sequence, :string
    end
  end
end
