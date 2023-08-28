defmodule JustTest do
  use ExUnit.Case
  doctest Just

  test "greets the world" do
    assert Just.hello() == :world
  end
end
