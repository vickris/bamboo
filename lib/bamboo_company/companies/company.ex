defmodule BambooCompany.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string
    belongs_to :category, BambooCompany.Companies.Category

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> assoc_constraint(:category)
  end
end
