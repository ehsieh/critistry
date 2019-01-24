defmodule CritistryWeb.Resolvers.Auth do
  import Ecto.Query, warn: false

  alias Critistry.Repo
  alias Critistry.Auth.User

  def user(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Auth.user"
    {:ok, Repo.get!(User, id)}
  end

  def admin_user(crit_group, _, _) do
    IO.puts "########## Resolvers.Auth.user"
    admin_user =
      crit_group
      |> Ecto.assoc(:admin_user)
      |> Repo.one

    {:ok, admin_user}
  end

  def users(_, _, _) do
    IO.puts "########## Resolvers.Auth.users"
    {:ok, Repo.all(User)}
  end
end
