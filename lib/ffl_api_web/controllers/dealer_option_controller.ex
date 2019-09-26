defmodule FflApiWeb.DealerOptionController do
  use FflApiWeb, :controller

  alias FflApi.Ffl
  alias FflApi.Ffl.DealerOption

  action_fallback FflApiWeb.FallbackController

  def index(conn, _params) do
    dealer_options = Ffl.list_dealer_options()
    render(conn, "index.json", dealer_options: dealer_options)
  end

  def create(conn, %{"dealer_option" => dealer_option_params}) do
    with {:ok, %DealerOption{} = dealer_option} <- Ffl.create_dealer_option(dealer_option_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.dealer_option_path(conn, :show, dealer_option))
      |> render("show.json", dealer_option: dealer_option)
    end
  end

  def show(conn, %{"id" => id}) do
    dealer_option = Ffl.get_dealer_option!(id)
    render(conn, "show.json", dealer_option: dealer_option)
  end

  def update(conn, %{"id" => id, "dealer_option" => dealer_option_params}) do
    dealer_option = Ffl.get_dealer_option!(id)

    with {:ok, %DealerOption{} = dealer_option} <- Ffl.update_dealer_option(dealer_option, dealer_option_params) do
      render(conn, "show.json", dealer_option: dealer_option)
    end
  end

  def delete(conn, %{"id" => id}) do
    dealer_option = Ffl.get_dealer_option!(id)

    with {:ok, %DealerOption{}} <- Ffl.delete_dealer_option(dealer_option) do
      send_resp(conn, :no_content, "")
    end
  end
end
