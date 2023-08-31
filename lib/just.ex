defmodule Just do
  @moduledoc """
  Library providing ways to work with just intonation (JI) in Elixir.
  """

  @doc """
  Playback the given playable struct
  """
  @spec play(term(), number() | nil) :: number() | [number()]
  def play(x, root \\ 440.0), do: Just.Play.play(x, root)
end
