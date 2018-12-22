defmodule Critistry.Crits.CritGroup do
  use Ecto.Schema
  import Ecto.Changeset


  schema "crit_groups" do
    field :admin_user_id, :integer
    field :approval_to_join, :boolean, default: false
    field :image, :string    
    field :description, :string
    field :is_private, :boolean, default: false
    field :max_members, :integer
    field :name, :string
    field :session_duration_days, :integer
    many_to_many :users, Critistry.Auth.User, join_through: "users_crit_groups"
    has_many :crit_sessions, Critistry.Crits.CritSession

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(crit_group, attrs) do
    crit_group
    |> cast(attrs, [:name, :description, :image, :is_private, :approval_to_join, :max_members, :session_duration_days, :admin_user_id])
    |> validate_required([:name, :description, :is_private, :approval_to_join, :max_members, :session_duration_days, :admin_user_id])
  end
end
