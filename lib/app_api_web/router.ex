defmodule AppApiWeb.Router do
  use AppApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :person do
    plug AppApi.Plugs.ValidateToken
  end

  scope "/api", AppApiWeb do
    pipe_through :api
    get "/login", LoginController, :index
    get "/person/info", PersonController, :index
  end

  scope "/api", AppApiWeb do
    pipe_through [:api, :person]
    resources "/capture", CaptureController, only: [:index, :create]
  end
end
