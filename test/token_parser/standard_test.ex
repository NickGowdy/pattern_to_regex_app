defmodule TokenParser.StandardTest do
  use ExUnit.Case, async: true

  test "Can very standard token" do
    assert = TokenParser.Simple.parse([], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["{", "1", "}"], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["1", "}"], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["}"], 0) == :false
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "1", "}"], 0) == :true
  end
end
