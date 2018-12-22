defmodule Critistry.Crits do
  import Ecto.Query, warn: false
  alias Critistry.Repo
  alias Critistry.Crits.CritGroup
  alias Critistry.Crits.CritSession
  alias Critistry.Crits.Crit

  def get_crit_group!(id) do
    crit_group = Repo.get!(CritGroup, id)
    Repo.preload(crit_group, :users);
  end

  def list_crit_groups do
    Repo.all(CritGroup)
  end

  def create_crit_group(attrs \\ %{}, user) do
    attrs = Map.put(attrs, "admin_user_id", Integer.to_string(user.id))    
    {:ok, crit_group} = %CritGroup{}
    |> CritGroup.changeset(attrs)
    |> Repo.insert()
    
    crit_group = Repo.preload(crit_group, :users)

    IO.inspect crit_group
    changeset = Ecto.Changeset.change(crit_group) 
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.update()
  end

  def change_crit_group(%CritGroup{} = crit_group) do
    CritGroup.changeset(crit_group, %{})
  end

  def update_crit_group(%CritGroup{} = crit_group, attrs) do
    crit_group 
    |> CritGroup.changeset(attrs)
    |> Repo.update()
  end
end
