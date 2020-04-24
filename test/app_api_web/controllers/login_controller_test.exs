defmodule AppApi.LoginControllerTest do
  use AppApiWeb.ConnCase

  describe "test login controller" do
    test "index page redirects to auth service", %{conn: conn} do
      conn = get(conn, Routes.login_path(conn, :index))
      assert conn.status == 302
    end
  end
end
