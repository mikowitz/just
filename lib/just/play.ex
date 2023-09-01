defprotocol Just.Play do
  @moduledoc """
  Protocol to allow audio playback of frequencies, ratios, and intervals.
  """

  @doc """
  Playback the given playable struct
  """
  @spec play(term(), Keyword.t()) :: number() | [number()]
  def play(x, opts \\ [])
end

defimpl Just.Play, for: Integer do
  def play(int, _opts) do
    Rodiex.play(int)
  end
end

defimpl Just.Play, for: Float do
  def play(float, _opts) do
    Rodiex.play(float)
  end
end
