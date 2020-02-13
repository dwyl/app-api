defmodule AppApiWeb.Router do
  use AppApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppApiWeb do
    pipe_through :api
    get "login", LoginController, :index
  end
end
