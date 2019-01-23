defmodule CritistryWeb.Resolvers.Crits do
  import Ecto.Query, warn: false

  alias Critistry.Crits
  alias Critistry.Repo

  def crit_group(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Crits.crit_group"
    {:ok, Crits.get_crit_group! id}
  end

  def crit_groups(_, _, _) do
    IO.puts "########## Resolvers.Crits.crit_groups"
    {:ok, Crits.list_crit_groups()}
  end

  def crit_group_crit_sessions(crit_group, _, _) do
    IO.puts "########## Resolvers.Crits.crit_group_crit_sessions"
    crit_sessions =
      crit_group
      |> Ecto.assoc(:crit_sessions)
      |> Repo.all

    {:ok, crit_sessions}
  end

  def crit_session(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Crits.crit_session"
    {:ok, Crits.get_crit_session! id}
  end

  def crit_sessions(_, _, _) do
    IO.puts "########## Resolvers.Crits.crit_sessions"
    {:ok, Crits.list_crit_sessions()}
  end

  def crit(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Crits.crit"
    {:ok, Crits.get_crit! id}
  end

  def crits(_, _, _) do
    IO.puts "########## esolvers.Crits.crits"
    {:ok, Crits.list_crits()}
  end

end
