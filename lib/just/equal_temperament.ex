defmodule Just.EqualTemperament do
  @moduledoc """
  Models an equal-tempered division of the octave.
  """

  defstruct [:octave_divisions]

  @type t :: %__MODULE__{
          octave_divisions: pos_integer()
        }

  def new(octave_divisions) when is_integer(octave_divisions) and octave_divisions > 0 do
    %__MODULE__{octave_divisions: octave_divisions}
  end

  def octave_divisor(%__MODULE__{octave_divisions: octave_divisions}), do: 1200 / octave_divisions
end
