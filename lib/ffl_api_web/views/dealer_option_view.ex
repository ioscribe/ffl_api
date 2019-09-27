defmodule FflApiWeb.DealerOptionView do
  use FflApiWeb, :view
  alias FflApiWeb.DealerOptionView

  def render("index.json", %{dealer_options: dealer_options}) do
    %{data: render_many(dealer_options, DealerOptionView, "dealer_option.json")}
  end

  def render("show.json", %{dealer_option: dealer_option}) do
    %{data: render_one(dealer_option, DealerOptionView, "dealer_option.json")}
  end

  def render("dealer_option.json", %{dealer_option: dealer_option}) do
    %{id: dealer_option.id,
      enabled: dealer_option.enabled,
      preferred: dealer_option.preferred,
      fees: dealer_option.fees,
      schedules: dealer_option.schedules,
      dealer_id: dealer_option.dealer_id
    }
  end
end
