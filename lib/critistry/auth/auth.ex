defmodule Critistry.Auth do
  import Ecto.Query, warn: false
  alias Critistry.Repo
  alias Critistry.Auth.User

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  def get_user!(id) do
    user = Repo.get!(User, id)

    user
    |> Repo.preload(:crit_groups)
  end

  def list_users() do
    Repo.all(User)
  end

  def find_or_create_user(info) do
    user = find_user_by_email(info.email)

    user =
      if user == nil do
        {:ok, new_user} = create_user(info)
        new_user
      else
        user
      end

    user
  end

  def find_user_by_email(email) do
    user = Repo.get_by(User, email: email)

    user
    |> Repo.preload(:crit_groups)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def get_user_count do
    Repo.one(from(u in User, select: count(u.id)))
  end
end
