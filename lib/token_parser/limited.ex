defmodule TokenParser.Limited do
  def parse([], _acc = 0), do: false

  def parse([element | elements], _acc = 0) do
    IO.inspect(elements, label: "These are my elements")
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
        IO.inspect(element, label: "Cond")
        IO.inspect(String.downcase(element) == "s")
        IO.inspect(element == "}" && Enum.count(elements) == 0)
        cond do
          String.downcase(element) == "s" -> is_token(elements, 2)
          element == "}" && Enum.count(elements) == 0 -> true
          true -> false
        end
    end
  end
end
