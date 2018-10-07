defmodule CritistryWeb.CritGroupController do
  use CritistryWeb, :controller 
  
  def list(conn, _params) do
    render conn, "list.html"
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def show(conn, _params) do
    render conn, "show.html"
  end
end
  