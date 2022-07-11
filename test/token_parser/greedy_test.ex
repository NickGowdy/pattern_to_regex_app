defmodule TokenParser.GreedyTest do
  use ExUnit.Case, async: true

  test "Can verify greedy token" do
    assert = TokenParser.Simple.parse([], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["{", "1", "}"], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["1", "}"], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["}"], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "0", "G", "}"], 0) == :true
  end
end
