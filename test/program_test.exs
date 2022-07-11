defmodule Program.Test do
  use ExUnit.Case, async: true

  test "Can get regex string from module" do
    assert Program.main('foo %{0} is a %{1S3}')
      |> IO.read(:all) = "foo [a-zA-Z ]{0,} is a \W*(\w+(\W+|$)){1,4}$"

      assert Program.main('')
      |> IO.read(:all)
  end
end
