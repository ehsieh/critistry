defmodule Critistry.Repo.Migrations.CreateCritGroups do
  use Ecto.Migration

  def change do
    create table(:crit_groups) do
      add :name, :string
      add :description, :string
      add :avatar, :string
      add :is_private, :boolean, default: false, null: false
      add :approval_to_join, :boolean, default: false, null: false
      add :max_members, :integer
      add :session_duration_days, :integer
      add :admin_user_id, :integer
      add :create_date, :naive_datetime
    
      timestamps()
    end

    create table(:users_crit_groups, primary_key: false) do
      add :user_id, references(:users)
      add :crit_group_id, references(:crit_groups)
    end

    create unique_index(:users_crit_groups, [:user_id, :crit_group_id])

  end
end
