defmodule BambooCompany.Listings do
  alias BambooCompany.Repo
  alias BambooCompany.Companies.Company
  alias BambooCompany.Companies.Category
  alias BambooCompany.EmailService
  require Logger

  @spec insert_company(map) :: any
  def insert_company(%{"company_name" => name, "category" => category_name}) do
    category = get_or_create_category(category_name);

    %Company{}
    |> Company.changeset(%{name: name})
    |> Ecto.Changeset.put_assoc(:category, category)
    |> Repo.insert()
  end

  def batch_insert(companies) do
    companies
    |> Enum.chunk_every(5)
    |> Enum.each(fn chunk ->
      chunk
      |> Enum.each(fn record ->
        insert_into_db_and_broadcast(record)
      end)
    end)
  end

  # Should Probably go into a utils file somewhere
  defp insert_into_db_and_broadcast(record) do
    case insert_company(record) do
      {:ok, company} ->
        EmailService.send_email(company)
        BambooCompanyWeb.Endpoint.broadcast!("listings:new", "new_listing", %{body: record})
      {:error, changeset} -> Logger.info("Something went wrong during company creation. Supplied params #{inspect(changeset)}")
    end
  end

  defp get_or_create_category(category_name) do
    category = Repo.get_by(Category, name: category_name)

     case category do
      nil -> create_category(category_name)
      _   -> category
     end
  end

  defp create_category(category_name)  do
    Repo.insert!(%Category{name: category_name})
  end
end
