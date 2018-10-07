defmodule Critistry.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :avatar, :string
    field :email, :string
    field :last_login, :utc_datetime
    field :user_name, :string
    field :first_name, :string
    field :last_name, :string
    field :bio, :string
    many_to_many :crit_groups, Critistry.Crits.CritGroup, join_through: "users_crit_groups"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_name, :email, :avatar, :last_login])
    |> validate_required([:user_name, :email, :avatar, :last_login])
  end
end
