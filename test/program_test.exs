defmodule Program.Test do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "Can get regex string from module" do
    assert "(foo) [a-zA-Z0-9_]+ (is) (a) ([a-zA-Z0-9]+[^a-zA-Z0-9]*){1,4}$\n" ==
             capture_io(fn ->
               Program.main('foo %{0} is a %{1S3}')
             end)

    assert "(foo) [a-zA-Z0-9_]+ (is) (a) ([a-zA-Z0-9]+[^a-zA-Z0-9]*){1,4}$ (with) (a) ([a-zA-Z0-9]+[^a-zA-Z0-9]*){1,5}$\n" ==
             capture_io(fn ->
               Program.main('foo %{0} is a %{1S3} with a %{2S4}')
             end)

    assert "(bar) .* (foo) [a-zA-Z0-9_]+\n" ==
             capture_io(fn ->
               Program.main('bar %{0G} foo %{1};')
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
