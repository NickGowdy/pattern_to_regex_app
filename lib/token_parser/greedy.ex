defmodule TokenParser.Greedy do
  def parse([]), do: ""

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
      {_, ""} ->
        is_token(elements, 3)

      :error ->
        false
    end
  end

  defp is_token([element | elements], _acc = 3) do
    case String.upcase(element) do
      "G" -> is_token(elements, 4)
      _ -> false
    end
  end

  defp is_token([element | _elements], _acc = 4) do
    case element do
      "}" -> true
      _ -> false
    end
  end
end
