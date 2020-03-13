defmodule AppApi.Captures do
  @moduledoc """
  The Captures context.
  """

  import Ecto.Query, warn: false
  alias AppApi.Repo

  alias AppApi.Captures.Capture
  alias AppApi.Timers.Timer

  @doc """
  Returns the list of captures.

  ## Examples

      iex> list_captures()
      [%Capture{}, ...]

  """
  def list_captures do
    Repo.all(Capture)
  end

  @doc """
  Gets a single capture.

  Raises `Ecto.NoResultsError` if the Capture does not exist.

  ## Examples

      iex> get_capture!(123)
      %Capture{}

      iex> get_capture!(456)
      ** (Ecto.NoResultsError)

  """
  def get_capture!(id), do: Repo.get!(Capture, id)

  def get_capture_by_id_person(id_person) do
    query =
      from c in Capture,
        where: c.id_person == ^id_person,
        order_by: [desc: c.created_at],
        preload: [timers: ^from(t in Timer, order_by: [desc: t.created_at])]

    Repo.all(query)
  end

  @doc """
  Creates a capture.

  ## Examples

      iex> create_capture(%{field: value})
      {:ok, %Capture{}}

      iex> create_capture(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_capture(attrs \\ %{}) do
    %Capture{}
    |> Capture.changeset(attrs)
    |> Repo.insert!()
    |> Repo.preload(timers: from(t in Timer, order_by: [desc: t.created_at]))
  end

  @doc """
  Updates a capture.

  ## Examples

      iex> update_capture(capture, %{field: new_value})
      {:ok, %Capture{}}

      iex> update_capture(capture, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_capture(%Capture{} = capture, attrs) do
    capture
    |> Capture.changeset(attrs)
    |> Repo.update!()
    |> Repo.preload(timers: from(t in Timer, order_by: [desc: t.created_at]))
  end

  @doc """
  Deletes a capture.

  ## Examples

      iex> delete_capture(capture)
      {:ok, %Capture{}}

      iex> delete_capture(capture)
      {:error, %Ecto.Changeset{}}

  """
  def delete_capture(%Capture{} = capture) do
    Repo.delete(capture)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking capture changes.

  ## Examples

      iex> change_capture(capture)
      %Ecto.Changeset{source: %Capture{}}

  """
  def change_capture(%Capture{} = capture) do
    Capture.changeset(capture, %{})
  end
end
