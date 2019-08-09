defmodule Critistry.Crits.Crit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "crits" do
    field(:text, :string)
    belongs_to(:user, Critistry.Auth.User)
    belongs_to(:crit_session, Critistry.Crits.CritSession)

    timestamps()
  end

  @doc false
  def changeset(crit, attrs) do
    crit
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
