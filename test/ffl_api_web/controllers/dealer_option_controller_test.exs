defmodule FflApiWeb.DealerOptionControllerTest do
  use FflApiWeb.ConnCase

  alias FflApi.Ffl
  alias FflApi.Ffl.DealerOption

  @create_attrs %{
    enabled: true,
    fees: "some fees",
    preferred: true,
    schedules: "some schedules"
  }
  @update_attrs %{
    enabled: false,
    fees: "some updated fees",
    preferred: false,
    schedules: "some updated schedules"
  }
  @invalid_attrs %{enabled: nil, fees: nil, preferred: nil, schedules: nil}

  def fixture(:dealer_option) do
    {:ok, dealer_option} = Ffl.create_dealer_option(@create_attrs)
    dealer_option
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dealer_options", %{conn: conn} do
      conn = get(conn, Routes.dealer_option_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dealer_option" do
    test "renders dealer_option when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dealer_option_path(conn, :create), dealer_option: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.dealer_option_path(conn, :show, id))

      assert %{
               "id" => id,
               "enabled" => true,
               "fees" => "some fees",
               "preferred" => true,
               "schedules" => "some schedules"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dealer_option_path(conn, :create), dealer_option: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dealer_option" do
    setup [:create_dealer_option]

    test "renders dealer_option when data is valid", %{conn: conn, dealer_option: %DealerOption{id: id} = dealer_option} do
      conn = put(conn, Routes.dealer_option_path(conn, :update, dealer_option), dealer_option: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.dealer_option_path(conn, :show, id))

      assert %{
               "id" => id,
               "enabled" => false,
               "fees" => "some updated fees",
               "preferred" => false,
               "schedules" => "some updated schedules"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, dealer_option: dealer_option} do
      conn = put(conn, Routes.dealer_option_path(conn, :update, dealer_option), dealer_option: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dealer_option" do
    setup [:create_dealer_option]

    test "deletes chosen dealer_option", %{conn: conn, dealer_option: dealer_option} do
      conn = delete(conn, Routes.dealer_option_path(conn, :delete, dealer_option))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.dealer_option_path(conn, :show, dealer_option))
      end
    end
  end

  defp create_dealer_option(_) do
    dealer_option = fixture(:dealer_option)
    {:ok, dealer_option: dealer_option}
  end
end
