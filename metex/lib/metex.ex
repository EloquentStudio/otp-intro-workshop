defmodule Metex do
  @moduledoc """
  Documentation for Metex.
  """
  def temperatures_of(cities) do
    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], Enum.count(cities)])
    cities |> Enum.each(fn city ->
        worker_pid = spawn(Metex.Worker, :loop, [])
        send(worker_pid, {coordinator_pid, city})
      end)
  end
end

## Usage
# cities = ["Singapore", "Monaco", "Vatican City", "Hong Kong", "Macau"]
# Metex.temperatures_of(cities)
