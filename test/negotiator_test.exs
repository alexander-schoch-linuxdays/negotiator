defmodule NegotiatorTest do
  use ExUnit.Case
  doctest Negotiator

  test "greets the world" do
    assert Negotiator.hello() == :world
  end
end
