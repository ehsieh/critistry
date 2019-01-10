defmodule Critistry.Crits do
  import Ecto.Query, warn: false
  alias Critistry.Repo
  alias Critistry.Crits.CritGroup
  alias Critistry.Crits.CritSession
  alias Critistry.Crits.Crit
  alias Critistry.Crits.Category

  ## Crit Group

  def get_crit_group!(id) do
    crit_group = Repo.get!(CritGroup, id)

    crit_group
    |> Repo.preload(:admin_user)
    |> Repo.preload(:users)
    |> Repo.preload(:categories)
  end

  def list_crit_groups do
    Repo.all(CritGroup)
  end

  def join_crit_group(crit_group, user) do
    Ecto.Changeset.change(crit_group)    
    |> Ecto.Changeset.put_assoc(:users, [user | crit_group.users])    
    |> Repo.update()
  end

  def create_crit_group(attrs \\ %{}, user) do
    {:ok, crit_group} = %CritGroup{}
    |> CritGroup.changeset(attrs)
    |> Repo.insert()

    %{"cat" => categories} = attrs
    query = from c in Category, where: c.id in ^(categories), preload: [:crit_groups]
    categories = Repo.all(query)
    IO.inspect categories

    crit_group = crit_group
    |> Repo.preload(:admin_user)
    |> Repo.preload(:users)
    |> Repo.preload(:categories)

    Ecto.Changeset.change(crit_group)
    |> Ecto.Changeset.put_assoc(:admin_user, user)
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Ecto.Changeset.put_assoc(:categories, categories)
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

  def set_crit_group_admin(crit_group_id, user) do
    crit_group = get_crit_group!(crit_group_id)    
    Ecto.Changeset.change(crit_group)
    |> Ecto.Changeset.put_assoc(:admin_user, user)
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.update()
  end

  def set_crit_group_categories(crit_group_id, categories) do
    crit_group = get_crit_group!(crit_group_id)
    Ecto.Changeset.change(crit_group)
    |> Ecto.Changeset.put_assoc(:categories, categories)
    |> Repo.update()
  end

  def list_crit_groups_by_category(category_id) do
    query = from c in "crit_groups_categories", 
    join: cg in CritGroup, 
    on: cg.id == c.crit_group_id,     
    where: c.category_id == ^category_id,
    select: {cg.id, cg.image, cg.name, cg.description},
    order_by: cg.name
    Repo.all(query)
  end

  def crit_group_member?(crit_group, user) do
    Enum.filter(crit_group.users, fn x -> x.id == user.id end) != []
  end

  ## Crit Session

  def get_crit_session!(id) do
    Repo.get!(CritSession, id)
  end

  def create_crit_session(attrs \\ %{}, user, crit_group) do
    {:ok, crit_session} = %CritSession{}
    |> CritSession.changeset(attrs)
    |> Repo.insert()

    crit_session = crit_session
    |> Repo.preload(:user)
    |> Repo.preload(:crit_group)

    Ecto.Changeset.change(crit_session)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:crit_group, crit_group)
    |> Repo.update()
  end

  def change_crit_session(%CritSession{} = crit_session) do
    CritSession.changeset(crit_session, %{})
  end

  def update_crit_session(%CritSession{} = crit_session, attrs) do
    crit_session
    |> CritSession.changeset(attrs)
    |> Repo.update()
  end  

  ## Crit

  def get_crit!(id) do
    Repo.get!(Crit, id)
  end

  def create_crit(attrs \\ %{}, user, crit_session) do
    {:ok, crit} = %Crit{}
    |> Crit.changeset(attrs)
    |> Repo.insert()

    crit = crit
    |> Repo.preload(:user)
    |> Repo.preload(:crit_session)

    Ecto.Changeset.change(crit)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:crit_session, crit_session)
    |> Repo.update()
  end

  def change_crit(%Crit{} = crit) do
    Crit.changeset(crit, %{})
  end

  def update_crit(%Crit{} = crit, attrs) do
    crit
    |> Crit.changeset(attrs)
    |> Repo.update()
  end

  ## Categories

  def list_categories do
    Repo.all(Category)
  end

  def get_category!(id) do
    category = Repo.get!(Category, id)

    category
    |> Repo.preload(:users)
  end

  def get_category_counts do
    query = from c in "crit_groups_categories", 
    join: cat in Category, 
    on: cat.id == c.category_id, 
    group_by: [cat.name, cat.id],
    select: {cat.name, cat.id, count(cat.name)},
    order_by: cat.name
    Repo.all(query)
  end

end
