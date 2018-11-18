defmodule Critistry.Crits.Crit do
  use Ecto.Schema
  import Ecto.Changeset


  schema "crits" do
    field :annotations_json, :string
    field :is_active, :boolean, default: false
    field :post_date, :utc_datetime
    belongs_to :user, Critistry.Auth.User
    belongs_to :crit_session, Critistry.Crits.CritSession

    timestamps()
  end

  @doc false
  def changeset(crit, attrs) do
    crit
    |> cast(attrs, [:annotations_json, :is_active, :post_date])
    |> validate_required([:annotations_json, :is_active, :post_date])
  end
end
