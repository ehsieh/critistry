defmodule CritistryWeb.AuthController do
    use CritistryWeb, :controller
    plug Ueberauth
    
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
        IO.inspect auth

        {:ok, jwt, _full_claims} =
            Critistry.Auth.Guardian.encode_and_sign(auth.info.email, %{})
            
        text conn, to_string(jwt)
    end

  end