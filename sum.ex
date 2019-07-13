defmodule ElixirSum do
  def sum([]), do: 0
  def sum([head | tail]) do
    head + sum(tail)
  end

  def sum(ele), do: ele
end

## Usage
# ElixirSum.sum([1,2,3,4])
