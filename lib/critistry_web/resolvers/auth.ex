defmodule CritistryWeb.Resolvers.Auth do
  import Ecto.Query, warn: false
  
  alias Critistry.Auth
  alias Critistry.Repo

  def user(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Auth.user"
    {:ok, Auth.get_user!(id)}
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
    {:ok, Auth.list_users()}
  end
end
