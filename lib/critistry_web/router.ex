defmodule CritistryWeb.Router do
  use CritistryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Critistry.Auth.Pipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CritistryWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    get "/faq", PageController, :faq
  end

  scope "/dashboard", CritistryWeb do
    pipe_through [:browser, :auth]

    get "/", DashboardController, :index   
    get "/my-crit-requests", DashboardController, :my_crit_requests   
    get "/my-crit-sessions", DashboardController, :my_crit_sessions      

    get "/crit-groups", CritGroupController, :list
    get "/crit-groups/:id", CritGroupController, :show
    get "/crit-groups/new", CritGroupController, :new

    get "/crit-sessions/:id", CritSessionController, :show
    get "/crit-groups/:id/crit-sessions/new", CritSessionController, :new

    get "/crits/:id", CritController, :show
    get "/crit-sessions/:id/crits/new", CritController, :new

    get "/user/:id", UserController, :show    
  end

  scope "/auth", CritistryWeb do
    pipe_through :browser
  
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
 
  # Other scopes may use custom stacks.
  # scope "/api", CritistryWeb do
  #   pipe_through :api
  # end
end
