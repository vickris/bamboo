defmodule BambooCompany.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :category_id, :integer
      timestamps()
    end

  end
end
