defmodule Program do
  @moduledoc """
  This is a module that takes a pattern specification (as a binary) provided
  through program.sh and returns a regex string to be used by pcre2grep
  """

  @doc """
  Entry point of application
  Returns regex of `String.t()

  ## Examples

      iex> Program.main('foo %{0} is a %{1S3}')
      foo [a-zA-Z ]{0,} is a [a-zA-Z ]{0,}

  """
  @spec main(binary) :: :ok
  def main(args) do
    args
    |> convert_to_string()
    |> Regex.Builder.build()
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
