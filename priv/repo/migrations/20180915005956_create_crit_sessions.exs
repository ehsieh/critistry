defmodule Critistry.Repo.Migrations.CreateCritSessions do
  use Ecto.Migration

  def change do
    create table(:crit_sessions) do
      add :name, :string
      add :description, :text
      add :image, :string      
      add :start_date, :timestamptz
      add :end_date, :timestamptz
      add :crit_group_id, references(:crit_groups, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      
      timestamps()
    end

    create index(:crit_sessions, [:crit_group_id])
    create index(:crit_sessions, [:user_id])

  end
end
