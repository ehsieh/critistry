defmodule CritistryWeb.LayoutView do
  use CritistryWeb, :view

  def is_logged_in?(conn) do
    conn
    |> Critistry.Auth.Guardian.Plug.authenticated?
  end
  
  def current_user(conn) do
    conn
    |> Critistry.Auth.Guardian.Plug.current_resource
  end  
end
