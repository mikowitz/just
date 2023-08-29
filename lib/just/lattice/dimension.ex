defmodule Just.Lattice.Dimension do
  @moduledoc """
  Models a single dimension of a `Just.Lattice`

  A Lattice dimension consists of a `Just.Ratio` that defines the possible intervals
  along the dimension, and a bounding rule that defines how far in each direction
  the dimension extends.

  ## Bounding rules

  Bounding rules can take one of three forms:

  * `:inf` (default) - infinite bounds, the dimension extends infinitely in both directions
  * length-bounded - defined by a single integer `i`, a dimension bound in this way extends
    through the range `[0, i)`. `i` can be positive or negative
  * range-bounded - defined by a tuple of integers `{a, b}`, a dimension bound in this way
    extends through the range `[a, b]`.

  For length- and range-bounded dimensions, indices outside of the range wrap around to the
  other end.

  ### Examples

  Given a length-bounded dimension

      Just.Lattice.Dimension.new(Ratio.new(3, 2), 3)

  indexing into the dimension at `2` would return the third element in the dimension, but
  indexing at `3` would return the 0-th element.

  Given a range-bounded dimension

      Just.Lattice.Dimension.new(Ratio.new(3, 2), {-2, 3})

  indexing into the dimension at `3` would return the element at index 3, but indexing at `4`
  would return the element at index `-2`.
  """

  alias Just.Ratio

  defstruct [:ratio, :bounds]

  @typedoc """
  Defines the bounding rule for a `Just.Lattice.Dimension`.

  See `Just.Lattice.Dimension` module docs for an explanation of the possible rules.
  """
  @type bounding_rule :: :inf | integer() | {integer(), integer()}
  @type t :: %__MODULE__{
          ratio: Ratio.t(),
          bounds: bounding_rule()
        }

  @doc """
  Constructs a new `Just.Lattice.Dimension` from a given `Just.Ratio` and a `t:bounding_rule/0`
  """
  @spec new(Ratio.t(), bounding_rule()) :: t()
  def new(%Ratio{} = ratio, bounds \\ :inf) do
    %__MODULE__{ratio: ratio, bounds: bounds}
  end

  @doc """
  Finds the ratio in the dimension at the given index, according to the dimension's bounding rules.
  """
  @spec at(t(), integer()) :: Ratio.t()
  def at(%__MODULE__{ratio: ratio} = dimension, index) do
    with exp <- bounded_index(dimension, index) do
      Ratio.pow(ratio, exp)
    end
  end

  @doc false
  def bounded_index(%__MODULE__{bounds: :inf}, index), do: index

  def bounded_index(%__MODULE__{bounds: b}, index) when is_integer(b) do
    mod(index, b)
  end

  def bounded_index(%__MODULE__{bounds: {a, b}}, index) do
    modulo = b - a + 1
    abs_a = abs(a)

    mod(index + abs_a, modulo) - abs_a
  end

  defp mod(a, b), do: rem(rem(a, b) + b, b)
end
