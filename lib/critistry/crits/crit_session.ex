defmodule Critistry.Crits.CritSession do
  use Ecto.Schema
  import Ecto.Changeset


  schema "crit_sessions" do
    field :description, :string
    field :end_date, :naive_datetime
    field :image, :string
    field :is_active, :boolean, default: false
    field :name, :string
    field :start_date, :naive_datetime
    belongs_to :crit_group, Critistry.Crits.CritGroup
    belongs_to :user, Critistry.Auth.User
    has_many :crit, Critistry.Crits.Crit

    timestamps()
  end

  @doc false
  def changeset(crit_session, attrs) do
    crit_session
    |> cast(attrs, [:name, :description, :image, :is_active, :start_date, :end_date])
    |> validate_required([:name, :description, :image, :is_active, :start_date, :end_date])
  end
end
