defmodule BambooCompany.ListingsTest do
  use BambooCompany.DataCase, async: true

  alias BambooCompany.Repo
  alias BambooCompany.Listings
  alias BambooCompany.Companies.Category
  alias BambooCompany.Companies.Company

  describe "insert company" do
    test "creates a new category if it doesn't exist and assigns company to it" do
      payload = %{"company_name" => "Company X", "category" => "New one"}
      initial_category_count = Repo.all(Category) |> Enum.count()
      Listings.insert_company(payload)
      new_category_count = Repo.all(Category) |> Enum.count()

      assert initial_category_count == 0
      assert new_category_count == 1
    end

    test "Works with existing category to list new company" do
      payload = %{"company_name" => "Company Y", "category" => "New one"}
      initial_category_count = Repo.all(Category) |> Enum.count()
      Listings.insert_company(payload)
      new_category_count = Repo.all(Category) |> Enum.count()

      payload = %{"company_name" => "Company Z", "category" => "New one"}
      Listings.insert_company(payload)

      latest_category_count = Repo.all(Category) |> Enum.count()

      assert initial_category_count == 0
      assert new_category_count == 1
      assert latest_category_count == new_category_count
    end
  end

  test "batch insert inserts all the records" do
    initial_company_count = Repo.all(Company) |> Enum.count()

    records = [
      %{"company_name" => "company X", "category" => "category X"},
      %{"company_name" => "company Y", "category" => "category Y"},
      %{"company_name" => "company Z", "category" => "category X"},
    ]

    Listings.batch_insert(records)

    latest_count = Repo.all(Company) |> Enum.count()

    assert  initial_company_count != latest_count
    assert  initial_company_count == 0
    assert  latest_count == 3
  end
end
