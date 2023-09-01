defmodule Just.RatioTest do
  use ExUnit.Case, async: true

  alias Just.{Temperaments.Equal.Twelve, Ratio}
  doctest Ratio

  describe "multiply" do
    test "multiplication is associative" do
      r1 = Ratio.new(3, 2)
      r2 = Ratio.new(4, 3)
      r3 = Ratio.new(10, 9)

      assert Ratio.multiply(r1, Ratio.multiply(r2, r3)) ==
               Ratio.multiply(Ratio.multiply(r1, r2), r3)
    end

    test "multiplication is commutative" do
      r1 = Ratio.new(3, 2)
      r2 = Ratio.new(4, 3)

      assert Ratio.multiply(r1, r2) == Ratio.multiply(r2, r1)
    end
  end

  describe "divide" do
    test "division is not associative" do
      r1 = Ratio.new(3, 2)
      r2 = Ratio.new(4, 3)
      r3 = Ratio.new(10, 9)

      refute Ratio.divide(r1, Ratio.divide(r2, r3)) ==
               Ratio.divide(Ratio.divide(r1, r2), r3)
    end

    test "division is not commutative" do
      r1 = Ratio.new(3, 2)
      r2 = Ratio.new(4, 3)

      assert Ratio.divide(r1, r2) == Ratio.new(9, 8)
      assert Ratio.divide(r2, r1) == Ratio.new(8, 9)
    end
  end

  describe "pow" do
    test "raising a ratio to the 0th power always returns 1/1" do
      for n <- 1..27, d <- 1..27 do
        assert Ratio.pow(Ratio.new(n, d), 0) == Ratio.new(1, 1)
      end
    end

    test "raising a ratio to the 1st power always returns itself" do
      for n <- 1..27, d <- 1..27 do
        r = Ratio.new(n, d)
        assert Ratio.pow(r, 1) == r
      end
    end
  end

  describe "to_approximate_equal_tempered_interval" do
    test "returns the equal tempered interval + the cents offset" do
      r = Ratio.new(3, 2)

      {et_interval, cents_offset} = Ratio.to_approximate_equal_tempered_interval(r, Twelve)

      assert et_interval == Twelve.perfect_fifth()
      assert_in_delta cents_offset, 1.95, 0.01
    end
  end
end
