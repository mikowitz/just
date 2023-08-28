defmodule Just.Ratio do
  @moduledoc """
  Models a just intonation interval as a ratio of integers.
  """

  defstruct [:numerator, :denominator]

  @type t :: %__MODULE__{
          numerator: pos_integer(),
          denominator: pos_integer()
        }

  @doc """
  Constructs a new ratio from the given integers

  ## Examples

      iex> Ratio.new(3, 2)
      %Just.Ratio{numerator: 3, denominator: 2}

    Reduces the ratio to its simplest form

      iex> Ratio.new(8, 6)
      %Just.Ratio{numerator: 4, denominator: 3}

  """
  @spec new(pos_integer(), pos_integer()) :: t()
  def new(numerator, denominator) do
    with {n, d} <- reduce(numerator, denominator) do
      %__MODULE__{numerator: n, denominator: d}
    end
  end

  @doc """
  Multiplies one ratio by another

  ## Examples

      iex> r1 = Ratio.new(3, 2)
      iex> r2 = Ratio.new(9, 8)
      iex> Ratio.multiply(r1, r2)
      %Just.Ratio{numerator: 27, denominator: 16}

  """
  @spec multiply(t(), t()) :: t()
  def multiply(%__MODULE__{numerator: n1, denominator: d1}, %__MODULE__{
        numerator: n2,
        denominator: d2
      }) do
    new(n1 * n2, d1 * d2)
  end

  @doc """
  Divides one ratio by another

  ## Examples

      iex> r1 = Ratio.new(3, 2)
      iex> r2 = Ratio.new(9, 8)
      iex> Ratio.divide(r1, r2)
      %Just.Ratio{numerator: 4, denominator: 3}

  """
  @spec divide(t(), t()) :: t()
  def divide(%__MODULE__{numerator: n1, denominator: d1}, %__MODULE__{
        numerator: n2,
        denominator: d2
      }) do
    new(n1 * d2, n2 * d1)
  end

  @doc """
  Returns the octave (2/1) complement of the ratio.

  Given the ratio `r` as an argument, calculates the ratio `c`
  such that `r * c == 2/1`

  ## Examples

      iex> r = Ratio.new(3, 2)
      iex> Ratio.complement(r)
      %Just.Ratio{numerator: 4, denominator: 3}

  """
  @spec complement(t()) :: t()
  def complement(%__MODULE__{} = ratio) do
    new(2, 1)
    |> divide(ratio)
  end

  @doc """
  Returns an octave-equivalent form of the ratio in the range [1, 2).

  ## Examples

      iex> r = Ratio.new(17, 2)
      iex> Ratio.normalize(r)
      %Just.Ratio{numerator: 17, denominator: 16}

      iex> r = Ratio.new(2, 7)
      iex> Ratio.normalize(r)
      %Just.Ratio{numerator: 8, denominator: 7}

  """
  @spec normalize(t()) :: t()
  def normalize(%__MODULE__{numerator: n, denominator: d} = ratio) do
    case n / d do
      f when f < 1 -> normalize(new(n * 2, d))
      f when f >= 2 -> normalize(new(n, d * 2))
      _ -> ratio
    end
  end

  @doc """
  Returns the ratio raised to the given power.

  ## Examples

      iex> r = Ratio.new(3, 2)
      iex> Ratio.pow(r, 2)
      %Just.Ratio{numerator: 9, denominator: 4}

      iex> r = Ratio.new(3, 2)
      iex> Ratio.pow(r, -2)
      %Just.Ratio{numerator: 16, denominator: 9}

  """
  @spec pow(t(), integer()) :: t()
  def pow(%__MODULE__{}, 0), do: new(1, 1)

  def pow(%__MODULE__{} = ratio, power) when power < 0 do
    ratio |> complement() |> pow(-power)
  end

  def pow(%__MODULE__{numerator: n, denominator: d}, power) do
    new(Integer.pow(n, power), Integer.pow(d, power))
  end

  defimpl String.Chars do
    def to_string(%@for{numerator: n, denominator: d}) do
      "#{n}/#{d}"
    end
  end

  defp reduce(a, b) do
    with g <- Integer.gcd(a, b) do
      {round(a / g), round(b / g)}
    end
  end
end
