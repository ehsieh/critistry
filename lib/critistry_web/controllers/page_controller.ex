defmodule CritistryWeb.PageController do
  use CritistryWeb, :controller
  import Critistry.Factory
  import Ecto.Query

  alias Critistry.Repo
  alias Critistry.Auth
  alias Critistry.Auth.User
  alias Critistry.Crits
  alias Critistry.Crits.CritGroup
  alias Critistry.Crits.Category


  def index(conn, _params) do
    conn = put_session(conn, :message, "new stuff we just set in the session")
    render conn, "index.html"
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

  def machina(conn, _params) do
    insert_list(35, :user, %{})
    insert_list(35, :crit_group, %{})
    insert_list(20, :category, %{})
    users = Auth.list_users
    users
    |> Enum.each(fn(u) -> Crits.set_crit_group_admin(u.id, u) end)
    crit_groups = Crits.list_crit_groups
    crit_groups
    |> Enum.each(fn(c) -> set_random_categories(c.id, Enum.take_random(1..20, 3)) end)
    render conn, "faq.html"
  end

  defp set_random_categories(crit_group_id, category_ids) do
    query = from c in Category, where: c.id in ^(category_ids), preload: [:crit_groups]
    categories = Repo.all(query)
    Crits.set_crit_group_categories(crit_group_id, categories)
  end
end
