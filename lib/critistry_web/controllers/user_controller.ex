defmodule CritistryWeb.UserController do
  use CritistryWeb, :controller

  def action(conn, _) do
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def show(conn, _params, user) do
    render(conn, "show.html")
  end
end
