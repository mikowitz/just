defmodule Just.LatticeTest do
  use ExUnit.Case, async: true

  alias Just.{Lattice, Lattice.Dimension, Ratio}

  describe "at" do
    test "with matching index counts" do
      l =
        Lattice.new([
          Dimension.new(Ratio.new(3, 2), :inf),
          Dimension.new(Ratio.new(5, 4), :inf),
          Dimension.new(Ratio.new(7, 4), :inf)
        ])

      assert Lattice.at(l, [1, 1, 1]) == Ratio.new(105, 64)
    end

    test "extra indices are ignored" do
      l =
        Lattice.new([
          Dimension.new(Ratio.new(3, 2), :inf),
          Dimension.new(Ratio.new(5, 4), :inf),
          Dimension.new(Ratio.new(7, 4), :inf)
        ])

      assert Lattice.at(l, [1, 1, 1, 3, 5]) == Ratio.new(105, 64)
    end

    test "extra dimensions are ignored" do
      l =
        Lattice.new([
          Dimension.new(Ratio.new(3, 2), :inf),
          Dimension.new(Ratio.new(5, 4), :inf),
          Dimension.new(Ratio.new(7, 4), :inf)
        ])

      assert Lattice.at(l, [1, 1]) == Ratio.new(15, 8)
    end
  end
end
