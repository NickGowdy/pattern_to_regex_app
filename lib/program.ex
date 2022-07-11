defmodule Program do
   @moduledoc """
  This is a module that takes a pattern specification provided
  as a commandline arguement into a regex.
  """

  @spec main(binary) :: :ok
  def main(args) do
    args
    |> convert_to_string()
    |> Regex.RegexBuilder.build()
    |> Regex.source()
    |> IO.puts()
  end

  @spec main :: :ok
  def main() do
    IO.puts("Nothing to process")
  end

  @spec convert_to_string(binary()) :: String.t()
  defp convert_to_string(binary) do
    for c <- binary, into: "", do: <<c>>
  end
end
