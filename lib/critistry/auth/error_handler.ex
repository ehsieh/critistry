defmodule Critistry.Auth.ErrorHandler do
  use CritistryWeb, :controller

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> Phoenix.Controller.redirect(to: "/#login")
  end
end
