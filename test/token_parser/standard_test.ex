defmodule TokenParser.Standard.Test do
  use ExUnit.Case, async: true

  test "Can verify standard token" do
    assert TokenParser.Simple.parse("") == {:error, {:expected, "%{"}}
    assert TokenParser.Simple.parse("{1}") == {:error, {:expected, "%{"}}
    assert = TokenParser.Simple.parse("1}") == {:error, {:expected, "%{"}}
    assert = TokenParser.Simple.parse("}")  == {:error, {:expected, "%{"}}
    assert = TokenParser.Simple.parse("%{-1}") == {:error, {:expected, "%{"}}

    assert = TokenParser.Simple.parse("%{1}") == :ok
    assert = TokenParser.Simple.parse("%{12}") == :ok
    assert = TokenParser.Simple.parse("%{123}") == :ok
    assert = TokenParser.Simple.parse("%{1234}") == :ok
    assert = TokenParser.Simple.parse("%{12345}") == :ok
    assert = TokenParser.Simple.parse("%{123456}") == :ok
    assert = TokenParser.Simple.parse("%{1234567}") == :ok
    assert = TokenParser.Simple.parse("%{12345678}") == :ok
    assert = TokenParser.Simple.parse("%{123456789}") == :ok
    assert = TokenParser.Simple.parse("%{1234567890}") == :ok
  end
end
