defmodule Just.Temperaments.Equal.Twelve do
  @moduledoc """
  Models an interval in 12-note equal temperament
  """

  use Just.Temperaments.Equal, octave_divisions: 12

  defimpl String.Chars do
    def to_string(%@for{steps: steps}), do: steps_to_name(steps)

    defp steps_to_name(0), do: "Perfect Unison"
    defp steps_to_name(1), do: "Minor Second"
    defp steps_to_name(2), do: "Major Second"
    defp steps_to_name(3), do: "Minor Third"
    defp steps_to_name(4), do: "Major Third"
    defp steps_to_name(5), do: "Perfect Fourth"
    defp steps_to_name(6), do: "Augmented Fourth"
    defp steps_to_name(7), do: "Perfect Fifth"
    defp steps_to_name(8), do: "Minor Sixth"
    defp steps_to_name(9), do: "Major Sixth"
    defp steps_to_name(10), do: "Minor Seventh"
    defp steps_to_name(11), do: "Major Seventh"
  end

  named_intervals =
    ~w(unison minor_second major_second minor_third major_third perfect_fourth augmented_fourth perfect_fifth minor_sixth major_sixth minor_seventh major_seventh)a
    |> Enum.with_index()

  for {name, steps} <- named_intervals do
    article = if steps == 6, do: "an", else: "a"

    @doc """
    Helper function for generating #{article} #{String.replace(to_string(name), "_", " ")}
    """
    def unquote(name)(), do: %__MODULE__{steps: unquote(steps)}
  end
end
