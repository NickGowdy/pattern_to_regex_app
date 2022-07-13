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
       cond do
        String.downcase(element) == "g" -> is_token(elements, 2)
        true -> is_token(element, 3)
       end
    end
  end

  defp is_token(element, _acc = 3) do
    case element do
      "}" -> true
      _ -> false
    end
  end
end
