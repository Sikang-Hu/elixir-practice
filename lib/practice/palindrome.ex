defmodule Practice.Palindrome do
  defp palin([]) do
    true
  end

  defp palin([_]) do
    true
  end
  
  defp palin(l) do
    [head | l] = l
    {tail, l} = List.pop_at(l, -1)
    head == tail && palin(l)
  end  

  def pan(str) do
    str
    |> String.to_charlist
    |> palin
  end
end
