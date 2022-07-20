defmodule TokenParser.Limited.Test do
  use ExUnit.Case, async: true

  test "Can verify limited token" do
    assert TokenParser.Limited.parse("") == {:error, {:expected, "%{"}}
    assert TokenParser.Limited.parse("{1}")  == {:error, {:expected, "%{"}}
    assert TokenParser.Limited.parse("1}") == {:error, {:expected, "%{"}}
    assert TokenParser.Limited.parse("}") == {:error, {:expected, "%{"}}
    assert TokenParser.Limited.parse("%{-1}") == {:error, {:expected, "S or `number`"}}
    assert TokenParser.Limited.parse("%1G}") == {:error, {:expected, "%{"}}
    assert TokenParser.Limited.parse("%{1D2}") == {:error, {:expected, "S or `number`"}}

    assert TokenParser.Limited.parse("%{1S1}") == :ok
    assert TokenParser.Limited.parse("%{1S12}") == :ok
    assert TokenParser.Limited.parse("%{1S123}") == :ok
    assert TokenParser.Limited.parse("%{1S1234}") == :ok
    assert TokenParser.Limited.parse("%{1S12345}") == :ok
    assert TokenParser.Limited.parse("%{1S123456}") == :ok
    assert TokenParser.Limited.parse("%{1S1234567}") == :ok
    assert TokenParser.Limited.parse("%{1S12345678}") == :ok
    assert TokenParser.Limited.parse("%{1S123456789}") == :ok
    assert TokenParser.Limited.parse("%{1S1234567890}") == :ok
  end
end
