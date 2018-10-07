defmodule CritistryWeb.DashboardController do
use CritistryWeb, :controller
import Critistry.Factory

  def index(conn, _params) do
    user = insert_list(100, :user)

    render conn, "index.html"
  end    
end