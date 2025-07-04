defmodule MySubscriptionAppSqliteWeb.Router do
  use MySubscriptionAppSqliteWeb, :router

  pipeline :graphql do
    plug AshGraphql.Plug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MySubscriptionAppSqliteWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/gql" do
    pipe_through [:graphql]

    forward "/playground", Absinthe.Plug.GraphiQL,
      schema: Module.concat(["MySubscriptionAppSqliteWeb.GraphqlSchema"]),
      socket: Module.concat(["MySubscriptionAppSqliteWeb.GraphqlSocket"]),
      interface: :playground

    forward "/", Absinthe.Plug,
      schema: Module.concat(["MySubscriptionAppSqliteWeb.GraphqlSchema"])
  end

  scope "/", MySubscriptionAppSqliteWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", MySubscriptionAppSqliteWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:my_subscription_app_sqlite, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MySubscriptionAppSqliteWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
