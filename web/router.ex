defmodule Ikki.Router do
  use Ikki.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug BasicAuth,
      realm: "Admin",
      username: Application.get_env(:ikki, :admin)[:username],
      password: Application.get_env(:ikki, :admin)[:password]
  end

  scope "/", Ikki do
    pipe_through :browser # Use the default browser stack

    get "/", SessionController, :new
    post "/session", SessionController, :signin
    delete "/session", SessionController, :signout

    get "/chat", ChatController, :index
  end

  scope "/admin", Ikki do
    pipe_through [:browser, :admin]
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ikki do
  #   pipe_through :api
  # end
end
