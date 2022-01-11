defmodule BambooCompany.Repo.Migrations.AddCategoryUsersTable do
  use Ecto.Migration

  def change do
    create table(:category_user) do
      add :category_id, references(:categories)
      add :user_id, references(:users)

      timestamps()
    end

  end
end
