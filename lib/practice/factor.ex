defmodule Practice.Factor do

  defp fac(1) do [1] end

  defp fac(2) do [2] end

  defp fac(3) do [3] end

  defp fac(x) do 
    case find_fac(x, 2, sqrt(x)) do 
        {f, q} -> [f | fac(q)]
        -1 -> [x]
    end
  end

  defp find_fac(num, f, lim) do 
    if f > lim do
        -1
    else
        case rem(num, f) do
            0 -> {f, div(num, f)}
            _ -> find_fac(num, f + 1, lim)
        end
    end
  end

  defp sqrt(x) do 
    x
    |> :math.sqrt()
    |> trunc()
  end

  def factor(x) do
    x
    |> fac
    |> Enum.sort
    |> inspect
  end
end
