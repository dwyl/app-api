defmodule AppApi.PersonControllerTest do
  use AppApiWeb.ConnCase
  alias AppApi.Tags

  describe "test person endoints" do
    test "attempt to get person info without a jwt returns an unauthorized error", %{conn: conn} do
      conn = get(conn, Routes.person_path(conn, :index))
      assert conn.status == 401
    end

    test "attempt to get person without a valid jwt", %{conn: conn} do
      conn

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put_req_header("authorization", "Bearer 123")
        |> get(Routes.person_path(conn, :index))

      assert conn.status == 401
    end
  end
end
