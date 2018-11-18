defmodule Critistry.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :image, :string
      add :bio, :string
      add :last_login, :timestamptz

      timestamps(type: :timestamptz)
    end

  end
end
