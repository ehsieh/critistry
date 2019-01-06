defmodule Critistry.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string

      timestamps()
    end

    create table(:crit_groups_categories, primary_key: false) do
      add :category_id, references(:categories, on_delete: :delete_all)
      add :crit_group_id, references(:crit_groups, on_delete: :delete_all)
    end

    create unique_index(:crit_groups_categories, [:category_id, :crit_group_id])

  end
end
