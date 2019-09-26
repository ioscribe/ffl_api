defmodule FflApi.Repo.Migrations.CreateDealerOptions do
  use Ecto.Migration

  def change do
    create table(:dealer_options) do
      add :enabled, :boolean, default: false, null: false
      add :preferred, :boolean, default: false, null: false
      add :fees, :string
      add :schedules, :string
      add :dealer_id, references(:dealers, on_delete: :nothing)

      timestamps()
    end

    create index(:dealer_options, [:dealer_id])
  end
end
