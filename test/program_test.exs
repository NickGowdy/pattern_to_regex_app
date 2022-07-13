defmodule Program.Test do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "Can get regex string from module" do
    assert "foo [a-zA-Z ]{0,} is a \\W*(\\w+(\\W+|$)){1,4}$\n" ==
             capture_io(fn ->
               Program.main('foo %{0} is a %{1S3}')
             end)

    assert "foo [a-zA-Z ]{0,} is a \\W*(\\w+(\\W+|$)){1,4}$ with a \\W*(\\w+(\\W+|$)){1,5}$\n" ==
             capture_io(fn ->
               Program.main('foo %{0} is a %{1S3} with a %{2S4}')
             end)
  end

  test "Empty argument returns empty string from program" do
    expected = "\n"

    actual =
      capture_io(fn ->
        Program.main('')
      end)

    assert expected == actual
  end
end
