defmodule Metex.Worker do
  use GenServer

  ## Client API
  def start_link(opts \\[]) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get_temperature(pid, location) do
    GenServer.call(pid, {:location, location})
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  ## Sever callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:location, location}, _from, stats) do
    case temperature_of(location) do
      {:ok, temp} ->
        {:reply, "#{temp} ˚C", stats}
      _ ->
        {:reply, :error, stats}
    end
  end

  def handle_cast(:stop, stats) do
    {:stop, :normal, stats}
  end

  def handle_info(msg, stats) do
    IO.puts "received #{inspect msg}"
    {:noreply, stats}
  end

  def terminate(reason, stats) do
    # We could write to a file, database etc
    IO.puts "server terminated because of #{inspect reason}"
       inspect stats
    :ok
  end

  def temperature_of(location) do
    url_for(location)
      |> HTTPoison.get
      |> parse_response
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temprature
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temprature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp apikey, do: "ff8b38f17bb390d6decb52d7b77ed4c1"
end

# Usage
# {:ok, pid} = Metex.Worker.start_link
# Metex.Worker.get_temperature(pid, "Delhi")
