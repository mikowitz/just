defmodule Just.Lattice do
  @moduledoc """
  Models an n-dimensional just intonation lattice.

  A lattice can be constructed from a list of `Just.Lattice.Dimension` structs

      iex> lattice = Lattice.new([
      ...>   Dimension.new(Ratio.new(3, 2)),
      ...>   Dimension.new(Ratio.new(5, 4)),
      ...>   Dimension.new(Ratio.new(7, 4))
      ...> ])

  and queried to find the ratio at any point in the lattice:

      iex> Lattice.at(lattice, [1,1,1])
      %Just.Ratio{numerator: 105, denominator: 32}


  Due to the potentially multi-dimensional and unbounded nature of lattices, there
  is currently no way to display them in their entirety.
  """

  alias Just.{Lattice.Dimension, Ratio}

  defstruct [:dimensions]

  @type t :: %__MODULE__{
          dimensions: [Dimension.t()]
        }

  @doc """
  Creates a new `Lattice` from a list of `Just.Lattice.Dimension` structs
  """
  @spec new([Dimension.t()]) :: t()
  def new(dimensions) do
    %__MODULE__{dimensions: dimensions}
  end

  @doc """
  Queries into a `Lattice` at the given indices.

  If more indices are given than the lattice has dimensions, the extra
  indices are ignored. Likewise if fewer indices are given, the higher
  dimensions of the lattice are ignored in calculating the resulting ratio.
  """
  @spec at(t(), [integer()]) :: Ratio.t()
  def at(%__MODULE__{dimensions: dimensions}, indices) do
    Enum.zip(dimensions, indices)
    |> Enum.map(fn {dim, index} -> Dimension.at(dim, index) end)
    |> Enum.reduce(Ratio.new(1, 1), &Ratio.multiply/2)
  end
end
