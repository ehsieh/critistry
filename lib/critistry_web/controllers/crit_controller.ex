defmodule CritistryWeb.CritController do
  use CritistryWeb, :controller

  alias Critistry.Crits
  alias Critistry.Crits.Crit

  def action(conn, _) do
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def new(conn, %{"id" => id}, user) do
    crit_session = Crits.get_crit_session!(id)
    changeset = Crits.change_crit(%Crit{})
    render(conn, "new.html", user: user, changeset: changeset, crit_session: crit_session)
  end

  def create(conn, %{"id" => id, "crit" => crit_params} = params, user) do
    IO.inspect(params)

    case Crits.create_crit(crit_params, user, Crits.get_crit_session!(id)) do
      {:ok, crit} ->
        conn
        |> redirect(to: crit_path(conn, :show, crit))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", user: user, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    crit = Crits.get_crit!(id)
    user_crits = Crits.get_crit_session_user_crits(crit.crit_session.id)
    render(conn, "show.html", user: user, crit: crit, user_crits: user_crits)
  end
end
