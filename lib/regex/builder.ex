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

    {:ok, regex} = Regex.compile(output)
    regex
  end

  @spec do_build(String.t()) :: String.t()
  defp do_build(value) do
    split_string = String.split(value, "", trim: true)

    is_standard_token = Simple.parse(split_string, 0)
    is_limited_token = Limited.parse(split_string, 0)
    is_greedy_tokene = Greedy.parse(split_string, 0)

    cond do
      is_standard_token -> standard_regex()
      is_limited_token -> limited_words_regex(split_string)
      is_greedy_tokene -> greedy_regex(split_string)
      !is_standard_token && !is_limited_token -> value <> " "
    end
  end

  defp standard_regex, do: "[a-zA-Z\s]{0,}" <> " "

  defp limited_words_regex(split_string) do
    word_limit = Enum.at(split_string, Enum.count(split_string) - 2)

    case Integer.parse(word_limit) do
      {number, ""} ->
        modified_number = number + 1
        "\\W*(\\w+(\\W+|$)){1,#{modified_number}}$" <> " "

      :error ->
        ""
    end
  end

  defp greedy_regex(split_string) do
    word_limit = Enum.at(split_string, Enum.count(split_string) - 3)

    case Integer.parse(word_limit) do
      {number, ""} ->
        modified_number = number + 1
        "[a-zA-Z ]{#{modified_number * 2},}" <> " "

      :error ->
        ""
    end
  end
end