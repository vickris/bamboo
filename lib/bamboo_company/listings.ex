defmodule BambooCompany.Listings do
  alias BambooCompany.Repo
  alias BambooCompany.Companies.Company
  alias BambooCompany.Companies.Category

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
        insert_company(record)
      end)
    end)
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
