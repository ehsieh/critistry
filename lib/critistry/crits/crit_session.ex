defmodule Critistry.Crits.CritSession do
  use Ecto.Schema
  import Ecto.Changeset


  schema "crit_sessions" do
    field :name, :string
    field :description, :string    
    field :image, :string        
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
    belongs_to :crit_group, Critistry.Crits.CritGroup
    belongs_to :user, Critistry.Auth.User
    has_many :crit, Critistry.Crits.Crit

    timestamps()
  end

  @doc false
  def changeset(crit_session, attrs) do
    crit_session
    |> cast(attrs, [:name, :description, :image, :start_date, :end_date])
    |> validate_required([:name, :description, :image])
  end
end
