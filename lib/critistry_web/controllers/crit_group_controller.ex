defmodule CritistryWeb.CritGroupController do
  use CritistryWeb, :controller

  alias Critistry.Crits
  alias Critistry.Crits.CritGroup
  alias Critistry.Upload

  def action(conn, _) do
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def list(conn, _params, user) do
    render conn, "list.html"
  end

  def new(conn, _params, user) do
    changeset = Crits.change_crit_group(%CritGroup{})
    category_list = Crits.list_categories
    |> Enum.map(fn x -> {x.name, x.id} end)

    render(conn, "new.html", user: user, changeset: changeset, category_list: category_list)
  end

  defp create_crit_group(conn, user, params) do
    case Crits.create_crit_group(params, user) do
      {:ok, crit_group} ->
        conn
        |> redirect(to: crit_group_path(conn, :show, crit_group))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        render(conn, "new.html", user: user, changeset: changeset)
    end
  end

  def create(conn, %{"crit_group" => %{"image" => crit_group_image} = crit_group_params}, user) do
    IO.inspect crit_group_params
    conn
    |> create_crit_group(user, %{crit_group_params | "image" => Upload.upload_image(crit_group_image)})
  end

  def create(conn, %{"crit_group" => crit_group_params}, user) do
    IO.inspect crit_group_params
    conn
    |> create_crit_group(user, crit_group_params)
  end


  def show(conn, %{"id" => id}, user) do
    crit_group = Crits.get_crit_group!(id)
    IO.inspect crit_group
    render(conn, "show.html", user: user, crit_group: crit_group)
  end
end
