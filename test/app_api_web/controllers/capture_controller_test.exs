defmodule AppApi.CaptureControllerTest do
  use AppApiWeb.ConnCase
  alias AppApiWeb.CaptureController

  describe "test captures endpoint" do
    test "index and show and create endpoints", %{conn: conn} do
      conn = post(conn, Routes.capture_path(conn, :create, text: "text capture"))
      create_response = json_response(conn, 200)
      assert create_response["data"]["text"] == "text capture"

      conn = get(conn, Routes.capture_path(conn, :index))
      list_captures = json_response(conn, 200)
      assert Enum.count(list_captures) == 1

      conn = get(conn, Routes.capture_path(conn, :show, create_response["data"]["capture_id"]))
      get_capture_response = json_response(conn, 200)
      assert get_capture_response["data"]["text"] == "text capture"
    end
  end
end
