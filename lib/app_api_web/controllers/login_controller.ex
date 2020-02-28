defmodule AppApiWeb.LoginController do
  use AppApiWeb, :controller

  def index(conn, _params) do
    # get oauth urls from auth
    redirect(conn, external: "https://auth-mvp.herokuapp.com/auth/urls")
  end
end
