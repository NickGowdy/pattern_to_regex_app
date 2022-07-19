defmodule TokenParser.Greedy do
  def parse("%{" <> rest), do: parse_interpolation(rest, 0)
  def parse(_), do: {:error, {:expected, "%{"}}

  defp parse_interpolation("G}" <> _rest, _acc), do: :ok

  defp parse_interpolation(<<d>> <> rest, acc) when d in ?0..?9 do
    parse_interpolation(rest, acc * 10 + (d - ?0))
  end

  defp parse_interpolation(<<_>> <> _rest, _acc) do
    {:error, {:expected, "digit or `}`"}}
  end
end
