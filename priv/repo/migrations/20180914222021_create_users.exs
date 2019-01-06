defmodule Critistry.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :avatar, :string
      add :bio, :text


      timestamps(type: :timestamptz)
    end
    
    create unique_index(:users, [:user_name])
  end
end
