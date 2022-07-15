defmodule TokenParser.Simple do
  def parse([], _acc = 0), do: false

  def parse([], _acc = 2), do: false


  def parse([element | elements], _acc = 0) do
    case element do
      "%" -> parse(elements, 1)
      _ -> false
    end
  end

  def parse([element | elements], _acc = 1) do
    case element do
      "{" -> parse(elements, 2)
      _ -> false
    end
  end

  def parse([element | elements], _acc = 2) do
    case Integer.parse(element) do
      {num, ""} ->
        if num >= 0, do: parse(elements, 2), else: false

      :error ->
       parse(element, 3)
    end
  end

  def parse(element, _acc = 3) do
    case element do
      "}" -> true
      _ -> false
    end
  end
end
