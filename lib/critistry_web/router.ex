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
    plug Guardian.Plug.Pipeline, module: Critistry.Auth.Guardian,
      error_handler: Critistry.Auth.ErrorHandler   
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated    
    plug Guardian.Plug.LoadResource
  end

  pipeline :home_auth do   
    plug Guardian.Plug.Pipeline, module: Critistry.Auth.Guardian,
      error_handler: Critistry.Auth.ErrorHandler
    plug Guardian.Plug.VerifySession    
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CritistryWeb do
    pipe_through [:browser, :home_auth]

    get "/", PageController, :index
    get "/sign-out", PageController, :sign_out
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    get "/faq", PageController, :faq
    get "/machina", PageController, :machina
  end

  scope "/dashboard", CritistryWeb do
    pipe_through [:browser, :auth]

    get "/", DashboardController, :index   
    get "/my-profile", DashboardController, :my_profile
    put "/my-profile", DashboardController, :update_my_profile
    get "/my-crit-requests", DashboardController, :my_crit_requests
    get "/my-crit-sessions", DashboardController, :my_crit_sessions

    get "/crit-groups", CritGroupController, :list
    get "/crit-groups/new", CritGroupController, :new
    post "/crit-groups", CritGroupController, :create
    get "/crit-groups/:id", CritGroupController, :show
    

    get "/crit-sessions/:id", CritSessionController, :show
    get "/crit-groups/:id/crit-sessions/new", CritSessionController, :new
    post "/crit-groups/:id/crit-sessions/new", CritSessionController, :create

    get "/crits/:id", CritController, :show
    get "/crit-sessions/:id/crits/new", CritController, :new
    post "/crit-sessions/:id/crits/new", CritController, :create

    get "/users/:id", UserController, :show    
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
