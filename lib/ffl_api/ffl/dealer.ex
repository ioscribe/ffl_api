defmodule FflApi.Ffl.Dealer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dealers" do
    field :business_name, :string
    field :license, :string
    field :license_county, :string
    field :license_district, :string
    field :license_expiration, :string
    field :license_name, :string
    field :license_region, :string
    field :license_sequence, :string
    field :license_type, :string
    field :mail_city, :string
    field :mail_state, :string
    field :mail_street, :string
    field :mail_zip, :string
    field :phone_number, :string
    field :premise_city, :string
    field :premise_state, :string
    field :premise_street, :string
    field :premise_zip, :string

    timestamps()
  end

  @doc false
  def changeset(dealer, attrs) do
    dealer
    |> cast(attrs, [
      :license,
      :license_region,
      :license_district,
      :license_county,
      :license_type,
      :license_expiration,
      :license_sequence,
      :business_name,
      :license_name,
      :mail_city,
      :mail_state,
      :mail_street,
      :mail_zip,
      :phone_number,
      :premise_city,
      :premise_state,
      :premise_street,
      :premise_zip
    ])
    |> validate_required([
      :license,
      :license_region,
      :license_district,
      :license_county,
      :license_type,
      :license_expiration,
      :license_sequence,
      :business_name,
      :license_name,
      :mail_city,
      :mail_state,
      :mail_street,
      :mail_zip,
      :phone_number,
      :premise_city,
      :premise_state,
      :premise_street,
      :premise_zip
    ])
  end
end
