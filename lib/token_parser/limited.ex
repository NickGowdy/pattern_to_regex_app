defmodule TokenParser.Limited do
  def parse("%{" <> rest), do: parse_interpolation(rest, 0, false)
  def parse(_), do: {:error, {:expected, "%{"}}

  defp parse_interpolation("}" <> rest, acc, _s), do: {:ok, acc, rest}

  defp parse_interpolation(<<d>> <> rest, acc, s) when d in ?0..?9 do
    parse_interpolation(rest, acc * 10 + (d - ?0), s)
  end

  defp parse_interpolation(<<d>> <> rest, acc, _s = false) when "S" == <<d>> do
    parse_interpolation(rest, acc * 10 + (d - ?0), true)
  end

  defp parse_interpolation(<<d>> <> _rest, _acc, _s = true) when "S" == <<d>> do
    {:error, {:expected, "digit or `}`"}}
  end
end
