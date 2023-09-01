defmodule Just do
  @moduledoc """
  Library providing ways to work with just intonation (JI) in Elixir.
  """

  @doc """
  Playback the given playable struct
  """
  @spec play(term(), Keyword.t()) :: number() | [number()]
  def play(x, opts \\ [root: 440.0]), do: Just.Play.play(x, opts)
end
