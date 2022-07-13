defmodule TokenParser.Greedy do
  def parse([], _acc = 0), do: false


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
        is_token(elements, 2)

      :error ->
       is_token(element, 3)
    end
  end

  defp is_token(element, _acc = 3) do
    case String.downcase(element) do
      "g" ->  is_token(element, 4)
      _ -> false
    end
  end

  defp is_token(element, _acc = 4) do
    case element do
      "}" -> true
      _ -> false
    end
  end
end
