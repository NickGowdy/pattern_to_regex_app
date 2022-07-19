defmodule TokenParser.Limited.Test do
  use ExUnit.Case, async: true

  test "Can verify limited token" do
    assert = TokenParser.Limited.parse([], 0) == :false
    assert = TokenParser.Limited.parse([_ | _] = ["{", "1", "}"], 0) == :false
    assert = TokenParser.Limited.parse([_ | _] = ["1", "}"], 0) == :false
    assert = TokenParser.Limited.parse([_ | _] = ["}"], 0) == :false
    assert = TokenParser.Limited.parse([_ | _] = ["%", "{", "-1", "}"], 0) == false

    assert = TokenParser.Limited.parse([_ | _] = ["%", "{", "1", "S", "0", "}"], 0) == :true
    assert = TokenParser.Limited.parse([_ | _] = ["%", "{", "12", "S", "0", "}"], 0) == :true
    assert = TokenParser.Limited.parse([_ | _] = ["%", "{", "12", "S", "12", "}"], 0) == :true
    assert = TokenParser.Limited.parse([_ | _] = ["%", "{", "", "S", "1234", "}"], 0) == :true
  end
end
