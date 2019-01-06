defmodule CritistryWeb.DashboardController do
  use CritistryWeb, :controller  

  alias Critistry.Auth
  alias Critistry.Upload

  def action(conn, _) do  
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, user) do
    #insert_list(100, :crit_session)    
    IO.inspect user
    render(conn, "index.html", user: user)
  end    

  def my_profile(conn, _params, user) do
    changeset = Auth.change_user(user)
    render(conn, "my_profile.html", user: user, changeset: changeset)    
  end

  defp update_user(conn, user, params) do
    case Auth.update_user(user, params) do
      {:ok, _user} ->
        conn        
        |> redirect(to: dashboard_path(conn, :my_profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        render(conn, "my_profile.html", user: user, changeset: changeset) 
    end
  end

  def update_my_profile(conn, %{"user" => %{"image" => user_image} = user_params}, user) do            
    conn
    |> update_user(user, %{user_params | "image" => Upload.upload_image(user_image)})
  end

  def update_my_profile(conn, %{"user" => user_params}, user) do    
    conn
    |> update_user(user, user_params)
  end

end