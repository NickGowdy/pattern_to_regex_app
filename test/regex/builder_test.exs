defmodule Regex.Builder.Test do
  use ExUnit.Case, async: true

  test "Match regex with string that has standard tokens" do
    pattern = "foo %{0} is a %{1}"
    regex = Regex.Builder.build(pattern)

    test_case_1 = "foo blah is a bar"
    test_case_2 = "foo blah is a very big boat;"
    test_case_3 = "foo blah is bar"
    test_case_4 = "foo blah"
    test_case_5 = "foo blah is"

    assert Regex.match?(regex, test_case_1) == true
    assert Regex.match?(regex, test_case_2) == true
    assert Regex.match?(regex, test_case_3) == false
    assert Regex.match?(regex, test_case_4) == false
    assert Regex.match?(regex, test_case_5) == false
  end

  test "Match regex with string that has space limiation token" do
    test_case_1 = "foo blah is a bar"
    test_case_2 = "foo blah is a very big boat;"
    test_case_3 = "foo blah is bar"
    test_case_4 = "foo blah"
    test_case_5 = "foo blah is"
    test_case_6 = "foo blah is a very big boat test test test test"
    test_case_7 = "foo blah is a very big boat test test test test"

    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S0}"), test_case_1) == true
    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S0}"), test_case_2) == false
    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S0}"), test_case_3) == false
    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S0}"), test_case_4) == false
    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S0}"), test_case_5) == false
    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S10}"), test_case_6) == true
    assert Regex.match?(Regex.Builder.build("foo %{0} is a %{1S3}"), test_case_6) == false
  end

  test "Match regex with string that has greedy token" do
    assert Regex.match?(
             Regex.Builder.build("bar %{0G} foo %{1}"),
             "bar foo bar foo bar foo bar foo"
           ) == true

    assert Regex.match?(
             Regex.Builder.build("bar %{0G} foo %{1}"),
             "bar foo bar foo2 bar foo"
           ) == false
  end

  test "Handle negative cases" do
    assert = Regex.Builder.build("") == ""
    assert = Regex.Builder.build("12234343effeef") == ""
    assert = Regex.Builder.build("   ") == ""
    assert = Regex.Builder.build("}{32}}%%$3") == ""
  end
end
