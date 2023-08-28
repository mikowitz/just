defmodule Just.Diamond do
  @moduledoc """
  Models a just-intonation tonality diamond

  Constructs a just-intonation tonality diamond from a set of given row/column limits.

  ## Examples

  A 5-limit tonality diamond

      iex> diamond = Diamond.new([1,5,3])

  The diamond can then be displayed in the console, with otonalites on the top half of
  the diamond, and utonalities on the bottom:

      iex> IO.puts(diamond)
                      3/2

              5/4             6/5

      1/1             1/1             1/1

              8/5             5/3

                      4/3
      :ok
  """

  alias Just.Ratio

  defstruct [:limits]

  @type t :: %__MODULE__{
          limits: list(pos_integer())
        }

  @doc """
  Returns a `Diamond` struct with the provided limits.
  """
  @spec new(list(pos_integer())) :: t()
  def new(limits) do
    %__MODULE__{limits: limits}
  end

  defimpl String.Chars do
    def to_string(%@for{limits: limits}) do
      Enum.map_join(index_coordinates(length(limits) - 1), "\n\n", fn row ->
        prefix = String.duplicate("\t", length(limits) - length(row))

        prefix <>
          Enum.map_join(row, "\t\t", fn {a, b} ->
            Ratio.new(Enum.at(limits, a), Enum.at(limits, b)) |> Ratio.normalize()
          end)
      end)
    end

    defp index_coordinates(max) do
      top = for i <- max..0, do: Enum.with_index(i..max)

      bottom = for i <- 1..max, do: Enum.with_index(i..max) |> Enum.map(fn {a, b} -> {b, a} end)

      top ++ bottom
    end
  end
end
