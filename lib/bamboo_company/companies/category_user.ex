defmodule BambooCompany.Companies.CategoryUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "category_user" do
    belongs_to :category, BambooCompany.Companies.Category
    belongs_to :user, BambooCompany.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(category_user, attrs) do
    category_user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
