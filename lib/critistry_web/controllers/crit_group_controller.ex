defmodule CritistryWeb.CritGroupController do
  use CritistryWeb, :controller

  alias Critistry.Crits
  alias Critistry.Crits.CritGroup
  alias Critistry.Upload

  def action(conn, _) do
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def list(conn, params, user) do
    page = Crits.list_crit_groups(params)
    categories = Crits.get_category_counts()
    render(conn, "list.html", crit_groups: page.entries, categories: categories, page: page)
  end

  def list_by_category(conn, %{"id" => id} = params, user) do
    page = Crits.list_crit_groups_by_category(String.to_integer(id), params)
    categories = Crits.get_category_counts()
    IO.inspect(page)

    render(conn, "list_by_category.html",
      crit_groups: page.entries,
      categories: categories,
      page: page,
      category_id: id
    )
  end

  def new(conn, _params, user) do
    changeset = Crits.change_crit_group(%CritGroup{})

    category_list =
      Crits.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    render(conn, "new.html", user: user, changeset: changeset, category_list: category_list)
  end

  defp create_crit_group(conn, user, params) do
    case Crits.create_crit_group(params, user) do
      {:ok, crit_group} ->
        conn
        |> redirect(to: crit_group_path(conn, :show, crit_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", user: user, changeset: changeset)
    end
  end

  def create(conn, %{"crit_group" => %{"image" => crit_group_image} = crit_group_params}, user) do
    IO.inspect(crit_group_params)

    conn
    |> create_crit_group(user, %{
      crit_group_params
      | "image" => Upload.upload_image(crit_group_image)
    })
  end

  def create(conn, %{"crit_group" => crit_group_params}, user) do
    IO.inspect(crit_group_params)

    conn
    |> create_crit_group(user, crit_group_params)
  end

  def join(conn, %{"id" => id}, user) do
    crit_group = Crits.get_crit_group!(id)
    Crits.join_crit_group(crit_group, user)
    conn |> redirect(to: crit_group_path(conn, :show, crit_group))
  end

  def show(conn, %{"id" => id}, user) do
    crit_group = Crits.get_crit_group!(id)
    crit_sessions = Crits.get_crit_sessions(id)
    render(conn, "show.html", user: user, crit_group: crit_group, crit_sessions: crit_sessions)
  end
end
