defmodule Critistry.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:avatar, :string)
    field(:email, :string)
    field(:user_name, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:bio, :string)
    many_to_many(:crit_groups, Critistry.Crits.CritGroup, join_through: "users_crit_groups")

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :user_name, :email, :bio, :avatar])
    |> validate_required([:email, :first_name, :last_name])
    |> unique_constraint(:user_name)
  end
end
