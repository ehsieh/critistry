defmodule CritistryWeb.PageController do
  use CritistryWeb, :controller
  import Critistry.Factory
  import Ecto.Query

  alias Critistry.Repo
  alias Critistry.Auth
  alias Critistry.Crits
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
   
    crit_groups = Crits.list_crit_groups
    crit_groups
    |> Enum.each(fn(c) -> setup_crit_group(c.id) end)
    render conn, "faq.html"
  end

  defp setup_crit_group(crit_group_id) do
    category_ids = Enum.take_random(1..20, 3)
    query = from c in Category, where: c.id in ^(category_ids), preload: [:crit_groups]
    categories = Repo.all(query)
    Crits.set_crit_group_categories(crit_group_id, categories)
    Crits.set_crit_group_admin(crit_group_id, Auth.get_user!(crit_group_id))
  end
end
