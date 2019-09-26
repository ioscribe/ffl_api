defmodule FflApi.Repo.Migrations.CreateDealers do
  use Ecto.Migration

  def change do
    create table(:dealers) do
      add :license, :string
      add :license_region, :string
      add :license_district, :string
      add :license_county, :string
      add :license_type, :string
      add :license_expiration, :string
      add :license_sequence, :string
      add :business_name, :string
      add :license_name, :string
      add :mail_city, :string
      add :mail_state, :string
      add :mail_street, :string
      add :mail_zip, :string
      add :phone_number, :string
      add :premise_city, :string
      add :premise_state, :string
      add :premise_street, :string
      add :premise_zip, :string

      timestamps()
    end

  end
end
