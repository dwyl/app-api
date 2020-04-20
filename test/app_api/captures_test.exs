defmodule AppApi.CapturesTest do
  use AppApi.DataCase

  alias AppApi.Captures

  describe "captures" do
    alias AppApi.Captures.Capture

    @valid_attrs %{completed: true, id_person: 42, text: "some text", tags: "tag1, tag2"}
    @update_attrs %{completed: false, id_person: 43, text: "some updated text", tags: "" }
    @invalid_attrs %{completed: nil, id_person: nil, text: nil, tags: ""}

    def capture_fixture(attrs \\ %{}) do
        attrs
        |> Enum.into(@valid_attrs)
        |> Captures.create_capture()
    end

    test "list_captures/0 returns all captures" do
      capture = capture_fixture()
      assert Captures.list_captures() == [capture]
    end

    test "get_capture!/1 returns the capture with given id" do
      capture = capture_fixture()
      assert Captures.get_capture!(capture.id) == capture
    end

    test "create_capture/1 with valid data creates a capture" do
      assert %Capture{} = capture = Captures.create_capture(@valid_attrs)
      assert capture.completed == true
      assert capture.id_person == 42
      assert capture.text == "some text"
    end

    test "create_capture/1 with invalid data returns error changeset" do
      assert catch_error(Captures.create_capture(@invalid_attrs))
    end

    test "update_capture/2 with valid data updates the capture" do
      capture = capture_fixture()
      assert %Capture{} = capture = Captures.update_capture(capture, @update_attrs)
      assert capture.completed == false
      assert capture.id_person == 43
      assert capture.text == "some updated text"
    end

    test "update_capture/2 with invalid data returns error changeset" do
      capture = capture_fixture()
      assert catch_error(Captures.update_capture(capture, @invalid_attrs))
      assert capture == Captures.get_capture!(capture.id)
    end

    test "delete_capture/1 deletes the capture" do
      capture = capture_fixture()
      assert {:ok, %Capture{}} = Captures.delete_capture(capture)
      assert_raise Ecto.NoResultsError, fn -> Captures.get_capture!(capture.id) end
    end

    test "change_capture/1 returns a capture changeset" do
      capture = capture_fixture()
      assert %Ecto.Changeset{} = Captures.change_capture(capture)
    end
  end
end
