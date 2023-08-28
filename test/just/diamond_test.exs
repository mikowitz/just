defmodule Just.DiamondTest do
  use ExUnit.Case, async: true

  alias Just.Diamond

  describe "new" do
    test "constructs a Diamond struct with the given limits" do
      assert Diamond.new([1, 5, 3]) == %Diamond{
               limits: [1, 5, 3]
             }
    end
  end

  describe "String.Chars" do
    test "returns a console-friendly representation of the diamond" do
      d = Diamond.new([1, 5, 3])

      assert to_string(d) ==
               "\t\t3/2\n\n\t5/4\t\t6/5\n\n1/1\t\t1/1\t\t1/1\n\n\t8/5\t\t5/3\n\n\t\t4/3"
    end
  end
end
