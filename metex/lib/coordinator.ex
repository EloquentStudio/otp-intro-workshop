defmodule Metex.Coordinator do
  def loop(results \\ [], count) do
    receive do
      {:ok, result} ->
        new_results = [result| results]
        if(count == Enum.count(new_results)) do
          send(self(), :exit)
        end
        loop(new_results, count)
          
      :exit ->
        IO.puts(results |> Enum.sort |> Enum.join(", "))
      _ ->
        loop(results, count)
    end
  end
end
