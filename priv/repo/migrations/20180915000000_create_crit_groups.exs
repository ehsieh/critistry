defmodule Critistry.Repo.Migrations.CreateCritGroups do
  use Ecto.Migration

  def change do
    create table(:crit_groups) do
      add :name, :string
      add :description, :text
      add :image, :string    
      add :max_members, :integer
      add :session_duration_days, :integer
      add :admin_user_id, references(:users, on_delete: :nothing)    
    
      timestamps()
    end

    create table(:users_crit_groups, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :crit_group_id, references(:crit_groups, on_delete: :delete_all)
    end

    create unique_index(:users_crit_groups, [:user_id, :crit_group_id])

  end
end
