defmodule Flatten do
  def flatten([]), do: []
  def flatten([head | tail]) do
      flatten(head) ++ flatten(tail)
  end
  def flatten(head), do: [head]
end

## Usage
# Flatten.flatten([1,2,3,4,5,6])
# Flatten.flatten([[1],[2,[[3],4],5],6])
# Flatten.flatten([1,2,3,[4,5],6])
