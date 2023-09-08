defmodule Just.EqualTemperament.IntervalTest do
  use ExUnit.Case, async: true

  alias Just.{EqualTemperament, EqualTemperament.Interval}

  describe "to_frequency" do
    test "returns the correct frequency of the ET interval given a base frequency" do
      twelve_et = EqualTemperament.new(12)
      octave = Interval.new(twelve_et, 12)
      perfect_fifth = Interval.new(twelve_et, 7)

      assert Interval.to_frequency(octave, 100) == 200
      assert Interval.to_frequency(perfect_fifth, 100) == 149.8307
    end

    test "can handle non-12ET systems" do
      thirty_one_et = EqualTemperament.new(31)
      octave = Interval.new(thirty_one_et, 31)
      perfect_fifth = Interval.new(thirty_one_et, 18)

      assert Interval.to_frequency(octave, 100) == 200
      assert Interval.to_frequency(perfect_fifth, 100) == 149.5518
    end
  end
end
