defmodule CritistryWeb.PageController do
  use CritistryWeb, :controller

  def index(conn, _params) do
    conn = put_session(conn, :message, "new stuff we just set in the session")    
    render conn, "index.html"
  end

  def sign_out(conn, _params) do
    conn
      |> Critistry.Auth.Guardian.Plug.sign_out
      |> redirect(to: "/")    
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end

  def faq(conn, _params) do
    render conn, "faq.html"
  end
end
