defmodule FflApi.Ffl do
  @moduledoc """
  The Ffl context.
  """

  import Ecto.Query, warn: false
  alias FflApi.Repo

  alias FflApi.Ffl.Dealer

  @doc """
  Returns the list of dealers.

  ## Examples

      iex> list_dealers()
      [%Dealer{}, ...]

  """
  def list_dealers do
    Repo.all(Dealer)
  end

  @doc """
  Gets a single dealer.

  Raises `Ecto.NoResultsError` if the Dealer does not exist.

  ## Examples

      iex> get_dealer!(123)
      %Dealer{}

      iex> get_dealer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dealer!(id), do: Repo.get!(Dealer, id)

  @doc """
  Creates a dealer.

  ## Examples

      iex> create_dealer(%{field: value})
      {:ok, %Dealer{}}

      iex> create_dealer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dealer(attrs \\ %{}) do
    %Dealer{}
    |> Dealer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dealer.

  ## Examples

      iex> update_dealer(dealer, %{field: new_value})
      {:ok, %Dealer{}}

      iex> update_dealer(dealer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dealer(%Dealer{} = dealer, attrs) do
    dealer
    |> Dealer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Dealer.

  ## Examples

      iex> delete_dealer(dealer)
      {:ok, %Dealer{}}

      iex> delete_dealer(dealer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dealer(%Dealer{} = dealer) do
    Repo.delete(dealer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dealer changes.

  ## Examples

      iex> change_dealer(dealer)
      %Ecto.Changeset{source: %Dealer{}}

  """
  def change_dealer(%Dealer{} = dealer) do
    Dealer.changeset(dealer, %{})
  end

  def insert_dealers do
    dealers =
      readTSV()
      |> parseLines()
      |> removeHeaders()
      |> Enum.map(&addBusinessName(&1))
      |> Enum.map(&toMap(&1))
      |> Enum.filter(&(&1.premise_state != "PR"))

    Enum.map(
      dealers,
      &Repo.insert!(%Dealer{
        license_name: &1.license_name,
        business_name: &1.business_name,
        premise_street: &1.premise_street,
        premise_city: &1.premise_city,
        premise_state: &1.premise_state,
        premise_zip: &1.premise_zip,
        mail_street: &1.mail_street,
        mail_city: &1.mail_city,
        mail_state: &1.mail_state,
        mail_zip: &1.mail_zip,
        phone_number: &1.phone_number,
        fees: &1.fees,
        schedule: &1.schedule,
        enabled: &1.enabled,
        preferred: &1.preferred
      })
    )
  end

  def readTSV do
    {status, file} = File.read("assets/csv/ffl-list.txt")

    case status do
      :ok ->
        file

      :error ->
        exit("Cannot find specified file")
    end
  end

  def parseLines(file) do
    String.replace(file, "\"", "")
    |> String.split("\r\n")
    |> Enum.map(&String.split(&1, "\t"))
  end

  def addBusinessName(line) do
    if Enum.at(line, 7) == "" do
      List.replace_at(line, 7, Enum.at(line, 6))
    else
      line
    end
  end

  def removeHeaders(list) do
    List.delete_at(list, 0)
    |> List.delete_at(0)
  end

  def toMap(line) do
    %{
      #      license_region: Enum.at(line, 0),
      #      license_district: Enum.at(line, 1),
      #      license_county: Enum.at(line, 2),
      #      license_type: Enum.at(line, 3),
      #      license_expiration: Enum.at(line, 4),
      #      license_sequence: Enum.at(line, 5),
      license_name: Enum.at(line, 6),
      business_name: Enum.at(line, 7),
      premise_street: Enum.at(line, 8),
      premise_city: Enum.at(line, 9),
      premise_state: Enum.at(line, 10),
      premise_zip: Enum.at(line, 11),
      mail_street: Enum.at(line, 12),
      mail_city: Enum.at(line, 13),
      mail_state: Enum.at(line, 14),
      mail_zip: Enum.at(line, 15),
      phone_number: Enum.at(line, 16),
      fees: "",
      schedule: "",
      enabled: false,
      preferred: false
    }
  end
end
