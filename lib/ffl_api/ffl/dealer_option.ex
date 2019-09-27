defmodule FflApi.Ffl.DealerOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dealer_options" do
    field :enabled, :boolean, default: false
    field :fees, :string
    field :preferred, :boolean, default: false
    field :schedules, :string
    field :dealer_id, :id

    timestamps()
  end

  @doc false
  def changeset(dealer_option, attrs) do
    dealer_option
    |> cast(attrs, [:enabled, :preferred, :fees, :schedules, :dealer_id])
    |> validate_required([:enabled, :preferred, :fees, :schedules, :dealer_id])
  end
end
