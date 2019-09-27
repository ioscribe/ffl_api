defmodule FflApi.Ffl do
  @moduledoc """
  The Ffl context.
  """
  import Ecto.Query, warn: false, only: [from: 2]
  alias FflApi.Repo

  alias FflApi.Ffl.Dealer

  @doc """
  Returns the list of dealers.

  ## Examples

      iex> list_dealers()
      [%Dealer{}, ...]

  """
  def list_dealers(params) do
    search_term = get_in(params, ["query"])

    Dealer
    |> dealer_search(search_term)
    |> Repo.all()
  end

  def dealer_search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from dealer in query,
      where: ilike(dealer.business_name, ^wildcard_search)
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
      read_tsv()
      |> parseLines()
      |> remove_headers()
      |> Enum.map(&addBusinessName(&1))
      |> Enum.map(&to_map(&1))
      |> Enum.filter(&(&1.premise_state != "PR"))

    Enum.map(
      dealers,
      &Repo.insert!(%Dealer{
        license: &1.license,
        license_region: &1.license_region,
        license_district: &1.license_district,
        license_county: &1.license_county,
        license_type: &1.license_type,
        license_expiration: &1.license_expiration,
        license_sequence: &1.license_sequence,
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
        phone_number: &1.phone_number
      })
    )
  end

  def read_tsv do
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

  def remove_headers(list) do
    List.delete_at(list, 0)
    |> List.delete_at(0)
  end

  def to_map(line) do
    %{
      license: to_license(line),
      license_region: Enum.at(line, 0),
      license_district: Enum.at(line, 1),
      license_county: Enum.at(line, 2),
      license_type: Enum.at(line, 3),
      license_expiration: Enum.at(line, 4),
      license_sequence: Enum.at(line, 5),
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
      phone_number: Enum.at(line, 16)
    }
  end

  def to_license(line) do
    region = Enum.at(line, 0)
    district = Enum.at(line, 1)
    county = Enum.at(line, 2)
    type = Enum.at(line, 3)
    expiration = Enum.at(line, 4)
    sequence = Enum.at(line, 5)

    region <>
      "-" <> district <> "-" <> county <> "-" <> type <> "-" <> expiration <> "-" <> sequence
  end

  alias FflApi.Ffl.DealerOption

  @doc """
  Returns the list of dealer_options.

  ## Examples

      iex> list_dealer_options()
      [%DealerOption{}, ...]

  """
  def list_dealer_options do
    Repo.all(DealerOption)
  end

  @doc """
  Gets a single dealer_option.

  Raises `Ecto.NoResultsError` if the Dealer option does not exist.

  ## Examples

      iex> get_dealer_option!(123)
      %DealerOption{}

      iex> get_dealer_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dealer_option!(id), do: Repo.get!(DealerOption, id)

  @doc """
  Creates a dealer_option.

  ## Examples

      iex> create_dealer_option(%{field: value})
      {:ok, %DealerOption{}}

      iex> create_dealer_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dealer_option(attrs \\ %{}) do
    %DealerOption{}
    |> DealerOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dealer_option.

  ## Examples

      iex> update_dealer_option(dealer_option, %{field: new_value})
      {:ok, %DealerOption{}}

      iex> update_dealer_option(dealer_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dealer_option(%DealerOption{} = dealer_option, attrs) do
    dealer_option
    |> DealerOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DealerOption.

  ## Examples

      iex> delete_dealer_option(dealer_option)
      {:ok, %DealerOption{}}

      iex> delete_dealer_option(dealer_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dealer_option(%DealerOption{} = dealer_option) do
    Repo.delete(dealer_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dealer_option changes.

  ## Examples

      iex> change_dealer_option(dealer_option)
      %Ecto.Changeset{source: %DealerOption{}}

  """
  def change_dealer_option(%DealerOption{} = dealer_option) do
    DealerOption.changeset(dealer_option, %{})
  end
end
