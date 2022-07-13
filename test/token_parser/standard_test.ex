defmodule TokenParser.Standard.Test do
  use ExUnit.Case, async: true

  test "Can very standard token" do
    assert = TokenParser.Simple.parse([], 0) == false
    assert = TokenParser.Simple.parse([_ | _] = ["{", "1", "}"], 0) == false
    assert = TokenParser.Simple.parse([_ | _] = ["1", "}"], 0) == false
    assert = TokenParser.Simple.parse([_ | _] = ["}"], 0) == false
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "1", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "12", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "123", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "1234", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "12345", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "123456", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "1234567", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "12345678", "}"], 0) == true
    assert = TokenParser.Simple.parse([_ | _] = ["%", "{", "123456789", "}"], 0) == true
  end
end
