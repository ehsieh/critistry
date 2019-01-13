defmodule Critistry.Repo.Migrations.CreateCrits do
  use Ecto.Migration

  def change do
    create table(:crits) do
      add :text, :text            
      add :user_id, references(:users, on_delete: :nothing)
      add :crit_session_id, references(:crit_sessions, on_delete: :nothing)

      timestamps()
    end

    create index(:crits, [:user_id])
    create index(:crits, [:crit_session_id])

  end
end
