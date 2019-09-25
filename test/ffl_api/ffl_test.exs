defmodule FflApi.FflTest do
  use FflApi.DataCase

  alias FflApi.Ffl

  describe "dealers" do
    alias FflApi.Ffl.Dealer

    @valid_attrs %{business_name: "some business_name", enabled: true, fees: "some fees", license_name: "some license_name", mail_city: "some mail_city", mail_state: "some mail_state", mail_street: "some mail_street", mail_zip: "some mail_zip", phone_number: "some phone_number", preferred: true, premise_city: "some premise_city", premise_state: "some premise_state", premise_street: "some premise_street", premise_zip: "some premise_zip", schedule: "some schedule"}
    @update_attrs %{business_name: "some updated business_name", enabled: false, fees: "some updated fees", license_name: "some updated license_name", mail_city: "some updated mail_city", mail_state: "some updated mail_state", mail_street: "some updated mail_street", mail_zip: "some updated mail_zip", phone_number: "some updated phone_number", preferred: false, premise_city: "some updated premise_city", premise_state: "some updated premise_state", premise_street: "some updated premise_street", premise_zip: "some updated premise_zip", schedule: "some updated schedule"}
    @invalid_attrs %{business_name: nil, enabled: nil, fees: nil, license_name: nil, mail_city: nil, mail_state: nil, mail_street: nil, mail_zip: nil, phone_number: nil, preferred: nil, premise_city: nil, premise_state: nil, premise_street: nil, premise_zip: nil, schedule: nil}

    def dealer_fixture(attrs \\ %{}) do
      {:ok, dealer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ffl.create_dealer()

      dealer
    end

    test "list_dealers/0 returns all dealers" do
      dealer = dealer_fixture()
      assert Ffl.list_dealers() == [dealer]
    end

    test "get_dealer!/1 returns the dealer with given id" do
      dealer = dealer_fixture()
      assert Ffl.get_dealer!(dealer.id) == dealer
    end

    test "create_dealer/1 with valid data creates a dealer" do
      assert {:ok, %Dealer{} = dealer} = Ffl.create_dealer(@valid_attrs)
      assert dealer.business_name == "some business_name"
      assert dealer.enabled == true
      assert dealer.fees == "some fees"
      assert dealer.license_name == "some license_name"
      assert dealer.mail_city == "some mail_city"
      assert dealer.mail_state == "some mail_state"
      assert dealer.mail_street == "some mail_street"
      assert dealer.mail_zip == "some mail_zip"
      assert dealer.phone_number == "some phone_number"
      assert dealer.preferred == true
      assert dealer.premise_city == "some premise_city"
      assert dealer.premise_state == "some premise_state"
      assert dealer.premise_street == "some premise_street"
      assert dealer.premise_zip == "some premise_zip"
      assert dealer.schedule == "some schedule"
    end

    test "create_dealer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ffl.create_dealer(@invalid_attrs)
    end

    test "update_dealer/2 with valid data updates the dealer" do
      dealer = dealer_fixture()
      assert {:ok, %Dealer{} = dealer} = Ffl.update_dealer(dealer, @update_attrs)
      assert dealer.business_name == "some updated business_name"
      assert dealer.enabled == false
      assert dealer.fees == "some updated fees"
      assert dealer.license_name == "some updated license_name"
      assert dealer.mail_city == "some updated mail_city"
      assert dealer.mail_state == "some updated mail_state"
      assert dealer.mail_street == "some updated mail_street"
      assert dealer.mail_zip == "some updated mail_zip"
      assert dealer.phone_number == "some updated phone_number"
      assert dealer.preferred == false
      assert dealer.premise_city == "some updated premise_city"
      assert dealer.premise_state == "some updated premise_state"
      assert dealer.premise_street == "some updated premise_street"
      assert dealer.premise_zip == "some updated premise_zip"
      assert dealer.schedule == "some updated schedule"
    end

    test "update_dealer/2 with invalid data returns error changeset" do
      dealer = dealer_fixture()
      assert {:error, %Ecto.Changeset{}} = Ffl.update_dealer(dealer, @invalid_attrs)
      assert dealer == Ffl.get_dealer!(dealer.id)
    end

    test "delete_dealer/1 deletes the dealer" do
      dealer = dealer_fixture()
      assert {:ok, %Dealer{}} = Ffl.delete_dealer(dealer)
      assert_raise Ecto.NoResultsError, fn -> Ffl.get_dealer!(dealer.id) end
    end

    test "change_dealer/1 returns a dealer changeset" do
      dealer = dealer_fixture()
      assert %Ecto.Changeset{} = Ffl.change_dealer(dealer)
    end
  end
end
