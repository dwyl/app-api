defmodule AppApi.Timers do
  @moduledoc """
  The Timers context.
  """

  import Ecto.Query, warn: false
  alias AppApi.Repo

  alias AppApi.Timers.Timer

  @doc """
  Returns the list of timers.

  ## Examples

      iex> list_timers()
      [%Timer{}, ...]

  """
  def list_timers do
    Repo.all(Timer)
  end

  @doc """
  Gets a single timer.

  Raises `Ecto.NoResultsError` if the Timer does not exist.

  ## Examples

      iex> get_timer!(123)
      %Timer{}

      iex> get_capture!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timer!(id), do: Repo.get!(Timer, id)

  @doc """
  Retuns the list of timers for a capture.
  ## Examples

      iex> get_capture_timers(1)
      [%Timer{}, ...]
  """
  def get_capture_timers(capture_id) do
    query = from c in Timer, where: c.capture_id == ^capture_id
    Repo.all(query)
  end

  def create_timer(capture, attrs \\ %{}) do
    %Timer{}
    |> Timer.changeset(attrs)
    |> put_capture(capture)
    |> Repo.insert()
  end

  def update_timer(%Timer{} = timer, attrs) do
    timer
    |> Timer.changeset(attrs)
    |> Repo.update()
  end

  def stop_timer(id) do
    get_timer!(id)
    |> update_timer(%{stopped_at: NaiveDateTime.utc_now()})
  end

  def put_capture(changeset, capture) do
    Ecto.Changeset.put_assoc(changeset, :capture, capture)
  end
end
