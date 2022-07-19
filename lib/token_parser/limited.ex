defmodule TokenParser.Limited do
  def parse("%{" <> rest), do: parse_interpolation(rest, 0, false)
  def parse(_), do: {:error, {:expected, "%{"}}

  defp parse_interpolation("}" <> _rest, _acc, _s), do: :ok

  defp parse_interpolation(<<d>> <> rest, acc, s) when d in ?0..?9 do
    parse_interpolation(rest, acc * 10 + (d - ?0), s)
  end

  defp parse_interpolation(<<d>> <> rest, acc, _s = false) when "S" == <<d>> do
    parse_interpolation(rest, acc * 10 + (d - ?0), true)
  end

  defp parse_interpolation(<<d>> <> _rest, _acc, _s = true) when "S" == <<d>> do
    {:error, {:expected, "digit or `}`"}}
  end

  defp parse_interpolation(<<d>> <> _rest, _acc, _s) when d not in ?0..?9 do
    {:error, {:expected, "S or `number`"}}
  end
end
