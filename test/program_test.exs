defmodule Program.Test do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "Can get regex string from module" do
    expected = "foo [a-zA-Z ]{0,} is a \\W*(\\w+(\\W+|$)){1,4}$\n"
    actual = capture_io(fn ->
      Program.main('foo %{0} is a %{1S3}')
    end)

    assert expected == actual
  end

  test "Empty argument returns empty string from program" do
    expected = "\n"
    actual = capture_io(fn ->
      Program.main('')
    end)

    assert expected == actual
  end
end
