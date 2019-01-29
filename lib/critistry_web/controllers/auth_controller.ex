defmodule CritistryWeb.AuthController do
    use CritistryWeb, :controller
    alias Critistry.Auth
    plug Ueberauth
    
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
      
      info = Map.from_struct(auth.info)
      |> Map.put_new(:avatar, auth.info.image)
      #|> Map.put_new(:user_name, auth.info.first_name <> " " <> auth.info.last_name)

      user = Auth.find_or_create_user(info)
      
      conn
      |> Critistry.Auth.Guardian.Plug.sign_in(user.email, %{})
      |> redirect(to: CritistryWeb.Router.Helpers.dashboard_path(conn, :index))
    end

  end