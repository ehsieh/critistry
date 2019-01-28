defmodule CritistryWeb.PageController do
  use CritistryWeb, :controller
  import Critistry.Factory
  import Ecto.Query

  alias Critistry.Repo
  alias Critistry.Auth
  alias Critistry.Crits
  alias Critistry.Crits.CritSession
  alias Critistry.Crits.Category


  def index(conn, _params) do
    conn = put_session(conn, :message, "new stuff we just set in the session")
    render conn, "index.html", stats: %{user_count: Auth.get_user_count, crit_group_count: Crits.get_crit_group_count, crit_session_count: Crits.get_crit_session_count, crit_count: Crits.get_crit_count}
  end

  def sign_out(conn, _params) do
    conn
      |> Critistry.Auth.Guardian.Plug.sign_out
      |> redirect(to: "/")
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end

  def faq(conn, _params) do
    render conn, "faq.html"
  end

  def machina(conn, %{"num_users" => a, "num_categories" => b, "crit_session_factor" => c, "crit_factor" => d}) do    
    num_users = String.to_integer(a)
    num_categories = String.to_integer(b)
    crit_session_factor = String.to_integer(c)
    crit_factor = String.to_integer(d)
    insert_list(num_users, :user, %{})
    insert_list(num_users, :crit_group, %{})
    insert_list(num_categories, :category, %{})   
    insert_list(num_users * crit_session_factor, :crit_session, %{})
    insert_list(num_users * crit_factor, :crit, %{})
   
    Crits.list_crit_groups
    |> Enum.each(fn(c) -> setup_crit_group(c.id) end)

    setup_crit_sessions(crit_session_factor)
    setup_crits(crit_factor)

    render conn, "faq.html"
  end

  defp setup_crit_group(crit_group_id) do
    category_ids = Enum.take_random(1..30, Enum.random(1..5))
    query = from c in Category, where: c.id in ^(category_ids), preload: [:crit_groups]
    categories = Repo.all(query)
    Crits.set_crit_group_categories(crit_group_id, categories)
    Crits.set_crit_group_admin(crit_group_id, Auth.get_user!(crit_group_id))
  end

  defp setup_crit_sessions(crit_session_factor) do
    Auth.list_users
    |> Enum.each(fn(u) -> setup_user_crit_sessions(u, Enum.take_random(1..100, Enum.random(1..6)), crit_session_factor) end)
  end

  defp setup_user_crit_sessions(user, crit_group_ids, crit_session_factor) do       
    crit_group_ids
    |> Enum.each(fn(id) -> Crits.join_crit_group(Crits.get_crit_group!(id), user) end)

    max_id = user.id * crit_session_factor
    max_id - (crit_session_factor - 1)..max_id
    |> Enum.each(fn(id) -> Crits.setup_crit_session(id, user, Enum.random(crit_group_ids)) end)
  end

  defp setup_crits(crit_factor) do
    Auth.list_users
    |> Enum.each(fn(u) -> setup_crit(u.id, crit_factor) end)
  end

  defp setup_crit(user_id, crit_factor) do   
    IO.inspect user_id     
    query = from c in "users_crit_groups", 
    join: cs in CritSession, on: cs.crit_group_id == c.crit_group_id, 
    where: c.user_id == ^user_id and cs.user_id != ^user_id, 
    select: cs.id

    crit_sessions = Repo.all(query)
    IO.inspect crit_sessions

    #def setup_crit(crit_id, user, crit_session_id) do

    max_id = user_id * crit_factor
    max_id - (crit_factor - 1)..max_id
    |> Enum.each(fn(id) -> Crits.setup_crit(id, Auth.get_user!(user_id), Enum.random(crit_sessions)) end)
  end
end
