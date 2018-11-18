defmodule CritistryWeb.DashboardController do
  use CritistryWeb, :controller
  import Critistry.Factory

  alias Critistry.Auth
  alias Critistry.Auth.User

  def action(conn, _) do  
    args = [conn, conn.params, Critistry.Auth.Guardian.Plug.current_resource(conn)]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, user) do
    #insert_list(100, :crit_session)
    IO.puts "Dashboard index"    
    IO.inspect user
    render(conn, "index.html", user: user)
  end    

  def my_profile(conn, _params, user) do
    changeset = Auth.change_user(user)
    render(conn, "my_profile.html", user: user, changeset: changeset)    
  end

  def update_my_profile(conn, %{"user" => user_params} = params, user) do
    IO.inspect user_params

    file_uuid = UUID.uuid4(:hex)        
    image_filename = user_params["image"].filename
    unique_filename = "#{file_uuid}-#{image_filename}"
    {:ok, image_binary} = File.read(user_params["image"].path)           
    bucket_name = System.get_env("BUCKET_NAME")

    result = 
      ExAws.S3.put_object(bucket_name, unique_filename, image_binary)          
      |> ExAws.request!

    IO.inspect result

    updated_params = %{user_params | "image" => "https://s3-us-west-1.amazonaws.com/#{bucket_name}/#{bucket_name}/#{unique_filename}"}      
    IO.inspect updated_params
    case Auth.update_user(user, updated_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> redirect(to: dashboard_path(conn, :my_profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
    end
  end

end