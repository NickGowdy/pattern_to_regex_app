defmodule RegexBuilderTest do
  use ExUnit.Case, async: true

  test "Match regex with string that has standard tokens" do
    pattern = "foo %{0} is a %{1}"
    regex =  Regex.Builder.build(pattern)

    test_case_1 = "foo blah is a bar"
    test_case_2 = "foo blah is a very big boat;"
    test_case_3 = "foo blah is bar"
    test_case_4 = "foo blah"
    test_case_5 = "foo blah is"

    assert = Regex.match?(regex, test_case_1)
    assert = Regex.match?(regex, test_case_2)
    assert = !Regex.match?(regex, test_case_3)
    assert = !Regex.match?(regex, test_case_4)
    assert = !Regex.match?(regex, test_case_5)
  end

  test "Match regex with string that has space limiation token" do
    pattern = "foo %{0} is a %{1S0}"
    regex = Regex.Builder.build(pattern)

    test_case_1 = "foo blah is a bar"
    test_case_2 = "foo blah is a very big boat;"
    test_case_3 = "foo blah is bar"
    test_case_4 = "foo blah"
    test_case_5 = "foo blah is"

    assert = Regex.match?(regex, test_case_1)
    assert = !Regex.match?(regex, test_case_2)
    assert = !Regex.match?(regex, test_case_3)
    assert = !Regex.match?(regex, test_case_4)
    assert = !Regex.match?(regex, test_case_5)
  end

  test "Match regex with string that has greedy token" do
    pattern = "the %{0S1} %{1} ran away"
    regex = Regex.Builder.build(pattern)

    test_case_1 = "the big brown fox ran away"

    assert = Regex.match?(regex, test_case_1)
  end

  test "Handle negative cases" do
    assert = Regex.Builder.build("") == ""
    assert = Regex.Builder.build("12234343effeef") == ""
    assert = Regex.Builder.build("   ") == ""
    assert = Regex.Builder.build("}{32}}%%$3") == ""
  end
end
