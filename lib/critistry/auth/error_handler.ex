defmodule Critistry.Auth.ErrorHandler do
  use CritistryWeb, :controller
  import Plug.Conn
  
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> Phoenix.Controller.redirect(to: "/#login")
  end
end