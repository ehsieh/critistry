defmodule CritistryWeb.AuthController do
    use CritistryWeb, :controller
    alias Critistry.Auth
    plug Ueberauth
    
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
            
        user = Auth.find_or_create_user(Map.from_struct(auth.info))
        
        conn
        |> Critistry.Auth.Guardian.Plug.sign_in(user.email, %{})
        |> redirect(to: CritistryWeb.Router.Helpers.dashboard_path(conn, :index))
    end

  end