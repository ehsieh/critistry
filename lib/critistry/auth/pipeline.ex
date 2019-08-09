defmodule Critistry.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :critistry,
    error_handler: Critistry.Auth.ErrorHandler,
    module: Critistry.Auth.Guardian

  # If there is a session token, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifySession)
  # plug Guardian.Plug.EnsureAuthenticated
  # Load the user if either of the verifications worked
  plug(Guardian.Plug.LoadResource)
end
