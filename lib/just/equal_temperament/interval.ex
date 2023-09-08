defmodule Just.EqualTemperament.Interval do
  @moduledoc """
  Models an interval in a given equal temperament.
  """

  alias Just.EqualTemperament

  defstruct [:temperament, :steps]

  @type t :: %__MODULE__{
          temperament: EqualTemperament.t(),
          steps: non_neg_integer()
        }

  def new(%EqualTemperament{} = temperament, steps) do
    %__MODULE__{temperament: temperament, steps: steps}
  end

  def to_frequency(%__MODULE__{temperament: temperament, steps: steps}, root) do
    %EqualTemperament{octave_divisions: divisions} = temperament
    Float.round(root * :math.pow(:math.pow(2, 1 / divisions), steps), 4)
  end
end
