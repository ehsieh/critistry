defmodule Critistry.Crits.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "categories" do
    field :name, :string
    many_to_many :crit_groups, Critistry.Crits.CritGroup, join_through: "crit_groups_categories"
    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
