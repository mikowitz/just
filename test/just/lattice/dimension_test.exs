defmodule Just.Lattice.DimensionTest do
  use ExUnit.Case, async: true

  alias Just.{Lattice.Dimension, Ratio}

  describe "at" do
    d = Dimension.new(Ratio.new(3, 2))

    assert(Dimension.at(d, 0)) == Ratio.new(1, 1)
    assert(Dimension.at(d, 1)) == Ratio.new(3, 2)
    assert(Dimension.at(d, 2)) == Ratio.new(9, 4)
    assert(Dimension.at(d, -1)) == Ratio.new(4, 3)
  end

  describe "bounded_index" do
    test "with infinite bounds" do
      d = Dimension.new(Ratio.new(3, 2))

      assert Dimension.bounded_index(d, 0) == 0
      assert Dimension.bounded_index(d, 3) == 3
      assert Dimension.bounded_index(d, -7) == -7
      assert Dimension.bounded_index(d, 42) == 42
    end

    test "zero-bounded (positive)" do
      d = Dimension.new(Ratio.new(3, 2), 2)

      assert Dimension.bounded_index(d, 0) == 0
      assert Dimension.bounded_index(d, 3) == 1
      assert Dimension.bounded_index(d, -7) == 1
      assert Dimension.bounded_index(d, 42) == 0
    end

    test "zero-bounded (negative)" do
      d = Dimension.new(Ratio.new(3, 2), -2)

      assert Dimension.bounded_index(d, 0) == 0
      assert Dimension.bounded_index(d, 3) == -1
      assert Dimension.bounded_index(d, -7) == -1
      assert Dimension.bounded_index(d, 42) == 0
    end

    test "range-bounded" do
      d = Dimension.new(Ratio.new(3, 2), {-2, 3})

      assert Dimension.bounded_index(d, 0) == 0
      assert Dimension.bounded_index(d, 3) == 3
      assert Dimension.bounded_index(d, 4) == -2
      assert Dimension.bounded_index(d, -3) == 3
    end
  end
end
