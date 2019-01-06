defmodule Critistry.Crits.Crit do
  use Ecto.Schema
  import Ecto.Changeset


  schema "crits" do
    field :text, :string    
    field :post_date, :utc_datetime
    belongs_to :user, Critistry.Auth.User
    belongs_to :crit_session, Critistry.Crits.CritSession

    timestamps()
  end

  @doc false
  def changeset(crit, attrs) do
    crit
    |> cast(attrs, [:text, :post_date])
    |> validate_required([:text])
  end
end
