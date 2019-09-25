defmodule FflApiWeb.DealerView do
  use FflApiWeb, :view
  alias FflApiWeb.DealerView

  def render("index.json", %{dealers: dealers}) do
    %{data: render_many(dealers, DealerView, "dealer.json")}
  end

  def render("show.json", %{dealer: dealer}) do
    %{data: render_one(dealer, DealerView, "dealer.json")}
  end

  def render("dealer.json", %{dealer: dealer}) do
    %{id: dealer.id,
      license_name: dealer.license_name,
      business_name: dealer.business_name,
      premise_street: dealer.premise_street,
      premise_city: dealer.premise_city,
      premise_state: dealer.premise_state,
      premise_zip: dealer.premise_zip,
      mail_street: dealer.mail_street,
      mail_city: dealer.mail_city,
      mail_state: dealer.mail_state,
      mail_zip: dealer.mail_zip,
      phone_number: dealer.phone_number,
      fees: dealer.fees,
      schedule: dealer.schedule,
      enabled: dealer.enabled,
      preferred: dealer.preferred}
  end
end
