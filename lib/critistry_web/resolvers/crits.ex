defmodule CritistryWeb.Resolvers.Crits do
  import Ecto.Query, warn: false

  alias Critistry.Crits.{CritGroup, CritSession, Crit}
  alias Critistry.Repo

  def crit_group(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Crits.crit_group"
    {:ok, Repo.get!(CritGroup, id)}
  end

  def crit_groups(_, _, _) do
    IO.puts "########## Resolvers.Crits.crit_groups"
    {:ok, Repo.all(CritGroup)}
  end  

  def crit_session(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Crits.crit_session"
    {:ok, Repo.get!(CritSession, id)}
  end

  def crit_sessions(_, _, _) do
    IO.puts "########## Resolvers.Crits.crit_sessions"
    {:ok, Repo.all(CritSession)}
  end

  def crit(_, %{id: id}, _) do
    IO.puts "########## Resolvers.Crits.crit"
    {:ok, Repo.get!(Crit, id)}
  end

  def crits(_, _, _) do
    IO.puts "########## esolvers.Crits.crits"
    {:ok, Repo.all(Crit)}
  end

end
