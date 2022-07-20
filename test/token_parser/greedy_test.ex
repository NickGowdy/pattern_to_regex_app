defmodule TokenParser.Greedy.Test do
  use ExUnit.Case, async: true

  test "Can verify greedy token" do
    assert TokenParser.Greedy.parse("") == {:error, {:expected, "%{"}}
    assert TokenParser.Greedy.parse("{1}")  == {:error, {:expected, "%{"}}
    assert TokenParser.Greedy.parse("1}") == {:error, {:expected, "%{"}}
    assert TokenParser.Greedy.parse("}") == {:error, {:expected, "%{"}}
    assert TokenParser.Greedy.parse("%{-1}") ==  {:error, {:expected, "digit or `}`"}}
    assert TokenParser.Greedy.parse("%1G}") == {:error, {:expected, "%{"}}
    assert TokenParser.Greedy.parse("%{1D2}") == {:error, {:expected, "digit or `}`"}}
    assert TokenParser.Greedy.parse("%{1G1}") == {:error, {:expected, "digit or `}`"}}

    assert TokenParser.Greedy.parse("%{1G}") == :ok
    assert TokenParser.Greedy.parse("%{12G}") == :ok
    assert TokenParser.Greedy.parse("%{123G}") == :ok
    assert TokenParser.Greedy.parse("%{1234G}") == :ok
    assert TokenParser.Greedy.parse("%{12345G}") == :ok
    assert TokenParser.Greedy.parse("%{123456G}") == :ok
    assert TokenParser.Greedy.parse("%{1234567G}") == :ok
    assert TokenParser.Greedy.parse("%{12345678G}") == :ok
    assert TokenParser.Greedy.parse("%{123456789G}") == :ok
    assert TokenParser.Greedy.parse("%{1234567890G}") == :ok

  end
end
