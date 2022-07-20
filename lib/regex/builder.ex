defmodule Regex.Builder do
  alias TokenParser.{Limited, Simple, Greedy}

  @doc """
  Builds regex based a pattern of strings with tokens

  Returns `Regex.t()`.

  ## Examples

      iex> Regex.Builder.build("foo %{0} is a %{1}")
      ~r/foo [a-zA-Z ]{0,} is a [a-zA-Z ]{0,}/

  """
  @spec build(binary) :: Regex.t()
  def build(command) do
    output =
      command
      |> String.split()
      |> Enum.map(fn string_val -> do_build(string_val) end)
      |> List.to_string()
      |> String.trim_trailing()

    case Regex.compile(output) do
      {:ok, regex} ->
        regex

      {:error, _msg} ->
        # some logger
        ""
    end
  end

  @spec do_build(String.t()) :: String.t()
  defp do_build(value) do
    is_standard_token = Simple.parse(value)
    is_limited_token = Limited.parse(value)
    is_greedy_token = Greedy.parse(value)

    cond do
      is_standard_token == :ok -> standard_regex()
      is_limited_token == :ok -> limited_words_regex(value)
      is_greedy_token == :ok -> greedy_regex()
      true -> exact_word_regex(value)
    end
  end

  defp exact_word_regex(word), do: "(#{word})" <> " "

  defp standard_regex, do: "[a-zA-Z0-9_]+" <> " "

  defp limited_words_regex(value) do
    word_limit =
      value
      |> String.replace(["{", "}", "%"], fn _ -> "" end)
      |> String.reverse()
      |> String.split("", trim: true)
      |> Enum.reduce_while([], fn x, list ->
        case Integer.parse(x) do
          {num, _} ->
            list = List.insert_at(list, 0, num)
            {:cont, list}

          :error ->
            case String.downcase(x) do
              "s" ->
                {:halt, list}

              _ ->
                {:halt, list}
            end
        end
      end)
      |> Enum.join()

    case Integer.parse(word_limit) do
      {number, ""} ->
        modified_number = number + 1
        "([a-zA-Z0-9]+[^a-zA-Z0-9]*){1,#{modified_number}}$" <> " "

      :error ->
        ""
    end
  end

  defp greedy_regex(), do: ".*" <> " "
end
