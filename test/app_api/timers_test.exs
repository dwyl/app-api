defmodule AppApi.TimersTest do
  use AppApi.DataCase

  alias AppApi.Timers
  alias AppApi.Captures
  describe "tags" do
    @valid_attrs_capture %{completed: true, id_person: 42, text: "some text", tags: "tag1, tag2"}
    @valid_attrs %{started_at: DateTime.utc_now(), stopped_at: nil}

    def capture_fixture(attrs \\ %{}) do
        attrs
        |> Enum.into(@valid_attrs_capture)
        |> Captures.create_capture()
    end

    def timer_fixture(attrs \\ %{}) do
      capture = capture_fixture()

      timer_attrs = attrs
      |> Enum.into(@valid_attrs)

      {:ok, timer} = Timers.create_timer(capture, timer_attrs)
      timer
    end

    test "stop timer" do
      timer = timer_fixture()
      assert is_nil(timer.stopped_at)
      timer_updated = Timers.stop_timer(timer.id)
      assert is_nil(timer_updated.stopped_at) == false
    end

    test "get capture' timers" do
      capture = capture_fixture()
      assert Timers.get_capture_timers(capture.id) == []
      {:ok, timer} = Timers.create_timer(capture, @valid_attrs)
      assert Enum.count(Timers.get_capture_timers(capture.id)) == 1
    end
  end
end
