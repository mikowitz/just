defprotocol Just.Play do
  @doc """
  Playback the given playable struct
  """
  @spec play(term(), number() | nil) :: number() | [number()]
  def play(x, root \\ 440.0)
end
