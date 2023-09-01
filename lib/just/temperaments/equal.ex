defmodule Just.Temperaments.Equal do
  @moduledoc """
  Behaviour for implementing arbitrary octave-divided equal temperament systems.
  """

  @doc """
  The number of equal steps the octave is divided into within this temperament.
  """
  @callback octave_divisions :: integer()

  defmacro __using__(opts) do
    octave_divisions = Keyword.get(opts, :octave_divisions)

    quote do
      defstruct [:steps]

      @type t :: %__MODULE__{
              steps: integer()
            }

      @behaviour Just.Temperaments.Equal

      @impl Just.Temperaments.Equal
      def octave_divisions, do: unquote(octave_divisions)

      def octave_divisor, do: 1200 / unquote(octave_divisions)

      @doc """
      Converts an ET interval to an absolute frequency based on a given root frequency.
      """
      def to_frequency(%__MODULE__{steps: steps}, root) do
        root * :math.pow(:math.pow(2, 1 / octave_divisions()), steps)
      end

      defimpl Just.Play do
        def play(%@for{} = et_interval, opts) do
          root = Keyword.get(opts, :root, 440.0)
          chord_only = Keyword.get(opts, :chord_only, false)

          freq = @for.to_frequency(et_interval, root)

          if !chord_only do
            Rodiex.play(root)
            Rodiex.play(freq)
          end

          Rodiex.play_chord([root, freq])
        end
      end
    end
  end
end
