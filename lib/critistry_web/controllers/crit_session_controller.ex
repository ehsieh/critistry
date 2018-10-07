defmodule CritistryWeb.CritSessionController do
  use CritistryWeb, :controller   

  def new(conn, _params) do
    render conn, "new.html"
  end

  def show(conn, _params) do
    render conn, "show.html"
  end
end
  