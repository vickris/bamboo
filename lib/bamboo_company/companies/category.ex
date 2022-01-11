defmodule BambooCompany.Companies.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    many_to_many :users, BambooCompany.Accounts.User,
      join_through: BambooCompany.Companies.CategoryUser

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
