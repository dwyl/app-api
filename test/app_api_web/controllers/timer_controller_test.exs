defmodule AppApi.TimerControllerTest do
  use AppApiWeb.ConnCase
  alias AppApi.Timers
  alias AppApi.Captures

  @valid_attrs_capture %{completed: true, id_person: 42, text: "some text", tags: "tag1, tag2"}
  @valid_attrs %{started_at: DateTime.utc_now(), stopped_at: nil}

  def capture_fixture(attrs \\ %{}) do
    attrs
    |> Enum.into(@valid_attrs_capture)
    |> Captures.create_capture()
  end

  def timer_fixture(attrs \\ %{}) do
    capture = capture_fixture()

    timer_attrs =
      attrs
      |> Enum.into(@valid_attrs)

    {:ok, timer} = Timers.create_timer(capture, timer_attrs)
    timer
  end

  describe "test timer endoints" do
    test "create endpoint", %{conn: conn} do
      capture = capture_fixture()
      conn = post(conn, Routes.capture_timer_path(conn, :create, capture.id))
      json_response(conn, 200)

      conn = get(conn, Routes.capture_timer_path(conn, :index, capture.id))
      response_timers = json_response(conn, 200)
      assert Enum.count(response_timers["data"]) == 1
    end

    test "create endpoint with different id person returns 401", %{conn: conn} do
      capture = capture_fixture(%{id_person: 1})
      conn = post(conn, Routes.capture_timer_path(conn, :create, capture.id))
      assert conn.status == 401
    end

    test "update endpoint", %{conn: conn} do
      timer = timer_fixture()

      conn =
        put(
          conn,
          Routes.capture_timer_path(
            conn,
            :update,
            timer.capture.id,
            timer.id
          ),
          %{"capture_id" => timer.capture.id, "timer_id" => timer.id, "action" => "stop"}
        )

      response_update = json_response(conn, 200)
      refute is_nil(response_update["data"]["stopped_at"])
    end

    test "update timer with wrong action", %{conn: conn} do
      timer = timer_fixture()

      conn =
        put(
          conn,
          Routes.capture_timer_path(
            conn,
            :update,
            timer.capture.id,
            timer.id
          ),
          %{"capture_id" => timer.capture.id, "timer_id" => timer.id, "action" => "wrong action"}
        )

      # action not found
      assert conn.status == 404
    end

    test "update with wrong catpure returns 401", %{conn: conn} do
      timer = timer_fixture()
      capture = capture_fixture(%{id_person: 1})

      conn =
        put(
          conn,
          Routes.capture_timer_path(
            conn,
            :update,
            capture.id,
            timer.id
          ),
          %{"capture_id" => timer.capture.id, "timer_id" => timer.id, "action" => "stop"}
        )

      assert conn.status == 401
    end
  end
end
