defmodule FflLocatorWeb.DealerView do
  use FflLocatorWeb, :view
  alias FflLocatorWeb.DealerView

  def render("index.json", %{dealers: dealers}) do
    %{data: render_many(dealers, DealerView, "dealer.json")}
  end

  def render("show.json", %{dealer: dealer}) do
    %{data: render_one(dealer, DealerView, "dealer.json")}
  end

  def render("dealer.json", %{dealer: dealer}) do
    %{id: dealer.id,
      business_name: dealer.business_name,
      license: dealer.license,
      license_county: dealer.license_county,
      license_district: dealer.license_district,
      license_expiration: dealer.license_expiration,
      license_name: dealer.license_name,
      license_region: dealer.license_region,
      license_sequence: dealer.license_sequence,
      license_type: dealer.license_type,
      mail_city: dealer.mail_city,
      mail_state: dealer.mail_state,
      mail_street: dealer.mail_street,
      mail_zip: dealer.mail_zip,
      phone_number: dealer.phone_number,
      premise_city: dealer.premise_city,
      premise_state: dealer.premise_state,
      premise_street: dealer.premise_street,
      premise_zip: dealer.premise_zip}
  end
end
