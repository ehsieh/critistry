# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :critistry,
  ecto_repos: [Critistry.Repo]

# Configures the endpoint
config :critistry, CritistryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "F5SNjyKeJ4uQSrlg7LfM310M1nRreCxnzqHzkTp/3SdSy3BmD2dD5fh7XNI/4GMl",
  render_errors: [view: CritistryWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Critistry.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []},
    facebook: {Ueberauth.Strategy.Facebook, []},
    twitter: {Ueberauth.Strategy.Twitter, []}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :critistry, Critistry.Auth.Guardian,
  issuer: "critistry",
  secret_key: "vzyII6cc0fX/7II4v3t+G4XHQ4lFq30hIYELyoHN/jUQRXK21cOpZKdygJnSNlwj"

config :ex_aws, 
access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),          
secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
s3: [ 
 scheme: "https://", 
 host: "critistry-uploads.s3.amazonaws.com", 
 region: "us-west-1" 
]
