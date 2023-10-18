defmodule WebGamesWeb.Router do
  use WebGamesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WebGamesWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebGamesWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/test", Test
    get "/select-game", SelectGameController, :select_game
    post "/new-game/minesweeper", NewGameController, :start_minesweeper
    post "/new-game/lightcycles", NewGameController, :start_lightcycles
    get "/play/:game_id", PlayController, :connect_to_game
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebGamesWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:web_games, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WebGamesWeb.Telemetry
    end
  end
end
