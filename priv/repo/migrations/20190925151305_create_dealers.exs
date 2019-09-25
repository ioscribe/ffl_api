defmodule FflApi.Repo.Migrations.CreateDealers do
  use Ecto.Migration

  def change do
    create table(:dealers) do
      add :license_name, :string
      add :business_name, :string
      add :premise_street, :string
      add :premise_city, :string
      add :premise_state, :string
      add :premise_zip, :string
      add :mail_street, :string
      add :mail_city, :string
      add :mail_state, :string
      add :mail_zip, :string
      add :phone_number, :string
      add :fees, :string
      add :schedule, :string
      add :enabled, :boolean, default: false, null: false
      add :preferred, :boolean, default: false, null: false

      timestamps()
    end

  end
end
