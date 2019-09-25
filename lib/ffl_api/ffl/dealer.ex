defmodule FflApi.Ffl.Dealer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dealers" do
    field :business_name, :string
    field :enabled, :boolean, default: false
    field :fees, :string
    field :license_name, :string
    field :mail_city, :string
    field :mail_state, :string
    field :mail_street, :string
    field :mail_zip, :string
    field :phone_number, :string
    field :preferred, :boolean, default: false
    field :premise_city, :string
    field :premise_state, :string
    field :premise_street, :string
    field :premise_zip, :string
    field :schedule, :string

    timestamps()
  end

  @doc false
  def changeset(dealer, attrs) do
    dealer
    |> cast(attrs, [:license_name, :business_name, :premise_street, :premise_city, :premise_state, :premise_zip, :mail_street, :mail_city, :mail_state, :mail_zip, :phone_number, :fees, :schedule, :enabled, :preferred])
    |> validate_required([:license_name, :business_name, :premise_street, :premise_city, :premise_state, :premise_zip, :mail_street, :mail_city, :mail_state, :mail_zip, :phone_number, :fees, :schedule, :enabled, :preferred])
  end
end
