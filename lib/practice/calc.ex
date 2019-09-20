defmodule Practice.Calc do

  @operators %{
    "+" => 1,
    "-" => 1,
    "*" => 2,
    "/" => 2
  }
  def parse_float(text) do
    if is_binary(text) do
        {num, _} = Float.parse(text)
        num
    else 
        text
    end
  end

  defp postfix([], stack, acc) do
    unless Enum.empty?(stack) do 
        [head | stack] = stack
        acc = acc ++ [head]
        postfix([], stack, acc)
    else 
        acc
    end
  end

  defp postfix(expr, stack, acc) do
    [head | expr] = expr
    cond do
        @operators[head] == nil -> 
            postfix(expr, stack, acc ++ [head])
        @operators[head] == 1 -> 
            if Enum.empty?(stack) do
                postfix(expr, [head | stack], acc)
            else 
                postfix(expr, [head], acc ++ stack)
            end
        @operators[head] == 2 -> 
            cond do
                Enum.empty?(stack) -> postfix(expr, [head | stack], acc)
                @operators[hd(stack)] == 2 -> postfix(expr, [head], acc ++ stack)
                @operators[hd(stack)] == 1 -> postfix(expr, [head | stack], acc)
            end
    end
  end

  defp arthm(a, op, b) do
    case op do 
        "+" -> a + b
        "-" -> a - b
        "*" -> a * b
        "/" -> a / b
    end
  end

  defp eval([], stack) do
    case length(stack) do 
        1 -> parse_float(hd(stack))
        _ -> :error
    end
  end

  defp eval(expr, stack) do
    [op | expr] = expr
    case Map.fetch(@operators, op) do 
        {:ok, _} -> 
            [a | stack] = stack
            eval(expr, [arthm(stack|>hd|>parse_float, op, parse_float(a)) | tl(stack)]) 
        :error -> eval(expr, [op |stack])
    end
  end


  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> postfix([], [])
    |> eval([])


    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
