defmodule Critistry.Crits.CritGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "crit_groups" do
    field(:image, :string)
    field(:description, :string)
    field(:max_members, :integer)
    field(:name, :string)
    field(:session_duration_days, :integer)
    belongs_to(:admin_user, Critistry.Auth.User)
    many_to_many(:users, Critistry.Auth.User, join_through: "users_crit_groups")
    many_to_many(:categories, Critistry.Crits.Category, join_through: "crit_groups_categories")
    has_many(:crit_sessions, Critistry.Crits.CritSession)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(crit_group, attrs) do
    crit_group
    |> cast(attrs, [:name, :description, :image, :max_members, :session_duration_days])
    |> validate_required([:name, :description, :max_members, :session_duration_days])
  end
end
