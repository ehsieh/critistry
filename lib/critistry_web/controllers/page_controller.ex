defmodule CritistryWeb.PageController do
  use CritistryWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
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
