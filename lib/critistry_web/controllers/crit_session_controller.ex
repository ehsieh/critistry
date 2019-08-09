defmodule CritistryWeb.CritSessionController do
  use CritistryWeb, :controller

  alias Critistry.Crits
  alias Critistry.Crits.CritSession
  alias Critistry.Upload

  def action(conn, _) do
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def new(conn, %{"id" => id}, user) do
    crit_group = Crits.get_crit_group!(id)
    changeset = Crits.change_crit_session(%CritSession{})
    render(conn, "new.html", user: user, changeset: changeset, crit_group: crit_group)
  end

  defp create_crit_session(conn, user, crit_group_id, params) do
    case Crits.create_crit_session(params, user, Crits.get_crit_group!(crit_group_id)) do
      {:ok, crit_session} ->
        conn
        |> redirect(to: crit_session_path(conn, :show, crit_session))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", user: user, changeset: changeset)
    end
  end

  def create(
        conn,
        %{"id" => id, "crit_session" => %{"image" => crit_session_image} = crit_session_params} =
          params,
        user
      ) do
    IO.inspect(params)

    conn
    |> create_crit_session(user, id, %{
      crit_session_params
      | "image" => Upload.upload_image(crit_session_image)
    })
  end

  def create(conn, %{"id" => id, "crit_session" => crit_session_params} = params, user) do
    IO.inspect(params)

    conn
    |> create_crit_session(user, id, crit_session_params)
  end

  def show(conn, %{"id" => id}, user) do
    crit_session = Crits.get_crit_session!(id)
    user_crits = Crits.get_crit_session_user_crits(id)
    render(conn, "show.html", user: user, crit_session: crit_session, user_crits: user_crits)
  end
end
