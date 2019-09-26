defmodule FflApiWeb.DealerControllerTest do
  use FflApiWeb.ConnCase

  alias FflApi.Ffl
  alias FflApi.Ffl.Dealer

  @create_attrs %{
    business_name: "some business_name",
    license: "some license",
    license_county: "some license_county",
    license_district: "some license_district",
    license_expiration: "some license_expiration",
    license_name: "some license_name",
    license_region: "some license_region",
    license_sequence: "some license_sequence",
    license_type: "some license_type",
    mail_city: "some mail_city",
    mail_state: "some mail_state",
    mail_street: "some mail_street",
    mail_zip: "some mail_zip",
    phone_number: "some phone_number",
    premise_city: "some premise_city",
    premise_state: "some premise_state",
    premise_street: "some premise_street",
    premise_zip: "some premise_zip"
  }
  @update_attrs %{
    business_name: "some updated business_name",
    license: "some updated license",
    license_county: "some updated license_county",
    license_district: "some updated license_district",
    license_expiration: "some updated license_expiration",
    license_name: "some updated license_name",
    license_region: "some updated license_region",
    license_sequence: "some updated license_sequence",
    license_type: "some updated license_type",
    mail_city: "some updated mail_city",
    mail_state: "some updated mail_state",
    mail_street: "some updated mail_street",
    mail_zip: "some updated mail_zip",
    phone_number: "some updated phone_number",
    premise_city: "some updated premise_city",
    premise_state: "some updated premise_state",
    premise_street: "some updated premise_street",
    premise_zip: "some updated premise_zip"
  }
  @invalid_attrs %{business_name: nil, license: nil, license_county: nil, license_district: nil, license_expiration: nil, license_name: nil, license_region: nil, license_sequence: nil, license_type: nil, mail_city: nil, mail_state: nil, mail_street: nil, mail_zip: nil, phone_number: nil, premise_city: nil, premise_state: nil, premise_street: nil, premise_zip: nil}

  def fixture(:dealer) do
    {:ok, dealer} = Ffl.create_dealer(@create_attrs)
    dealer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dealers", %{conn: conn} do
      conn = get(conn, Routes.dealer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dealer" do
    test "renders dealer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dealer_path(conn, :create), dealer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.dealer_path(conn, :show, id))

      assert %{
               "id" => id,
               "business_name" => "some business_name",
               "license" => "some license",
               "license_county" => "some license_county",
               "license_district" => "some license_district",
               "license_expiration" => "some license_expiration",
               "license_name" => "some license_name",
               "license_region" => "some license_region",
               "license_sequence" => "some license_sequence",
               "license_type" => "some license_type",
               "mail_city" => "some mail_city",
               "mail_state" => "some mail_state",
               "mail_street" => "some mail_street",
               "mail_zip" => "some mail_zip",
               "phone_number" => "some phone_number",
               "premise_city" => "some premise_city",
               "premise_state" => "some premise_state",
               "premise_street" => "some premise_street",
               "premise_zip" => "some premise_zip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dealer_path(conn, :create), dealer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dealer" do
    setup [:create_dealer]

    test "renders dealer when data is valid", %{conn: conn, dealer: %Dealer{id: id} = dealer} do
      conn = put(conn, Routes.dealer_path(conn, :update, dealer), dealer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.dealer_path(conn, :show, id))

      assert %{
               "id" => id,
               "business_name" => "some updated business_name",
               "license" => "some updated license",
               "license_county" => "some updated license_county",
               "license_district" => "some updated license_district",
               "license_expiration" => "some updated license_expiration",
               "license_name" => "some updated license_name",
               "license_region" => "some updated license_region",
               "license_sequence" => "some updated license_sequence",
               "license_type" => "some updated license_type",
               "mail_city" => "some updated mail_city",
               "mail_state" => "some updated mail_state",
               "mail_street" => "some updated mail_street",
               "mail_zip" => "some updated mail_zip",
               "phone_number" => "some updated phone_number",
               "premise_city" => "some updated premise_city",
               "premise_state" => "some updated premise_state",
               "premise_street" => "some updated premise_street",
               "premise_zip" => "some updated premise_zip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, dealer: dealer} do
      conn = put(conn, Routes.dealer_path(conn, :update, dealer), dealer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dealer" do
    setup [:create_dealer]

    test "deletes chosen dealer", %{conn: conn, dealer: dealer} do
      conn = delete(conn, Routes.dealer_path(conn, :delete, dealer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.dealer_path(conn, :show, dealer))
      end
    end
  end

  defp create_dealer(_) do
    dealer = fixture(:dealer)
    {:ok, dealer: dealer}
  end
end
