defmodule TokenParser.Simple do
  def parse([]), do: false
  def parse([], _acc), do: false

  def parse([element | elements], _acc = 0) do
    case element do
      "%" -> is_token(elements, 1)
      _ -> false
    end
  end

  defp is_token([element | elements], _acc = 1) do
    case element do
      "{" -> is_token(elements, 2)
      _ -> false
    end
  end

  defp is_token([element | elements], _acc = 2) do
    case Integer.parse(element) do
      {num, ""} ->
        if num >= 0, do: is_token(elements, 2), else: false

      :error ->
        is_token(element, 3)
    end
  end

  defp is_token(element, _acc = 3) do
    case element do
      "}" -> true
      _ -> false
    end
  end

  defp is_token([], _acc), do: false
end
